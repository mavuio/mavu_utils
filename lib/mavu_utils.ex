defmodule MavuUtils do
  @moduledoc """
  An opinionated set of utility functions used by other (upcoming) packages under mavuio/\*
  """

  require Logger

  @doc """
  macro to only apply a function within a pipe if a condition equals to true.

  the conditional gets passed to true?/1  first

  ##Example:

      |> pipe_when(
          item[:taxrate],
          update_in([:taxrates], &update_taxrate_stats(&1, item))
        )

  """
  defmacro pipe_when(left, condition, fun) do
    quote do
      left = unquote(left)

      if true?(unquote(condition)),
        do: left |> unquote(fun),
        else: left
    end
  end

  @doc """

  applies a value when piped value is_empty ( as defined by present?/1 )

  ##Example:

    taxrate_item =
      taxrates[taxkey]
      |> if_empty(%{tax: "0", net: "0", gross: "0"})
      |> taxrate_item_append(create_taxrate_stats_entry_for_item(item))

  """
  def if_empty(val, default_val) do
    if present?(val) do
      val
    else
      default_val
    end
  end

  @doc """

  applies a value when piped value is nil

  ##Example:

    get_max_order_id()
    |> if_nil(1000)

  """
  def if_nil(val, default_val) do
    if is_nil(val) do
      default_val
    else
      val
    end
  end

  @doc """

  tries to convert any value to integer

  returns integer on success, nil on failure

  """
  def to_int(val) do
    case val do
      val when is_integer(val) ->
        val

      val when is_binary(val) ->
        Integer.parse(val)
        |> case do
          {val, ""} -> val
          _ -> nil
        end

      val when is_float(val) ->
        Kernel.round(val)

      %Decimal{} = val ->
        val |> Decimal.round() |> Decimal.to_integer()

      nil ->
        nil
    end
  end

  @doc """

  tests if value is "non-blank"

  """
  def present?(term) do
    !Blankable.blank?(term)
  end

  @doc """

  tests if value is "blank"

  """

  def empty?(term) do
    Blankable.blank?(term)
  end

  @doc """

  tests if value is one of several falsy values.

  """

  def false?(false), do: true
  def false?("false"), do: true
  def false?(-1), do: true
  def false?(0), do: true
  def false?("0"), do: true
  def false?("-1"), do: true

  def false?(term) do
    empty?(term)
  end

  @doc """

  tests if value is one of several truthy values
  and not false?/1

  """

  def true?(true), do: true
  def true?("true"), do: true
  def true?(1), do: true
  def true?("1"), do: true

  def true?(term) do
    !false?(term)
  end

  @doc """

  simple pipeable logger.

  setting a  loglevel is mandatory

  order
  |> MavuUtils.log("trying to finish order \#{order.id}", :info)
  |> finish_order()

  """

  def log(data, msg \\ "", level) when is_atom(level) do
    Logger.log(
      level,
      msg <> " " <> inspect(data, printable_limit: :infinity, limit: 50, pretty: true)
    )

    data
  end

  def die(data, msg \\ "") do
    MavuUtils.Error.die(data, label: msg)
  end
end
