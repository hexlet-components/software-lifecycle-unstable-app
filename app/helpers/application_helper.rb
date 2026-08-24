# frozen_string_literal: true

module ApplicationHelper
  # Классы собираются в хелпере, а не в шаблоне: цвет зависит от типа сообщения.
  # Поэтому в @source точки входа css указан и каталог хелперов, иначе эти классы
  # не попадут в сборку, а вывод сборки останется зелёным.
  def alert_classes(type)
    map = {
      notice: 'border-sky-200 bg-sky-50 text-sky-800',
      error: 'border-red-200 bg-red-50 text-red-800',
      success: 'border-green-200 bg-green-50 text-green-800'
    }
    map.fetch(type.to_sym, 'border-sky-200 bg-sky-50 text-sky-800')
  end
end
