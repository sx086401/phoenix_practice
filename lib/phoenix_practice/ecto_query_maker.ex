use Croma

defmodule PhoenixPractice.EctoQueryMaker do
  import Ecto.Query

  alias Ecto.Query

  @callback apply_filter(filter :: atom | {atom, any}, query :: Query.t()) :: Query.t()
  @callback apply_option(opt :: atom | {atom, any}, query :: Query.t()) :: Query.t()
  @callback apply_join(join :: atom | {atom, any}, query :: Query.t()) :: Query.t()
  @callback apply_preload(preload :: atom | {atom, any}) :: atom | {atom, any}
  @optional_callbacks apply_filter: 2, apply_option: 2, apply_join: 2, apply_preload: 1

  defun apply(query :: Ecto.Queryable.t, filters :: v[list], opts :: v[list]) :: Query.t do
    apply(query, __MODULE__, filters, opts)
  end

  defun apply(query :: Ecto.Queryable.t, module :: v[module], filters :: v[list], opts :: v[list]) :: Query.t  do
    Code.ensure_loaded(module)

    query
    |> apply_filters(filters, {function_exported?(module, :apply_filter, 2), module})
    |> apply_options(opts, {function_exported?(module, :apply_option, 2), module})
  end

  defp apply_filters(query, [], _module_info), do: query

  defp apply_filters(query, [filter | tail], {true, module} = module_info) do
    case module.apply_filter(filter, query) do
      ^query -> apply_filter(filter, query)
      query -> query
    end
    |> apply_filters(tail, module_info)
  end

  defp apply_filters(query, [filter | tail], module_info) do
    apply_filter(filter, query)
    |> apply_filters(tail, module_info)
  end

  defp apply_filter({attr, value}, query) when is_list(value) do
    where(query, [r], field(r, ^attr) in ^value)
  end

  defp apply_filter({attr, nil}, query) do
    where(query, [r], is_nil(field(r, ^attr)))
  end

  defp apply_filter({attr, value}, query) do
    where(query, [r], field(r, ^attr) == ^value)
  end

  defp apply_options(query, [], _module_info), do: query

  defp apply_options(query, [{:select, []} | tail], module_info) do
    apply_options(query, tail, module_info)
  end

  defp apply_options(query, [{:select, select_by} | tail], module_info) do
    query
    |> select([q], map(q, ^select_by))
    |> apply_options(tail, module_info)
  end

  defp apply_options(query, [{:limit, limit} | tail], module_info) do
    query
    |> limit(^limit)
    |> apply_options(tail, module_info)
  end

  defp apply_options(query, [{:offset, offset} | tail], module_info) do
    query
    |> offset(^offset)
    |> apply_options(tail, module_info)
  end

  defp apply_options(query, [{:order, order_by} | tail], module_info) do
    query
    |> order_by(^order_by)
    |> apply_options(tail, module_info)
  end

  defp apply_options(query, [{:preload, preloads} | tail], {_, module} = module_info) do
    preloads = apply_preloads([], preloads, {function_exported?(module, :apply_preload, 1), module})

    query
    |> preload(^preloads)
    |> apply_options(tail, module_info)
  end

  defp apply_options(query, [{:join, joins} | tail], {_, module} = module_info) do
    query
    |> apply_joins(joins, {function_exported?(module, :apply_join, 2), module})
    |> apply_options(tail, module_info)
  end

  defp apply_options(query, [opt | tail], {true, module} = module_info) do
    module.apply_option(opt, query)
    |> apply_options(tail, module_info)
  end

  defp apply_options(query, [_ | tail], module_info) do
    apply_options(query, tail, module_info)
  end

  defp apply_joins(query, [], _module_info), do: query

  defp apply_joins(query, [join | tail], {true, module} = module_info) do
    module.apply_join(join, query)
    |> apply_joins(tail, module_info)
  end

  defp apply_joins(query, [_ | tail], module_info) do
    apply_joins(query, tail, module_info)
  end

  defp apply_preloads(preloads, [], _module_info), do: preloads

  defp apply_preloads(preloads, [preload | tail], {true, module} = module_info) do
    [module.apply_preload(preload) | preloads]
    |> apply_preloads(tail, module_info)
  end

  defp apply_preloads(preloads, [preload | tail], module_info) do
    apply_preloads([preload | preloads], tail, module_info)
  end
end
