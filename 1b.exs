defmodule Analisis do
  def contar_bajo_stock([], _t), do: 0

  def contar_bajo_stock([%Pieza{stock: stock} | t], umbral) do
    if stock < umbral do
      1 + contar_bajo_stock(t, umbral)
    else
      contar_bajo_stock(t, umbral)
    end
  end
end
