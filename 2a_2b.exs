defmodule Movimiento do
  defstruct codigo: "", tipo: "", cantidad: 0, fecha: ""

  def crear(codigo, tipo, cantidad, fecha) do
    %Movimiento{codigo: codigo, tipo: tipo, cantidad: cantidad, fecha: fecha}
  end

  def escribir(lista_movimientos, nombre_archivo) do
    header = "codigo,tipo,cantidad,fecha\n"
    contenido =
      lista_movimientos
      |> Enum.map(fn %Movimiento{codigo: c, tipo: t, cantidad: cant, fecha: f} ->
        "#{c},#{t},#{cant},#{f}\n"
      end)
      |> Enum.join("")

    File.write(nombre_archivo, header <> contenido)
  end

  def leer(nombre_archivo) do
    case File.read(nombre_archivo) do
      {:ok, contenido} ->
        contenido
        |> String.split("\n", trim: true)
        |> Enum.drop(1)
        |> Enum.map(fn row ->
          [codigo, tipo, cantidad, fecha] = String.split(row, ",")
          Movimiento.crear(codigo, tipo, String.to_integer(cantidad), fecha)
        end)

      {:error, razon} ->
        IO.puts("Error al leer el archivo: #{razon}")
        []
    end
  end
end

defmodule Main do
  def main do
    m1 = Movimiento.crear("COD123","ENTRADA",50,"2025-09-10")
    m2 = Movimiento.crear("COD124","SALIDA",10,"2025-09-12")
    movimientos = [m1, m2]
    Movimiento.escribir(movimientos, "movimientos.csv")
    lista_struct = Movimiento.leer("movimientos.csv")
    IO.inspect(lista_struct)

    nueva_lista = actualizar(lista_struct)
    Movimiento.escribir(nueva_lista, "inventario_actual.csv")
  end

  def actualizar(lista), do: actualizar(lista, [])
  def actualizar([], nueva), do: nueva

  def actualizar([h | t], nueva) do
    cond do
      h.tipo == "ENTRADA" -> actualizar(t, [sal(h) | nueva])
      h.tipo == "SALIDA" -> actualizar(t, [enter(h) | nueva])
    end
  end

  def sal(move), do: %Movimiento{move | tipo: "SALIDA"}
  def enter(move), do: %Movimiento{move | tipo: "ENTRADA"}
end

Main.main()
