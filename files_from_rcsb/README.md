Arquivos extraídos de "CHARMM-GUI"
==================================

Nesse diretório estão arquivos retirados do _Protein Data Bank_. Além disso,
alguns diretórios apresentam os arquivos `disulfide_bonds.pdb` e
`protein_nocorrection.pdb`. De modo geral, foram adicionados os resíduos
faltantes intermediários (mas não terminais!) às estruturas das proteínas,
e não foram adicionadas pontes de dissulfeto.

Caso o programa oferecesse a adição de pontes de dissulfeto, eram gerados
dois arquivos: um com (`disulfide_bonds.pdb`), e um sem (`receptor_default.pdb`)
essas ligações. Caso oferecesse a adição de resíduos faltantes, também eram
gerados dois arquivos, um com esses resíduos (`receptor_default.pdb`) e um sem
(`protein_nocorrection.pdb`). Por fim, caso ambos fossem possíveis,
`protein_nocorrection.pdb` não apresenta nem pontes nem adição de resíduos
faltantes, `disulfide_bonds.pdb` apresenta ambos e `receptor_default.pdb`
apresenta apenas a adição de resíduos faltantes.

Em todos os casos foram retirados glicanos, heteroátomos e moléculas de
água. A molécula original (como obtida da base de dados RCSB está disponível
em um arquivo `.cif`).

Por fim, ressaltamos que, dos 90 complexos avaliados anteriormente (cargas
e hidrogênios), 2 apresentaram problemas, os complexos de código RCSB 3AG9
(PKA em complexo com o inibidor de cinases ARC-1012) e 3E93 (Cinase P38 em
complexo com um inibidor). Esses complexos não foram, portanto, considerados.


