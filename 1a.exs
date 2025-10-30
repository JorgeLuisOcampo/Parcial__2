defmodule Pieza do
  defstruct codigo: "", nombre: "", valor: 0, unidad: "", stock: 0

  def crear(codigo, nombre, valor, unidad, stock), do:
  %Pieza{codigo: codigo, nombre: nombre, valor: valor, unidad: unidad, stock: stock}

  def leer(nombre_archivo) do
    case File.read(nombre_archivo) do
      {:ok, contenido} ->
          piezas =
            contenido
            |> String.split("\n", trim: true)
            |> Enum.drop(1)
            |> Enum.map(fn linea ->
              [codigo, nombre, valor, unidad, stock] = String.split(linea, ",")
              Pieza.crear(
                codigo,
                nombre,
                String.to_integer(valor),
                unidad,
                String.to_integer(stock)
              )
            end)

          {:ok, piezas}

      {:error, razon} ->
        {:error, razon}
    end
  end
end
