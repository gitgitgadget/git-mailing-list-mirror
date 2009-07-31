From: =?ISO-8859-1?Q?Andr=E9_Goddard_Rosa?= <andre.goddard@gmail.com>
Subject: [PATCH v3] Fix typos on pt_BR/gittutorial.txt translation
Date: Fri, 31 Jul 2009 14:11:24 -0300
Message-ID: <b8bf37780907311011m232b68b7k2ba63a8ee7fc2322@mail.gmail.com>
References: <b8bf37780907292044i5ad7b879ueb5048447e4e5bb5@mail.gmail.com>
	 <20090730145044.GA1727@vespa.holoscopio.com>
	 <4A71C6A7.80008@drmicha.warpmail.net>
	 <b8bf37780907301031iec37ef8i6b3db7a9eb21eb8b@mail.gmail.com>
	 <20090731163341.GB10800@vespa.holoscopio.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016363b86de8ba14f0470038259
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	"Carlos R. Mafra" <crmafra2@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 19:11:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWvdt-0004We-Aj
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 19:11:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751862AbZGaRL0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2009 13:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751860AbZGaRL0
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 13:11:26 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:29726 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710AbZGaRLY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2009 13:11:24 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1178540qwh.37
        for <git@vger.kernel.org>; Fri, 31 Jul 2009 10:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=Mgacl5jO3UB51DDhx8UZWdpLmiw3WC0jvMh8wkmdwyk=;
        b=nssvnu49BHM1Sh3wzUcWTFOVeYzZAU3mbTOJv/gAKLZFcCPPNDJjdW8BYe55gYDSmL
         g36+oSqfAI1qgKVzxUQCAhGzKom6FLqU/h2ALCAkthzlO6VVdWLAmD/UJpfGHZjdnuRS
         7pTopZCc6xB9VtZu6exZDHC1aUD1gX7KfRU+w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=lu7cVTtxNE81gGI1AU5VHLJ1RqNAa9l/EJIVJanEbyPGIxJIOTKsHMR75dvBD2E+88
         NH0swB+bMW8MnhCIuxAgGLsvinUoqoDC9h9EpnmJT1Cx0E2dGuC+qhG9CF6dYEQiYcB1
         JHLWnHjDvSxO3vt+qXclFwftkeMboZAqjxBy0=
Received: by 10.220.46.10 with SMTP id h10mr3076623vcf.8.1249060284243; Fri, 
	31 Jul 2009 10:11:24 -0700 (PDT)
In-Reply-To: <20090731163341.GB10800@vespa.holoscopio.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124583>

--0016363b86de8ba14f0470038259
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

>From 6f4be91c88496917faf0bd63227149b1b66be1a8 Mon Sep 17 00:00:00 2001
From: =3D?UTF-8?q?Andr=3DC3=3DA9=3D20Goddard=3D20Rosa?=3D <andre.goddard@gm=
ail.com>
Date: Fri, 31 Jul 2009 13:50:50 -0300
Subject: [PATCH] [PATCH] Fix typos on pt_BR/gittutorial.txt translation
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Andr=E9 Goddard Rosa <andre.goddard@gmail.com>
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Signed-off-by: Carlos R. Mafra <crmafra2@gmail.com>
[Included extra fixes from Thadeu and Carlos as well]
---
 Documentation/pt_BR/gittutorial.txt |  142 +++++++++++++++++--------------=
----
 1 files changed, 69 insertions(+), 73 deletions(-)

diff --git a/Documentation/pt_BR/gittutorial.txt
b/Documentation/pt_BR/gittutorial.txt
index f368b1b..81e7ad7 100644
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
+Se as mudan=E7as n=E3o conflitarem, estar=E1 pronto. Se existirem conflito=
s,
 marcadores ser=E3o deixados nos arquivos problem=E1ticos exibindo o
 conflito;

@@ -245,7 +244,7 @@ conflito;
 $ git diff
 ------------------------------------------------

-vai exibir isto.  Ap=F3s voc=EA editar os arquivos para resolver os
+vai exibir isto. Ap=F3s voc=EA editar os arquivos para resolver os
 conflitos,

 ------------------------------------------------
@@ -273,7 +272,7 @@ Se voc=EA desenvolve em um ramo ideia-louca, e se
arrepende, voc=EA pode
 sempre remover o ramo com

 -------------------------------------
-$ git branch -D crazy-idea
+$ git branch -D ideia-louca
 -------------------------------------

 Ramos s=E3o baratos e f=E1ceis, ent=E3o isto =E9 uma boa maneira de experi=
mentar
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
+VEJA TAMB=C9M
 --------
 linkgit:gittutorial-2[7],
 linkgit:gitcvs-migration[7],
--=20
1.6.4.388.gc1120

--0016363b86de8ba14f0470038259
Content-Type: text/x-patch; charset=UTF-8; 
	name="0001-PATCH-Fix-typos-on-pt_BR-gittutorial.txt-translation.patch"
Content-Disposition: attachment; 
	filename="0001-PATCH-Fix-typos-on-pt_BR-gittutorial.txt-translation.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fxt64i451

RnJvbSA2ZjRiZTkxYzg4NDk2OTE3ZmFmMGJkNjMyMjcxNDliMWI2NmJlMWE4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/QW5kcj1DMz1BOT0yMEdvZGRhcmQ9MjBSb3Nh
Pz0gPGFuZHJlLmdvZGRhcmRAZ21haWwuY29tPgpEYXRlOiBGcmksIDMxIEp1bCAyMDA5IDEzOjUw
OjUwIC0wMzAwClN1YmplY3Q6IFtQQVRDSF0gW1BBVENIXSBGaXggdHlwb3Mgb24gcHRfQlIvZ2l0
dHV0b3JpYWwudHh0IHRyYW5zbGF0aW9uCk1JTUUtVmVyc2lvbjogMS4wCkNvbnRlbnQtVHlwZTog
dGV4dC9wbGFpbjsgY2hhcnNldD1VVEYtOApDb250ZW50LVRyYW5zZmVyLUVuY29kaW5nOiA4Yml0
CgpTaWduZWQtb2ZmLWJ5OiBBbmRyw6kgR29kZGFyZCBSb3NhIDxhbmRyZS5nb2RkYXJkQGdtYWls
LmNvbT4KU2lnbmVkLW9mZi1ieTogVGhhZGV1IExpbWEgZGUgU291emEgQ2FzY2FyZG8gPGNhc2Nh
cmRvQGhvbG9zY29waW8uY29tPgpTaWduZWQtb2ZmLWJ5OiBDYXJsb3MgUi4gTWFmcmEgPGNybWFm
cmEyQGdtYWlsLmNvbT4KW0luY2x1ZGVkIGV4dHJhIGZpeGVzIGZyb20gVGhhZGV1IGFuZCBDYXJs
b3MgYXMgd2VsbF0KLS0tCiBEb2N1bWVudGF0aW9uL3B0X0JSL2dpdHR1dG9yaWFsLnR4dCB8ICAx
NDIgKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0KIDEgZmlsZXMgY2hhbmdlZCwg
NjkgaW5zZXJ0aW9ucygrKSwgNzMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRh
dGlvbi9wdF9CUi9naXR0dXRvcmlhbC50eHQgYi9Eb2N1bWVudGF0aW9uL3B0X0JSL2dpdHR1dG9y
aWFsLnR4dAppbmRleCBmMzY4YjFiLi44MWU3YWQ3IDEwMDY0NAotLS0gYS9Eb2N1bWVudGF0aW9u
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
aXJlbSBjb25mbGl0b3MsCitTZSBhcyBtdWRhbsOnYXMgbsOjbyBjb25mbGl0YXJlbSwgZXN0YXLD
oSBwcm9udG8uIFNlIGV4aXN0aXJlbSBjb25mbGl0b3MsCiBtYXJjYWRvcmVzIHNlcsOjbyBkZWl4
YWRvcyBub3MgYXJxdWl2b3MgcHJvYmxlbcOhdGljb3MgZXhpYmluZG8gbwogY29uZmxpdG87CiAK
QEAgLTI0NSw3ICsyNDQsNyBAQCBjb25mbGl0bzsKICQgZ2l0IGRpZmYKIC0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogCi12YWkgZXhpYmlyIGlzdG8uICBB
cMOzcyB2b2PDqiBlZGl0YXIgb3MgYXJxdWl2b3MgcGFyYSByZXNvbHZlciBvcwordmFpIGV4aWJp
ciBpc3RvLiBBcMOzcyB2b2PDqiBlZGl0YXIgb3MgYXJxdWl2b3MgcGFyYSByZXNvbHZlciBvcwog
Y29uZmxpdG9zLAogCiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0KQEAgLTI3Myw3ICsyNzIsNyBAQCBTZSB2b2PDqiBkZXNlbnZvbHZlIGVtIHVtIHJhbW8g
aWRlaWEtbG91Y2EsIGUgc2UgYXJyZXBlbmRlLCB2b2PDqiBwb2RlCiBzZW1wcmUgcmVtb3ZlciBv
IHJhbW8gY29tCiAKIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KLSQgZ2l0
IGJyYW5jaCAtRCBjcmF6eS1pZGVhCiskIGdpdCBicmFuY2ggLUQgaWRlaWEtbG91Y2EKIC0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIAogUmFtb3Mgc8OjbyBiYXJhdG9zIGUg
ZsOhY2VpcywgZW50w6NvIGlzdG8gw6kgdW1hIGJvYSBtYW5laXJhIGRlIGV4cGVyaW1lbnRhcgpA
QCAtMjkzLDcgKzI5Miw3IEBAIGJvYiQgZ2l0IGNsb25lIC9ob21lL2FsaWNlL3Byb2plY3QgbXly
ZXBvCiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIAog
SXNzbyBjcmlhIHVtIG5vdm8gZGlyZXTDs3JpbyAibXlyZXBvIiBjb250ZW5kbyB1bSBjbG9uZSBk
byByZXBvc2l0w7NyaW8gZGUKLUFsaWNlLiAgTyBjbG9uZSBlc3TDoSBubyBtZXNtbyBww6kgcXVl
IG8gcHJvamV0byBvcmlnaW5hbCwgcG9zc3VpbmRvIHN1YQorQWxpY2UuIE8gY2xvbmUgZXN0w6Eg
bm8gbWVzbW8gcMOpIHF1ZSBvIHByb2pldG8gb3JpZ2luYWwsIHBvc3N1aW5kbyBzdWEKIHByw7Nw
cmlhIGPDs3BpYSBkYSBoaXN0w7NyaWEgZG8gcHJvamV0byBvcmlnaW5hbC4KIAogQm9iIGVudMOj
byBmYXogYWxndW1hcyBtdWRhbsOnYXMgZSBhcyBncmF2YToKQEAgLTMwNSw3ICszMDQsNyBAQCBi
b2IkIGdpdCBjb21taXQgLWEKIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQogCiBRdWFudG8gZXN0w6EgcHJvbnRvLCBlbGUgZGl6IGEgQWxpY2UgcGFyYSBw
dXhhciBhcyBtdWRhbsOnYXMgZG8KLXJlcG9zaXTDs3JpbyBlbSAvaG9tZS9ib2IvbXlyZXBvLiAg
RWxhIG8gZmF6IGNvbToKK3JlcG9zaXTDs3JpbyBlbSAvaG9tZS9ib2IvbXlyZXBvLiBFbGEgbyBm
YXogY29tOgogCiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0KIGFsaWNlJCBjZCAvaG9tZS9hbGljZS9wcm9qZWN0CkBAIC0zMTQsMTQgKzMxMywxNCBAQCBh
bGljZSQgZ2l0IHB1bGwgL2hvbWUvYm9iL215cmVwbyBtYXN0ZXIKIAogSXN0byB1bmlmaWNhIGFz
IG11ZGFuw6dhcyBkbyByYW1vICJtYXN0ZXIiIGRvIEJvYiBhbyByYW1vIGF0dWFsIGRlIEFsaWNl
LgogU2UgQWxpY2UgZmV6IHN1YXMgcHLDs3ByaWFzIG11ZGFuw6dhcyBubyBpbnRlcnZhbG8sIGVs
YSwgZW50w6NvLCBwb2RlCi1wcmVjaXNhciBjb3JyaWdpciBtYW51YWxtZW50ZSBxdWFpcXVlciBj
b25mbGl0b3MuICAoTm90ZSBxdWUgbyBhcmd1bWVudG8KK3ByZWNpc2FyIGNvcnJpZ2lyIG1hbnVh
bG1lbnRlIHF1YWlzcXVlciBjb25mbGl0b3MuIChOb3RlIHF1ZSBvIGFyZ3VtZW50bwogIm1hc3Rl
ciIgbm8gY29tYW5kbyBhY2ltYSDDqSwgZGUgZmF0bywgZGVzbmVjZXNzw6FyaW8sIGrDoSBxdWUg
w6kgbyBwYWRyw6NvLikKIAogTyBjb21hbmRvICJwdWxsIiBleGVjdXRhLCBlbnTDo28sIGR1YXMg
b3BlcmHDp8O1ZXM6IGVsZSBvYnTDqW0gbXVkYW7Dp2FzIGRlCiB1bSByYW1vIHJlbW90bywgZSwg
ZW50w6NvLCBhcyB1bmlmaWNhIG5vIHJhbW8gYXR1YWwuCiAKIE5vdGUgcXVlLCBlbSBnZXJhbCwg
QWxpY2UgZ29zdGFyaWEgcXVlIHN1YXMgbXVkYW7Dp2FzIGxvY2FpcyBmb3NzZW0KLWdyYXZhZGFz
IGFudGVzIGRlIGluaWNpYXIgZXN0ZSAicHVsbCIuICBTZSBvIHRyYWJhbGhvIGRlIEJvYm8gY29u
ZmxpdGEKK2dyYXZhZGFzIGFudGVzIGRlIGluaWNpYXIgZXN0ZSAicHVsbCIuIFNlIG8gdHJhYmFs
aG8gZGUgQm9iIGNvbmZsaXRhCiBjb20gbyBxdWUgQWxpY2UgZmV6IGRlc2RlIHF1ZSBzdWFzIGhp
c3TDs3JpYXMgc2UgcmFtaWZpY2FyYW0sIEFsaWNlIGlyw6EKIHVzYXIgc2V1IGRpcmV0w7NyaW8g
ZGUgdHJhYmFsaG8gZSBvIMOtbmRpY2UgcGFyYSByZXNvbHZlciBjb25mbGl0b3MsIGUKIG11ZGFu
w6dhcyBsb2NhaXMgZXhpc3RlbnRlcyBpcsOjbyBpbnRlcmZlcmlyIGNvbSBvIHByb2Nlc3NvIGRl
IHJlc29sdcOnw6NvCkBAIC0zNDEsMTggKzM0MCwxOCBAQCBhbGljZSQgZ2l0IGxvZyAtcCBIRUFE
Li5GRVRDSF9IRUFECiAKIEVzdGEgb3BlcmHDp8OjbyDDqSBzZWd1cmEgbWVzbW8gc2UgQWxpY2Ug
dGVtIG11ZGFuw6dhcyBsb2NhaXMgbsOjbyBncmF2YWRhcy4KIEEgbm90YcOnw6NvIGRlIGludGVy
dmFsbyAiSEVBRC4uRkVUQ0hfSEVBRCIgc2lnbmlmaWNhIG1vc3RyYXIgdHVkbyBxdWUgw6kKLWFs
Y2Fuw6fDoXZlbCBkZSBGRVRDSF9IRUFEIG1hcyBleGNsdWEgdHVkbyBxdWUgw6kgYWxjYW7Dp8Oh
dmVsIGRlIEhFQUQuIEFsY2llCi1qw6Egc2FiZSB0dWRvIHF1ZSBsZXZhIGEgc2V1IGVzdGFkbyBh
dHVhbCAoSEVBRCksIGUgcmV2aXNhIG8gcXVlIEJvYiB0ZW0KLWVtIHNldSBlc3RhZG8gKEZFVENI
X0hFQUQpIHF1ZSBlbGEgYWluZGEgbsOjbyB2aXUgY29tIGVzc2UgY29tYW5kby4KK2FsY2Fuw6fD
oXZlbCBkZSBGRVRDSF9IRUFEIG1hcyBleGNsdWEgdHVkbyBvIHF1ZSDDqSBhbGNhbsOnw6F2ZWwg
ZGUgSEVBRC4KK0FsaWNlIGrDoSBzYWJlIHR1ZG8gcXVlIGxldmEgYSBzZXUgZXN0YWRvIGF0dWFs
IChIRUFEKSwgZSByZXZpc2EgbyBxdWUgQm9iCit0ZW0gZW0gc2V1IGVzdGFkbyAoRkVUQ0hfSEVB
RCkgcXVlIGVsYSBhaW5kYSBuw6NvIHZpdSBjb20gZXNzZSBjb21hbmRvLgogCi1TZSBBbGljZSBx
dWVyIHZpc3VhbGl6YXIgbyBxdWUgQm9iIGZleiBkZXNkZSBxdWUgc3VhcyBoaXN0w7NyaWEKK1Nl
IEFsaWNlIHF1ZXIgdmlzdWFsaXphciBvIHF1ZSBCb2IgZmV6IGRlc2RlIHF1ZSBzdWFzIGhpc3TD
s3JpYXMgc2UKIHJhbWlmaWNhcmFtLCBlbGEgcG9kZSBkaXNwYXJhciBvIHNlZ3VpbnRlIGNvbWFu
ZG86CiAKIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQog
JCBnaXRrIEhFQUQuLkZFVENIX0hFQUQKIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQogCi1Jc3RvIHVzYXIgYSBtZXNtYSBub3Rhw6fDo28gZGUgaW50ZXJ2
YWxkbyBxdWUgdmltb3MgYW50ZXMgY29tICdnaXQgbG9nJy4KK0lzdG8gdXNhIGEgbWVzbWEgbm90
YcOnw6NvIGRlIGludGVydmFsbyBxdWUgdmltb3MgYW50ZXMgY29tICdnaXQgbG9nJy4KIAogQWxp
Y2UgcG9kZSBxdWVyZXIgdmVyIG8gcXVlIGFtYm9zIGZpemVyYW0gZGVzZGUgcXVlIHJhbWlmaWNh
cmFtLiBFbGEKIHBvZGUgdXNhciBhIGZvcm1hIGNvbSB0csOqcyBwb250b3MgYW8gaW52w6lzIGRh
IGZvcm1hIGNvbSBkb2lzIHBvbnRvczoKQEAgLTM2MSwyMyArMzYwLDIxIEBAIHBvZGUgdXNhciBh
IGZvcm1hIGNvbSB0csOqcyBwb250b3MgYW8gaW52w6lzIGRhIGZvcm1hIGNvbSBkb2lzIHBvbnRv
czoKICQgZ2l0ayBIRUFELi4uRkVUQ0hfSEVBRAogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tCiAKLUlzdG8gc2lnbmlmaWNhICJtb3N0cmUgdHVkbyBxdWUg
w6kgYWxjYW7Dp2F2ZWwgZGUgcXVhbHF1ZXIgdW0sIG1hcyBleGNsdWEKLXR1ZG8gcXVlIMOpIGFs
Y2Fuw6dhdmVsIGEgcGFydGlyIGRlIGFtYm9zIi4KLVRoaXMgbWVhbnMgInNob3cgZXZlcnl0aGlu
ZyB0aGF0IGlzIHJlYWNoYWJsZSBmcm9tIGVpdGhlciBvbmUsIGJ1dAotZXhjbHVkZSBhbnl0aGlu
ZyB0aGF0IGlzIHJlYWNoYWJsZSBmcm9tIGJvdGggb2YgdGhlbSIuCitJc3RvIHNpZ25pZmljYSAi
bW9zdHJlIHR1ZG8gcXVlIMOpIGFsY2Fuw6fDoXZlbCBkZSBxdWFscXVlciB1bSBkZWxlcywgbWFz
CitleGNsdWEgdHVkbyBxdWUgw6kgYWxjYW7Dp8OhdmVsIGEgcGFydGlyIGRlIGFtYm9zIi4KIAog
UG9yIGZhdm9yLCBub3RlIHF1ZSBlc3NhcyBub3Rhw6fDtWVzIGRlIGludGVydmFsbyBwb2RlbSBz
ZXIgdXNhZGFzIHRhbnRvCiBjb20gZ2l0ayBxdWFudG8gY29tICJnaXQgbG9nIi4KIAotQXBvw7Nz
IGluc3BlY2lvbmFyIG8gcXVlIEJvYiBmZXosIHNlIG7Do28gaMOhIG5hZGEgdXJnZW50ZSwgQWxp
Y2UgcG9kZQotZGVjaWRpciBjb250aW51YXIgdHJhYmFsaGFuZG8gc2VtIHB1eGFyIGRlIEJvYi4g
IFNlIGEgaGlzdMOzcmlhIGRlIEJvYgorQXDDs3MgaW5zcGVjaW9uYXIgbyBxdWUgQm9iIGZleiwg
c2UgbsOjbyBow6EgbmFkYSB1cmdlbnRlLCBBbGljZSBwb2RlCitkZWNpZGlyIGNvbnRpbnVhciB0
cmFiYWxoYW5kbyBzZW0gcHV4YXIgZGUgQm9iLiBTZSBhIGhpc3TDs3JpYSBkZSBCb2IKIHRlbSBh
bGd1bWEgY29pc2EgcXVlIEFsaWNlIHByZWNpc2EgaW1lZGlhdGFtZW50ZSwgQWxpY2UgcG9kZSBv
cHRhciBwb3IKIHNlcGFyYXIgc2V1IHRyYWJhbGhvIGVtIHByb2dyZXNzbyBwcmltZWlybywgZmF6
ZXIgdW0gInB1bGwiLCBlLCBlbnTDo28sCiBmaW5hbG1lbnRlLCByZXRvbWFyIHNldSB0cmFiYWxo
byBlbSBwcm9ncmVzc28gZW0gY2ltYSBkYSBoaXN0w7NyaWEKIHJlc3VsdGFudGUuCiAKLVF1YW50
byB2b2PDqiBlc3TDoSB0cmFiYWxoYW5kbyBlbSB1bSBwZXF1ZW5vIGdydXBvIHVuaWRvLCBuw6Nv
IMOpIGluY29tdW0KLWludGVyYWdpciBjb20gbyBtZXNtbyByZXBvc2l0w7NyaW8gdsOhcmlhcyBl
IHbDoXJpYXMgdmV6ZXMuICBEZWZpbmluZG8gdW0KK1F1YW5kbyB2b2PDqiBlc3TDoSB0cmFiYWxo
YW5kbyBlbSB1bSBwZXF1ZW5vIGdydXBvIHVuaWRvLCBuw6NvIMOpIGluY29tdW0KK2ludGVyYWdp
ciBjb20gbyBtZXNtbyByZXBvc2l0w7NyaW8gdsOhcmlhcyBlIHbDoXJpYXMgdmV6ZXMuIERlZmlu
aW5kbyB1bQogcmVwb3NpdMOzcmlvIHJlbW90byBhbnRlcyBkZSB0dWRvLCB2b2PDqiBwb2RlIGZh
esOqLWxvIG1haXMgZmFjaWxtZW50ZToKIAogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tCkBAIC0zOTQsNyArMzkxLDcgQEAgYWxpY2UkIGdpdCBmZXRjaCBi
b2IKIAogRGlmZXJlbnRlIGRhIGZvcm1hIGxvbmdhLCBxdWFuZG8gQWxpY2Ugb2J0ZXZlIGRlIEJv
YiB1c2FuZG8gdW0KIHJlcG9zaXTDs3JpbyByZW1vdG8gYW50ZXMgZGVmaW5pZG8gY29tICdnaXQt
cmVtb3RlJywgbyBxdWUgZm9pIG9idGlkbyDDqQotYXJtYXplbmFkbyB1bSByYW1vIHJlbW90bywg
bmVzdGUgY2FzbyBgYm9iL21hc3RlcmAuICBFbnTDo28sIGFww7NzIGlzc286Cithcm1hemVuYWRv
IGVtIHVtIHJhbW8gcmVtb3RvLCBuZXN0ZSBjYXNvIGBib2IvbWFzdGVyYC4gRW50w6NvLCBhcMOz
cyBpc3NvOgogCiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiBhbGljZSQg
Z2l0IGxvZyAtcCBtYXN0ZXIuLmJvYi9tYXN0ZXIKQEAgLTQxNyw3ICs0MTQsNyBAQCBhbGljZSQg
Z2l0IHB1bGwgLiByZW1vdGVzL2JvYi9tYXN0ZXIKIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0KIAogTm90ZSBxdWUgJ2dpdCBwdWxsJyBzZW1wcmUgdW5pZmljYSBhbyByYW1v
IGF0dWFsLCBpbmRlcGVuZGVudGUgZG8gcXVlCi1tYWlzIGZvaSBkYWRvIG5hIGxpbmhhIGRlIGNv
bWFuZG8uCittYWlzIGZvaSBwYXNzYWRvIG5hIGxpbmhhIGRlIGNvbWFuZG8uCiAKIERlcG9pcywg
Qm9iIHBvZGUgYXR1YWxpemFyIHNldSByZXBvc2l0w7NyaW8gY29tIGFzIMO6bHRpbWFzIG11ZGFu
w6dhcyBkZQogQWxpY2UsIHVzYW5kbwpAQCAtNDI4LDcgKzQyNSw3IEBAIGJvYiQgZ2l0IHB1bGwK
IAogTm90ZSBxdWUgZWxlIG7Do28gcHJlY2lzYSBkYXIgbyBjYW1pbmhvIGRvIHJlcG9zaXTDs3Jp
byBkZSBBbGljZTsgcXVhbmRvCiBCb2IgY2xvbm91IHNldSByZXBvc2l0w7NyaW8sIG8gZ2l0IGFy
bWF6ZW5vdSBhIGxvY2FsaXphw6fDo28gZGUgc2V1Ci1yZXBvc2l0w7NyaW8gbmEgY29uZmlndXJh
w6fDo28gZG8gcmVwb3NpdMOzcmlvLCBlIGVzc2EgbG9jYWxpemHDp8OjbyDDqSB1c2FkYQorcmVw
b3NpdMOzcmlvIG5hIGNvbmZpZ3VyYcOnw6NvIGRvIG1lc21vLCBlIGVzc2EgbG9jYWxpemHDp8Oj
byDDqSB1c2FkYQogcGFyYSBwdXhhcjoKIAogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQpAQCAtNDU5LDE1ICs0NTYsMTUgQEAgQWx0ZXJuYXRpdmFtZW50ZSwgbyBnaXQgdGVt
IHVtIHByb3RvY29sbyBuYXRpdm8sIG91IHBvZGUgdXNhciByc3luYyBvdQogaHR0cDsgdmVqYSBs
aW5rZ2l0OmdpdC1wdWxsWzFdIHBhcmEgZGV0YWxoZXMuCiAKIEdpdCBwb2RlIHRhbWLDqW0gc2Vy
IHVzYWRvIGVtIHVtIG1vZG8gcGFyZWNpZG8gY29tIENWUywgY29tIHVtCi1yZXBvc2l0w7NyaW8g
Y2VudHJhbCBwYXJhIG8gcXVhbCBxdWUgdsOhcmlvcyB1c3XDoXJpb3MgZW1wdXJyYW0KLW1vZGlm
aWNhw6fDtWVzOyB2ZWphIGxpbmtnaXQ6Z2l0LXB1c2hbMV0gZSBsaW5rZ2l0OmdpdGN2cy1taWdy
YXRpb25bN10uCityZXBvc2l0w7NyaW8gY2VudHJhbCBwYXJhIG8gcXVhbCB2w6FyaW9zIHVzdcOh
cmlvcyBlbXB1cnJhbSBtb2RpZmljYcOnw7VlczsKK3ZlamEgbGlua2dpdDpnaXQtcHVzaFsxXSBl
IGxpbmtnaXQ6Z2l0Y3ZzLW1pZ3JhdGlvbls3XS4KIAogRXhwbG9yYW5kbyBoaXN0w7NyaWEKIC0t
LS0tLS0tLS0tLS0tLS0tCiAKIEEgaGlzdMOzcmlhIG5vIGdpdCDDqSByZXByZXNlbnRhZGEgY29t
byB1bWEgc8OpcmllIGRlIGNvbW1pdHMKLWludGVycmVsYWNpb25hZG9zLiAgTsOzcyBqw6Egdmlt
b3MgcXVlIG8gY29tYW5kbyAnZ2l0LWxvZycgcG9kZSBsaXN0YXIKLWVzc2VzIGNvbW1pdHMuIE5v
dGUgcXVlIGEgcHJpbWVpcmEgbGluaGEgZGUgY2FtYSBlbnRyYWRhIG5vIGxvZyB0YW1iw6ltCitp
bnRlcnJlbGFjaW9uYWRvcy4gTsOzcyBqw6Egdmltb3MgcXVlIG8gY29tYW5kbyAnZ2l0LWxvZycg
cG9kZSBsaXN0YXIKK2Vzc2VzIGNvbW1pdHMuIE5vdGUgcXVlIGEgcHJpbWVpcmEgbGluaGEgZGUg
Y2FkYSBlbnRyYWRhIG5vIGxvZyB0YW1iw6ltCiBkw6EgbyBub21lIHBhcmEgbyBjb21taXQ6CiAK
IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KQEAgLTQ4Niw5ICs0ODMsOSBA
QCBjb21taXQuCiAkIGdpdCBzaG93IGM4MmEyMmMzOWNiYzMyNTc2ZjY0ZjVjNmIzZjI0Yjk5ZWE4
MTQ5YzcKIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIAotTWFzIGjDoSBv
dXRyYXMgZm9ybWFzIGRlIHNlIHJlZmVyaXIgYSBjb21taXRzLiAgVm9jw6ogcG9kZSB1c2FyIHF1
YWxxdWVyCi1wYXJ0ZSBpbmljaWFsIGRvIG5vbWUgcXVlIHNlamEgbG9uZ28gbyBiYXN0YW50ZSBw
YXJhIHVuaWNhbWVudGUKLWlkZW50aWZpY2FyIG8gY29tbWl0OgorTWFzIGjDoSBvdXRyYXMgZm9y
bWFzIGRlIHNlIHJlZmVyaXIgYW9zIGNvbW1pdHMuIFZvY8OqIHBvZGUgdXNhciBxdWFscXVlcgor
cGFydGUgaW5pY2lhbCBkbyBub21lIHF1ZSBzZWphIGxvbmdvIG8gYmFzdGFudGUgcGFyYSBpZGVu
dGlmaWNhcgordW5pY2FtZW50ZSBvIGNvbW1pdDoKIAogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLQogJCBnaXQgc2hvdyBjODJhMjJjMzljCSMgb3MgcHJpbWVpcm9zIGNhcmFj
dGVyZXMgZG8gbm9tZSBzw6NvIG8gYmFzdGFudGUKQEAgLTQ5Nyw3ICs0OTQsNyBAQCAkIGdpdCBz
aG93IEhFQUQJCSMgYSBwb250YSBkbyByYW1vIGF0dWFsCiAkIGdpdCBzaG93IGV4cGVyaW1lbnRh
bAkjIGEgcG9udGEgZG8gcmFtbyAiZXhwZXJpbWVudGFsIgogLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLQogCi1Ub2RvIGNvbW1pdCB1c3VhbG1lbnRlIHRlbSB1bSBjb21taXQg
InBhaSIgcXVlIGFwb250YSBwYXJhIG8gZXN0YWRvCitUb2RvIGNvbW1pdCBub3JtYWxtZW50ZSB0
ZW0gdW0gY29tbWl0ICJwYWkiIHF1ZSBhcG9udGEgcGFyYSBvIGVzdGFkbwogYW50ZXJpb3IgZG8g
cHJvamV0bzoKIAogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpAQCAtNTEz
LDE5ICs1MTAsMTkgQEAgJCBnaXQgc2hvdyBIRUFEXjEgIyBtb3N0cmEgbyBwcmltZWlybyBwYWkg
ZGUgSEVBRCAobyBtZXNtbyBxdWUgSEVBRF4pCiAkIGdpdCBzaG93IEhFQUReMiAjIG1vc3RyYSBv
IHNlZ3VuZG8gcGFpIGRlIEhFQUQKIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0KIAotVm9jw6ogdGFtYsOpbSBwb2RlIGRhciBhb3MgY29tbWl0cyBub21lcyBzZXVzOyBhcMOz
cyBleGVjdXRhcgorVm9jw6ogdGFtYsOpbSBwb2RlIGRhciBhb3MgY29tbWl0cyBub21lcyDDoCBz
dWEgZXNjb2xoYTsgYXDDs3MgZXhlY3V0YXIKIAogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQogJCBnaXQgdGFnIHYyLjUgMWIyZTFkNjNmZgogLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQogCi12b2PDqiBwb2RlIHNlIHJlZmVyaXIgYSAxYjJlMWQ2M2Zm
IHBlbG8gbm9tZSAidjIuNSIuICBTZSB2b2PDqiBwcmV0ZW5kZQordm9jw6ogcG9kZSBzZSByZWZl
cmlyIGEgMWIyZTFkNjNmZiBwZWxvIG5vbWUgInYyLjUiLiBTZSB2b2PDqiBwcmV0ZW5kZQogY29t
cGFydGlsaGFyIGVzc2Ugbm9tZSBjb20gb3V0cmFzIHBlc3NvYXMgKHBvciBleGVtcGxvLCBwYXJh
IGlkZW50aWZpY2FyCi11bWEgdmVyc8OjbyBkZSBsYW7Dp2FtZW50byksIHZvY8OqIGRldmUgY3Jp
YXIgdW0gb2JqZXRvICJ0YWciLCBlIHRhbHZlegordW1hIHZlcnPDo28gZGUgbGFuw6dhbWVudG8p
LCB2b2PDqiBkZXZlcmlhIGNyaWFyIHVtIG9iamV0byAidGFnIiwgZSB0YWx2ZXoKIGFzc2luw6Et
bG87IHZlamEgbGlua2dpdDpnaXQtdGFnWzFdIHBhcmEgZGV0YWxoZXMuCiAKIFF1YWxxdWVyIGNv
bWFuZG8gZ2l0IHF1ZSBwcmVjaXNlIGNvbmhlY2VyIHVtIGNvbW1pdCBwb2RlIHJlY2ViZXIKLXF1
YWlzcXVlciBkZXNzZXMgbm9tZXMuICBQb3IgZXhlbXBsbzoKK3F1YWlzcXVlciBkZXNzZXMgbm9t
ZXMuIFBvciBleGVtcGxvOgogCiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
CiAkIGdpdCBkaWZmIHYyLjUgSEVBRAkgIyBjb21wYXJhIG8gSEVBRCBhdHVhbCBjb20gdjIuNQpA
QCAtNTM3LDggKzUzNCw4IEBAICQgZ2l0IHJlc2V0IC0taGFyZCBIRUFEXiAjIHJlc2V0YSBzZXUg
cmFtbyBhdHVhbCBlIHNldSBkaXJldMOzcmlvIGRlCiAKIFNlamEgY3VpZGFkb3NvIGNvbSBvIMO6
bHRpbW8gY29tYW5kbzogYWzDqW0gZGUgcGVyZGVyIHF1YWlzcXVlciBtdWRhbsOnYXMKIGVtIHNl
dSBkaXJldMOzcmlvIGRlIHRyYWJhbGhvLCBlbGUgdGFtYsOpbSByZW1vdmUgdG9kb3Mgb3MgY29t
bWl0cwotcG9zdGVyaW9yZXMgZGVzc2UgcmFtby4gIFNlIGVzc2UgcmFtbyDDqSBvIMO6bmljbyBy
YW1vIGNvbnRlbmRvIGVzc2VzCi1jb21taXRzLCBlbGVzIHNlcsOjbyBwZXJkaWRvcy4gIFRhbWLD
qW0sIG7Do28gdXNlICdnaXQtcmVzZXQnIG51bSByYW1vCitwb3N0ZXJpb3JlcyBkZXNzZSByYW1v
LiBTZSBlc3NlIHJhbW8gw6kgbyDDum5pY28gcmFtbyBjb250ZW5kbyBlc3NlcworY29tbWl0cywg
ZWxlcyBzZXLDo28gcGVyZGlkb3MuIFRhbWLDqW0sIG7Do28gdXNlICdnaXQtcmVzZXQnIG51bSBy
YW1vCiBwdWJsaWNhbWVudGUgdmlzw612ZWwgZGUgb25kZSBvdXRyb3MgZGVzZW52b2x2ZWRvcmVz
IHB1eGFtLCBqw6EgcXVlIHZhaQogZm9yw6dhciB1bmlmaWNhw6fDtWVzIGRlc25lY2Vzc8Ohcmlh
cyBwYXJhIHF1ZSBvdXRyb3MgZGVzZW52b2x2ZWRvcmVzIGxpbXBlbQogYSBoaXN0w7NyaWEuIFNl
IHZvY8OqIHByZWNpc2EgZGVzZmF6ZXIgbXVkYW7Dp2FzIHF1ZSB2b2PDqiBlbXB1cnJvdSwgdXNl
CkBAIC01NTEsMTAgKzU0OCwxMCBAQCBwcm9qZXRvLCBlbnTDo28KICQgZ2l0IGdyZXAgImhlbGxv
IiB2Mi41CiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiAKLXByb2N1cmEg
cG9yIHRvZGFzIGFzIG9jb3JyZcOqbmNpYXMgZGUgImhlbGxvIiBlbSB2Mi41LgorcHJvY3VyYSBw
b3IgdG9kYXMgYXMgb2NvcnLDqm5jaWFzIGRlICJoZWxsbyIgZW0gdjIuNS4KIAogU2Ugdm9jw6og
ZGVpeGFyIGRlIGZvcmEgbyBub21lIGRvIGNvbW1pdCwgJ2dpdC1ncmVwJyBpcsOhIHByb2N1cmFy
Ci1xdWFpc3F1ZXIgZG9zIGFycXVpdm9zIHF1ZSBlbGUgZ2VyZW5jaWEgbm8gZGlyZXTDs3JpbyBj
b3JyZW50ZS4gIEVudMOjbworcXVhaXNxdWVyIGRvcyBhcnF1aXZvcyBxdWUgZWxlIGdlcmVuY2lh
IG5vIGRpcmV0w7NyaW8gY29ycmVudGUuIEVudMOjbwogCiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tCiAkIGdpdCBncmVwICJoZWxsbyIKQEAgLTU2NCw4ICs1NjEsNyBAQCAk
IGdpdCBncmVwICJoZWxsbyIKIGdpdC4KIAogTXVpdG9zIGNvbWFuZG9zIGdpdCB0YW1iw6ltIHJl
Y2ViZW0gdW0gY29uanVudG8gZGUgY29tbWl0cywgbyBxdWUgcG9kZQotc2VyIGVzcGVjaWZpY2Fk
byBkZSB1bSBib20gbsO6bWVybyBkZSBmb3JtYXMuICBBcXVpIGVzdMOjbyBhbGd1bnMgZXhlbXBs
b3MKLWNvbSAnZ2l0LWxvZyc6CitzZXIgZXNwZWNpZmljYWRvIGRlIHbDoXJpYXMgZm9ybWFzLiBB
cXVpIGVzdMOjbyBhbGd1bnMgZXhlbXBsb3MgY29tICdnaXQtbG9nJzoKIAogLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogJCBnaXQgbG9nIHYyLjUuLnYyLjYgICAgICAgICAg
ICAjIGNvbW1pdHMgZW50cmUgdjIuNSBlIHYyLjYKQEAgLTU4NCw3ICs1ODAsNyBAQCBjb211bSBh
bGd1bSB0ZW1wbyBhdHLDoXMsIGVudMOjbwogJCBnaXQgbG9nIHN0YWJsZS4ubWFzdGVyCiAtLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiAKLWlyw6EgbGlzdGFzIG9zIGNvbW1p
dHMgZmVpdG9zIG5vIHJhbW8gIm1hc3RlciIgbWFzIG7Do28gbm8gcmFtbworaXLDoSBsaXN0YXIg
b3MgY29tbWl0cyBmZWl0b3Mgbm8gcmFtbyAibWFzdGVyIiBtYXMgbsOjbyBubyByYW1vCiAic3Rh
YmxlIiwgZW5xdWFudG8KIAogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpA
QCAtNTk0LDI2ICs1OTAsMjYgQEAgJCBnaXQgbG9nIG1hc3Rlci4uc3RhYmxlCiBpcsOhIGxpc3Rh
ciBhIGxpc3RhIGRlIGNvbW1pdHMgZmVpdG9zIG5vIHJhbW8gInN0YWJsZSIgbWFzIG7Do28gbm8g
cmFtbwogIm1hc3RlciIuCiAKLU8gY29tYW5kbyAnZ2l0LWxvZycgdGVtIHVtYSBmcmFxdXphOiBl
bGUgcHJlY2lzYSBtb3N0cmFyIG9zIGNvbW1pdHMgZW0KK08gY29tYW5kbyAnZ2l0LWxvZycgdGVt
IHVtYSBmcmFxdWV6YTogZWxlIHByZWNpc2EgbW9zdHJhciBvcyBjb21taXRzIGVtCiB1bWEgbGlz
dGEuIFF1YW5kbyBhIGhpc3TDs3JpYSB0ZW0gbGluaGFzIGRlIGRlc2Vudm9sdmltZW50byBxdWUK
IGRpdmVyZ2lyYW0gZSBlbnTDo28gZm9yYW0gdW5pZmljYWRhcyBub3ZhbWVudGUsIGEgb3JkZW0g
ZW0gcXVlICdnaXQtbG9nJwotYXByZXNlbnRhIGVzc2FzIG11ZGFuw6dhcyDDqSBpbnNpZ25pZmlj
YW50ZS4KK2FwcmVzZW50YSBlc3NhcyBtdWRhbsOnYXMgw6kgaXJyZWxldmFudGUuCiAKIEEgbWFp
b3JpYSBkb3MgcHJvamV0b3MgY29tIG3Dumx0aXBsb3MgY29udHJpYnVpZG9yZXMgKGNvbW8gbyBr
ZXJuZWwKLWxpbnV4LCBvdSBvIGdpdCBtZXNtbykgdGVtIHVuaWZpY2HDp8O1ZXMgZnJlcXVlbnRl
cywgZSAnZ2l0aycgZmF6IHVtCi10cmFiYWxobyBtZWxob3IgZGUgdmlzdWFsaXphciBzdWEgaGlz
dMOzcmlhLiAgUG9yIGV4ZW1wbG8sCitMaW51eCwgb3UgbyBwcsOzcHJpbyBnaXQpIHRlbSB1bmlm
aWNhw6fDtWVzIGZyZXF1ZW50ZXMsIGUgJ2dpdGsnIGZheiB1bQordHJhYmFsaG8gbWVsaG9yIGRl
IHZpc3VhbGl6YXIgc3VhIGhpc3TDs3JpYS4gUG9yIGV4ZW1wbG8sCiAKIC0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KICQgZ2l0ayAtLXNpbmNlPSIyIHdlZWtzIGFnbyIgZHJp
dmVycy8KIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIAotcGVybWl0ZSB2
b2PDqiBuYXZlZ2FyIGVtIHF1YWlzcXVlciBjb21taXRzIGRlc2RlIGFzIMO6bHRpbWFzIGR1YXMg
c2VtYW5hcwotZGUgY29tbWl0cyBxdWUgbW9kaWZpY2FyYW0gYXJxdWl2b3Mgc29iIG8gZGlyZXTD
s3JpbyAiZHJpdmVycyIuICAoTm90YToKK3Blcm1pdGUgYSB2b2PDqiBuYXZlZ2FyIGVtIHF1YWlz
cXVlciBjb21taXRzIGRlc2RlIGFzIMO6bHRpbWFzIGR1YXMgc2VtYW5hcworZGUgY29tbWl0cyBx
dWUgbW9kaWZpY2FyYW0gYXJxdWl2b3Mgc29iIG8gZGlyZXTDs3JpbyAiZHJpdmVycyIuIChOb3Rh
Ogogdm9jw6ogcG9kZSBhanVzdGFyIGFzIGZvbnRlcyBkbyBnaXRrIHNlZ3VyYW5kbyBhIHRlY2xh
IGNvbnRyb2wgZW5xdWFudG8KIHByZXNzaW9uYSAiLSIgb3UgIisiLikKIAotRmluYWxtZW50ZSwg
YSBtYWlvcmlhIGRvcyBjb21hbmRvcyBxdWUgcmVjZWJlbSBub21lcyBkZSBhcnF1aXZvCi10ZSBw
ZXJtaXRpcsOjbyBvcGNpb25hbG1lbnRlIHByZWNlZGVyIHF1YWxxdWVyIG5vbWUgZGUgYXJxdWl2
byBwb3IgdW0KK0ZpbmFsbWVudGUsIGEgbWFpb3JpYSBkb3MgY29tYW5kb3MgcXVlIHJlY2ViZW0g
bm9tZXMgZGUgYXJxdWl2byBwZXJtaXRpcsOjbwordGFtYsOpbSwgb3BjaW9uYWxtZW50ZSwgcHJl
Y2VkZXIgcXVhbHF1ZXIgbm9tZSBkZSBhcnF1aXZvIHBvciB1bQogY29tbWl0LCBwYXJhIGVzcGVj
aWZpY2FyIHVtYSB2ZXJzw6NvIHBhcnRpY3VsYXIgZG8gYXJxdWl2bzoKIAogLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpAQCAtNjMwLDMzICs2MjYsMzMgQEAgUHLDs3hpbW9z
IHBhc3NvcwogLS0tLS0tLS0tLQogCiBFc3RlIHR1dG9yaWFsIGRldmUgc2VyIG8gYmFzdGFudGUg
cGFyYSBvcGVyYXIgY29udHJvbGUgZGUgcmV2aXPDo28KLWRpc3RyaWJ1w61kbyBiw6FzaWNvIHBh
cmEgc2V1cyBwcm9qZXRvcy4gIE5vIGVudGFudG8sIHBhcmEgZW50ZW5kZXIKK2Rpc3RyaWJ1w61k
byBiw6FzaWNvIHBhcmEgc2V1cyBwcm9qZXRvcy4gTm8gZW50YW50bywgcGFyYSBlbnRlbmRlcgog
cGxlbmFtZW50ZSBhIHByb2Z1bmRpZGFkZSBlIG8gcG9kZXIgZG8gZ2l0IHZvY8OqIHByZWNpc2Eg
ZW50ZW5kZXIgZHVhcwogaWTDqWlhcyBzaW1wbGVzIG5hcyBxdWFpcyBlbGUgc2UgYmFzZWlhOgog
CiAgICogQSBiYXNlIGRlIG9iamV0b3Mgw6kgdW0gc2lzdGVtYSBiZW0gZWxlZ2FudGUgdXNhZG8g
cGFyYSBhcm1hemVuYXIgYQogICAgIGhpc3TDs3JpYSBkZSBzZXUgcHJvamV0by0tYXJxdWl2b3Ms
IGRpcmV0w7NyaW9zLCBlIGNvbW1pdHMuCiAKLSAgKiBPIGFycXVpdm8gZGUgw61uZGljYSDDqSB1
bSBjYWNoZSBkbyBlc3RhZG8gZGUgdW1hIMOhcnZvcmUgZGUgZGlyZXTDs3JpbywKKyAgKiBPIGFy
cXVpdm8gZGUgw61uZGljZSDDqSB1bSBjYWNoZSBkbyBlc3RhZG8gZGUgdW1hIMOhcnZvcmUgZGUg
ZGlyZXTDs3JpbywKICAgICB1c2FkbyBwYXJhIGNyaWFyIGNvbW1pdHMsIHJlc3RhdXJhciBkaXJl
dMOzcmlvcyBkZSB0cmFiYWxobywgZQotICAgIGNvbXByZWVuZGVyIGFzIHbDoXJpYXMgw6Fydm9y
ZXMgaW52b2x2aWRhcyBlbSB1bWEgdW5pZmljYcOnw6NvLgorICAgIGFybWF6ZW5hciBhcyB2w6Fy
aWFzIMOhcnZvcmVzIGVudm9sdmlkYXMgZW0gdW1hIHVuaWZpY2HDp8Ojby4KIAotUGFydGUgZG9p
cyBkZXN0ZSB0dXRvcmlhbCBleHBsaWNhIGEgYmFzZSBkZSBvYmpldG9zLCBvIGFycXVpdm8gZGUK
K0EgcGFydGUgZG9pcyBkZXN0ZSB0dXRvcmlhbCBleHBsaWNhIGEgYmFzZSBkZSBvYmpldG9zLCBv
IGFycXVpdm8gZGUKIMOtbmRpY2UsIGUgYWxndW1hcyBvdXRyYXMgY29pc2luaGFzIHF1ZSB2b2PD
qiB2YWkgcHJlY2lzYXIgcHJhIHVzYXIgbwogbcOheGltbyBkbyBnaXQuIFZvY8OqIHBvZGUgZW5j
b250csOhLWxhIGVtIGxpbmtnaXQ6Z2l0dHV0b3JpYWwtMls3XS4KIAotU2Ugdm9jw6ogbsOjbyBx
dWVyIGNvbnRpbnVhciBkbyBqZWl0byBjZXJ0bywgYWxndW1hcyBvdXRyYXMgZGlzZ3Jlc3PDtWVz
Ci1xdWUgcG9kZW0gc2VyIGludGVyZXNzYW50ZXMgbmVzdGUgcG9udG8gc8OjbzoKK1NlIHZvY8Oq
IG7Do28gcXVpc2VyIGNvbnRpbnVhciBjb20gbyB0dXRvcmlhbCBhZ29yYSBuZXNzZSBtb21lbnRv
LCBhbGd1bWFzCitvdXRyYXMgZGlncmVzc8O1ZXMgcXVlIHBvZGVtIHNlciBpbnRlcmVzc2FudGVz
IG5lc3RlIHBvbnRvIHPDo286CiAKICAgKiBsaW5rZ2l0OmdpdC1mb3JtYXQtcGF0Y2hbMV0sIGxp
bmtnaXQ6Z2l0LWFtWzFdOiBFc3RlcyBjb252ZXJ0ZW0KLSAgICBzw6lyaWVzIGRlIGNvbW1pdHMg
ZW0gcGF0Y2hlcyBlbSBlbWFpbCwgZSB2aWNlLXZlcnNhLCDDunRlaXMgcGFyYQotICAgIHByb2pl
dG9zIGNvbW8gbyBrZXJuZWwgbGludXggcXVlIGRlcGVuZGVtIHBlc2FkYW1lbnRlIGVtIHBhdGNo
ZXMKKyAgICBzw6lyaWVzIGRlIGNvbW1pdHMgZW0gcGF0Y2hlcyBwYXJhIGVtYWlsLCBlIHZpY2Ut
dmVyc2EsIMO6dGVpcyBwYXJhCisgICAgcHJvamV0b3MgY29tbyBvIGtlcm5lbCBMaW51eCBxdWUg
ZGVwZW5kZW0gZm9ydGVtZW50ZSBkZSBwYXRjaGVzCiAgICAgZW52aWFkb3MgcG9yIGVtYWlsLgog
CiAgICogbGlua2dpdDpnaXQtYmlzZWN0WzFdOiBRdWFuZG8gaMOhIHVtYSByZWdyZXNzw6NvIGVt
IHNldSBwcm9qZXRvLCB1bWEKICAgICBmb3JtYSBkZSByYXN0cmVhciB1bSBidWcgw6kgcHJvY3Vy
YW5kbyBwZWxhIGhpc3TDs3JpYSBwYXJhIGVuY29udHJhciBvCi0gICAgY29tbWl0IGN1bHBhZG8u
ICBHaXQgYmlzZWN0IHBvZGUgYWp1ZGFyIGEgZXhlY3V0YXIgdW1hIGJ1c2NhIGJpbsOhcmlhCi0g
ICAgcG9yIGVzc2UgY29tbWl0LiAgRWxlIMOpIGludGVsaWdlbnRlIG8gYmFzdGFudGUgcGFyYSBl
eGVjdXRhciB1bWEKKyAgICBjb21taXQgY3VscGFkby4gR2l0IGJpc2VjdCBwb2RlIGFqdWRhciBh
IGV4ZWN1dGFyIHVtYSBidXNjYSBiaW7DoXJpYQorICAgIHBvciBlc3NlIGNvbW1pdC4gRWxlIMOp
IGludGVsaWdlbnRlIG8gYmFzdGFudGUgcGFyYSBleGVjdXRhciB1bWEKICAgICBidXNjYSBwcsOz
eGltYSBkYSDDs3RpbWEgbWVzbW8gbm8gY2FzbyBkZSB1bWEgaGlzdMOzcmlhIGNvbXBsZXhhCiAg
ICAgbsOjby1saW5lYXIgY29tIG11aXRvcyByYW1vcyB1bmlmaWNhZG9zLgogCkBAIC02NjQsNyAr
NjYwLDcgQEAgcXVlIHBvZGVtIHNlciBpbnRlcmVzc2FudGVzIG5lc3RlIHBvbnRvIHPDo286CiAK
ICAgKiBsaW5rZ2l0OmdpdGN2cy1taWdyYXRpb25bN106IEdpdCBwYXJhIHVzdcOhcmlvcyBkZSBD
VlMuCiAKLVZlamEgVGFtYsOpbQorVkVKQSBUQU1Cw4lNCiAtLS0tLS0tLQogbGlua2dpdDpnaXR0
dXRvcmlhbC0yWzddLAogbGlua2dpdDpnaXRjdnMtbWlncmF0aW9uWzddLAotLSAKMS42LjQuMzg4
LmdjMTEyMAoK
--0016363b86de8ba14f0470038259--
