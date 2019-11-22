# kudo to : https://pragprog.com/titles/lhelph/errata?utf8=%E2%9C%93&what_to_show=2222
require Protocol

defimpl Jason.Encoder, for: [MapSet] do
  def encode(struct, opts) do
    Jason.Encode.list(Enum.to_list(struct), opts)
  end
end
