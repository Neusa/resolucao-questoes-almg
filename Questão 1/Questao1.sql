select	
	cl.nome as nome_cliente, 
	co.data as data_compra,
	co.seq as seq_compra,
	sum(ic.quantidade) as quantidade_total,
	sum(ic.quantidade * pr.valor_unitario) as valor_total_compra
from cliente cl 
	inner join compra co on cl.codigo = co.cliente
	inner join item_compra ic on co.seq = ic.compra
	inner join produto pr on ic.produto = pr.codigo
group by cl.nome, co.data, co.seq
order by cl.nome

------

Uma outra alternativa, com uma subconsulta e uma segunda ordenação (por data, só para garantir)

select cli.nome as nome_cliente, 
       co.data as data_compra, 
       co.seq as seq_compra, 
       x.qtd as quantidade_total, 
       x.valor as valor_total_compra
from cliente cli, compra co,
     (select ic.compra, sum(ic.quantidade) as qtd, sum(ic.quantidade * pr.valor_unitario) as valor
      from item_compra ic, produto pr
      where ic.produto = pr.codigo
      group by ic.compra) x
where co.seq = x.compra
and cli.codigo = co.cliente
order by cli.nome, co.data
