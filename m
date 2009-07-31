From: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Subject: Re: [PATCH v2] Fix typos on pt_BR/gittutorial.txt translation
Date: Fri, 31 Jul 2009 13:33:42 -0300
Message-ID: <20090731163341.GB10800@vespa.holoscopio.com>
References: <b8bf37780907292044i5ad7b879ueb5048447e4e5bb5@mail.gmail.com> <20090730145044.GA1727@vespa.holoscopio.com> <4A71C6A7.80008@drmicha.warpmail.net> <b8bf37780907301031iec37ef8i6b3db7a9eb21eb8b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xgyAXRrhYN0wYx8y"
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	"Carlos R. Mafra" <crmafra2@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: =?utf-8?B?QW5kcsOp?= Goddard Rosa <andre.goddard@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 18:34:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWv3K-0004rv-T4
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 18:33:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752017AbZGaQdr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2009 12:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751961AbZGaQdr
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 12:33:47 -0400
Received: from liberdade.minaslivre.org ([72.232.18.203]:34548 "EHLO
	liberdade.minaslivre.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751947AbZGaQdp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2009 12:33:45 -0400
Received: from vespa.holoscopio.com (unknown [201.80.130.87])
	by liberdade.minaslivre.org (Postfix) with ESMTPSA id D837A208020;
	Fri, 31 Jul 2009 13:46:20 -0300 (BRT)
Received: by vespa.holoscopio.com (Postfix, from userid 1000)
	id 7839DC22A; Fri, 31 Jul 2009 13:33:42 -0300 (BRT)
Content-Disposition: inline
In-Reply-To: <b8bf37780907301031iec37ef8i6b3db7a9eb21eb8b@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124579>


--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2009 at 02:31:08PM -0300, Andr=C3=A9 Goddard Rosa wrote:
> From 02eb3045e4f1415528f8c07f6c9bafb0beb8c8cc Mon Sep 17 00:00:00 2001
> From: =3D?UTF-8?q?Andr=3DC3=3DA9=3D20Goddard=3D20Rosa?=3D <andre.goddard@=
gmail.com>
> Date: Thu, 30 Jul 2009 14:20:02 -0300
> Subject: [PATCH] [PATCH] Fix typos on pt_BR/gittutorial.txt translation
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>=20
> Signed-off-by: Andr=C3=A9 Goddard Rosa <andre.goddard@gmail.com>
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
> Signed-off-by: Carlos R. Mafra <crmafra2@gmail.com>
> [Included extra fixes from Thadeu and Carlos as well]
> ---
>  Documentation/pt_BR/gittutorial.txt |  144 +++++++++++++++++------------=
------
>  1 files changed, 70 insertions(+), 74 deletions(-)
>=20
> diff --git a/Documentation/pt_BR/gittutorial.txt
> b/Documentation/pt_BR/gittutorial.txt
> index f368b1b..38fab57 100644
> --- a/Documentation/pt_BR/gittutorial.txt
> +++ b/Documentation/pt_BR/gittutorial.txt
> @@ -16,7 +16,7 @@ Este tutorial explica como importar um novo projeto
> para o git,
>  adicionar mudan=C3=A7as a ele, e compartilhar mudan=C3=A7as com outros
>  desenvolvedores.
>=20
> -If, ao inv=C3=A9s disso, voc=C3=AA est=C3=A1 interessado primariamente e=
m usar git para
> +Se, ao inv=C3=A9s disso, voc=C3=AA est=C3=A1 interessado primariamente e=
m usar git para
>  obter um projeto, por exemplo, para testar a =C3=BAltima vers=C3=A3o, vo=
c=C3=AA pode
>  preferir come=C3=A7ar com os primeiros dois cap=C3=ADtulos de
>  link:user-manual.html[O Manual do Usu=C3=A1rio Git].
> @@ -37,9 +37,8 @@ $ git help log
>  Com a =C3=BAltima forma, voc=C3=AA pode usar o visualizador de manual de=
 sua
>  escolha; veja linkgit:git-help[1] para maior informa=C3=A7=C3=A3o.
>=20
> -=C3=89 uma boa id=C3=A9ia se introduzir ao git com seu nome e endere=C3=
=A7o p=C3=BAblico de
> -email antes de fazer qualquer opera=C3=A7=C3=A3o. A maneira mais f=C3=A1=
cil de faz=C3=AA-lo
> -=C3=A9:
> +=C3=89 uma boa id=C3=A9ia informar ao git seu nome e endere=C3=A7o p=C3=
=BAblico de email
> +antes de fazer qualquer opera=C3=A7=C3=A3o. A maneira mais f=C3=A1cil de=
 faz=C3=AA-lo =C3=A9:
>=20
>  ------------------------------------------------
>  $ git config --global user.name "Seu Nome Vem Aqui"
> @@ -51,7 +50,7 @@ Importando um novo projeto
>  -----------------------
>=20
>  Assuma que voc=C3=AA tem um tarball project.tar.gz com seu trabalho inic=
ial.
> -Voc=C3=AA pode coloc=C3=A1-lo sob controle de revis=C3=A3o git como a se=
guir.
> +Voc=C3=AA pode coloc=C3=A1-lo sob controle de revis=C3=A3o git da seguin=
te forma:
>=20
>  ------------------------------------------------
>  $ tar xzf project.tar.gz
> @@ -76,7 +75,7 @@ $ git add .
>  ------------------------------------------------
>=20
>  Este instant=C3=A2neo est=C3=A1 agora armazenado em uma =C3=A1rea tempor=
=C3=A1ria que o git
> -chama de "index" ou =C3=ADndice. Voc=C3=AA pode permanetemente armazenar=
 o
> +chama de "index" ou =C3=ADndice. Voc=C3=AA pode armazenar permanentement=
e o
>  conte=C3=BAdo do =C3=ADndice no reposit=C3=B3rio com 'git-commit':
>=20
>  ------------------------------------------------
> @@ -142,7 +141,7 @@ novos), adicion=C3=A1-los ao =C3=ADndices, e gravar, =
tudo em
> um =C3=BAnico passo.
>  Uma nota em mensagens de commit: Apesar de n=C3=A3o ser exigido, =C3=A9 =
uma boa
>  id=C3=A9ia come=C3=A7ar a mensagem com uma simples e curta (menos de 50
>  caracteres) linha sumarizando a mudan=C3=A7a, seguida de uma linha em br=
anco
> -e, ent=C3=A3o, uma descri=C3=A7=C3=A3o mais detalhada.  Ferramentas que =
transformam
> +e, ent=C3=A3o, uma descri=C3=A7=C3=A3o mais detalhada. Ferramentas que t=
ransformam
>  commits em email, por exemplo, usam a primeira linha no campo de
>  cabe=C3=A7alho Subject: e o resto no corpo.
>=20
> @@ -150,7 +149,7 @@ Git rastreia conte=C3=BAdo, n=C3=A3o arquivos
>  ----------------------------
>=20
>  Muitos sistemas de controle de revis=C3=A3o prov=C3=AAem um comando `add=
` que diz
> -ao sistema para come=C3=A7ar a rastrear mudan=C3=A7as em um novo arquivo=
=2E  O
> +ao sistema para come=C3=A7ar a rastrear mudan=C3=A7as em um novo arquivo=
=2E O
>  comando `add` do git faz algo mais simples e mais poderoso: 'git-add' =
=C3=A9
>  usado tanto para arquivos novos e arquivos recentemente modificados, e
>  em ambos os casos, ele tira o instant=C3=A2neo dos arquivos dados e arma=
zena
> @@ -183,7 +182,7 @@ Gerenciando "branches"/ramos
>  -----------------
>=20
>  Um simples reposit=C3=B3rio git pode manter m=C3=BAltiplos ramos de
> -desenvolvimento.  Para criar um novo ramo chamado "experimental", use
> +desenvolvimento. Para criar um novo ramo chamado "experimental", use
>=20
>  ------------------------------------------------
>  $ git branch experimental
> @@ -203,14 +202,14 @@ voc=C3=AA vai obter uma lista de todos os ramos exi=
stentes:
>  ------------------------------------------------
>=20
>  O ramo "experimental" =C3=A9 o que voc=C3=AA acaba de criar, e o ramo "m=
aster" =C3=A9 o
> -ramo padr=C3=A3o que foi criado pra voc=C3=AA automaticamente.  O asteri=
sco marca
> +ramo padr=C3=A3o que foi criado pra voc=C3=AA automaticamente. O asteris=
co marca
>  o ramo em que voc=C3=AA est=C3=A1 atualmente; digite
>=20
>  ------------------------------------------------
>  $ git checkout experimental
>  ------------------------------------------------
>=20
> -para mudar para o ramo experimental.  Agora edite um arquivo, grave a
> +para mudar para o ramo experimental. Agora edite um arquivo, grave a
>  mudan=C3=A7a, e mude de volta para o ramo master:
>=20
>  ------------------------------------------------
> @@ -230,14 +229,14 @@ $ git commit -a
>  ------------------------------------------------
>=20
>  neste ponto, os dois ramos divergiram, com diferentes mudan=C3=A7as feit=
as em
> -cada um.  Para unificar as mudan=C3=A7as feitas no experimental para o
> +cada um. Para unificar as mudan=C3=A7as feitas no experimental para o
>  master, execute
>=20
>  ------------------------------------------------
>  $ git merge experimental
>  ------------------------------------------------
>=20
> -Se as mudan=C3=A7as n=C3=A3o conflitam, est=C3=A1 pronto.  Se existirem =
conflitos,
> +Caso as mudan=C3=A7as n=C3=A3o conflitam, est=C3=A1 pronto. Se existirem=
 conflitos,

I think the time tense here should be changed if we change from "Se" to
"Caso". I'd rather keep "Se ... conflitam".

>  marcadores ser=C3=A3o deixados nos arquivos problem=C3=A1ticos exibindo o
>  conflito;
>=20
> @@ -245,7 +244,7 @@ conflito;
>  $ git diff
>  ------------------------------------------------
>=20
> -vai exibir isto.  Ap=C3=B3s voc=C3=AA editar os arquivos para resolver os
> +vai exibir isto. Ap=C3=B3s voc=C3=AA editar os arquivos para resolver os
>  conflitos,
>=20
>  ------------------------------------------------
> @@ -273,10 +272,10 @@ Se voc=C3=AA desenvolve em um ramo ideia-louca, e se
> arrepende, voc=C3=AA pode
>  sempre remover o ramo com
>=20
>  -------------------------------------
> -$ git branch -D crazy-idea
> +$ git branch -D ideia-louca
>  -------------------------------------
>=20
> -Ramos s=C3=A3o baratos e f=C3=A1ceis, ent=C3=A3o isto =C3=A9 uma boa man=
eira de experimentar
> +Ramos s=C3=A3o eficientes e f=C3=A1ceis, ent=C3=A3o isto =C3=A9 uma boa =
maneira de experimentar

I like "cheap", instead of "efficient". "cheap" is in the primary
documentation, so I'd rather keep it "baratos".

>  alguma coisa.
>=20
>  Usando git para colabora=C3=A7=C3=A3o
> @@ -293,7 +292,7 @@ bob$ git clone /home/alice/project myrepo
>  ------------------------------------------------
>=20
>  Isso cria um novo diret=C3=B3rio "myrepo" contendo um clone do reposit=
=C3=B3rio de
> -Alice.  O clone est=C3=A1 no mesmo p=C3=A9 que o projeto original, possu=
indo sua
> +Alice. O clone est=C3=A1 no mesmo p=C3=A9 que o projeto original, possui=
ndo sua
>  pr=C3=B3pria c=C3=B3pia da hist=C3=B3ria do projeto original.
>=20
>  Bob ent=C3=A3o faz algumas mudan=C3=A7as e as grava:
> @@ -305,7 +304,7 @@ bob$ git commit -a
>  ------------------------------------------------
>=20
>  Quanto est=C3=A1 pronto, ele diz a Alice para puxar as mudan=C3=A7as do
> -reposit=C3=B3rio em /home/bob/myrepo.  Ela o faz com:
> +reposit=C3=B3rio em /home/bob/myrepo. Ela o faz com:
>=20
>  ------------------------------------------------
>  alice$ cd /home/alice/project
> @@ -314,14 +313,14 @@ alice$ git pull /home/bob/myrepo master
>=20
>  Isto unifica as mudan=C3=A7as do ramo "master" do Bob ao ramo atual de A=
lice.
>  Se Alice fez suas pr=C3=B3prias mudan=C3=A7as no intervalo, ela, ent=C3=
=A3o, pode
> -precisar corrigir manualmente quaiquer conflitos.  (Note que o argumento
> +precisar corrigir manualmente quaisquer conflitos. (Note que o argumento
>  "master" no comando acima =C3=A9, de fato, desnecess=C3=A1rio, j=C3=A1 q=
ue =C3=A9 o padr=C3=A3o.)
>=20
>  O comando "pull" executa, ent=C3=A3o, duas opera=C3=A7=C3=B5es: ele obt=
=C3=A9m mudan=C3=A7as de
>  um ramo remoto, e, ent=C3=A3o, as unifica no ramo atual.
>=20
>  Note que, em geral, Alice gostaria que suas mudan=C3=A7as locais fossem
> -gravadas antes de iniciar este "pull".  Se o trabalho de Bobo conflita
> +gravadas antes de iniciar este "pull". Se o trabalho de Bob conflita
>  com o que Alice fez desde que suas hist=C3=B3rias se ramificaram, Alice =
ir=C3=A1
>  usar seu diret=C3=B3rio de trabalho e o =C3=ADndice para resolver confli=
tos, e
>  mudan=C3=A7as locais existentes ir=C3=A3o interferir com o processo de r=
esolu=C3=A7=C3=A3o
> @@ -341,18 +340,18 @@ alice$ git log -p HEAD..FETCH_HEAD
>=20
>  Esta opera=C3=A7=C3=A3o =C3=A9 segura mesmo se Alice tem mudan=C3=A7as l=
ocais n=C3=A3o gravadas.
>  A nota=C3=A7=C3=A3o de intervalo "HEAD..FETCH_HEAD" significa mostrar tu=
do que =C3=A9
> -alcan=C3=A7=C3=A1vel de FETCH_HEAD mas exclua tudo que =C3=A9 alcan=C3=
=A7=C3=A1vel de HEAD. Alcie
> -j=C3=A1 sabe tudo que leva a seu estado atual (HEAD), e revisa o que Bob=
 tem
> -em seu estado (FETCH_HEAD) que ela ainda n=C3=A3o viu com esse comando.
> +alcan=C3=A7=C3=A1vel de FETCH_HEAD mas exclua tudo o que =C3=A9 alcan=C3=
=A7=C3=A1vel de HEAD.
> +Alice j=C3=A1 sabe tudo que leva a seu estado atual (HEAD), e revisa o q=
ue Bob
> +tem em seu estado (FETCH_HEAD) que ela ainda n=C3=A3o viu com esse coman=
do.
>=20
> -Se Alice quer visualizar o que Bob fez desde que suas hist=C3=B3ria
> +Se Alice quer visualizar o que Bob fez desde que suas hist=C3=B3rias se
>  ramificaram, ela pode disparar o seguinte comando:
>=20
>  ------------------------------------------------
>  $ gitk HEAD..FETCH_HEAD
>  ------------------------------------------------
>=20
> -Isto usar a mesma nota=C3=A7=C3=A3o de intervaldo que vimos antes com 'g=
it log'.
> +Isto usa a mesma nota=C3=A7=C3=A3o de intervalo que vimos antes com 'git=
 log'.
>=20
>  Alice pode querer ver o que ambos fizeram desde que ramificaram. Ela
>  pode usar a forma com tr=C3=AAs pontos ao inv=C3=A9s da forma com dois p=
ontos:
> @@ -361,23 +360,21 @@ pode usar a forma com tr=C3=AAs pontos ao inv=C3=A9=
s da
> forma com dois pontos:
>  $ gitk HEAD...FETCH_HEAD
>  ------------------------------------------------
>=20
> -Isto significa "mostre tudo que =C3=A9 alcan=C3=A7avel de qualquer um, m=
as exclua
> -tudo que =C3=A9 alcan=C3=A7avel a partir de ambos".
> -This means "show everything that is reachable from either one, but
> -exclude anything that is reachable from both of them".
> +Isto significa "mostre tudo que =C3=A9 alcan=C3=A7=C3=A1vel de qualquer =
um deles, mas
> +exclua tudo que =C3=A9 alcan=C3=A7=C3=A1vel a partir de ambos".
>=20
>  Por favor, note que essas nota=C3=A7=C3=B5es de intervalo podem ser usad=
as tanto
>  com gitk quanto com "git log".
>=20
> -Apo=C3=B3s inspecionar o que Bob fez, se n=C3=A3o h=C3=A1 nada urgente, =
Alice pode
> -decidir continuar trabalhando sem puxar de Bob.  Se a hist=C3=B3ria de B=
ob
> +Ap=C3=B3s inspecionar o que Bob fez, se n=C3=A3o h=C3=A1 nada urgente, A=
lice pode
> +decidir continuar trabalhando sem puxar de Bob. Se a hist=C3=B3ria de Bob
>  tem alguma coisa que Alice precisa imediatamente, Alice pode optar por
>  separar seu trabalho em progresso primeiro, fazer um "pull", e, ent=C3=
=A3o,
>  finalmente, retomar seu trabalho em progresso em cima da hist=C3=B3ria
>  resultante.
>=20
> -Quanto voc=C3=AA est=C3=A1 trabalhando em um pequeno grupo unido, n=C3=
=A3o =C3=A9 incomum
> -interagir com o mesmo reposit=C3=B3rio v=C3=A1rias e v=C3=A1rias vezes. =
 Definindo um
> +Quando voc=C3=AA est=C3=A1 trabalhando em um pequeno grupo unido, n=C3=
=A3o =C3=A9 incomum
> +interagir com o mesmo reposit=C3=B3rio v=C3=A1rias e v=C3=A1rias vezes. =
Definindo um
>  reposit=C3=B3rio remoto antes de tudo, voc=C3=AA pode faz=C3=AA-lo mais =
facilmente:
>=20
>  ------------------------------------------------
> @@ -394,7 +391,7 @@ alice$ git fetch bob
>=20
>  Diferente da forma longa, quando Alice obteve de Bob usando um
>  reposit=C3=B3rio remoto antes definido com 'git-remote', o que foi obtid=
o =C3=A9
> -armazenado um ramo remoto, neste caso `bob/master`.  Ent=C3=A3o, ap=C3=
=B3s isso:
> +armazenado em um ramo remoto, neste caso `bob/master`. Ent=C3=A3o, ap=C3=
=B3s isso:
>=20
>  -------------------------------------
>  alice$ git log -p master..bob/master
> @@ -417,7 +414,7 @@ alice$ git pull . remotes/bob/master
>  -------------------------------------
>=20
>  Note que 'git pull' sempre unifica ao ramo atual, independente do que
> -mais foi dado na linha de comando.
> +mais foi passado na linha de comando.
>=20
>  Depois, Bob pode atualizar seu reposit=C3=B3rio com as =C3=BAltimas muda=
n=C3=A7as de
>  Alice, usando
> @@ -428,7 +425,7 @@ bob$ git pull
>=20
>  Note que ele n=C3=A3o precisa dar o caminho do reposit=C3=B3rio de Alice=
; quando
>  Bob clonou seu reposit=C3=B3rio, o git armazenou a localiza=C3=A7=C3=A3o=
 de seu
> -reposit=C3=B3rio na configura=C3=A7=C3=A3o do reposit=C3=B3rio, e essa l=
ocaliza=C3=A7=C3=A3o =C3=A9 usada
> +reposit=C3=B3rio na configura=C3=A7=C3=A3o do mesmo, e essa localiza=C3=
=A7=C3=A3o =C3=A9 usada
>  para puxar:
>=20
>  -------------------------------------
> @@ -459,15 +456,15 @@ Alternativamente, o git tem um protocolo nativo,
> ou pode usar rsync ou
>  http; veja linkgit:git-pull[1] para detalhes.
>=20
>  Git pode tamb=C3=A9m ser usado em um modo parecido com CVS, com um
> -reposit=C3=B3rio central para o qual que v=C3=A1rios usu=C3=A1rios empur=
ram
> -modifica=C3=A7=C3=B5es; veja linkgit:git-push[1] e linkgit:gitcvs-migrat=
ion[7].
> +reposit=C3=B3rio central para o qual v=C3=A1rios usu=C3=A1rios empurram =
modifica=C3=A7=C3=B5es;
> +veja linkgit:git-push[1] e linkgit:gitcvs-migration[7].
>=20
>  Explorando hist=C3=B3ria
>  -----------------
>=20
>  A hist=C3=B3ria no git =C3=A9 representada como uma s=C3=A9rie de commits
> -interrelacionados.  N=C3=B3s j=C3=A1 vimos que o comando 'git-log' pode =
listar
> -esses commits. Note que a primeira linha de cama entrada no log tamb=C3=
=A9m
> +interrelacionados. N=C3=B3s j=C3=A1 vimos que o comando 'git-log' pode l=
istar
> +esses commits. Note que a primeira linha de cada entrada no log tamb=C3=
=A9m
>  d=C3=A1 o nome para o commit:
>=20
>  -------------------------------------
> @@ -486,9 +483,9 @@ commit.
>  $ git show c82a22c39cbc32576f64f5c6b3f24b99ea8149c7
>  -------------------------------------
>=20
> -Mas h=C3=A1 outras formas de se referir a commits.  Voc=C3=AA pode usar =
qualquer
> -parte inicial do nome que seja longo o bastante para unicamente
> -identificar o commit:
> +Mas h=C3=A1 outras formas de se referir aos commits. Voc=C3=AA pode usar=
 qualquer
> +parte inicial do nome que seja longo o bastante para identificar
> +unicamente o commit:
>=20
>  -------------------------------------
>  $ git show c82a22c39c	# os primeiros caracteres do nome s=C3=A3o o basta=
nte
> @@ -497,7 +494,7 @@ $ git show HEAD		# a ponta do ramo atual
>  $ git show experimental	# a ponta do ramo "experimental"
>  -------------------------------------
>=20
> -Todo commit usualmente tem um commit "pai" que aponta para o estado
> +Todo commit normalmente tem um commit "pai" que aponta para o estado
>  anterior do projeto:
>=20
>  -------------------------------------
> @@ -513,19 +510,19 @@ $ git show HEAD^1 # mostra o primeiro pai de
> HEAD (o mesmo que HEAD^)
>  $ git show HEAD^2 # mostra o segundo pai de HEAD
>  -------------------------------------
>=20
> -Voc=C3=AA tamb=C3=A9m pode dar aos commits nomes seus; ap=C3=B3s executar
> +Voc=C3=AA tamb=C3=A9m pode dar aos commits nomes =C3=A0 sua escolha; ap=
=C3=B3s executar
>=20
>  -------------------------------------
>  $ git tag v2.5 1b2e1d63ff
>  -------------------------------------
>=20
> -voc=C3=AA pode se referir a 1b2e1d63ff pelo nome "v2.5".  Se voc=C3=AA p=
retende
> +voc=C3=AA pode se referir a 1b2e1d63ff pelo nome "v2.5". Se voc=C3=AA pr=
etende
>  compartilhar esse nome com outras pessoas (por exemplo, para identificar
> -uma vers=C3=A3o de lan=C3=A7amento), voc=C3=AA deve criar um objeto "tag=
", e talvez
> +uma vers=C3=A3o de lan=C3=A7amento), voc=C3=AA deveria criar um objeto "=
tag", e talvez
>  assin=C3=A1-lo; veja linkgit:git-tag[1] para detalhes.
>=20
>  Qualquer comando git que precise conhecer um commit pode receber
> -quaisquer desses nomes.  Por exemplo:
> +quaisquer desses nomes. Por exemplo:
>=20
>  -------------------------------------
>  $ git diff v2.5 HEAD	 # compara o HEAD atual com v2.5
> @@ -537,8 +534,8 @@ $ git reset --hard HEAD^ # reseta seu ramo atual e
> seu diret=C3=B3rio de
>=20
>  Seja cuidadoso com o =C3=BAltimo comando: al=C3=A9m de perder quaisquer =
mudan=C3=A7as
>  em seu diret=C3=B3rio de trabalho, ele tamb=C3=A9m remove todos os commi=
ts
> -posteriores desse ramo.  Se esse ramo =C3=A9 o =C3=BAnico ramo contendo =
esses
> -commits, eles ser=C3=A3o perdidos.  Tamb=C3=A9m, n=C3=A3o use 'git-reset=
' num ramo
> +posteriores desse ramo. Se esse ramo =C3=A9 o =C3=BAnico ramo contendo e=
sses
> +commits, eles ser=C3=A3o perdidos. Tamb=C3=A9m, n=C3=A3o use 'git-reset'=
 num ramo
>  publicamente vis=C3=ADvel de onde outros desenvolvedores puxam, j=C3=A1 =
que vai
>  for=C3=A7ar unifica=C3=A7=C3=B5es desnecess=C3=A1rias para que outros de=
senvolvedores limpem
>  a hist=C3=B3ria. Se voc=C3=AA precisa desfazer mudan=C3=A7as que voc=C3=
=AA empurrou, use
> @@ -551,10 +548,10 @@ projeto, ent=C3=A3o
>  $ git grep "hello" v2.5
>  -------------------------------------
>=20
> -procura por todas as ocorre=C3=AAncias de "hello" em v2.5.
> +procura por todas as ocorr=C3=AAncias de "hello" em v2.5.
>=20
>  Se voc=C3=AA deixar de fora o nome do commit, 'git-grep' ir=C3=A1 procur=
ar
> -quaisquer dos arquivos que ele gerencia no diret=C3=B3rio corrente.  Ent=
=C3=A3o
> +quaisquer dos arquivos que ele gerencia no diret=C3=B3rio corrente. Ent=
=C3=A3o
>=20
>  -------------------------------------
>  $ git grep "hello"
> @@ -564,8 +561,7 @@ $ git grep "hello"
>  git.
>=20
>  Muitos comandos git tamb=C3=A9m recebem um conjunto de commits, o que po=
de
> -ser especificado de um bom n=C3=BAmero de formas.  Aqui est=C3=A3o algun=
s exemplos
> -com 'git-log':
> +ser especificado de v=C3=A1rias formas. Aqui est=C3=A3o alguns exemplos =
com 'git-log':
>=20
>  -------------------------------------
>  $ git log v2.5..v2.6            # commits entre v2.5 e v2.6
> @@ -584,7 +580,7 @@ comum algum tempo atr=C3=A1s, ent=C3=A3o
>  $ git log stable..master
>  -------------------------------------
>=20
> -ir=C3=A1 listas os commits feitos no ramo "master" mas n=C3=A3o no ramo
> +ir=C3=A1 listar os commits feitos no ramo "master" mas n=C3=A3o no ramo
>  "stable", enquanto
>=20
>  -------------------------------------
> @@ -594,26 +590,26 @@ $ git log master..stable
>  ir=C3=A1 listar a lista de commits feitos no ramo "stable" mas n=C3=A3o =
no ramo
>  "master".
>=20
> -O comando 'git-log' tem uma fraquza: ele precisa mostrar os commits em
> +O comando 'git-log' tem uma fraqueza: ele precisa mostrar os commits em
>  uma lista. Quando a hist=C3=B3ria tem linhas de desenvolvimento que
>  divergiram e ent=C3=A3o foram unificadas novamente, a ordem em que 'git-=
log'
> -apresenta essas mudan=C3=A7as =C3=A9 insignificante.
> +apresenta essas mudan=C3=A7as =C3=A9 irrelevante.
>=20
>  A maioria dos projetos com m=C3=BAltiplos contribuidores (como o kernel
> -linux, ou o git mesmo) tem unifica=C3=A7=C3=B5es frequentes, e 'gitk' fa=
z um
> -trabalho melhor de visualizar sua hist=C3=B3ria.  Por exemplo,
> +Linux, ou o pr=C3=B3prio git) tem unifica=C3=A7=C3=B5es frequentes, e 'g=
itk' faz um
> +trabalho melhor de visualizar sua hist=C3=B3ria. Por exemplo,
>=20
>  -------------------------------------
>  $ gitk --since=3D"2 weeks ago" drivers/
>  -------------------------------------
>=20
> -permite voc=C3=AA navegar em quaisquer commits desde as =C3=BAltimas dua=
s semanas
> -de commits que modificaram arquivos sob o diret=C3=B3rio "drivers".  (No=
ta:
> +permite a voc=C3=AA navegar em quaisquer commits desde as =C3=BAltimas d=
uas semanas
> +de commits que modificaram arquivos sob o diret=C3=B3rio "drivers". (Not=
a:
>  voc=C3=AA pode ajustar as fontes do gitk segurando a tecla control enqua=
nto
>  pressiona "-" ou "+".)
>=20
> -Finalmente, a maioria dos comandos que recebem nomes de arquivo
> -te permitir=C3=A3o opcionalmente preceder qualquer nome de arquivo por um
> +Finalmente, a maioria dos comandos que recebem nomes de arquivo permitir=
=C3=A3o
> +tamb=C3=A9m, opcionalmente, preceder qualquer nome de arquivo por um
>  commit, para especificar uma vers=C3=A3o particular do arquivo:
>=20
>  -------------------------------------
> @@ -630,33 +626,33 @@ Pr=C3=B3ximos passos
>  ----------
>=20
>  Este tutorial deve ser o bastante para operar controle de revis=C3=A3o
> -distribu=C3=ADdo b=C3=A1sico para seus projetos.  No entanto, para enten=
der
> +distribu=C3=ADdo b=C3=A1sico para seus projetos. No entanto, para entend=
er
>  plenamente a profundidade e o poder do git voc=C3=AA precisa entender du=
as
>  id=C3=A9ias simples nas quais ele se baseia:
>=20
>    * A base de objetos =C3=A9 um sistema bem elegante usado para armazena=
r a
>      hist=C3=B3ria de seu projeto--arquivos, diret=C3=B3rios, e commits.
>=20
> -  * O arquivo de =C3=ADndica =C3=A9 um cache do estado de uma =C3=A1rvor=
e de diret=C3=B3rio,
> +  * O arquivo de =C3=ADndice =C3=A9 um cache do estado de uma =C3=A1rvor=
e de diret=C3=B3rio,
>      usado para criar commits, restaurar diret=C3=B3rios de trabalho, e
> -    compreender as v=C3=A1rias =C3=A1rvores involvidas em uma unifica=C3=
=A7=C3=A3o.
> +    armazenar as v=C3=A1rias =C3=A1rvores envolvidas em uma unifica=C3=
=A7=C3=A3o.
>=20
> -Parte dois deste tutorial explica a base de objetos, o arquivo de
> +A parte dois deste tutorial explica a base de objetos, o arquivo de
>  =C3=ADndice, e algumas outras coisinhas que voc=C3=AA vai precisar pra u=
sar o
>  m=C3=A1ximo do git. Voc=C3=AA pode encontr=C3=A1-la em linkgit:gittutori=
al-2[7].
>=20
> -Se voc=C3=AA n=C3=A3o quer continuar do jeito certo, algumas outras disg=
ress=C3=B5es
> -que podem ser interessantes neste ponto s=C3=A3o:
> +Se voc=C3=AA n=C3=A3o quiser continuar com o tutorial agora nesse moment=
o, algumas
> +outras digress=C3=B5es que podem ser interessantes neste ponto s=C3=A3o:
>=20
>    * linkgit:git-format-patch[1], linkgit:git-am[1]: Estes convertem
> -    s=C3=A9ries de commits em patches em email, e vice-versa, =C3=BAteis=
 para
> -    projetos como o kernel linux que dependem pesadamente em patches
> +    s=C3=A9ries de commits em patches para email, e vice-versa, =C3=BAte=
is para
> +    projetos como o kernel Linux que dependem fortemente de patches
>      enviados por email.
>=20
>    * linkgit:git-bisect[1]: Quando h=C3=A1 uma regress=C3=A3o em seu proj=
eto, uma
>      forma de rastrear um bug =C3=A9 procurando pela hist=C3=B3ria para e=
ncontrar o
> -    commit culpado.  Git bisect pode ajudar a executar uma busca bin=C3=
=A1ria
> -    por esse commit.  Ele =C3=A9 inteligente o bastante para executar uma
> +    commit culpado. Git bisect pode ajudar a executar uma busca bin=C3=
=A1ria
> +    por esse commit. Ele =C3=A9 inteligente o bastante para executar uma
>      busca pr=C3=B3xima da =C3=B3tima mesmo no caso de uma hist=C3=B3ria =
complexa
>      n=C3=A3o-linear com muitos ramos unificados.
>=20
> @@ -664,7 +660,7 @@ que podem ser interessantes neste ponto s=C3=A3o:
>=20
>    * linkgit:gitcvs-migration[7]: Git para usu=C3=A1rios de CVS.
>=20
> -Veja Tamb=C3=A9m
> +Veja tamb=C3=A9m
>  --------

This is all caps in the original. The original mix style in these
topics, using "SEE ALSO", "Next Steps" and "Exploring history" to give a
few examples.

>  linkgit:gittutorial-2[7],
>  linkgit:gitcvs-migration[7],
> --=20
> 1.6.4.388.gc1120


Regards,
Cascardo.

--xgyAXRrhYN0wYx8y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkpzHOUACgkQyTpryRcqtS0NlQCgks9ZA2PCamoHxrfcu2fAmZkj
Lw4An0cOVtFG7pFApFloLMljo7QErfb9
=QoQM
-----END PGP SIGNATURE-----

--xgyAXRrhYN0wYx8y--
