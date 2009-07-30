From: =?ISO-8859-1?Q?Andr=E9_Goddard_Rosa?= <andre.goddard@gmail.com>
Subject: [PATCH v2] Fix typos on pt_BR/gittutorial.txt translation
Date: Thu, 30 Jul 2009 14:31:08 -0300
Message-ID: <b8bf37780907301031iec37ef8i6b3db7a9eb21eb8b@mail.gmail.com>
References: <b8bf37780907292044i5ad7b879ueb5048447e4e5bb5@mail.gmail.com>
	 <20090730145044.GA1727@vespa.holoscopio.com>
	 <4A71C6A7.80008@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016e645b9be48c139046fefab3c
Cc: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>,
	"Carlos R. Mafra" <crmafra2@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 30 19:31:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWZTS-0003k6-Dv
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 19:31:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751769AbZG3RbM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2009 13:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751692AbZG3RbM
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jul 2009 13:31:12 -0400
Received: from mail-qy0-f196.google.com ([209.85.221.196]:57161 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751629AbZG3RbJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2009 13:31:09 -0400
Received: by qyk34 with SMTP id 34so966202qyk.33
        for <git@vger.kernel.org>; Thu, 30 Jul 2009 10:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=ZJKsupoWof6OsE5DChEOzixx05AO+PjWLpafAxSJQx8=;
        b=fd5Q9P8nT9cYihtapveAjGKj/GqdSLgGmSnFmnlnOBzD6gF/5an3d7i4mUYRk/OZEI
         qtL9JZj3VT6UkxrW6qWWSqr8DVQ2AK1gD3IdyGvvxHeTsZRry5E+eFKexrcDfSzmvQY2
         rOt0+71ZzIQZ60Xh5cTB6+90NHjcJmgPXRqYI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=DKUlE1UxH/TDj91RLoK1rXC21Xe81nrI0aqzHvmmwtnzKBtXvnZmTw8xZPWrF+yAS8
         mUY4DOErt/cdtrWmWRrZDBuQt90Y3lwmz2+d5dn2L1nkivKdFgiyX9IXFEBPmzr79m80
         5vv5gJs0u+l0DSJfXBSb+7/EuxWq6hdXdaw/M=
Received: by 10.220.90.199 with SMTP id j7mr1770857vcm.57.1248975068379; Thu, 
	30 Jul 2009 10:31:08 -0700 (PDT)
In-Reply-To: <4A71C6A7.80008@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124472>

--0016e645b9be48c139046fefab3c
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

>From 02eb3045e4f1415528f8c07f6c9bafb0beb8c8cc Mon Sep 17 00:00:00 2001
From: =3D?UTF-8?q?Andr=3DC3=3DA9=3D20Goddard=3D20Rosa?=3D <andre.goddard@gm=
ail.com>
Date: Thu, 30 Jul 2009 14:20:02 -0300
Subject: [PATCH] [PATCH] Fix typos on pt_BR/gittutorial.txt translation
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Andr=E9 Goddard Rosa <andre.goddard@gmail.com>
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Signed-off-by: Carlos R. Mafra <crmafra2@gmail.com>
[Included extra fixes from Thadeu and Carlos as well]
---
 Documentation/pt_BR/gittutorial.txt |  144 +++++++++++++++++--------------=
----
 1 files changed, 70 insertions(+), 74 deletions(-)

diff --git a/Documentation/pt_BR/gittutorial.txt
b/Documentation/pt_BR/gittutorial.txt
index f368b1b..38fab57 100644
--- a/Documentation/pt_BR/gittutorial.txt
+++ b/Documentation/pt_BR/gittutorial.txt
@@ -16,7 +16,7 @@ Este tutorial explica como importar um novo projeto
para o git,
 adicionar mudan=E7as a ele, e compartilhar mudan=E7as com outros
 desenvolvedores.

-If, ao inv=E9s disso, voc=EA est=E1 interessado primariamente em usar git =
para
+Se, ao inv=E9s disso, voc=EA est=E1 interessado primariamente em usar git =
para
 obter um projeto, por exemplo, para testar a =FAltima vers=E3o, voc=EA pod=
e
 preferir come=E7ar com os primeiros dois cap=EDtulos de
 link:user-manual.html[O Manual do Usu=E1rio Git].
@@ -37,9 +37,8 @@ $ git help log
 Com a =FAltima forma, voc=EA pode usar o visualizador de manual de sua
 escolha; veja linkgit:git-help[1] para maior informa=E7=E3o.

-=C9 uma boa id=E9ia se introduzir ao git com seu nome e endere=E7o p=FAbli=
co de
-email antes de fazer qualquer opera=E7=E3o. A maneira mais f=E1cil de faz=
=EA-lo
-=E9:
+=C9 uma boa id=E9ia informar ao git seu nome e endere=E7o p=FAblico de ema=
il
+antes de fazer qualquer opera=E7=E3o. A maneira mais f=E1cil de faz=EA-lo =
=E9:

 ------------------------------------------------
 $ git config --global user.name "Seu Nome Vem Aqui"
@@ -51,7 +50,7 @@ Importando um novo projeto
 -----------------------

 Assuma que voc=EA tem um tarball project.tar.gz com seu trabalho inicial.
-Voc=EA pode coloc=E1-lo sob controle de revis=E3o git como a seguir.
+Voc=EA pode coloc=E1-lo sob controle de revis=E3o git da seguinte forma:

 ------------------------------------------------
 $ tar xzf project.tar.gz
@@ -76,7 +75,7 @@ $ git add .
 ------------------------------------------------

 Este instant=E2neo est=E1 agora armazenado em uma =E1rea tempor=E1ria que =
o git
-chama de "index" ou =EDndice. Voc=EA pode permanetemente armazenar o
+chama de "index" ou =EDndice. Voc=EA pode armazenar permanentemente o
 conte=FAdo do =EDndice no reposit=F3rio com 'git-commit':

 ------------------------------------------------
@@ -142,7 +141,7 @@ novos), adicion=E1-los ao =EDndices, e gravar, tudo em
um =FAnico passo.
 Uma nota em mensagens de commit: Apesar de n=E3o ser exigido, =E9 uma boa
 id=E9ia come=E7ar a mensagem com uma simples e curta (menos de 50
 caracteres) linha sumarizando a mudan=E7a, seguida de uma linha em branco
-e, ent=E3o, uma descri=E7=E3o mais detalhada.  Ferramentas que transformam
+e, ent=E3o, uma descri=E7=E3o mais detalhada. Ferramentas que transformam
 commits em email, por exemplo, usam a primeira linha no campo de
 cabe=E7alho Subject: e o resto no corpo.

@@ -150,7 +149,7 @@ Git rastreia conte=FAdo, n=E3o arquivos
 ----------------------------

 Muitos sistemas de controle de revis=E3o prov=EAem um comando `add` que di=
z
-ao sistema para come=E7ar a rastrear mudan=E7as em um novo arquivo.  O
+ao sistema para come=E7ar a rastrear mudan=E7as em um novo arquivo. O
 comando `add` do git faz algo mais simples e mais poderoso: 'git-add' =E9
 usado tanto para arquivos novos e arquivos recentemente modificados, e
 em ambos os casos, ele tira o instant=E2neo dos arquivos dados e armazena
@@ -183,7 +182,7 @@ Gerenciando "branches"/ramos
 -----------------

 Um simples reposit=F3rio git pode manter m=FAltiplos ramos de
-desenvolvimento.  Para criar um novo ramo chamado "experimental", use
+desenvolvimento. Para criar um novo ramo chamado "experimental", use

 ------------------------------------------------
 $ git branch experimental
@@ -203,14 +202,14 @@ voc=EA vai obter uma lista de todos os ramos existent=
es:
 ------------------------------------------------

 O ramo "experimental" =E9 o que voc=EA acaba de criar, e o ramo "master" =
=E9 o
-ramo padr=E3o que foi criado pra voc=EA automaticamente.  O asterisco marc=
a
+ramo padr=E3o que foi criado pra voc=EA automaticamente. O asterisco marca
 o ramo em que voc=EA est=E1 atualmente; digite

 ------------------------------------------------
 $ git checkout experimental
 ------------------------------------------------

-para mudar para o ramo experimental.  Agora edite um arquivo, grave a
+para mudar para o ramo experimental. Agora edite um arquivo, grave a
 mudan=E7a, e mude de volta para o ramo master:

 ------------------------------------------------
@@ -230,14 +229,14 @@ $ git commit -a
 ------------------------------------------------

 neste ponto, os dois ramos divergiram, com diferentes mudan=E7as feitas em
-cada um.  Para unificar as mudan=E7as feitas no experimental para o
+cada um. Para unificar as mudan=E7as feitas no experimental para o
 master, execute

 ------------------------------------------------
 $ git merge experimental
 ------------------------------------------------

-Se as mudan=E7as n=E3o conflitam, est=E1 pronto.  Se existirem conflitos,
+Caso as mudan=E7as n=E3o conflitam, est=E1 pronto. Se existirem conflitos,
 marcadores ser=E3o deixados nos arquivos problem=E1ticos exibindo o
 conflito;

@@ -245,7 +244,7 @@ conflito;
 $ git diff
 ------------------------------------------------

-vai exibir isto.  Ap=F3s voc=EA editar os arquivos para resolver os
+vai exibir isto. Ap=F3s voc=EA editar os arquivos para resolver os
 conflitos,

 ------------------------------------------------
@@ -273,10 +272,10 @@ Se voc=EA desenvolve em um ramo ideia-louca, e se
arrepende, voc=EA pode
 sempre remover o ramo com

 -------------------------------------
-$ git branch -D crazy-idea
+$ git branch -D ideia-louca
 -------------------------------------

-Ramos s=E3o baratos e f=E1ceis, ent=E3o isto =E9 uma boa maneira de experi=
mentar
+Ramos s=E3o eficientes e f=E1ceis, ent=E3o isto =E9 uma boa maneira de exp=
erimentar
 alguma coisa.

 Usando git para colabora=E7=E3o
@@ -293,7 +292,7 @@ bob$ git clone /home/alice/project myrepo
 ------------------------------------------------

 Isso cria um novo diret=F3rio "myrepo" contendo um clone do reposit=F3rio =
de
-Alice.  O clone est=E1 no mesmo p=E9 que o projeto original, possuindo sua
+Alice. O clone est=E1 no mesmo p=E9 que o projeto original, possuindo sua
 pr=F3pria c=F3pia da hist=F3ria do projeto original.

 Bob ent=E3o faz algumas mudan=E7as e as grava:
@@ -305,7 +304,7 @@ bob$ git commit -a
 ------------------------------------------------

 Quanto est=E1 pronto, ele diz a Alice para puxar as mudan=E7as do
-reposit=F3rio em /home/bob/myrepo.  Ela o faz com:
+reposit=F3rio em /home/bob/myrepo. Ela o faz com:

 ------------------------------------------------
 alice$ cd /home/alice/project
@@ -314,14 +313,14 @@ alice$ git pull /home/bob/myrepo master

 Isto unifica as mudan=E7as do ramo "master" do Bob ao ramo atual de Alice.
 Se Alice fez suas pr=F3prias mudan=E7as no intervalo, ela, ent=E3o, pode
-precisar corrigir manualmente quaiquer conflitos.  (Note que o argumento
+precisar corrigir manualmente quaisquer conflitos. (Note que o argumento
 "master" no comando acima =E9, de fato, desnecess=E1rio, j=E1 que =E9 o pa=
dr=E3o.)

 O comando "pull" executa, ent=E3o, duas opera=E7=F5es: ele obt=E9m mudan=
=E7as de
 um ramo remoto, e, ent=E3o, as unifica no ramo atual.

 Note que, em geral, Alice gostaria que suas mudan=E7as locais fossem
-gravadas antes de iniciar este "pull".  Se o trabalho de Bobo conflita
+gravadas antes de iniciar este "pull". Se o trabalho de Bob conflita
 com o que Alice fez desde que suas hist=F3rias se ramificaram, Alice ir=E1
 usar seu diret=F3rio de trabalho e o =EDndice para resolver conflitos, e
 mudan=E7as locais existentes ir=E3o interferir com o processo de resolu=E7=
=E3o
@@ -341,18 +340,18 @@ alice$ git log -p HEAD..FETCH_HEAD

 Esta opera=E7=E3o =E9 segura mesmo se Alice tem mudan=E7as locais n=E3o gr=
avadas.
 A nota=E7=E3o de intervalo "HEAD..FETCH_HEAD" significa mostrar tudo que =
=E9
-alcan=E7=E1vel de FETCH_HEAD mas exclua tudo que =E9 alcan=E7=E1vel de HEA=
D. Alcie
-j=E1 sabe tudo que leva a seu estado atual (HEAD), e revisa o que Bob tem
-em seu estado (FETCH_HEAD) que ela ainda n=E3o viu com esse comando.
+alcan=E7=E1vel de FETCH_HEAD mas exclua tudo o que =E9 alcan=E7=E1vel de H=
EAD.
+Alice j=E1 sabe tudo que leva a seu estado atual (HEAD), e revisa o que Bo=
b
+tem em seu estado (FETCH_HEAD) que ela ainda n=E3o viu com esse comando.

-Se Alice quer visualizar o que Bob fez desde que suas hist=F3ria
+Se Alice quer visualizar o que Bob fez desde que suas hist=F3rias se
 ramificaram, ela pode disparar o seguinte comando:

 ------------------------------------------------
 $ gitk HEAD..FETCH_HEAD
 ------------------------------------------------

-Isto usar a mesma nota=E7=E3o de intervaldo que vimos antes com 'git log'.
+Isto usa a mesma nota=E7=E3o de intervalo que vimos antes com 'git log'.

 Alice pode querer ver o que ambos fizeram desde que ramificaram. Ela
 pode usar a forma com tr=EAs pontos ao inv=E9s da forma com dois pontos:
@@ -361,23 +360,21 @@ pode usar a forma com tr=EAs pontos ao inv=E9s da
forma com dois pontos:
 $ gitk HEAD...FETCH_HEAD
 ------------------------------------------------

-Isto significa "mostre tudo que =E9 alcan=E7avel de qualquer um, mas exclu=
a
-tudo que =E9 alcan=E7avel a partir de ambos".
-This means "show everything that is reachable from either one, but
-exclude anything that is reachable from both of them".
+Isto significa "mostre tudo que =E9 alcan=E7=E1vel de qualquer um deles, m=
as
+exclua tudo que =E9 alcan=E7=E1vel a partir de ambos".

 Por favor, note que essas nota=E7=F5es de intervalo podem ser usadas tanto
 com gitk quanto com "git log".

-Apo=F3s inspecionar o que Bob fez, se n=E3o h=E1 nada urgente, Alice pode
-decidir continuar trabalhando sem puxar de Bob.  Se a hist=F3ria de Bob
+Ap=F3s inspecionar o que Bob fez, se n=E3o h=E1 nada urgente, Alice pode
+decidir continuar trabalhando sem puxar de Bob. Se a hist=F3ria de Bob
 tem alguma coisa que Alice precisa imediatamente, Alice pode optar por
 separar seu trabalho em progresso primeiro, fazer um "pull", e, ent=E3o,
 finalmente, retomar seu trabalho em progresso em cima da hist=F3ria
 resultante.

-Quanto voc=EA est=E1 trabalhando em um pequeno grupo unido, n=E3o =E9 inco=
mum
-interagir com o mesmo reposit=F3rio v=E1rias e v=E1rias vezes.  Definindo =
um
+Quando voc=EA est=E1 trabalhando em um pequeno grupo unido, n=E3o =E9 inco=
mum
+interagir com o mesmo reposit=F3rio v=E1rias e v=E1rias vezes. Definindo u=
m
 reposit=F3rio remoto antes de tudo, voc=EA pode faz=EA-lo mais facilmente:

 ------------------------------------------------
@@ -394,7 +391,7 @@ alice$ git fetch bob

 Diferente da forma longa, quando Alice obteve de Bob usando um
 reposit=F3rio remoto antes definido com 'git-remote', o que foi obtido =E9
-armazenado um ramo remoto, neste caso `bob/master`.  Ent=E3o, ap=F3s isso:
+armazenado em um ramo remoto, neste caso `bob/master`. Ent=E3o, ap=F3s iss=
o:

 -------------------------------------
 alice$ git log -p master..bob/master
@@ -417,7 +414,7 @@ alice$ git pull . remotes/bob/master
 -------------------------------------

 Note que 'git pull' sempre unifica ao ramo atual, independente do que
-mais foi dado na linha de comando.
+mais foi passado na linha de comando.

 Depois, Bob pode atualizar seu reposit=F3rio com as =FAltimas mudan=E7as d=
e
 Alice, usando
@@ -428,7 +425,7 @@ bob$ git pull

 Note que ele n=E3o precisa dar o caminho do reposit=F3rio de Alice; quando
 Bob clonou seu reposit=F3rio, o git armazenou a localiza=E7=E3o de seu
-reposit=F3rio na configura=E7=E3o do reposit=F3rio, e essa localiza=E7=E3o=
 =E9 usada
+reposit=F3rio na configura=E7=E3o do mesmo, e essa localiza=E7=E3o =E9 usa=
da
 para puxar:

 -------------------------------------
@@ -459,15 +456,15 @@ Alternativamente, o git tem um protocolo nativo,
ou pode usar rsync ou
 http; veja linkgit:git-pull[1] para detalhes.

 Git pode tamb=E9m ser usado em um modo parecido com CVS, com um
-reposit=F3rio central para o qual que v=E1rios usu=E1rios empurram
-modifica=E7=F5es; veja linkgit:git-push[1] e linkgit:gitcvs-migration[7].
+reposit=F3rio central para o qual v=E1rios usu=E1rios empurram modifica=E7=
=F5es;
+veja linkgit:git-push[1] e linkgit:gitcvs-migration[7].

 Explorando hist=F3ria
 -----------------

 A hist=F3ria no git =E9 representada como uma s=E9rie de commits
-interrelacionados.  N=F3s j=E1 vimos que o comando 'git-log' pode listar
-esses commits. Note que a primeira linha de cama entrada no log tamb=E9m
+interrelacionados. N=F3s j=E1 vimos que o comando 'git-log' pode listar
+esses commits. Note que a primeira linha de cada entrada no log tamb=E9m
 d=E1 o nome para o commit:

 -------------------------------------
@@ -486,9 +483,9 @@ commit.
 $ git show c82a22c39cbc32576f64f5c6b3f24b99ea8149c7
 -------------------------------------

-Mas h=E1 outras formas de se referir a commits.  Voc=EA pode usar qualquer
-parte inicial do nome que seja longo o bastante para unicamente
-identificar o commit:
+Mas h=E1 outras formas de se referir aos commits. Voc=EA pode usar qualque=
r
+parte inicial do nome que seja longo o bastante para identificar
+unicamente o commit:

 -------------------------------------
 $ git show c82a22c39c	# os primeiros caracteres do nome s=E3o o bastante
@@ -497,7 +494,7 @@ $ git show HEAD		# a ponta do ramo atual
 $ git show experimental	# a ponta do ramo "experimental"
 -------------------------------------

-Todo commit usualmente tem um commit "pai" que aponta para o estado
+Todo commit normalmente tem um commit "pai" que aponta para o estado
 anterior do projeto:

 -------------------------------------
@@ -513,19 +510,19 @@ $ git show HEAD^1 # mostra o primeiro pai de
HEAD (o mesmo que HEAD^)
 $ git show HEAD^2 # mostra o segundo pai de HEAD
 -------------------------------------

-Voc=EA tamb=E9m pode dar aos commits nomes seus; ap=F3s executar
+Voc=EA tamb=E9m pode dar aos commits nomes =E0 sua escolha; ap=F3s executa=
r

 -------------------------------------
 $ git tag v2.5 1b2e1d63ff
 -------------------------------------

-voc=EA pode se referir a 1b2e1d63ff pelo nome "v2.5".  Se voc=EA pretende
+voc=EA pode se referir a 1b2e1d63ff pelo nome "v2.5". Se voc=EA pretende
 compartilhar esse nome com outras pessoas (por exemplo, para identificar
-uma vers=E3o de lan=E7amento), voc=EA deve criar um objeto "tag", e talvez
+uma vers=E3o de lan=E7amento), voc=EA deveria criar um objeto "tag", e tal=
vez
 assin=E1-lo; veja linkgit:git-tag[1] para detalhes.

 Qualquer comando git que precise conhecer um commit pode receber
-quaisquer desses nomes.  Por exemplo:
+quaisquer desses nomes. Por exemplo:

 -------------------------------------
 $ git diff v2.5 HEAD	 # compara o HEAD atual com v2.5
@@ -537,8 +534,8 @@ $ git reset --hard HEAD^ # reseta seu ramo atual e
seu diret=F3rio de

 Seja cuidadoso com o =FAltimo comando: al=E9m de perder quaisquer mudan=E7=
as
 em seu diret=F3rio de trabalho, ele tamb=E9m remove todos os commits
-posteriores desse ramo.  Se esse ramo =E9 o =FAnico ramo contendo esses
-commits, eles ser=E3o perdidos.  Tamb=E9m, n=E3o use 'git-reset' num ramo
+posteriores desse ramo. Se esse ramo =E9 o =FAnico ramo contendo esses
+commits, eles ser=E3o perdidos. Tamb=E9m, n=E3o use 'git-reset' num ramo
 publicamente vis=EDvel de onde outros desenvolvedores puxam, j=E1 que vai
 for=E7ar unifica=E7=F5es desnecess=E1rias para que outros desenvolvedores =
limpem
 a hist=F3ria. Se voc=EA precisa desfazer mudan=E7as que voc=EA empurrou, u=
se
@@ -551,10 +548,10 @@ projeto, ent=E3o
 $ git grep "hello" v2.5
 -------------------------------------

-procura por todas as ocorre=EAncias de "hello" em v2.5.
+procura por todas as ocorr=EAncias de "hello" em v2.5.

 Se voc=EA deixar de fora o nome do commit, 'git-grep' ir=E1 procurar
-quaisquer dos arquivos que ele gerencia no diret=F3rio corrente.  Ent=E3o
+quaisquer dos arquivos que ele gerencia no diret=F3rio corrente. Ent=E3o

 -------------------------------------
 $ git grep "hello"
@@ -564,8 +561,7 @@ $ git grep "hello"
 git.

 Muitos comandos git tamb=E9m recebem um conjunto de commits, o que pode
-ser especificado de um bom n=FAmero de formas.  Aqui est=E3o alguns exempl=
os
-com 'git-log':
+ser especificado de v=E1rias formas. Aqui est=E3o alguns exemplos com 'git=
-log':

 -------------------------------------
 $ git log v2.5..v2.6            # commits entre v2.5 e v2.6
@@ -584,7 +580,7 @@ comum algum tempo atr=E1s, ent=E3o
 $ git log stable..master
 -------------------------------------

-ir=E1 listas os commits feitos no ramo "master" mas n=E3o no ramo
+ir=E1 listar os commits feitos no ramo "master" mas n=E3o no ramo
 "stable", enquanto

 -------------------------------------
@@ -594,26 +590,26 @@ $ git log master..stable
 ir=E1 listar a lista de commits feitos no ramo "stable" mas n=E3o no ramo
 "master".

-O comando 'git-log' tem uma fraquza: ele precisa mostrar os commits em
+O comando 'git-log' tem uma fraqueza: ele precisa mostrar os commits em
 uma lista. Quando a hist=F3ria tem linhas de desenvolvimento que
 divergiram e ent=E3o foram unificadas novamente, a ordem em que 'git-log'
-apresenta essas mudan=E7as =E9 insignificante.
+apresenta essas mudan=E7as =E9 irrelevante.

 A maioria dos projetos com m=FAltiplos contribuidores (como o kernel
-linux, ou o git mesmo) tem unifica=E7=F5es frequentes, e 'gitk' faz um
-trabalho melhor de visualizar sua hist=F3ria.  Por exemplo,
+Linux, ou o pr=F3prio git) tem unifica=E7=F5es frequentes, e 'gitk' faz um
+trabalho melhor de visualizar sua hist=F3ria. Por exemplo,

 -------------------------------------
 $ gitk --since=3D"2 weeks ago" drivers/
 -------------------------------------

-permite voc=EA navegar em quaisquer commits desde as =FAltimas duas semana=
s
-de commits que modificaram arquivos sob o diret=F3rio "drivers".  (Nota:
+permite a voc=EA navegar em quaisquer commits desde as =FAltimas duas sema=
nas
+de commits que modificaram arquivos sob o diret=F3rio "drivers". (Nota:
 voc=EA pode ajustar as fontes do gitk segurando a tecla control enquanto
 pressiona "-" ou "+".)

-Finalmente, a maioria dos comandos que recebem nomes de arquivo
-te permitir=E3o opcionalmente preceder qualquer nome de arquivo por um
+Finalmente, a maioria dos comandos que recebem nomes de arquivo permitir=
=E3o
+tamb=E9m, opcionalmente, preceder qualquer nome de arquivo por um
 commit, para especificar uma vers=E3o particular do arquivo:

 -------------------------------------
@@ -630,33 +626,33 @@ Pr=F3ximos passos
 ----------

 Este tutorial deve ser o bastante para operar controle de revis=E3o
-distribu=EDdo b=E1sico para seus projetos.  No entanto, para entender
+distribu=EDdo b=E1sico para seus projetos. No entanto, para entender
 plenamente a profundidade e o poder do git voc=EA precisa entender duas
 id=E9ias simples nas quais ele se baseia:

   * A base de objetos =E9 um sistema bem elegante usado para armazenar a
     hist=F3ria de seu projeto--arquivos, diret=F3rios, e commits.

-  * O arquivo de =EDndica =E9 um cache do estado de uma =E1rvore de diret=
=F3rio,
+  * O arquivo de =EDndice =E9 um cache do estado de uma =E1rvore de diret=
=F3rio,
     usado para criar commits, restaurar diret=F3rios de trabalho, e
-    compreender as v=E1rias =E1rvores involvidas em uma unifica=E7=E3o.
+    armazenar as v=E1rias =E1rvores envolvidas em uma unifica=E7=E3o.

-Parte dois deste tutorial explica a base de objetos, o arquivo de
+A parte dois deste tutorial explica a base de objetos, o arquivo de
 =EDndice, e algumas outras coisinhas que voc=EA vai precisar pra usar o
 m=E1ximo do git. Voc=EA pode encontr=E1-la em linkgit:gittutorial-2[7].

-Se voc=EA n=E3o quer continuar do jeito certo, algumas outras disgress=F5e=
s
-que podem ser interessantes neste ponto s=E3o:
+Se voc=EA n=E3o quiser continuar com o tutorial agora nesse momento, algum=
as
+outras digress=F5es que podem ser interessantes neste ponto s=E3o:

   * linkgit:git-format-patch[1], linkgit:git-am[1]: Estes convertem
-    s=E9ries de commits em patches em email, e vice-versa, =FAteis para
-    projetos como o kernel linux que dependem pesadamente em patches
+    s=E9ries de commits em patches para email, e vice-versa, =FAteis para
+    projetos como o kernel Linux que dependem fortemente de patches
     enviados por email.

   * linkgit:git-bisect[1]: Quando h=E1 uma regress=E3o em seu projeto, uma
     forma de rastrear um bug =E9 procurando pela hist=F3ria para encontrar=
 o
-    commit culpado.  Git bisect pode ajudar a executar uma busca bin=E1ria
-    por esse commit.  Ele =E9 inteligente o bastante para executar uma
+    commit culpado. Git bisect pode ajudar a executar uma busca bin=E1ria
+    por esse commit. Ele =E9 inteligente o bastante para executar uma
     busca pr=F3xima da =F3tima mesmo no caso de uma hist=F3ria complexa
     n=E3o-linear com muitos ramos unificados.

@@ -664,7 +660,7 @@ que podem ser interessantes neste ponto s=E3o:

   * linkgit:gitcvs-migration[7]: Git para usu=E1rios de CVS.

-Veja Tamb=E9m
+Veja tamb=E9m
 --------
 linkgit:gittutorial-2[7],
 linkgit:gitcvs-migration[7],
--=20
1.6.4.388.gc1120

--0016e645b9be48c139046fefab3c
Content-Type: text/x-patch; charset=UTF-8; 
	name="0001-PATCH-Fix-typos-on-pt_BR-gittutorial.txt-translation.patch"
Content-Disposition: attachment; 
	filename="0001-PATCH-Fix-typos-on-pt_BR-gittutorial.txt-translation.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fxrreala0

RnJvbSAwMmViMzA0NWU0ZjE0MTU1MjhmOGMwN2Y2YzliYWZiMGJlYjhjOGNjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/QW5kcj1DMz1BOT0yMEdvZGRhcmQ9MjBSb3Nh
Pz0gPGFuZHJlLmdvZGRhcmRAZ21haWwuY29tPgpEYXRlOiBUaHUsIDMwIEp1bCAyMDA5IDE0OjIw
OjAyIC0wMzAwClN1YmplY3Q6IFtQQVRDSF0gW1BBVENIXSBGaXggdHlwb3Mgb24gcHRfQlIvZ2l0
dHV0b3JpYWwudHh0IHRyYW5zbGF0aW9uCk1JTUUtVmVyc2lvbjogMS4wCkNvbnRlbnQtVHlwZTog
dGV4dC9wbGFpbjsgY2hhcnNldD1VVEYtOApDb250ZW50LVRyYW5zZmVyLUVuY29kaW5nOiA4Yml0
CgpTaWduZWQtb2ZmLWJ5OiBBbmRyw6kgR29kZGFyZCBSb3NhIDxhbmRyZS5nb2RkYXJkQGdtYWls
LmNvbT4KU2lnbmVkLW9mZi1ieTogVGhhZGV1IExpbWEgZGUgU291emEgQ2FzY2FyZG8gPGNhc2Nh
cmRvQGhvbG9zY29waW8uY29tPgpTaWduZWQtb2ZmLWJ5OiBDYXJsb3MgUi4gTWFmcmEgPGNybWFm
cmEyQGdtYWlsLmNvbT4KW0luY2x1ZGVkIGV4dHJhIGZpeGVzIGZyb20gVGhhZGV1IGFuZCBDYXJs
b3MgYXMgd2VsbF0KLS0tCiBEb2N1bWVudGF0aW9uL3B0X0JSL2dpdHR1dG9yaWFsLnR4dCB8ICAx
NDQgKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0KIDEgZmlsZXMgY2hhbmdlZCwg
NzAgaW5zZXJ0aW9ucygrKSwgNzQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRh
dGlvbi9wdF9CUi9naXR0dXRvcmlhbC50eHQgYi9Eb2N1bWVudGF0aW9uL3B0X0JSL2dpdHR1dG9y
aWFsLnR4dAppbmRleCBmMzY4YjFiLi4zOGZhYjU3IDEwMDY0NAotLS0gYS9Eb2N1bWVudGF0aW9u
L3B0X0JSL2dpdHR1dG9yaWFsLnR4dAorKysgYi9Eb2N1bWVudGF0aW9uL3B0X0JSL2dpdHR1dG9y
aWFsLnR4dApAQCAtMTYsNyArMTYsNyBAQCBFc3RlIHR1dG9yaWFsIGV4cGxpY2EgY29tbyBpbXBv
cnRhciB1bSBub3ZvIHByb2pldG8gcGFyYSBvIGdpdCwKIGFkaWNpb25hciBtdWRhbsOnYXMgYSBl
bGUsIGUgY29tcGFydGlsaGFyIG11ZGFuw6dhcyBjb20gb3V0cm9zCiBkZXNlbnZvbHZlZG9yZXMu
CiAKLUlmLCBhbyBpbnbDqXMgZGlzc28sIHZvY8OqIGVzdMOhIGludGVyZXNzYWRvIHByaW1hcmlh
bWVudGUgZW0gdXNhciBnaXQgcGFyYQorU2UsIGFvIGludsOpcyBkaXNzbywgdm9jw6ogZXN0w6Eg
aW50ZXJlc3NhZG8gcHJpbWFyaWFtZW50ZSBlbSB1c2FyIGdpdCBwYXJhCiBvYnRlciB1bSBwcm9q
ZXRvLCBwb3IgZXhlbXBsbywgcGFyYSB0ZXN0YXIgYSDDumx0aW1hIHZlcnPDo28sIHZvY8OqIHBv
ZGUKIHByZWZlcmlyIGNvbWXDp2FyIGNvbSBvcyBwcmltZWlyb3MgZG9pcyBjYXDDrXR1bG9zIGRl
CiBsaW5rOnVzZXItbWFudWFsLmh0bWxbTyBNYW51YWwgZG8gVXN1w6FyaW8gR2l0XS4KQEAgLTM3
LDkgKzM3LDggQEAgJCBnaXQgaGVscCBsb2cKIENvbSBhIMO6bHRpbWEgZm9ybWEsIHZvY8OqIHBv
ZGUgdXNhciBvIHZpc3VhbGl6YWRvciBkZSBtYW51YWwgZGUgc3VhCiBlc2NvbGhhOyB2ZWphIGxp
bmtnaXQ6Z2l0LWhlbHBbMV0gcGFyYSBtYWlvciBpbmZvcm1hw6fDo28uCiAKLcOJIHVtYSBib2Eg
aWTDqWlhIHNlIGludHJvZHV6aXIgYW8gZ2l0IGNvbSBzZXUgbm9tZSBlIGVuZGVyZcOnbyBww7pi
bGljbyBkZQotZW1haWwgYW50ZXMgZGUgZmF6ZXIgcXVhbHF1ZXIgb3BlcmHDp8Ojby4gQSBtYW5l
aXJhIG1haXMgZsOhY2lsIGRlIGZhesOqLWxvCi3DqToKK8OJIHVtYSBib2EgaWTDqWlhIGluZm9y
bWFyIGFvIGdpdCBzZXUgbm9tZSBlIGVuZGVyZcOnbyBww7pibGljbyBkZSBlbWFpbAorYW50ZXMg
ZGUgZmF6ZXIgcXVhbHF1ZXIgb3BlcmHDp8Ojby4gQSBtYW5laXJhIG1haXMgZsOhY2lsIGRlIGZh
esOqLWxvIMOpOgogCiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0KICQgZ2l0IGNvbmZpZyAtLWdsb2JhbCB1c2VyLm5hbWUgIlNldSBOb21lIFZlbSBBcXVp
IgpAQCAtNTEsNyArNTAsNyBAQCBJbXBvcnRhbmRvIHVtIG5vdm8gcHJvamV0bwogLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0KIAogQXNzdW1hIHF1ZSB2b2PDqiB0ZW0gdW0gdGFyYmFsbCBwcm9qZWN0
LnRhci5neiBjb20gc2V1IHRyYWJhbGhvIGluaWNpYWwuCi1Wb2PDqiBwb2RlIGNvbG9jw6EtbG8g
c29iIGNvbnRyb2xlIGRlIHJldmlzw6NvIGdpdCBjb21vIGEgc2VndWlyLgorVm9jw6ogcG9kZSBj
b2xvY8OhLWxvIHNvYiBjb250cm9sZSBkZSByZXZpc8OjbyBnaXQgZGEgc2VndWludGUgZm9ybWE6
CiAKIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogJCB0
YXIgeHpmIHByb2plY3QudGFyLmd6CkBAIC03Niw3ICs3NSw3IEBAICQgZ2l0IGFkZCAuCiAtLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIAogRXN0ZSBpbnN0
YW50w6JuZW8gZXN0w6EgYWdvcmEgYXJtYXplbmFkbyBlbSB1bWEgw6FyZWEgdGVtcG9yw6FyaWEg
cXVlIG8gZ2l0Ci1jaGFtYSBkZSAiaW5kZXgiIG91IMOtbmRpY2UuIFZvY8OqIHBvZGUgcGVybWFu
ZXRlbWVudGUgYXJtYXplbmFyIG8KK2NoYW1hIGRlICJpbmRleCIgb3Ugw61uZGljZS4gVm9jw6og
cG9kZSBhcm1hemVuYXIgcGVybWFuZW50ZW1lbnRlIG8KIGNvbnRlw7pkbyBkbyDDrW5kaWNlIG5v
IHJlcG9zaXTDs3JpbyBjb20gJ2dpdC1jb21taXQnOgogCiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KQEAgLTE0Miw3ICsxNDEsNyBAQCBub3ZvcyksIGFk
aWNpb27DoS1sb3MgYW8gw61uZGljZXMsIGUgZ3JhdmFyLCB0dWRvIGVtIHVtIMO6bmljbyBwYXNz
by4KIFVtYSBub3RhIGVtIG1lbnNhZ2VucyBkZSBjb21taXQ6IEFwZXNhciBkZSBuw6NvIHNlciBl
eGlnaWRvLCDDqSB1bWEgYm9hCiBpZMOpaWEgY29tZcOnYXIgYSBtZW5zYWdlbSBjb20gdW1hIHNp
bXBsZXMgZSBjdXJ0YSAobWVub3MgZGUgNTAKIGNhcmFjdGVyZXMpIGxpbmhhIHN1bWFyaXphbmRv
IGEgbXVkYW7Dp2EsIHNlZ3VpZGEgZGUgdW1hIGxpbmhhIGVtIGJyYW5jbwotZSwgZW50w6NvLCB1
bWEgZGVzY3Jpw6fDo28gbWFpcyBkZXRhbGhhZGEuICBGZXJyYW1lbnRhcyBxdWUgdHJhbnNmb3Jt
YW0KK2UsIGVudMOjbywgdW1hIGRlc2NyacOnw6NvIG1haXMgZGV0YWxoYWRhLiBGZXJyYW1lbnRh
cyBxdWUgdHJhbnNmb3JtYW0KIGNvbW1pdHMgZW0gZW1haWwsIHBvciBleGVtcGxvLCB1c2FtIGEg
cHJpbWVpcmEgbGluaGEgbm8gY2FtcG8gZGUKIGNhYmXDp2FsaG8gU3ViamVjdDogZSBvIHJlc3Rv
IG5vIGNvcnBvLgogCkBAIC0xNTAsNyArMTQ5LDcgQEAgR2l0IHJhc3RyZWlhIGNvbnRlw7pkbywg
bsOjbyBhcnF1aXZvcwogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogCiBNdWl0b3Mgc2lz
dGVtYXMgZGUgY29udHJvbGUgZGUgcmV2aXPDo28gcHJvdsOqZW0gdW0gY29tYW5kbyBgYWRkYCBx
dWUgZGl6Ci1hbyBzaXN0ZW1hIHBhcmEgY29tZcOnYXIgYSByYXN0cmVhciBtdWRhbsOnYXMgZW0g
dW0gbm92byBhcnF1aXZvLiAgTworYW8gc2lzdGVtYSBwYXJhIGNvbWXDp2FyIGEgcmFzdHJlYXIg
bXVkYW7Dp2FzIGVtIHVtIG5vdm8gYXJxdWl2by4gTwogY29tYW5kbyBgYWRkYCBkbyBnaXQgZmF6
IGFsZ28gbWFpcyBzaW1wbGVzIGUgbWFpcyBwb2Rlcm9zbzogJ2dpdC1hZGQnIMOpCiB1c2FkbyB0
YW50byBwYXJhIGFycXVpdm9zIG5vdm9zIGUgYXJxdWl2b3MgcmVjZW50ZW1lbnRlIG1vZGlmaWNh
ZG9zLCBlCiBlbSBhbWJvcyBvcyBjYXNvcywgZWxlIHRpcmEgbyBpbnN0YW50w6JuZW8gZG9zIGFy
cXVpdm9zIGRhZG9zIGUgYXJtYXplbmEKQEAgLTE4Myw3ICsxODIsNyBAQCBHZXJlbmNpYW5kbyAi
YnJhbmNoZXMiL3JhbW9zCiAtLS0tLS0tLS0tLS0tLS0tLQogCiBVbSBzaW1wbGVzIHJlcG9zaXTD
s3JpbyBnaXQgcG9kZSBtYW50ZXIgbcO6bHRpcGxvcyByYW1vcyBkZQotZGVzZW52b2x2aW1lbnRv
LiAgUGFyYSBjcmlhciB1bSBub3ZvIHJhbW8gY2hhbWFkbyAiZXhwZXJpbWVudGFsIiwgdXNlCitk
ZXNlbnZvbHZpbWVudG8uIFBhcmEgY3JpYXIgdW0gbm92byByYW1vIGNoYW1hZG8gImV4cGVyaW1l
bnRhbCIsIHVzZQogCiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0KICQgZ2l0IGJyYW5jaCBleHBlcmltZW50YWwKQEAgLTIwMywxNCArMjAyLDE0IEBAIHZv
Y8OqIHZhaSBvYnRlciB1bWEgbGlzdGEgZGUgdG9kb3Mgb3MgcmFtb3MgZXhpc3RlbnRlczoKIC0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogCiBPIHJhbW8g
ImV4cGVyaW1lbnRhbCIgw6kgbyBxdWUgdm9jw6ogYWNhYmEgZGUgY3JpYXIsIGUgbyByYW1vICJt
YXN0ZXIiIMOpIG8KLXJhbW8gcGFkcsOjbyBxdWUgZm9pIGNyaWFkbyBwcmEgdm9jw6ogYXV0b21h
dGljYW1lbnRlLiAgTyBhc3RlcmlzY28gbWFyY2EKK3JhbW8gcGFkcsOjbyBxdWUgZm9pIGNyaWFk
byBwcmEgdm9jw6ogYXV0b21hdGljYW1lbnRlLiBPIGFzdGVyaXNjbyBtYXJjYQogbyByYW1vIGVt
IHF1ZSB2b2PDqiBlc3TDoSBhdHVhbG1lbnRlOyBkaWdpdGUKIAogLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiAkIGdpdCBjaGVja291dCBleHBlcmltZW50
YWwKIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogCi1w
YXJhIG11ZGFyIHBhcmEgbyByYW1vIGV4cGVyaW1lbnRhbC4gIEFnb3JhIGVkaXRlIHVtIGFycXVp
dm8sIGdyYXZlIGEKK3BhcmEgbXVkYXIgcGFyYSBvIHJhbW8gZXhwZXJpbWVudGFsLiBBZ29yYSBl
ZGl0ZSB1bSBhcnF1aXZvLCBncmF2ZSBhCiBtdWRhbsOnYSwgZSBtdWRlIGRlIHZvbHRhIHBhcmEg
byByYW1vIG1hc3RlcjoKIAogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tCkBAIC0yMzAsMTQgKzIyOSwxNCBAQCAkIGdpdCBjb21taXQgLWEKIC0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogCiBuZXN0ZSBwb250bywg
b3MgZG9pcyByYW1vcyBkaXZlcmdpcmFtLCBjb20gZGlmZXJlbnRlcyBtdWRhbsOnYXMgZmVpdGFz
IGVtCi1jYWRhIHVtLiAgUGFyYSB1bmlmaWNhciBhcyBtdWRhbsOnYXMgZmVpdGFzIG5vIGV4cGVy
aW1lbnRhbCBwYXJhIG8KK2NhZGEgdW0uIFBhcmEgdW5pZmljYXIgYXMgbXVkYW7Dp2FzIGZlaXRh
cyBubyBleHBlcmltZW50YWwgcGFyYSBvCiBtYXN0ZXIsIGV4ZWN1dGUKIAogLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiAkIGdpdCBtZXJnZSBleHBlcmlt
ZW50YWwKIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQog
Ci1TZSBhcyBtdWRhbsOnYXMgbsOjbyBjb25mbGl0YW0sIGVzdMOhIHByb250by4gIFNlIGV4aXN0
aXJlbSBjb25mbGl0b3MsCitDYXNvIGFzIG11ZGFuw6dhcyBuw6NvIGNvbmZsaXRhbSwgZXN0w6Eg
cHJvbnRvLiBTZSBleGlzdGlyZW0gY29uZmxpdG9zLAogbWFyY2Fkb3JlcyBzZXLDo28gZGVpeGFk
b3Mgbm9zIGFycXVpdm9zIHByb2JsZW3DoXRpY29zIGV4aWJpbmRvIG8KIGNvbmZsaXRvOwogCkBA
IC0yNDUsNyArMjQ0LDcgQEAgY29uZmxpdG87CiAkIGdpdCBkaWZmCiAtLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIAotdmFpIGV4aWJpciBpc3RvLiAgQXDD
s3Mgdm9jw6ogZWRpdGFyIG9zIGFycXVpdm9zIHBhcmEgcmVzb2x2ZXIgb3MKK3ZhaSBleGliaXIg
aXN0by4gQXDDs3Mgdm9jw6ogZWRpdGFyIG9zIGFycXVpdm9zIHBhcmEgcmVzb2x2ZXIgb3MKIGNv
bmZsaXRvcywKIAogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tCkBAIC0yNzMsMTAgKzI3MiwxMCBAQCBTZSB2b2PDqiBkZXNlbnZvbHZlIGVtIHVtIHJhbW8g
aWRlaWEtbG91Y2EsIGUgc2UgYXJyZXBlbmRlLCB2b2PDqiBwb2RlCiBzZW1wcmUgcmVtb3ZlciBv
IHJhbW8gY29tCiAKIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KLSQgZ2l0
IGJyYW5jaCAtRCBjcmF6eS1pZGVhCiskIGdpdCBicmFuY2ggLUQgaWRlaWEtbG91Y2EKIC0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIAotUmFtb3Mgc8OjbyBiYXJhdG9zIGUg
ZsOhY2VpcywgZW50w6NvIGlzdG8gw6kgdW1hIGJvYSBtYW5laXJhIGRlIGV4cGVyaW1lbnRhcgor
UmFtb3Mgc8OjbyBlZmljaWVudGVzIGUgZsOhY2VpcywgZW50w6NvIGlzdG8gw6kgdW1hIGJvYSBt
YW5laXJhIGRlIGV4cGVyaW1lbnRhcgogYWxndW1hIGNvaXNhLgogCiBVc2FuZG8gZ2l0IHBhcmEg
Y29sYWJvcmHDp8OjbwpAQCAtMjkzLDcgKzI5Miw3IEBAIGJvYiQgZ2l0IGNsb25lIC9ob21lL2Fs
aWNlL3Byb2plY3QgbXlyZXBvCiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0KIAogSXNzbyBjcmlhIHVtIG5vdm8gZGlyZXTDs3JpbyAibXlyZXBvIiBjb250
ZW5kbyB1bSBjbG9uZSBkbyByZXBvc2l0w7NyaW8gZGUKLUFsaWNlLiAgTyBjbG9uZSBlc3TDoSBu
byBtZXNtbyBww6kgcXVlIG8gcHJvamV0byBvcmlnaW5hbCwgcG9zc3VpbmRvIHN1YQorQWxpY2Uu
IE8gY2xvbmUgZXN0w6Egbm8gbWVzbW8gcMOpIHF1ZSBvIHByb2pldG8gb3JpZ2luYWwsIHBvc3N1
aW5kbyBzdWEKIHByw7NwcmlhIGPDs3BpYSBkYSBoaXN0w7NyaWEgZG8gcHJvamV0byBvcmlnaW5h
bC4KIAogQm9iIGVudMOjbyBmYXogYWxndW1hcyBtdWRhbsOnYXMgZSBhcyBncmF2YToKQEAgLTMw
NSw3ICszMDQsNyBAQCBib2IkIGdpdCBjb21taXQgLWEKIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogCiBRdWFudG8gZXN0w6EgcHJvbnRvLCBlbGUgZGl6
IGEgQWxpY2UgcGFyYSBwdXhhciBhcyBtdWRhbsOnYXMgZG8KLXJlcG9zaXTDs3JpbyBlbSAvaG9t
ZS9ib2IvbXlyZXBvLiAgRWxhIG8gZmF6IGNvbToKK3JlcG9zaXTDs3JpbyBlbSAvaG9tZS9ib2Iv
bXlyZXBvLiBFbGEgbyBmYXogY29tOgogCiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0KIGFsaWNlJCBjZCAvaG9tZS9hbGljZS9wcm9qZWN0CkBAIC0zMTQs
MTQgKzMxMywxNCBAQCBhbGljZSQgZ2l0IHB1bGwgL2hvbWUvYm9iL215cmVwbyBtYXN0ZXIKIAog
SXN0byB1bmlmaWNhIGFzIG11ZGFuw6dhcyBkbyByYW1vICJtYXN0ZXIiIGRvIEJvYiBhbyByYW1v
IGF0dWFsIGRlIEFsaWNlLgogU2UgQWxpY2UgZmV6IHN1YXMgcHLDs3ByaWFzIG11ZGFuw6dhcyBu
byBpbnRlcnZhbG8sIGVsYSwgZW50w6NvLCBwb2RlCi1wcmVjaXNhciBjb3JyaWdpciBtYW51YWxt
ZW50ZSBxdWFpcXVlciBjb25mbGl0b3MuICAoTm90ZSBxdWUgbyBhcmd1bWVudG8KK3ByZWNpc2Fy
IGNvcnJpZ2lyIG1hbnVhbG1lbnRlIHF1YWlzcXVlciBjb25mbGl0b3MuIChOb3RlIHF1ZSBvIGFy
Z3VtZW50bwogIm1hc3RlciIgbm8gY29tYW5kbyBhY2ltYSDDqSwgZGUgZmF0bywgZGVzbmVjZXNz
w6FyaW8sIGrDoSBxdWUgw6kgbyBwYWRyw6NvLikKIAogTyBjb21hbmRvICJwdWxsIiBleGVjdXRh
LCBlbnTDo28sIGR1YXMgb3BlcmHDp8O1ZXM6IGVsZSBvYnTDqW0gbXVkYW7Dp2FzIGRlCiB1bSBy
YW1vIHJlbW90bywgZSwgZW50w6NvLCBhcyB1bmlmaWNhIG5vIHJhbW8gYXR1YWwuCiAKIE5vdGUg
cXVlLCBlbSBnZXJhbCwgQWxpY2UgZ29zdGFyaWEgcXVlIHN1YXMgbXVkYW7Dp2FzIGxvY2FpcyBm
b3NzZW0KLWdyYXZhZGFzIGFudGVzIGRlIGluaWNpYXIgZXN0ZSAicHVsbCIuICBTZSBvIHRyYWJh
bGhvIGRlIEJvYm8gY29uZmxpdGEKK2dyYXZhZGFzIGFudGVzIGRlIGluaWNpYXIgZXN0ZSAicHVs
bCIuIFNlIG8gdHJhYmFsaG8gZGUgQm9iIGNvbmZsaXRhCiBjb20gbyBxdWUgQWxpY2UgZmV6IGRl
c2RlIHF1ZSBzdWFzIGhpc3TDs3JpYXMgc2UgcmFtaWZpY2FyYW0sIEFsaWNlIGlyw6EKIHVzYXIg
c2V1IGRpcmV0w7NyaW8gZGUgdHJhYmFsaG8gZSBvIMOtbmRpY2UgcGFyYSByZXNvbHZlciBjb25m
bGl0b3MsIGUKIG11ZGFuw6dhcyBsb2NhaXMgZXhpc3RlbnRlcyBpcsOjbyBpbnRlcmZlcmlyIGNv
bSBvIHByb2Nlc3NvIGRlIHJlc29sdcOnw6NvCkBAIC0zNDEsMTggKzM0MCwxOCBAQCBhbGljZSQg
Z2l0IGxvZyAtcCBIRUFELi5GRVRDSF9IRUFECiAKIEVzdGEgb3BlcmHDp8OjbyDDqSBzZWd1cmEg
bWVzbW8gc2UgQWxpY2UgdGVtIG11ZGFuw6dhcyBsb2NhaXMgbsOjbyBncmF2YWRhcy4KIEEgbm90
YcOnw6NvIGRlIGludGVydmFsbyAiSEVBRC4uRkVUQ0hfSEVBRCIgc2lnbmlmaWNhIG1vc3RyYXIg
dHVkbyBxdWUgw6kKLWFsY2Fuw6fDoXZlbCBkZSBGRVRDSF9IRUFEIG1hcyBleGNsdWEgdHVkbyBx
dWUgw6kgYWxjYW7Dp8OhdmVsIGRlIEhFQUQuIEFsY2llCi1qw6Egc2FiZSB0dWRvIHF1ZSBsZXZh
IGEgc2V1IGVzdGFkbyBhdHVhbCAoSEVBRCksIGUgcmV2aXNhIG8gcXVlIEJvYiB0ZW0KLWVtIHNl
dSBlc3RhZG8gKEZFVENIX0hFQUQpIHF1ZSBlbGEgYWluZGEgbsOjbyB2aXUgY29tIGVzc2UgY29t
YW5kby4KK2FsY2Fuw6fDoXZlbCBkZSBGRVRDSF9IRUFEIG1hcyBleGNsdWEgdHVkbyBvIHF1ZSDD
qSBhbGNhbsOnw6F2ZWwgZGUgSEVBRC4KK0FsaWNlIGrDoSBzYWJlIHR1ZG8gcXVlIGxldmEgYSBz
ZXUgZXN0YWRvIGF0dWFsIChIRUFEKSwgZSByZXZpc2EgbyBxdWUgQm9iCit0ZW0gZW0gc2V1IGVz
dGFkbyAoRkVUQ0hfSEVBRCkgcXVlIGVsYSBhaW5kYSBuw6NvIHZpdSBjb20gZXNzZSBjb21hbmRv
LgogCi1TZSBBbGljZSBxdWVyIHZpc3VhbGl6YXIgbyBxdWUgQm9iIGZleiBkZXNkZSBxdWUgc3Vh
cyBoaXN0w7NyaWEKK1NlIEFsaWNlIHF1ZXIgdmlzdWFsaXphciBvIHF1ZSBCb2IgZmV6IGRlc2Rl
IHF1ZSBzdWFzIGhpc3TDs3JpYXMgc2UKIHJhbWlmaWNhcmFtLCBlbGEgcG9kZSBkaXNwYXJhciBv
IHNlZ3VpbnRlIGNvbWFuZG86CiAKIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQogJCBnaXRrIEhFQUQuLkZFVENIX0hFQUQKIC0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogCi1Jc3RvIHVzYXIgYSBtZXNtYSBub3Rh
w6fDo28gZGUgaW50ZXJ2YWxkbyBxdWUgdmltb3MgYW50ZXMgY29tICdnaXQgbG9nJy4KK0lzdG8g
dXNhIGEgbWVzbWEgbm90YcOnw6NvIGRlIGludGVydmFsbyBxdWUgdmltb3MgYW50ZXMgY29tICdn
aXQgbG9nJy4KIAogQWxpY2UgcG9kZSBxdWVyZXIgdmVyIG8gcXVlIGFtYm9zIGZpemVyYW0gZGVz
ZGUgcXVlIHJhbWlmaWNhcmFtLiBFbGEKIHBvZGUgdXNhciBhIGZvcm1hIGNvbSB0csOqcyBwb250
b3MgYW8gaW52w6lzIGRhIGZvcm1hIGNvbSBkb2lzIHBvbnRvczoKQEAgLTM2MSwyMyArMzYwLDIx
IEBAIHBvZGUgdXNhciBhIGZvcm1hIGNvbSB0csOqcyBwb250b3MgYW8gaW52w6lzIGRhIGZvcm1h
IGNvbSBkb2lzIHBvbnRvczoKICQgZ2l0ayBIRUFELi4uRkVUQ0hfSEVBRAogLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiAKLUlzdG8gc2lnbmlmaWNhICJt
b3N0cmUgdHVkbyBxdWUgw6kgYWxjYW7Dp2F2ZWwgZGUgcXVhbHF1ZXIgdW0sIG1hcyBleGNsdWEK
LXR1ZG8gcXVlIMOpIGFsY2Fuw6dhdmVsIGEgcGFydGlyIGRlIGFtYm9zIi4KLVRoaXMgbWVhbnMg
InNob3cgZXZlcnl0aGluZyB0aGF0IGlzIHJlYWNoYWJsZSBmcm9tIGVpdGhlciBvbmUsIGJ1dAot
ZXhjbHVkZSBhbnl0aGluZyB0aGF0IGlzIHJlYWNoYWJsZSBmcm9tIGJvdGggb2YgdGhlbSIuCitJ
c3RvIHNpZ25pZmljYSAibW9zdHJlIHR1ZG8gcXVlIMOpIGFsY2Fuw6fDoXZlbCBkZSBxdWFscXVl
ciB1bSBkZWxlcywgbWFzCitleGNsdWEgdHVkbyBxdWUgw6kgYWxjYW7Dp8OhdmVsIGEgcGFydGly
IGRlIGFtYm9zIi4KIAogUG9yIGZhdm9yLCBub3RlIHF1ZSBlc3NhcyBub3Rhw6fDtWVzIGRlIGlu
dGVydmFsbyBwb2RlbSBzZXIgdXNhZGFzIHRhbnRvCiBjb20gZ2l0ayBxdWFudG8gY29tICJnaXQg
bG9nIi4KIAotQXBvw7NzIGluc3BlY2lvbmFyIG8gcXVlIEJvYiBmZXosIHNlIG7Do28gaMOhIG5h
ZGEgdXJnZW50ZSwgQWxpY2UgcG9kZQotZGVjaWRpciBjb250aW51YXIgdHJhYmFsaGFuZG8gc2Vt
IHB1eGFyIGRlIEJvYi4gIFNlIGEgaGlzdMOzcmlhIGRlIEJvYgorQXDDs3MgaW5zcGVjaW9uYXIg
byBxdWUgQm9iIGZleiwgc2UgbsOjbyBow6EgbmFkYSB1cmdlbnRlLCBBbGljZSBwb2RlCitkZWNp
ZGlyIGNvbnRpbnVhciB0cmFiYWxoYW5kbyBzZW0gcHV4YXIgZGUgQm9iLiBTZSBhIGhpc3TDs3Jp
YSBkZSBCb2IKIHRlbSBhbGd1bWEgY29pc2EgcXVlIEFsaWNlIHByZWNpc2EgaW1lZGlhdGFtZW50
ZSwgQWxpY2UgcG9kZSBvcHRhciBwb3IKIHNlcGFyYXIgc2V1IHRyYWJhbGhvIGVtIHByb2dyZXNz
byBwcmltZWlybywgZmF6ZXIgdW0gInB1bGwiLCBlLCBlbnTDo28sCiBmaW5hbG1lbnRlLCByZXRv
bWFyIHNldSB0cmFiYWxobyBlbSBwcm9ncmVzc28gZW0gY2ltYSBkYSBoaXN0w7NyaWEKIHJlc3Vs
dGFudGUuCiAKLVF1YW50byB2b2PDqiBlc3TDoSB0cmFiYWxoYW5kbyBlbSB1bSBwZXF1ZW5vIGdy
dXBvIHVuaWRvLCBuw6NvIMOpIGluY29tdW0KLWludGVyYWdpciBjb20gbyBtZXNtbyByZXBvc2l0
w7NyaW8gdsOhcmlhcyBlIHbDoXJpYXMgdmV6ZXMuICBEZWZpbmluZG8gdW0KK1F1YW5kbyB2b2PD
qiBlc3TDoSB0cmFiYWxoYW5kbyBlbSB1bSBwZXF1ZW5vIGdydXBvIHVuaWRvLCBuw6NvIMOpIGlu
Y29tdW0KK2ludGVyYWdpciBjb20gbyBtZXNtbyByZXBvc2l0w7NyaW8gdsOhcmlhcyBlIHbDoXJp
YXMgdmV6ZXMuIERlZmluaW5kbyB1bQogcmVwb3NpdMOzcmlvIHJlbW90byBhbnRlcyBkZSB0dWRv
LCB2b2PDqiBwb2RlIGZhesOqLWxvIG1haXMgZmFjaWxtZW50ZToKIAogLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkBAIC0zOTQsNyArMzkxLDcgQEAgYWxp
Y2UkIGdpdCBmZXRjaCBib2IKIAogRGlmZXJlbnRlIGRhIGZvcm1hIGxvbmdhLCBxdWFuZG8gQWxp
Y2Ugb2J0ZXZlIGRlIEJvYiB1c2FuZG8gdW0KIHJlcG9zaXTDs3JpbyByZW1vdG8gYW50ZXMgZGVm
aW5pZG8gY29tICdnaXQtcmVtb3RlJywgbyBxdWUgZm9pIG9idGlkbyDDqQotYXJtYXplbmFkbyB1
bSByYW1vIHJlbW90bywgbmVzdGUgY2FzbyBgYm9iL21hc3RlcmAuICBFbnTDo28sIGFww7NzIGlz
c286Cithcm1hemVuYWRvIGVtIHVtIHJhbW8gcmVtb3RvLCBuZXN0ZSBjYXNvIGBib2IvbWFzdGVy
YC4gRW50w6NvLCBhcMOzcyBpc3NvOgogCiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tCiBhbGljZSQgZ2l0IGxvZyAtcCBtYXN0ZXIuLmJvYi9tYXN0ZXIKQEAgLTQxNyw3ICs0
MTQsNyBAQCBhbGljZSQgZ2l0IHB1bGwgLiByZW1vdGVzL2JvYi9tYXN0ZXIKIC0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIAogTm90ZSBxdWUgJ2dpdCBwdWxsJyBzZW1wcmUg
dW5pZmljYSBhbyByYW1vIGF0dWFsLCBpbmRlcGVuZGVudGUgZG8gcXVlCi1tYWlzIGZvaSBkYWRv
IG5hIGxpbmhhIGRlIGNvbWFuZG8uCittYWlzIGZvaSBwYXNzYWRvIG5hIGxpbmhhIGRlIGNvbWFu
ZG8uCiAKIERlcG9pcywgQm9iIHBvZGUgYXR1YWxpemFyIHNldSByZXBvc2l0w7NyaW8gY29tIGFz
IMO6bHRpbWFzIG11ZGFuw6dhcyBkZQogQWxpY2UsIHVzYW5kbwpAQCAtNDI4LDcgKzQyNSw3IEBA
IGJvYiQgZ2l0IHB1bGwKIAogTm90ZSBxdWUgZWxlIG7Do28gcHJlY2lzYSBkYXIgbyBjYW1pbmhv
IGRvIHJlcG9zaXTDs3JpbyBkZSBBbGljZTsgcXVhbmRvCiBCb2IgY2xvbm91IHNldSByZXBvc2l0
w7NyaW8sIG8gZ2l0IGFybWF6ZW5vdSBhIGxvY2FsaXphw6fDo28gZGUgc2V1Ci1yZXBvc2l0w7Ny
aW8gbmEgY29uZmlndXJhw6fDo28gZG8gcmVwb3NpdMOzcmlvLCBlIGVzc2EgbG9jYWxpemHDp8Oj
byDDqSB1c2FkYQorcmVwb3NpdMOzcmlvIG5hIGNvbmZpZ3VyYcOnw6NvIGRvIG1lc21vLCBlIGVz
c2EgbG9jYWxpemHDp8OjbyDDqSB1c2FkYQogcGFyYSBwdXhhcjoKIAogLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpAQCAtNDU5LDE1ICs0NTYsMTUgQEAgQWx0ZXJuYXRpdmFt
ZW50ZSwgbyBnaXQgdGVtIHVtIHByb3RvY29sbyBuYXRpdm8sIG91IHBvZGUgdXNhciByc3luYyBv
dQogaHR0cDsgdmVqYSBsaW5rZ2l0OmdpdC1wdWxsWzFdIHBhcmEgZGV0YWxoZXMuCiAKIEdpdCBw
b2RlIHRhbWLDqW0gc2VyIHVzYWRvIGVtIHVtIG1vZG8gcGFyZWNpZG8gY29tIENWUywgY29tIHVt
Ci1yZXBvc2l0w7NyaW8gY2VudHJhbCBwYXJhIG8gcXVhbCBxdWUgdsOhcmlvcyB1c3XDoXJpb3Mg
ZW1wdXJyYW0KLW1vZGlmaWNhw6fDtWVzOyB2ZWphIGxpbmtnaXQ6Z2l0LXB1c2hbMV0gZSBsaW5r
Z2l0OmdpdGN2cy1taWdyYXRpb25bN10uCityZXBvc2l0w7NyaW8gY2VudHJhbCBwYXJhIG8gcXVh
bCB2w6FyaW9zIHVzdcOhcmlvcyBlbXB1cnJhbSBtb2RpZmljYcOnw7VlczsKK3ZlamEgbGlua2dp
dDpnaXQtcHVzaFsxXSBlIGxpbmtnaXQ6Z2l0Y3ZzLW1pZ3JhdGlvbls3XS4KIAogRXhwbG9yYW5k
byBoaXN0w7NyaWEKIC0tLS0tLS0tLS0tLS0tLS0tCiAKIEEgaGlzdMOzcmlhIG5vIGdpdCDDqSBy
ZXByZXNlbnRhZGEgY29tbyB1bWEgc8OpcmllIGRlIGNvbW1pdHMKLWludGVycmVsYWNpb25hZG9z
LiAgTsOzcyBqw6Egdmltb3MgcXVlIG8gY29tYW5kbyAnZ2l0LWxvZycgcG9kZSBsaXN0YXIKLWVz
c2VzIGNvbW1pdHMuIE5vdGUgcXVlIGEgcHJpbWVpcmEgbGluaGEgZGUgY2FtYSBlbnRyYWRhIG5v
IGxvZyB0YW1iw6ltCitpbnRlcnJlbGFjaW9uYWRvcy4gTsOzcyBqw6Egdmltb3MgcXVlIG8gY29t
YW5kbyAnZ2l0LWxvZycgcG9kZSBsaXN0YXIKK2Vzc2VzIGNvbW1pdHMuIE5vdGUgcXVlIGEgcHJp
bWVpcmEgbGluaGEgZGUgY2FkYSBlbnRyYWRhIG5vIGxvZyB0YW1iw6ltCiBkw6EgbyBub21lIHBh
cmEgbyBjb21taXQ6CiAKIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KQEAg
LTQ4Niw5ICs0ODMsOSBAQCBjb21taXQuCiAkIGdpdCBzaG93IGM4MmEyMmMzOWNiYzMyNTc2ZjY0
ZjVjNmIzZjI0Yjk5ZWE4MTQ5YzcKIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0KIAotTWFzIGjDoSBvdXRyYXMgZm9ybWFzIGRlIHNlIHJlZmVyaXIgYSBjb21taXRzLiAgVm9j
w6ogcG9kZSB1c2FyIHF1YWxxdWVyCi1wYXJ0ZSBpbmljaWFsIGRvIG5vbWUgcXVlIHNlamEgbG9u
Z28gbyBiYXN0YW50ZSBwYXJhIHVuaWNhbWVudGUKLWlkZW50aWZpY2FyIG8gY29tbWl0OgorTWFz
IGjDoSBvdXRyYXMgZm9ybWFzIGRlIHNlIHJlZmVyaXIgYW9zIGNvbW1pdHMuIFZvY8OqIHBvZGUg
dXNhciBxdWFscXVlcgorcGFydGUgaW5pY2lhbCBkbyBub21lIHF1ZSBzZWphIGxvbmdvIG8gYmFz
dGFudGUgcGFyYSBpZGVudGlmaWNhcgordW5pY2FtZW50ZSBvIGNvbW1pdDoKIAogLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogJCBnaXQgc2hvdyBjODJhMjJjMzljCSMgb3Mg
cHJpbWVpcm9zIGNhcmFjdGVyZXMgZG8gbm9tZSBzw6NvIG8gYmFzdGFudGUKQEAgLTQ5Nyw3ICs0
OTQsNyBAQCAkIGdpdCBzaG93IEhFQUQJCSMgYSBwb250YSBkbyByYW1vIGF0dWFsCiAkIGdpdCBz
aG93IGV4cGVyaW1lbnRhbAkjIGEgcG9udGEgZG8gcmFtbyAiZXhwZXJpbWVudGFsIgogLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogCi1Ub2RvIGNvbW1pdCB1c3VhbG1lbnRl
IHRlbSB1bSBjb21taXQgInBhaSIgcXVlIGFwb250YSBwYXJhIG8gZXN0YWRvCitUb2RvIGNvbW1p
dCBub3JtYWxtZW50ZSB0ZW0gdW0gY29tbWl0ICJwYWkiIHF1ZSBhcG9udGEgcGFyYSBvIGVzdGFk
bwogYW50ZXJpb3IgZG8gcHJvamV0bzoKIAogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQpAQCAtNTEzLDE5ICs1MTAsMTkgQEAgJCBnaXQgc2hvdyBIRUFEXjEgIyBtb3N0cmEg
byBwcmltZWlybyBwYWkgZGUgSEVBRCAobyBtZXNtbyBxdWUgSEVBRF4pCiAkIGdpdCBzaG93IEhF
QUReMiAjIG1vc3RyYSBvIHNlZ3VuZG8gcGFpIGRlIEhFQUQKIC0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0KIAotVm9jw6ogdGFtYsOpbSBwb2RlIGRhciBhb3MgY29tbWl0cyBu
b21lcyBzZXVzOyBhcMOzcyBleGVjdXRhcgorVm9jw6ogdGFtYsOpbSBwb2RlIGRhciBhb3MgY29t
bWl0cyBub21lcyDDoCBzdWEgZXNjb2xoYTsgYXDDs3MgZXhlY3V0YXIKIAogLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogJCBnaXQgdGFnIHYyLjUgMWIyZTFkNjNmZgogLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogCi12b2PDqiBwb2RlIHNlIHJlZmVy
aXIgYSAxYjJlMWQ2M2ZmIHBlbG8gbm9tZSAidjIuNSIuICBTZSB2b2PDqiBwcmV0ZW5kZQordm9j
w6ogcG9kZSBzZSByZWZlcmlyIGEgMWIyZTFkNjNmZiBwZWxvIG5vbWUgInYyLjUiLiBTZSB2b2PD
qiBwcmV0ZW5kZQogY29tcGFydGlsaGFyIGVzc2Ugbm9tZSBjb20gb3V0cmFzIHBlc3NvYXMgKHBv
ciBleGVtcGxvLCBwYXJhIGlkZW50aWZpY2FyCi11bWEgdmVyc8OjbyBkZSBsYW7Dp2FtZW50byks
IHZvY8OqIGRldmUgY3JpYXIgdW0gb2JqZXRvICJ0YWciLCBlIHRhbHZlegordW1hIHZlcnPDo28g
ZGUgbGFuw6dhbWVudG8pLCB2b2PDqiBkZXZlcmlhIGNyaWFyIHVtIG9iamV0byAidGFnIiwgZSB0
YWx2ZXoKIGFzc2luw6EtbG87IHZlamEgbGlua2dpdDpnaXQtdGFnWzFdIHBhcmEgZGV0YWxoZXMu
CiAKIFF1YWxxdWVyIGNvbWFuZG8gZ2l0IHF1ZSBwcmVjaXNlIGNvbmhlY2VyIHVtIGNvbW1pdCBw
b2RlIHJlY2ViZXIKLXF1YWlzcXVlciBkZXNzZXMgbm9tZXMuICBQb3IgZXhlbXBsbzoKK3F1YWlz
cXVlciBkZXNzZXMgbm9tZXMuIFBvciBleGVtcGxvOgogCiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tCiAkIGdpdCBkaWZmIHYyLjUgSEVBRAkgIyBjb21wYXJhIG8gSEVBRCBh
dHVhbCBjb20gdjIuNQpAQCAtNTM3LDggKzUzNCw4IEBAICQgZ2l0IHJlc2V0IC0taGFyZCBIRUFE
XiAjIHJlc2V0YSBzZXUgcmFtbyBhdHVhbCBlIHNldSBkaXJldMOzcmlvIGRlCiAKIFNlamEgY3Vp
ZGFkb3NvIGNvbSBvIMO6bHRpbW8gY29tYW5kbzogYWzDqW0gZGUgcGVyZGVyIHF1YWlzcXVlciBt
dWRhbsOnYXMKIGVtIHNldSBkaXJldMOzcmlvIGRlIHRyYWJhbGhvLCBlbGUgdGFtYsOpbSByZW1v
dmUgdG9kb3Mgb3MgY29tbWl0cwotcG9zdGVyaW9yZXMgZGVzc2UgcmFtby4gIFNlIGVzc2UgcmFt
byDDqSBvIMO6bmljbyByYW1vIGNvbnRlbmRvIGVzc2VzCi1jb21taXRzLCBlbGVzIHNlcsOjbyBw
ZXJkaWRvcy4gIFRhbWLDqW0sIG7Do28gdXNlICdnaXQtcmVzZXQnIG51bSByYW1vCitwb3N0ZXJp
b3JlcyBkZXNzZSByYW1vLiBTZSBlc3NlIHJhbW8gw6kgbyDDum5pY28gcmFtbyBjb250ZW5kbyBl
c3NlcworY29tbWl0cywgZWxlcyBzZXLDo28gcGVyZGlkb3MuIFRhbWLDqW0sIG7Do28gdXNlICdn
aXQtcmVzZXQnIG51bSByYW1vCiBwdWJsaWNhbWVudGUgdmlzw612ZWwgZGUgb25kZSBvdXRyb3Mg
ZGVzZW52b2x2ZWRvcmVzIHB1eGFtLCBqw6EgcXVlIHZhaQogZm9yw6dhciB1bmlmaWNhw6fDtWVz
IGRlc25lY2Vzc8OhcmlhcyBwYXJhIHF1ZSBvdXRyb3MgZGVzZW52b2x2ZWRvcmVzIGxpbXBlbQog
YSBoaXN0w7NyaWEuIFNlIHZvY8OqIHByZWNpc2EgZGVzZmF6ZXIgbXVkYW7Dp2FzIHF1ZSB2b2PD
qiBlbXB1cnJvdSwgdXNlCkBAIC01NTEsMTAgKzU0OCwxMCBAQCBwcm9qZXRvLCBlbnTDo28KICQg
Z2l0IGdyZXAgImhlbGxvIiB2Mi41CiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tCiAKLXByb2N1cmEgcG9yIHRvZGFzIGFzIG9jb3JyZcOqbmNpYXMgZGUgImhlbGxvIiBlbSB2
Mi41LgorcHJvY3VyYSBwb3IgdG9kYXMgYXMgb2NvcnLDqm5jaWFzIGRlICJoZWxsbyIgZW0gdjIu
NS4KIAogU2Ugdm9jw6ogZGVpeGFyIGRlIGZvcmEgbyBub21lIGRvIGNvbW1pdCwgJ2dpdC1ncmVw
JyBpcsOhIHByb2N1cmFyCi1xdWFpc3F1ZXIgZG9zIGFycXVpdm9zIHF1ZSBlbGUgZ2VyZW5jaWEg
bm8gZGlyZXTDs3JpbyBjb3JyZW50ZS4gIEVudMOjbworcXVhaXNxdWVyIGRvcyBhcnF1aXZvcyBx
dWUgZWxlIGdlcmVuY2lhIG5vIGRpcmV0w7NyaW8gY29ycmVudGUuIEVudMOjbwogCiAtLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiAkIGdpdCBncmVwICJoZWxsbyIKQEAgLTU2
NCw4ICs1NjEsNyBAQCAkIGdpdCBncmVwICJoZWxsbyIKIGdpdC4KIAogTXVpdG9zIGNvbWFuZG9z
IGdpdCB0YW1iw6ltIHJlY2ViZW0gdW0gY29uanVudG8gZGUgY29tbWl0cywgbyBxdWUgcG9kZQot
c2VyIGVzcGVjaWZpY2FkbyBkZSB1bSBib20gbsO6bWVybyBkZSBmb3JtYXMuICBBcXVpIGVzdMOj
byBhbGd1bnMgZXhlbXBsb3MKLWNvbSAnZ2l0LWxvZyc6CitzZXIgZXNwZWNpZmljYWRvIGRlIHbD
oXJpYXMgZm9ybWFzLiBBcXVpIGVzdMOjbyBhbGd1bnMgZXhlbXBsb3MgY29tICdnaXQtbG9nJzoK
IAogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogJCBnaXQgbG9nIHYyLjUu
LnYyLjYgICAgICAgICAgICAjIGNvbW1pdHMgZW50cmUgdjIuNSBlIHYyLjYKQEAgLTU4NCw3ICs1
ODAsNyBAQCBjb211bSBhbGd1bSB0ZW1wbyBhdHLDoXMsIGVudMOjbwogJCBnaXQgbG9nIHN0YWJs
ZS4ubWFzdGVyCiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiAKLWlyw6Eg
bGlzdGFzIG9zIGNvbW1pdHMgZmVpdG9zIG5vIHJhbW8gIm1hc3RlciIgbWFzIG7Do28gbm8gcmFt
bworaXLDoSBsaXN0YXIgb3MgY29tbWl0cyBmZWl0b3Mgbm8gcmFtbyAibWFzdGVyIiBtYXMgbsOj
byBubyByYW1vCiAic3RhYmxlIiwgZW5xdWFudG8KIAogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQpAQCAtNTk0LDI2ICs1OTAsMjYgQEAgJCBnaXQgbG9nIG1hc3Rlci4uc3Rh
YmxlCiBpcsOhIGxpc3RhciBhIGxpc3RhIGRlIGNvbW1pdHMgZmVpdG9zIG5vIHJhbW8gInN0YWJs
ZSIgbWFzIG7Do28gbm8gcmFtbwogIm1hc3RlciIuCiAKLU8gY29tYW5kbyAnZ2l0LWxvZycgdGVt
IHVtYSBmcmFxdXphOiBlbGUgcHJlY2lzYSBtb3N0cmFyIG9zIGNvbW1pdHMgZW0KK08gY29tYW5k
byAnZ2l0LWxvZycgdGVtIHVtYSBmcmFxdWV6YTogZWxlIHByZWNpc2EgbW9zdHJhciBvcyBjb21t
aXRzIGVtCiB1bWEgbGlzdGEuIFF1YW5kbyBhIGhpc3TDs3JpYSB0ZW0gbGluaGFzIGRlIGRlc2Vu
dm9sdmltZW50byBxdWUKIGRpdmVyZ2lyYW0gZSBlbnTDo28gZm9yYW0gdW5pZmljYWRhcyBub3Zh
bWVudGUsIGEgb3JkZW0gZW0gcXVlICdnaXQtbG9nJwotYXByZXNlbnRhIGVzc2FzIG11ZGFuw6dh
cyDDqSBpbnNpZ25pZmljYW50ZS4KK2FwcmVzZW50YSBlc3NhcyBtdWRhbsOnYXMgw6kgaXJyZWxl
dmFudGUuCiAKIEEgbWFpb3JpYSBkb3MgcHJvamV0b3MgY29tIG3Dumx0aXBsb3MgY29udHJpYnVp
ZG9yZXMgKGNvbW8gbyBrZXJuZWwKLWxpbnV4LCBvdSBvIGdpdCBtZXNtbykgdGVtIHVuaWZpY2HD
p8O1ZXMgZnJlcXVlbnRlcywgZSAnZ2l0aycgZmF6IHVtCi10cmFiYWxobyBtZWxob3IgZGUgdmlz
dWFsaXphciBzdWEgaGlzdMOzcmlhLiAgUG9yIGV4ZW1wbG8sCitMaW51eCwgb3UgbyBwcsOzcHJp
byBnaXQpIHRlbSB1bmlmaWNhw6fDtWVzIGZyZXF1ZW50ZXMsIGUgJ2dpdGsnIGZheiB1bQordHJh
YmFsaG8gbWVsaG9yIGRlIHZpc3VhbGl6YXIgc3VhIGhpc3TDs3JpYS4gUG9yIGV4ZW1wbG8sCiAK
IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KICQgZ2l0ayAtLXNpbmNlPSIy
IHdlZWtzIGFnbyIgZHJpdmVycy8KIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0KIAotcGVybWl0ZSB2b2PDqiBuYXZlZ2FyIGVtIHF1YWlzcXVlciBjb21taXRzIGRlc2RlIGFz
IMO6bHRpbWFzIGR1YXMgc2VtYW5hcwotZGUgY29tbWl0cyBxdWUgbW9kaWZpY2FyYW0gYXJxdWl2
b3Mgc29iIG8gZGlyZXTDs3JpbyAiZHJpdmVycyIuICAoTm90YToKK3Blcm1pdGUgYSB2b2PDqiBu
YXZlZ2FyIGVtIHF1YWlzcXVlciBjb21taXRzIGRlc2RlIGFzIMO6bHRpbWFzIGR1YXMgc2VtYW5h
cworZGUgY29tbWl0cyBxdWUgbW9kaWZpY2FyYW0gYXJxdWl2b3Mgc29iIG8gZGlyZXTDs3JpbyAi
ZHJpdmVycyIuIChOb3RhOgogdm9jw6ogcG9kZSBhanVzdGFyIGFzIGZvbnRlcyBkbyBnaXRrIHNl
Z3VyYW5kbyBhIHRlY2xhIGNvbnRyb2wgZW5xdWFudG8KIHByZXNzaW9uYSAiLSIgb3UgIisiLikK
IAotRmluYWxtZW50ZSwgYSBtYWlvcmlhIGRvcyBjb21hbmRvcyBxdWUgcmVjZWJlbSBub21lcyBk
ZSBhcnF1aXZvCi10ZSBwZXJtaXRpcsOjbyBvcGNpb25hbG1lbnRlIHByZWNlZGVyIHF1YWxxdWVy
IG5vbWUgZGUgYXJxdWl2byBwb3IgdW0KK0ZpbmFsbWVudGUsIGEgbWFpb3JpYSBkb3MgY29tYW5k
b3MgcXVlIHJlY2ViZW0gbm9tZXMgZGUgYXJxdWl2byBwZXJtaXRpcsOjbwordGFtYsOpbSwgb3Bj
aW9uYWxtZW50ZSwgcHJlY2VkZXIgcXVhbHF1ZXIgbm9tZSBkZSBhcnF1aXZvIHBvciB1bQogY29t
bWl0LCBwYXJhIGVzcGVjaWZpY2FyIHVtYSB2ZXJzw6NvIHBhcnRpY3VsYXIgZG8gYXJxdWl2bzoK
IAogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpAQCAtNjMwLDMzICs2MjYs
MzMgQEAgUHLDs3hpbW9zIHBhc3NvcwogLS0tLS0tLS0tLQogCiBFc3RlIHR1dG9yaWFsIGRldmUg
c2VyIG8gYmFzdGFudGUgcGFyYSBvcGVyYXIgY29udHJvbGUgZGUgcmV2aXPDo28KLWRpc3RyaWJ1
w61kbyBiw6FzaWNvIHBhcmEgc2V1cyBwcm9qZXRvcy4gIE5vIGVudGFudG8sIHBhcmEgZW50ZW5k
ZXIKK2Rpc3RyaWJ1w61kbyBiw6FzaWNvIHBhcmEgc2V1cyBwcm9qZXRvcy4gTm8gZW50YW50bywg
cGFyYSBlbnRlbmRlcgogcGxlbmFtZW50ZSBhIHByb2Z1bmRpZGFkZSBlIG8gcG9kZXIgZG8gZ2l0
IHZvY8OqIHByZWNpc2EgZW50ZW5kZXIgZHVhcwogaWTDqWlhcyBzaW1wbGVzIG5hcyBxdWFpcyBl
bGUgc2UgYmFzZWlhOgogCiAgICogQSBiYXNlIGRlIG9iamV0b3Mgw6kgdW0gc2lzdGVtYSBiZW0g
ZWxlZ2FudGUgdXNhZG8gcGFyYSBhcm1hemVuYXIgYQogICAgIGhpc3TDs3JpYSBkZSBzZXUgcHJv
amV0by0tYXJxdWl2b3MsIGRpcmV0w7NyaW9zLCBlIGNvbW1pdHMuCiAKLSAgKiBPIGFycXVpdm8g
ZGUgw61uZGljYSDDqSB1bSBjYWNoZSBkbyBlc3RhZG8gZGUgdW1hIMOhcnZvcmUgZGUgZGlyZXTD
s3JpbywKKyAgKiBPIGFycXVpdm8gZGUgw61uZGljZSDDqSB1bSBjYWNoZSBkbyBlc3RhZG8gZGUg
dW1hIMOhcnZvcmUgZGUgZGlyZXTDs3JpbywKICAgICB1c2FkbyBwYXJhIGNyaWFyIGNvbW1pdHMs
IHJlc3RhdXJhciBkaXJldMOzcmlvcyBkZSB0cmFiYWxobywgZQotICAgIGNvbXByZWVuZGVyIGFz
IHbDoXJpYXMgw6Fydm9yZXMgaW52b2x2aWRhcyBlbSB1bWEgdW5pZmljYcOnw6NvLgorICAgIGFy
bWF6ZW5hciBhcyB2w6FyaWFzIMOhcnZvcmVzIGVudm9sdmlkYXMgZW0gdW1hIHVuaWZpY2HDp8Oj
by4KIAotUGFydGUgZG9pcyBkZXN0ZSB0dXRvcmlhbCBleHBsaWNhIGEgYmFzZSBkZSBvYmpldG9z
LCBvIGFycXVpdm8gZGUKK0EgcGFydGUgZG9pcyBkZXN0ZSB0dXRvcmlhbCBleHBsaWNhIGEgYmFz
ZSBkZSBvYmpldG9zLCBvIGFycXVpdm8gZGUKIMOtbmRpY2UsIGUgYWxndW1hcyBvdXRyYXMgY29p
c2luaGFzIHF1ZSB2b2PDqiB2YWkgcHJlY2lzYXIgcHJhIHVzYXIgbwogbcOheGltbyBkbyBnaXQu
IFZvY8OqIHBvZGUgZW5jb250csOhLWxhIGVtIGxpbmtnaXQ6Z2l0dHV0b3JpYWwtMls3XS4KIAot
U2Ugdm9jw6ogbsOjbyBxdWVyIGNvbnRpbnVhciBkbyBqZWl0byBjZXJ0bywgYWxndW1hcyBvdXRy
YXMgZGlzZ3Jlc3PDtWVzCi1xdWUgcG9kZW0gc2VyIGludGVyZXNzYW50ZXMgbmVzdGUgcG9udG8g
c8OjbzoKK1NlIHZvY8OqIG7Do28gcXVpc2VyIGNvbnRpbnVhciBjb20gbyB0dXRvcmlhbCBhZ29y
YSBuZXNzZSBtb21lbnRvLCBhbGd1bWFzCitvdXRyYXMgZGlncmVzc8O1ZXMgcXVlIHBvZGVtIHNl
ciBpbnRlcmVzc2FudGVzIG5lc3RlIHBvbnRvIHPDo286CiAKICAgKiBsaW5rZ2l0OmdpdC1mb3Jt
YXQtcGF0Y2hbMV0sIGxpbmtnaXQ6Z2l0LWFtWzFdOiBFc3RlcyBjb252ZXJ0ZW0KLSAgICBzw6ly
aWVzIGRlIGNvbW1pdHMgZW0gcGF0Y2hlcyBlbSBlbWFpbCwgZSB2aWNlLXZlcnNhLCDDunRlaXMg
cGFyYQotICAgIHByb2pldG9zIGNvbW8gbyBrZXJuZWwgbGludXggcXVlIGRlcGVuZGVtIHBlc2Fk
YW1lbnRlIGVtIHBhdGNoZXMKKyAgICBzw6lyaWVzIGRlIGNvbW1pdHMgZW0gcGF0Y2hlcyBwYXJh
IGVtYWlsLCBlIHZpY2UtdmVyc2EsIMO6dGVpcyBwYXJhCisgICAgcHJvamV0b3MgY29tbyBvIGtl
cm5lbCBMaW51eCBxdWUgZGVwZW5kZW0gZm9ydGVtZW50ZSBkZSBwYXRjaGVzCiAgICAgZW52aWFk
b3MgcG9yIGVtYWlsLgogCiAgICogbGlua2dpdDpnaXQtYmlzZWN0WzFdOiBRdWFuZG8gaMOhIHVt
YSByZWdyZXNzw6NvIGVtIHNldSBwcm9qZXRvLCB1bWEKICAgICBmb3JtYSBkZSByYXN0cmVhciB1
bSBidWcgw6kgcHJvY3VyYW5kbyBwZWxhIGhpc3TDs3JpYSBwYXJhIGVuY29udHJhciBvCi0gICAg
Y29tbWl0IGN1bHBhZG8uICBHaXQgYmlzZWN0IHBvZGUgYWp1ZGFyIGEgZXhlY3V0YXIgdW1hIGJ1
c2NhIGJpbsOhcmlhCi0gICAgcG9yIGVzc2UgY29tbWl0LiAgRWxlIMOpIGludGVsaWdlbnRlIG8g
YmFzdGFudGUgcGFyYSBleGVjdXRhciB1bWEKKyAgICBjb21taXQgY3VscGFkby4gR2l0IGJpc2Vj
dCBwb2RlIGFqdWRhciBhIGV4ZWN1dGFyIHVtYSBidXNjYSBiaW7DoXJpYQorICAgIHBvciBlc3Nl
IGNvbW1pdC4gRWxlIMOpIGludGVsaWdlbnRlIG8gYmFzdGFudGUgcGFyYSBleGVjdXRhciB1bWEK
ICAgICBidXNjYSBwcsOzeGltYSBkYSDDs3RpbWEgbWVzbW8gbm8gY2FzbyBkZSB1bWEgaGlzdMOz
cmlhIGNvbXBsZXhhCiAgICAgbsOjby1saW5lYXIgY29tIG11aXRvcyByYW1vcyB1bmlmaWNhZG9z
LgogCkBAIC02NjQsNyArNjYwLDcgQEAgcXVlIHBvZGVtIHNlciBpbnRlcmVzc2FudGVzIG5lc3Rl
IHBvbnRvIHPDo286CiAKICAgKiBsaW5rZ2l0OmdpdGN2cy1taWdyYXRpb25bN106IEdpdCBwYXJh
IHVzdcOhcmlvcyBkZSBDVlMuCiAKLVZlamEgVGFtYsOpbQorVmVqYSB0YW1iw6ltCiAtLS0tLS0t
LQogbGlua2dpdDpnaXR0dXRvcmlhbC0yWzddLAogbGlua2dpdDpnaXRjdnMtbWlncmF0aW9uWzdd
LAotLSAKMS42LjQuMzg4LmdjMTEyMAoK
--0016e645b9be48c139046fefab3c--
