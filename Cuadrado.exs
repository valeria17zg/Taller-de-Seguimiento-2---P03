
defmodule Cuadrados do
  @moduledoc """
    Módulo para generar un archivo SVG con cuadrados concéntricos.
    -autores: Valeria Zapata Giraldo, Juan Miguel Henao Gaviria
    -fecha: Octubre 2026
    -licencia: GNU GPL V3
  """
  @doc """
    Genera un archivo SVG con cuadrados concéntricos.
  """
  def main do
    IO.puts("=== Generador de Cuadrados Concéntricos ===")
    n = IO.gets("Cantidad de cuadrados: ")
    |> String.trim()
    |> String.to_integer()

    reduccion = IO.gets("Espacio entre cuadrados (ej. 50): ")
    |> String.trim()
    |> String.to_integer()
    |> Kernel.*(1.0)


    x_inicial = 20.0
    y_inicial = 20.0
    lado_inicial = 800.0


    generar_texto_svg(x_inicial, y_inicial, lado_inicial, n, reduccion)
    |> guardar("cuadrados.svg")
    |> mostrar_resultado()
  end


  defp generar_texto_svg(x, y, lado, n, reduccion) do
    ancho = lado + (x * 2)
    alto = lado + (y * 2)

    """
    <svg xmlns="http://www.w3.org/2000/svg"
    width="#{ancho}" height="#{alto}"
    viewBox="0 0 #{ancho} #{alto}">
    <rect width="100%" height="100%" fill="black"/>
    #{dibujar_cuadrados(x, y, lado, n, reduccion)}
    </svg>
    """
  end

  defp dibujar_cuadrados(_x, _y, _lado, 0, _reduccion), do: ""

  #función recursiva para dibujar cuadrados concéntricos
  defp dibujar_cuadrados(x, y, lado, n, reduccion) do
    color = obtener_color(n)

    rect_actual = """
    <rect x="#{x}" y="#{y}" width="#{lado}" height="#{lado}"
    fill="none" stroke="#{color}" stroke-width="5"/>
    """

    #para que el espaciado sea visualmente igual en todos los bordes:
    nuevo_x = x + reduccion
    nuevo_y = y + reduccion
    nuevo_lado = lado - (reduccion * 2)

    #recursividad
    rect_actual <> dibujar_cuadrados(nuevo_x, nuevo_y, nuevo_lado, n - 1, reduccion)
  end

  #colores para los cuadrados, se repiten cada 6 cuadrados
  defp obtener_color(n) do
    case rem(n, 6) do
      0 -> "#4a90e2" # Azul
      1 -> "#45b39d" # Verde agua
      2 -> "#7cb342" # Verde claro
      3 -> "#fbc02d" # Amarillo
      4 -> "#f57c00" # Naranja
      5 -> "#e74c3c" # Rojo
    end
  end

  defp guardar(texto, ruta) do
    case File.write(ruta, texto) do
      :ok -> {:ok, "Archivo generado exitosamente: #{ruta}"}
      {:error, razon} -> {:error, razon}
    end
  end

  defp mostrar_resultado({:ok, mensaje}), do: IO.puts(mensaje)
  defp mostrar_resultado({:error, razon}), do: IO.puts("Error al guardar: #{razon}")
end
Cuadrados.main()
