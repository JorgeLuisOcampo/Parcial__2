defmodule Pieza do
  defstruct codigo: "", nombre: "", valor: 0, unidad: "", stock: 0
  def crear(codigo,nombre,valor,unidad,stock) do
    %Pieza{codigo: codigo, nombre: nombre, valor: valor, unidad: unidad, stock: stock}

  end
end

defmodule Main do
  def main do

    p1=  Pieza.crear("COD123","Resistor",47,"ohm",120)
    p2=  Pieza.crear("COD124","Capacitor",100,"uF",35)
    p3=  Pieza.crear("COD131","Potenciómetro",10000,"ohm",25)
    p4=  Pieza.crear("COD125","Resistor",220,"ohm",150)
    p12=  Pieza.crear("COD126","Resistor",1000,"ohm",200)
    p5=  Pieza.crear("COD127","Capacitor",10,"uF",50)
    p6=  Pieza.crear("COD125","Resistor",220,"ohm",150)
    p7=  Pieza.crear("COD128","Inductor",4.7,"mH",60)
    p8=  Pieza.crear("COD129","Diodo", 1,"A",90)
    p9=  Pieza.crear("COD126","Resistor",1000,"ohm", 200)
    p10=  Pieza.crear("COD131","Potenciómetro",10000, "ohm",25)
    p11=  Pieza.crear("COD132","LED Rojo",20,"V",150)
    lista_pieza = [p1,p2,p3,p4,p12,p5,p6,p7,p8,p9,p10,p11]
    nueva_lista = eliminar_duplicados(lista_pieza)
    IO.inspect(nueva_lista)

  end

  def eliminar_duplicados(lista), do: eliminar_duplicados(lista, [])
  def eliminar_duplicados([], acc), do: acc
  def eliminar_duplicados([h | t], acc) do

    acc_sin_duplicado = quitar_codigo(h.codigo, acc)

    eliminar_duplicados(t, acc_sin_duplicado ++ [h])
  end

  def quitar_codigo(_codigo, []), do: []
  def quitar_codigo(codigo, [h | t]) do
    if h.codigo == codigo do
      quitar_codigo(codigo, t)
    else
      [h | quitar_codigo(codigo, t)]
    end
  end

end

Main.main()
