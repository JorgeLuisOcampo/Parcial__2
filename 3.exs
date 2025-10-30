def analizar_movimientos(movimientos, fini, ffin) do
  if(fini <= ffin) do
    contar_dias_y_max(movimientos, fini, ffin, [], 0)
  else
    {:error, "fini debe ser menor o igual que ffin"}
  end
end

defp contar_dias_y_max([], _ini, _fin, fechas, max) do
  {:ok, {contar(fechas), max}}
end

defp contar_dias_y_max([mov | resto], ini, fin, fechas, max) do
  if(mov.fecha >= ini and mov.fecha <= fin) do
    cantidad = String.to_integer(mov.cantidad)

    nuevas_fechas =
      if(fecha_existe?(mov.fecha, fechas), do: fechas, else: [mov.fecha | fechas])

    nuevo_max = if(cantidad > max, do: cantidad, else: max)

    contar_dias_y_max(resto, ini, fin, nuevas_fechas, nuevo_max)
  else
    contar_dias_y_max(resto, ini, fin, fechas, max)
  end
end

def fecha_existe(_f, []), do: false
def fecha_existe(f, [h | t]), do: if(f == h, do: true, else: fecha_existe(f, t))

def contar([], acc \\ 0)
def contar([], acc), do: acc
def contar([_ | t], acc), do: contar(t, acc + 1)
