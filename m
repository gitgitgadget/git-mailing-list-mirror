From: =?ISO-8859-1?Q?Andr=E9_Goddard_Rosa?= <andre.goddard@gmail.com>
Subject: [PATCH] Fix typos on pt_BR/gittutorial.txt translation
Date: Thu, 30 Jul 2009 00:44:50 -0300
Message-ID: <b8bf37780907292044i5ad7b879ueb5048447e4e5bb5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016363b9302356b10046fe420d5
Cc: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>,
	Thadeu Lima de Souza Cascardo <cascardo@minaslivre.org>
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 30 05:45:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWMZj-0003He-S5
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 05:45:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754022AbZG3Dox (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 23:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753965AbZG3Dox
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 23:44:53 -0400
Received: from mail-vw0-f172.google.com ([209.85.212.172]:49327 "EHLO
	mail-vw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753629AbZG3Dov (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 23:44:51 -0400
X-Greylist: delayed 1116 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Jul 2009 23:44:50 EDT
Received: by vws2 with SMTP id 2so21438vws.4
        for <git@vger.kernel.org>; Wed, 29 Jul 2009 20:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type;
        bh=AqzJh7gW1Faz9AGpFshAFdwj3/NazIxwqZyOnI04Jsk=;
        b=Xbk0Ty/nCqUfk65Bnpxt+G8tqcE/00l/I+n1w95p+cKGptdv3O1KdqnK2bnaT6s2i6
         42yldohyl9du7oUXnlfPTdJiG5kPUGApcxPVanVXp9D0JOhhKuQSJW+oFtutZlg+WaXp
         1FHr7nd5TqwGuvnRqN48LaUMxY3Vjd8AV+Tws=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=IOF0cnInISnMCsrntYUsMDhmKfDeKpvRIX/kKvIJMJ6cQmqYLPOiP4fM/8nNYm0a/Q
         NcZhhWxr62Y6ixtoO8NEd1IC0VndER9TzMIIKncRZBQD27geSnTELb7INJ7NrlTrueip
         mZHsx3MOoYKoB2TO+cWb6xPuTQWgGGLlRpcc8=
Received: by 10.220.84.66 with SMTP id i2mr841089vcl.44.1248925490440; Wed, 29 
	Jul 2009 20:44:50 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124440>

--0016363b9302356b10046fe420d5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

>From c11206cad8af0a3fbd55e5bf3cd74d3da144d843 Mon Sep 17 00:00:00 2001
From: =3D?UTF-8?q?Andr=3DC3=3DA9=3D20Goddard=3D20Rosa?=3D <andre.goddard@gm=
ail.com>
Date: Thu, 30 Jul 2009 00:35:17 -0300
Subject: [PATCH] [PATCH] Fix typos on pt_BR/gittutorial.txt translation
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Andr=E9 Goddard Rosa <andre.goddard@gmail.com>
---
 Documentation/pt_BR/gittutorial.txt |  146 +++++++++++++++++--------------=
----
 1 files changed, 71 insertions(+), 75 deletions(-)

diff --git a/Documentation/pt_BR/gittutorial.txt
b/Documentation/pt_BR/gittutorial.txt
index f368b1b..531f310 100644
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
+Se as mudan=E7as n=E3o conflitam, est=E1 pronto. Se existirem conflitos,
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
+ser especificado de v=E0rias formas. Aqui est=E3o alguns exemplos com 'git=
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

-A maioria dos projetos com m=FAltiplos contribuidores (como o kernel
-linux, ou o git mesmo) tem unifica=E7=F5es frequentes, e 'gitk' faz um
-trabalho melhor de visualizar sua hist=F3ria.  Por exemplo,
+A maioria dos projetos com m=FAltiplos contribuidores (como o kernel do
+linux, ou o pr=F3prio git) tem unifica=E7=F5es frequentes, e 'gitk' faz um
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
+Se voc=EA n=E3o quer continuar com o tutorial agora nesse momento, algumas
+outras digress=F5es que podem ser interessantes neste ponto s=E3o:

   * linkgit:git-format-patch[1], linkgit:git-am[1]: Estes convertem
-    s=E9ries de commits em patches em email, e vice-versa, =FAteis para
-    projetos como o kernel linux que dependem pesadamente em patches
+    s=E9ries de commits em patches para email, e vice-versa, =FAteis para
+    projetos como o kernel do linux que dependem fortemente de patches
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
1.6.4.373.gc2651

--0016363b9302356b10046fe420d5
Content-Type: text/x-patch; charset=UTF-8; 
	name="0001-PATCH-Fix-typos-on-pt_BR-gittutorial.txt-translation.patch"
Content-Disposition: attachment; 
	filename="0001-PATCH-Fix-typos-on-pt_BR-gittutorial.txt-translation.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fxqxsigo0

RnJvbSBjMTEyMDZjYWQ4YWYwYTNmYmQ1NWU1YmYzY2Q3NGQzZGExNDRkODQzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/QW5kcj1DMz1BOT0yMEdvZGRhcmQ9MjBSb3Nh
Pz0gPGFuZHJlLmdvZGRhcmRAZ21haWwuY29tPgpEYXRlOiBUaHUsIDMwIEp1bCAyMDA5IDAwOjM1
OjE3IC0wMzAwClN1YmplY3Q6IFtQQVRDSF0gW1BBVENIXSBGaXggdHlwb3Mgb24gcHRfQlIvZ2l0
dHV0b3JpYWwudHh0IHRyYW5zbGF0aW9uCk1JTUUtVmVyc2lvbjogMS4wCkNvbnRlbnQtVHlwZTog
dGV4dC9wbGFpbjsgY2hhcnNldD1VVEYtOApDb250ZW50LVRyYW5zZmVyLUVuY29kaW5nOiA4Yml0
CgpTaWduZWQtb2ZmLWJ5OiBBbmRyw6kgR29kZGFyZCBSb3NhIDxhbmRyZS5nb2RkYXJkQGdtYWls
LmNvbT4KLS0tCiBEb2N1bWVudGF0aW9uL3B0X0JSL2dpdHR1dG9yaWFsLnR4dCB8ICAxNDYgKysr
KysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0KIDEgZmlsZXMgY2hhbmdlZCwgNzEgaW5z
ZXJ0aW9ucygrKSwgNzUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9w
dF9CUi9naXR0dXRvcmlhbC50eHQgYi9Eb2N1bWVudGF0aW9uL3B0X0JSL2dpdHR1dG9yaWFsLnR4
dAppbmRleCBmMzY4YjFiLi41MzFmMzEwIDEwMDY0NAotLS0gYS9Eb2N1bWVudGF0aW9uL3B0X0JS
L2dpdHR1dG9yaWFsLnR4dAorKysgYi9Eb2N1bWVudGF0aW9uL3B0X0JSL2dpdHR1dG9yaWFsLnR4
dApAQCAtMTYsNyArMTYsNyBAQCBFc3RlIHR1dG9yaWFsIGV4cGxpY2EgY29tbyBpbXBvcnRhciB1
bSBub3ZvIHByb2pldG8gcGFyYSBvIGdpdCwKIGFkaWNpb25hciBtdWRhbsOnYXMgYSBlbGUsIGUg
Y29tcGFydGlsaGFyIG11ZGFuw6dhcyBjb20gb3V0cm9zCiBkZXNlbnZvbHZlZG9yZXMuCiAKLUlm
LCBhbyBpbnbDqXMgZGlzc28sIHZvY8OqIGVzdMOhIGludGVyZXNzYWRvIHByaW1hcmlhbWVudGUg
ZW0gdXNhciBnaXQgcGFyYQorU2UsIGFvIGludsOpcyBkaXNzbywgdm9jw6ogZXN0w6EgaW50ZXJl
c3NhZG8gcHJpbWFyaWFtZW50ZSBlbSB1c2FyIGdpdCBwYXJhCiBvYnRlciB1bSBwcm9qZXRvLCBw
b3IgZXhlbXBsbywgcGFyYSB0ZXN0YXIgYSDDumx0aW1hIHZlcnPDo28sIHZvY8OqIHBvZGUKIHBy
ZWZlcmlyIGNvbWXDp2FyIGNvbSBvcyBwcmltZWlyb3MgZG9pcyBjYXDDrXR1bG9zIGRlCiBsaW5r
OnVzZXItbWFudWFsLmh0bWxbTyBNYW51YWwgZG8gVXN1w6FyaW8gR2l0XS4KQEAgLTM3LDkgKzM3
LDggQEAgJCBnaXQgaGVscCBsb2cKIENvbSBhIMO6bHRpbWEgZm9ybWEsIHZvY8OqIHBvZGUgdXNh
ciBvIHZpc3VhbGl6YWRvciBkZSBtYW51YWwgZGUgc3VhCiBlc2NvbGhhOyB2ZWphIGxpbmtnaXQ6
Z2l0LWhlbHBbMV0gcGFyYSBtYWlvciBpbmZvcm1hw6fDo28uCiAKLcOJIHVtYSBib2EgaWTDqWlh
IHNlIGludHJvZHV6aXIgYW8gZ2l0IGNvbSBzZXUgbm9tZSBlIGVuZGVyZcOnbyBww7pibGljbyBk
ZQotZW1haWwgYW50ZXMgZGUgZmF6ZXIgcXVhbHF1ZXIgb3BlcmHDp8Ojby4gQSBtYW5laXJhIG1h
aXMgZsOhY2lsIGRlIGZhesOqLWxvCi3DqToKK8OJIHVtYSBib2EgaWTDqWlhIGluZm9ybWFyIGFv
IGdpdCBzZXUgbm9tZSBlIGVuZGVyZcOnbyBww7pibGljbyBkZSBlbWFpbAorYW50ZXMgZGUgZmF6
ZXIgcXVhbHF1ZXIgb3BlcmHDp8Ojby4gQSBtYW5laXJhIG1haXMgZsOhY2lsIGRlIGZhesOqLWxv
IMOpOgogCiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0K
ICQgZ2l0IGNvbmZpZyAtLWdsb2JhbCB1c2VyLm5hbWUgIlNldSBOb21lIFZlbSBBcXVpIgpAQCAt
NTEsNyArNTAsNyBAQCBJbXBvcnRhbmRvIHVtIG5vdm8gcHJvamV0bwogLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0KIAogQXNzdW1hIHF1ZSB2b2PDqiB0ZW0gdW0gdGFyYmFsbCBwcm9qZWN0LnRhci5n
eiBjb20gc2V1IHRyYWJhbGhvIGluaWNpYWwuCi1Wb2PDqiBwb2RlIGNvbG9jw6EtbG8gc29iIGNv
bnRyb2xlIGRlIHJldmlzw6NvIGdpdCBjb21vIGEgc2VndWlyLgorVm9jw6ogcG9kZSBjb2xvY8Oh
LWxvIHNvYiBjb250cm9sZSBkZSByZXZpc8OjbyBnaXQgZGEgc2VndWludGUgZm9ybWE6CiAKIC0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogJCB0YXIgeHpm
IHByb2plY3QudGFyLmd6CkBAIC03Niw3ICs3NSw3IEBAICQgZ2l0IGFkZCAuCiAtLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIAogRXN0ZSBpbnN0YW50w6Ju
ZW8gZXN0w6EgYWdvcmEgYXJtYXplbmFkbyBlbSB1bWEgw6FyZWEgdGVtcG9yw6FyaWEgcXVlIG8g
Z2l0Ci1jaGFtYSBkZSAiaW5kZXgiIG91IMOtbmRpY2UuIFZvY8OqIHBvZGUgcGVybWFuZXRlbWVu
dGUgYXJtYXplbmFyIG8KK2NoYW1hIGRlICJpbmRleCIgb3Ugw61uZGljZS4gVm9jw6ogcG9kZSBh
cm1hemVuYXIgcGVybWFuZW50ZW1lbnRlIG8KIGNvbnRlw7pkbyBkbyDDrW5kaWNlIG5vIHJlcG9z
aXTDs3JpbyBjb20gJ2dpdC1jb21taXQnOgogCiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0KQEAgLTE0Miw3ICsxNDEsNyBAQCBub3ZvcyksIGFkaWNpb27D
oS1sb3MgYW8gw61uZGljZXMsIGUgZ3JhdmFyLCB0dWRvIGVtIHVtIMO6bmljbyBwYXNzby4KIFVt
YSBub3RhIGVtIG1lbnNhZ2VucyBkZSBjb21taXQ6IEFwZXNhciBkZSBuw6NvIHNlciBleGlnaWRv
LCDDqSB1bWEgYm9hCiBpZMOpaWEgY29tZcOnYXIgYSBtZW5zYWdlbSBjb20gdW1hIHNpbXBsZXMg
ZSBjdXJ0YSAobWVub3MgZGUgNTAKIGNhcmFjdGVyZXMpIGxpbmhhIHN1bWFyaXphbmRvIGEgbXVk
YW7Dp2EsIHNlZ3VpZGEgZGUgdW1hIGxpbmhhIGVtIGJyYW5jbwotZSwgZW50w6NvLCB1bWEgZGVz
Y3Jpw6fDo28gbWFpcyBkZXRhbGhhZGEuICBGZXJyYW1lbnRhcyBxdWUgdHJhbnNmb3JtYW0KK2Us
IGVudMOjbywgdW1hIGRlc2NyacOnw6NvIG1haXMgZGV0YWxoYWRhLiBGZXJyYW1lbnRhcyBxdWUg
dHJhbnNmb3JtYW0KIGNvbW1pdHMgZW0gZW1haWwsIHBvciBleGVtcGxvLCB1c2FtIGEgcHJpbWVp
cmEgbGluaGEgbm8gY2FtcG8gZGUKIGNhYmXDp2FsaG8gU3ViamVjdDogZSBvIHJlc3RvIG5vIGNv
cnBvLgogCkBAIC0xNTAsNyArMTQ5LDcgQEAgR2l0IHJhc3RyZWlhIGNvbnRlw7pkbywgbsOjbyBh
cnF1aXZvcwogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogCiBNdWl0b3Mgc2lzdGVtYXMg
ZGUgY29udHJvbGUgZGUgcmV2aXPDo28gcHJvdsOqZW0gdW0gY29tYW5kbyBgYWRkYCBxdWUgZGl6
Ci1hbyBzaXN0ZW1hIHBhcmEgY29tZcOnYXIgYSByYXN0cmVhciBtdWRhbsOnYXMgZW0gdW0gbm92
byBhcnF1aXZvLiAgTworYW8gc2lzdGVtYSBwYXJhIGNvbWXDp2FyIGEgcmFzdHJlYXIgbXVkYW7D
p2FzIGVtIHVtIG5vdm8gYXJxdWl2by4gTwogY29tYW5kbyBgYWRkYCBkbyBnaXQgZmF6IGFsZ28g
bWFpcyBzaW1wbGVzIGUgbWFpcyBwb2Rlcm9zbzogJ2dpdC1hZGQnIMOpCiB1c2FkbyB0YW50byBw
YXJhIGFycXVpdm9zIG5vdm9zIGUgYXJxdWl2b3MgcmVjZW50ZW1lbnRlIG1vZGlmaWNhZG9zLCBl
CiBlbSBhbWJvcyBvcyBjYXNvcywgZWxlIHRpcmEgbyBpbnN0YW50w6JuZW8gZG9zIGFycXVpdm9z
IGRhZG9zIGUgYXJtYXplbmEKQEAgLTE4Myw3ICsxODIsNyBAQCBHZXJlbmNpYW5kbyAiYnJhbmNo
ZXMiL3JhbW9zCiAtLS0tLS0tLS0tLS0tLS0tLQogCiBVbSBzaW1wbGVzIHJlcG9zaXTDs3JpbyBn
aXQgcG9kZSBtYW50ZXIgbcO6bHRpcGxvcyByYW1vcyBkZQotZGVzZW52b2x2aW1lbnRvLiAgUGFy
YSBjcmlhciB1bSBub3ZvIHJhbW8gY2hhbWFkbyAiZXhwZXJpbWVudGFsIiwgdXNlCitkZXNlbnZv
bHZpbWVudG8uIFBhcmEgY3JpYXIgdW0gbm92byByYW1vIGNoYW1hZG8gImV4cGVyaW1lbnRhbCIs
IHVzZQogCiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0K
ICQgZ2l0IGJyYW5jaCBleHBlcmltZW50YWwKQEAgLTIwMywxNCArMjAyLDE0IEBAIHZvY8OqIHZh
aSBvYnRlciB1bWEgbGlzdGEgZGUgdG9kb3Mgb3MgcmFtb3MgZXhpc3RlbnRlczoKIC0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogCiBPIHJhbW8gImV4cGVy
aW1lbnRhbCIgw6kgbyBxdWUgdm9jw6ogYWNhYmEgZGUgY3JpYXIsIGUgbyByYW1vICJtYXN0ZXIi
IMOpIG8KLXJhbW8gcGFkcsOjbyBxdWUgZm9pIGNyaWFkbyBwcmEgdm9jw6ogYXV0b21hdGljYW1l
bnRlLiAgTyBhc3RlcmlzY28gbWFyY2EKK3JhbW8gcGFkcsOjbyBxdWUgZm9pIGNyaWFkbyBwcmEg
dm9jw6ogYXV0b21hdGljYW1lbnRlLiBPIGFzdGVyaXNjbyBtYXJjYQogbyByYW1vIGVtIHF1ZSB2
b2PDqiBlc3TDoSBhdHVhbG1lbnRlOyBkaWdpdGUKIAogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiAkIGdpdCBjaGVja291dCBleHBlcmltZW50YWwKIC0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogCi1wYXJhIG11
ZGFyIHBhcmEgbyByYW1vIGV4cGVyaW1lbnRhbC4gIEFnb3JhIGVkaXRlIHVtIGFycXVpdm8sIGdy
YXZlIGEKK3BhcmEgbXVkYXIgcGFyYSBvIHJhbW8gZXhwZXJpbWVudGFsLiBBZ29yYSBlZGl0ZSB1
bSBhcnF1aXZvLCBncmF2ZSBhCiBtdWRhbsOnYSwgZSBtdWRlIGRlIHZvbHRhIHBhcmEgbyByYW1v
IG1hc3RlcjoKIAogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tCkBAIC0yMzAsMTQgKzIyOSwxNCBAQCAkIGdpdCBjb21taXQgLWEKIC0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogCiBuZXN0ZSBwb250bywgb3MgZG9p
cyByYW1vcyBkaXZlcmdpcmFtLCBjb20gZGlmZXJlbnRlcyBtdWRhbsOnYXMgZmVpdGFzIGVtCi1j
YWRhIHVtLiAgUGFyYSB1bmlmaWNhciBhcyBtdWRhbsOnYXMgZmVpdGFzIG5vIGV4cGVyaW1lbnRh
bCBwYXJhIG8KK2NhZGEgdW0uIFBhcmEgdW5pZmljYXIgYXMgbXVkYW7Dp2FzIGZlaXRhcyBubyBl
eHBlcmltZW50YWwgcGFyYSBvCiBtYXN0ZXIsIGV4ZWN1dGUKIAogLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiAkIGdpdCBtZXJnZSBleHBlcmltZW50YWwK
IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogCi1TZSBh
cyBtdWRhbsOnYXMgbsOjbyBjb25mbGl0YW0sIGVzdMOhIHByb250by4gIFNlIGV4aXN0aXJlbSBj
b25mbGl0b3MsCitTZSBhcyBtdWRhbsOnYXMgbsOjbyBjb25mbGl0YW0sIGVzdMOhIHByb250by4g
U2UgZXhpc3RpcmVtIGNvbmZsaXRvcywKIG1hcmNhZG9yZXMgc2Vyw6NvIGRlaXhhZG9zIG5vcyBh
cnF1aXZvcyBwcm9ibGVtw6F0aWNvcyBleGliaW5kbyBvCiBjb25mbGl0bzsKIApAQCAtMjQ1LDcg
KzI0NCw3IEBAIGNvbmZsaXRvOwogJCBnaXQgZGlmZgogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiAKLXZhaSBleGliaXIgaXN0by4gIEFww7NzIHZvY8Oq
IGVkaXRhciBvcyBhcnF1aXZvcyBwYXJhIHJlc29sdmVyIG9zCit2YWkgZXhpYmlyIGlzdG8uIEFw
w7NzIHZvY8OqIGVkaXRhciBvcyBhcnF1aXZvcyBwYXJhIHJlc29sdmVyIG9zCiBjb25mbGl0b3Ms
CiAKIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpAQCAt
MjczLDEwICsyNzIsMTAgQEAgU2Ugdm9jw6ogZGVzZW52b2x2ZSBlbSB1bSByYW1vIGlkZWlhLWxv
dWNhLCBlIHNlIGFycmVwZW5kZSwgdm9jw6ogcG9kZQogc2VtcHJlIHJlbW92ZXIgbyByYW1vIGNv
bQogCiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCi0kIGdpdCBicmFuY2gg
LUQgY3JhenktaWRlYQorJCBnaXQgYnJhbmNoIC1EIGlkZWlhLWxvdWNhCiAtLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiAKLVJhbW9zIHPDo28gYmFyYXRvcyBlIGbDoWNlaXMs
IGVudMOjbyBpc3RvIMOpIHVtYSBib2EgbWFuZWlyYSBkZSBleHBlcmltZW50YXIKK1JhbW9zIHPD
o28gZWZpY2llbnRlcyBlIGbDoWNlaXMsIGVudMOjbyBpc3RvIMOpIHVtYSBib2EgbWFuZWlyYSBk
ZSBleHBlcmltZW50YXIKIGFsZ3VtYSBjb2lzYS4KIAogVXNhbmRvIGdpdCBwYXJhIGNvbGFib3Jh
w6fDo28KQEAgLTI5Myw3ICsyOTIsNyBAQCBib2IkIGdpdCBjbG9uZSAvaG9tZS9hbGljZS9wcm9q
ZWN0IG15cmVwbwogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tCiAKIElzc28gY3JpYSB1bSBub3ZvIGRpcmV0w7NyaW8gIm15cmVwbyIgY29udGVuZG8gdW0g
Y2xvbmUgZG8gcmVwb3NpdMOzcmlvIGRlCi1BbGljZS4gIE8gY2xvbmUgZXN0w6Egbm8gbWVzbW8g
cMOpIHF1ZSBvIHByb2pldG8gb3JpZ2luYWwsIHBvc3N1aW5kbyBzdWEKK0FsaWNlLiBPIGNsb25l
IGVzdMOhIG5vIG1lc21vIHDDqSBxdWUgbyBwcm9qZXRvIG9yaWdpbmFsLCBwb3NzdWluZG8gc3Vh
CiBwcsOzcHJpYSBjw7NwaWEgZGEgaGlzdMOzcmlhIGRvIHByb2pldG8gb3JpZ2luYWwuCiAKIEJv
YiBlbnTDo28gZmF6IGFsZ3VtYXMgbXVkYW7Dp2FzIGUgYXMgZ3JhdmE6CkBAIC0zMDUsNyArMzA0
LDcgQEAgYm9iJCBnaXQgY29tbWl0IC1hCiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0KIAogUXVhbnRvIGVzdMOhIHByb250bywgZWxlIGRpeiBhIEFsaWNl
IHBhcmEgcHV4YXIgYXMgbXVkYW7Dp2FzIGRvCi1yZXBvc2l0w7NyaW8gZW0gL2hvbWUvYm9iL215
cmVwby4gIEVsYSBvIGZheiBjb206CityZXBvc2l0w7NyaW8gZW0gL2hvbWUvYm9iL215cmVwby4g
RWxhIG8gZmF6IGNvbToKIAogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tCiBhbGljZSQgY2QgL2hvbWUvYWxpY2UvcHJvamVjdApAQCAtMzE0LDE0ICszMTMs
MTQgQEAgYWxpY2UkIGdpdCBwdWxsIC9ob21lL2JvYi9teXJlcG8gbWFzdGVyCiAKIElzdG8gdW5p
ZmljYSBhcyBtdWRhbsOnYXMgZG8gcmFtbyAibWFzdGVyIiBkbyBCb2IgYW8gcmFtbyBhdHVhbCBk
ZSBBbGljZS4KIFNlIEFsaWNlIGZleiBzdWFzIHByw7NwcmlhcyBtdWRhbsOnYXMgbm8gaW50ZXJ2
YWxvLCBlbGEsIGVudMOjbywgcG9kZQotcHJlY2lzYXIgY29ycmlnaXIgbWFudWFsbWVudGUgcXVh
aXF1ZXIgY29uZmxpdG9zLiAgKE5vdGUgcXVlIG8gYXJndW1lbnRvCitwcmVjaXNhciBjb3JyaWdp
ciBtYW51YWxtZW50ZSBxdWFpc3F1ZXIgY29uZmxpdG9zLiAoTm90ZSBxdWUgbyBhcmd1bWVudG8K
ICJtYXN0ZXIiIG5vIGNvbWFuZG8gYWNpbWEgw6ksIGRlIGZhdG8sIGRlc25lY2Vzc8OhcmlvLCBq
w6EgcXVlIMOpIG8gcGFkcsOjby4pCiAKIE8gY29tYW5kbyAicHVsbCIgZXhlY3V0YSwgZW50w6Nv
LCBkdWFzIG9wZXJhw6fDtWVzOiBlbGUgb2J0w6ltIG11ZGFuw6dhcyBkZQogdW0gcmFtbyByZW1v
dG8sIGUsIGVudMOjbywgYXMgdW5pZmljYSBubyByYW1vIGF0dWFsLgogCiBOb3RlIHF1ZSwgZW0g
Z2VyYWwsIEFsaWNlIGdvc3RhcmlhIHF1ZSBzdWFzIG11ZGFuw6dhcyBsb2NhaXMgZm9zc2VtCi1n
cmF2YWRhcyBhbnRlcyBkZSBpbmljaWFyIGVzdGUgInB1bGwiLiAgU2UgbyB0cmFiYWxobyBkZSBC
b2JvIGNvbmZsaXRhCitncmF2YWRhcyBhbnRlcyBkZSBpbmljaWFyIGVzdGUgInB1bGwiLiBTZSBv
IHRyYWJhbGhvIGRlIEJvYiBjb25mbGl0YQogY29tIG8gcXVlIEFsaWNlIGZleiBkZXNkZSBxdWUg
c3VhcyBoaXN0w7NyaWFzIHNlIHJhbWlmaWNhcmFtLCBBbGljZSBpcsOhCiB1c2FyIHNldSBkaXJl
dMOzcmlvIGRlIHRyYWJhbGhvIGUgbyDDrW5kaWNlIHBhcmEgcmVzb2x2ZXIgY29uZmxpdG9zLCBl
CiBtdWRhbsOnYXMgbG9jYWlzIGV4aXN0ZW50ZXMgaXLDo28gaW50ZXJmZXJpciBjb20gbyBwcm9j
ZXNzbyBkZSByZXNvbHXDp8OjbwpAQCAtMzQxLDE4ICszNDAsMTggQEAgYWxpY2UkIGdpdCBsb2cg
LXAgSEVBRC4uRkVUQ0hfSEVBRAogCiBFc3RhIG9wZXJhw6fDo28gw6kgc2VndXJhIG1lc21vIHNl
IEFsaWNlIHRlbSBtdWRhbsOnYXMgbG9jYWlzIG7Do28gZ3JhdmFkYXMuCiBBIG5vdGHDp8OjbyBk
ZSBpbnRlcnZhbG8gIkhFQUQuLkZFVENIX0hFQUQiIHNpZ25pZmljYSBtb3N0cmFyIHR1ZG8gcXVl
IMOpCi1hbGNhbsOnw6F2ZWwgZGUgRkVUQ0hfSEVBRCBtYXMgZXhjbHVhIHR1ZG8gcXVlIMOpIGFs
Y2Fuw6fDoXZlbCBkZSBIRUFELiBBbGNpZQotasOhIHNhYmUgdHVkbyBxdWUgbGV2YSBhIHNldSBl
c3RhZG8gYXR1YWwgKEhFQUQpLCBlIHJldmlzYSBvIHF1ZSBCb2IgdGVtCi1lbSBzZXUgZXN0YWRv
IChGRVRDSF9IRUFEKSBxdWUgZWxhIGFpbmRhIG7Do28gdml1IGNvbSBlc3NlIGNvbWFuZG8uCith
bGNhbsOnw6F2ZWwgZGUgRkVUQ0hfSEVBRCBtYXMgZXhjbHVhIHR1ZG8gbyBxdWUgw6kgYWxjYW7D
p8OhdmVsIGRlIEhFQUQuCitBbGljZSBqw6Egc2FiZSB0dWRvIHF1ZSBsZXZhIGEgc2V1IGVzdGFk
byBhdHVhbCAoSEVBRCksIGUgcmV2aXNhIG8gcXVlIEJvYgordGVtIGVtIHNldSBlc3RhZG8gKEZF
VENIX0hFQUQpIHF1ZSBlbGEgYWluZGEgbsOjbyB2aXUgY29tIGVzc2UgY29tYW5kby4KIAotU2Ug
QWxpY2UgcXVlciB2aXN1YWxpemFyIG8gcXVlIEJvYiBmZXogZGVzZGUgcXVlIHN1YXMgaGlzdMOz
cmlhCitTZSBBbGljZSBxdWVyIHZpc3VhbGl6YXIgbyBxdWUgQm9iIGZleiBkZXNkZSBxdWUgc3Vh
cyBoaXN0w7NyaWFzIHNlCiByYW1pZmljYXJhbSwgZWxhIHBvZGUgZGlzcGFyYXIgbyBzZWd1aW50
ZSBjb21hbmRvOgogCiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0KICQgZ2l0ayBIRUFELi5GRVRDSF9IRUFECiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIAotSXN0byB1c2FyIGEgbWVzbWEgbm90YcOnw6NvIGRl
IGludGVydmFsZG8gcXVlIHZpbW9zIGFudGVzIGNvbSAnZ2l0IGxvZycuCitJc3RvIHVzYSBhIG1l
c21hIG5vdGHDp8OjbyBkZSBpbnRlcnZhbG8gcXVlIHZpbW9zIGFudGVzIGNvbSAnZ2l0IGxvZycu
CiAKIEFsaWNlIHBvZGUgcXVlcmVyIHZlciBvIHF1ZSBhbWJvcyBmaXplcmFtIGRlc2RlIHF1ZSBy
YW1pZmljYXJhbS4gRWxhCiBwb2RlIHVzYXIgYSBmb3JtYSBjb20gdHLDqnMgcG9udG9zIGFvIGlu
dsOpcyBkYSBmb3JtYSBjb20gZG9pcyBwb250b3M6CkBAIC0zNjEsMjMgKzM2MCwyMSBAQCBwb2Rl
IHVzYXIgYSBmb3JtYSBjb20gdHLDqnMgcG9udG9zIGFvIGludsOpcyBkYSBmb3JtYSBjb20gZG9p
cyBwb250b3M6CiAkIGdpdGsgSEVBRC4uLkZFVENIX0hFQUQKIC0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogCi1Jc3RvIHNpZ25pZmljYSAibW9zdHJlIHR1
ZG8gcXVlIMOpIGFsY2Fuw6dhdmVsIGRlIHF1YWxxdWVyIHVtLCBtYXMgZXhjbHVhCi10dWRvIHF1
ZSDDqSBhbGNhbsOnYXZlbCBhIHBhcnRpciBkZSBhbWJvcyIuCi1UaGlzIG1lYW5zICJzaG93IGV2
ZXJ5dGhpbmcgdGhhdCBpcyByZWFjaGFibGUgZnJvbSBlaXRoZXIgb25lLCBidXQKLWV4Y2x1ZGUg
YW55dGhpbmcgdGhhdCBpcyByZWFjaGFibGUgZnJvbSBib3RoIG9mIHRoZW0iLgorSXN0byBzaWdu
aWZpY2EgIm1vc3RyZSB0dWRvIHF1ZSDDqSBhbGNhbsOnw6F2ZWwgZGUgcXVhbHF1ZXIgdW0gZGVs
ZXMsIG1hcworZXhjbHVhIHR1ZG8gcXVlIMOpIGFsY2Fuw6fDoXZlbCBhIHBhcnRpciBkZSBhbWJv
cyIuCiAKIFBvciBmYXZvciwgbm90ZSBxdWUgZXNzYXMgbm90YcOnw7VlcyBkZSBpbnRlcnZhbG8g
cG9kZW0gc2VyIHVzYWRhcyB0YW50bwogY29tIGdpdGsgcXVhbnRvIGNvbSAiZ2l0IGxvZyIuCiAK
LUFwb8OzcyBpbnNwZWNpb25hciBvIHF1ZSBCb2IgZmV6LCBzZSBuw6NvIGjDoSBuYWRhIHVyZ2Vu
dGUsIEFsaWNlIHBvZGUKLWRlY2lkaXIgY29udGludWFyIHRyYWJhbGhhbmRvIHNlbSBwdXhhciBk
ZSBCb2IuICBTZSBhIGhpc3TDs3JpYSBkZSBCb2IKK0Fww7NzIGluc3BlY2lvbmFyIG8gcXVlIEJv
YiBmZXosIHNlIG7Do28gaMOhIG5hZGEgdXJnZW50ZSwgQWxpY2UgcG9kZQorZGVjaWRpciBjb250
aW51YXIgdHJhYmFsaGFuZG8gc2VtIHB1eGFyIGRlIEJvYi4gU2UgYSBoaXN0w7NyaWEgZGUgQm9i
CiB0ZW0gYWxndW1hIGNvaXNhIHF1ZSBBbGljZSBwcmVjaXNhIGltZWRpYXRhbWVudGUsIEFsaWNl
IHBvZGUgb3B0YXIgcG9yCiBzZXBhcmFyIHNldSB0cmFiYWxobyBlbSBwcm9ncmVzc28gcHJpbWVp
cm8sIGZhemVyIHVtICJwdWxsIiwgZSwgZW50w6NvLAogZmluYWxtZW50ZSwgcmV0b21hciBzZXUg
dHJhYmFsaG8gZW0gcHJvZ3Jlc3NvIGVtIGNpbWEgZGEgaGlzdMOzcmlhCiByZXN1bHRhbnRlLgog
Ci1RdWFudG8gdm9jw6ogZXN0w6EgdHJhYmFsaGFuZG8gZW0gdW0gcGVxdWVubyBncnVwbyB1bmlk
bywgbsOjbyDDqSBpbmNvbXVtCi1pbnRlcmFnaXIgY29tIG8gbWVzbW8gcmVwb3NpdMOzcmlvIHbD
oXJpYXMgZSB2w6FyaWFzIHZlemVzLiAgRGVmaW5pbmRvIHVtCitRdWFuZG8gdm9jw6ogZXN0w6Eg
dHJhYmFsaGFuZG8gZW0gdW0gcGVxdWVubyBncnVwbyB1bmlkbywgbsOjbyDDqSBpbmNvbXVtCitp
bnRlcmFnaXIgY29tIG8gbWVzbW8gcmVwb3NpdMOzcmlvIHbDoXJpYXMgZSB2w6FyaWFzIHZlemVz
LiBEZWZpbmluZG8gdW0KIHJlcG9zaXTDs3JpbyByZW1vdG8gYW50ZXMgZGUgdHVkbywgdm9jw6og
cG9kZSBmYXrDqi1sbyBtYWlzIGZhY2lsbWVudGU6CiAKIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpAQCAtMzk0LDcgKzM5MSw3IEBAIGFsaWNlJCBnaXQg
ZmV0Y2ggYm9iCiAKIERpZmVyZW50ZSBkYSBmb3JtYSBsb25nYSwgcXVhbmRvIEFsaWNlIG9idGV2
ZSBkZSBCb2IgdXNhbmRvIHVtCiByZXBvc2l0w7NyaW8gcmVtb3RvIGFudGVzIGRlZmluaWRvIGNv
bSAnZ2l0LXJlbW90ZScsIG8gcXVlIGZvaSBvYnRpZG8gw6kKLWFybWF6ZW5hZG8gdW0gcmFtbyBy
ZW1vdG8sIG5lc3RlIGNhc28gYGJvYi9tYXN0ZXJgLiAgRW50w6NvLCBhcMOzcyBpc3NvOgorYXJt
YXplbmFkbyBlbSB1bSByYW1vIHJlbW90bywgbmVzdGUgY2FzbyBgYm9iL21hc3RlcmAuIEVudMOj
bywgYXDDs3MgaXNzbzoKIAogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQog
YWxpY2UkIGdpdCBsb2cgLXAgbWFzdGVyLi5ib2IvbWFzdGVyCkBAIC00MTcsNyArNDE0LDcgQEAg
YWxpY2UkIGdpdCBwdWxsIC4gcmVtb3Rlcy9ib2IvbWFzdGVyCiAtLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tCiAKIE5vdGUgcXVlICdnaXQgcHVsbCcgc2VtcHJlIHVuaWZpY2Eg
YW8gcmFtbyBhdHVhbCwgaW5kZXBlbmRlbnRlIGRvIHF1ZQotbWFpcyBmb2kgZGFkbyBuYSBsaW5o
YSBkZSBjb21hbmRvLgorbWFpcyBmb2kgcGFzc2FkbyBuYSBsaW5oYSBkZSBjb21hbmRvLgogCiBE
ZXBvaXMsIEJvYiBwb2RlIGF0dWFsaXphciBzZXUgcmVwb3NpdMOzcmlvIGNvbSBhcyDDumx0aW1h
cyBtdWRhbsOnYXMgZGUKIEFsaWNlLCB1c2FuZG8KQEAgLTQyOCw3ICs0MjUsNyBAQCBib2IkIGdp
dCBwdWxsCiAKIE5vdGUgcXVlIGVsZSBuw6NvIHByZWNpc2EgZGFyIG8gY2FtaW5obyBkbyByZXBv
c2l0w7NyaW8gZGUgQWxpY2U7IHF1YW5kbwogQm9iIGNsb25vdSBzZXUgcmVwb3NpdMOzcmlvLCBv
IGdpdCBhcm1hemVub3UgYSBsb2NhbGl6YcOnw6NvIGRlIHNldQotcmVwb3NpdMOzcmlvIG5hIGNv
bmZpZ3VyYcOnw6NvIGRvIHJlcG9zaXTDs3JpbywgZSBlc3NhIGxvY2FsaXphw6fDo28gw6kgdXNh
ZGEKK3JlcG9zaXTDs3JpbyBuYSBjb25maWd1cmHDp8OjbyBkbyBtZXNtbywgZSBlc3NhIGxvY2Fs
aXphw6fDo28gw6kgdXNhZGEKIHBhcmEgcHV4YXI6CiAKIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0KQEAgLTQ1OSwxNSArNDU2LDE1IEBAIEFsdGVybmF0aXZhbWVudGUsIG8g
Z2l0IHRlbSB1bSBwcm90b2NvbG8gbmF0aXZvLCBvdSBwb2RlIHVzYXIgcnN5bmMgb3UKIGh0dHA7
IHZlamEgbGlua2dpdDpnaXQtcHVsbFsxXSBwYXJhIGRldGFsaGVzLgogCiBHaXQgcG9kZSB0YW1i
w6ltIHNlciB1c2FkbyBlbSB1bSBtb2RvIHBhcmVjaWRvIGNvbSBDVlMsIGNvbSB1bQotcmVwb3Np
dMOzcmlvIGNlbnRyYWwgcGFyYSBvIHF1YWwgcXVlIHbDoXJpb3MgdXN1w6FyaW9zIGVtcHVycmFt
Ci1tb2RpZmljYcOnw7VlczsgdmVqYSBsaW5rZ2l0OmdpdC1wdXNoWzFdIGUgbGlua2dpdDpnaXRj
dnMtbWlncmF0aW9uWzddLgorcmVwb3NpdMOzcmlvIGNlbnRyYWwgcGFyYSBvIHF1YWwgdsOhcmlv
cyB1c3XDoXJpb3MgZW1wdXJyYW0gbW9kaWZpY2HDp8O1ZXM7Cit2ZWphIGxpbmtnaXQ6Z2l0LXB1
c2hbMV0gZSBsaW5rZ2l0OmdpdGN2cy1taWdyYXRpb25bN10uCiAKIEV4cGxvcmFuZG8gaGlzdMOz
cmlhCiAtLS0tLS0tLS0tLS0tLS0tLQogCiBBIGhpc3TDs3JpYSBubyBnaXQgw6kgcmVwcmVzZW50
YWRhIGNvbW8gdW1hIHPDqXJpZSBkZSBjb21taXRzCi1pbnRlcnJlbGFjaW9uYWRvcy4gIE7Ds3Mg
asOhIHZpbW9zIHF1ZSBvIGNvbWFuZG8gJ2dpdC1sb2cnIHBvZGUgbGlzdGFyCi1lc3NlcyBjb21t
aXRzLiBOb3RlIHF1ZSBhIHByaW1laXJhIGxpbmhhIGRlIGNhbWEgZW50cmFkYSBubyBsb2cgdGFt
YsOpbQoraW50ZXJyZWxhY2lvbmFkb3MuIE7Ds3MgasOhIHZpbW9zIHF1ZSBvIGNvbWFuZG8gJ2dp
dC1sb2cnIHBvZGUgbGlzdGFyCitlc3NlcyBjb21taXRzLiBOb3RlIHF1ZSBhIHByaW1laXJhIGxp
bmhhIGRlIGNhZGEgZW50cmFkYSBubyBsb2cgdGFtYsOpbQogZMOhIG8gbm9tZSBwYXJhIG8gY29t
bWl0OgogCiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkBAIC00ODYsOSAr
NDgzLDkgQEAgY29tbWl0LgogJCBnaXQgc2hvdyBjODJhMjJjMzljYmMzMjU3NmY2NGY1YzZiM2Yy
NGI5OWVhODE0OWM3CiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiAKLU1h
cyBow6Egb3V0cmFzIGZvcm1hcyBkZSBzZSByZWZlcmlyIGEgY29tbWl0cy4gIFZvY8OqIHBvZGUg
dXNhciBxdWFscXVlcgotcGFydGUgaW5pY2lhbCBkbyBub21lIHF1ZSBzZWphIGxvbmdvIG8gYmFz
dGFudGUgcGFyYSB1bmljYW1lbnRlCi1pZGVudGlmaWNhciBvIGNvbW1pdDoKK01hcyBow6Egb3V0
cmFzIGZvcm1hcyBkZSBzZSByZWZlcmlyIGFvcyBjb21taXRzLiBWb2PDqiBwb2RlIHVzYXIgcXVh
bHF1ZXIKK3BhcnRlIGluaWNpYWwgZG8gbm9tZSBxdWUgc2VqYSBsb25nbyBvIGJhc3RhbnRlIHBh
cmEgaWRlbnRpZmljYXIKK3VuaWNhbWVudGUgbyBjb21taXQ6CiAKIC0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0KICQgZ2l0IHNob3cgYzgyYTIyYzM5YwkjIG9zIHByaW1laXJv
cyBjYXJhY3RlcmVzIGRvIG5vbWUgc8OjbyBvIGJhc3RhbnRlCkBAIC00OTcsNyArNDk0LDcgQEAg
JCBnaXQgc2hvdyBIRUFECQkjIGEgcG9udGEgZG8gcmFtbyBhdHVhbAogJCBnaXQgc2hvdyBleHBl
cmltZW50YWwJIyBhIHBvbnRhIGRvIHJhbW8gImV4cGVyaW1lbnRhbCIKIC0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIAotVG9kbyBjb21taXQgdXN1YWxtZW50ZSB0ZW0gdW0g
Y29tbWl0ICJwYWkiIHF1ZSBhcG9udGEgcGFyYSBvIGVzdGFkbworVG9kbyBjb21taXQgbm9ybWFs
bWVudGUgdGVtIHVtIGNvbW1pdCAicGFpIiBxdWUgYXBvbnRhIHBhcmEgbyBlc3RhZG8KIGFudGVy
aW9yIGRvIHByb2pldG86CiAKIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0K
QEAgLTUxMywxOSArNTEwLDE5IEBAICQgZ2l0IHNob3cgSEVBRF4xICMgbW9zdHJhIG8gcHJpbWVp
cm8gcGFpIGRlIEhFQUQgKG8gbWVzbW8gcXVlIEhFQUReKQogJCBnaXQgc2hvdyBIRUFEXjIgIyBt
b3N0cmEgbyBzZWd1bmRvIHBhaSBkZSBIRUFECiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tCiAKLVZvY8OqIHRhbWLDqW0gcG9kZSBkYXIgYW9zIGNvbW1pdHMgbm9tZXMgc2V1
czsgYXDDs3MgZXhlY3V0YXIKK1ZvY8OqIHRhbWLDqW0gcG9kZSBkYXIgYW9zIGNvbW1pdHMgbm9t
ZXMgw6Agc3VhIGVzY29saGE7IGFww7NzIGV4ZWN1dGFyCiAKIC0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0KICQgZ2l0IHRhZyB2Mi41IDFiMmUxZDYzZmYKIC0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIAotdm9jw6ogcG9kZSBzZSByZWZlcmlyIGEgMWIy
ZTFkNjNmZiBwZWxvIG5vbWUgInYyLjUiLiAgU2Ugdm9jw6ogcHJldGVuZGUKK3ZvY8OqIHBvZGUg
c2UgcmVmZXJpciBhIDFiMmUxZDYzZmYgcGVsbyBub21lICJ2Mi41Ii4gU2Ugdm9jw6ogcHJldGVu
ZGUKIGNvbXBhcnRpbGhhciBlc3NlIG5vbWUgY29tIG91dHJhcyBwZXNzb2FzIChwb3IgZXhlbXBs
bywgcGFyYSBpZGVudGlmaWNhcgotdW1hIHZlcnPDo28gZGUgbGFuw6dhbWVudG8pLCB2b2PDqiBk
ZXZlIGNyaWFyIHVtIG9iamV0byAidGFnIiwgZSB0YWx2ZXoKK3VtYSB2ZXJzw6NvIGRlIGxhbsOn
YW1lbnRvKSwgdm9jw6ogZGV2ZXJpYSBjcmlhciB1bSBvYmpldG8gInRhZyIsIGUgdGFsdmV6CiBh
c3NpbsOhLWxvOyB2ZWphIGxpbmtnaXQ6Z2l0LXRhZ1sxXSBwYXJhIGRldGFsaGVzLgogCiBRdWFs
cXVlciBjb21hbmRvIGdpdCBxdWUgcHJlY2lzZSBjb25oZWNlciB1bSBjb21taXQgcG9kZSByZWNl
YmVyCi1xdWFpc3F1ZXIgZGVzc2VzIG5vbWVzLiAgUG9yIGV4ZW1wbG86CitxdWFpc3F1ZXIgZGVz
c2VzIG5vbWVzLiBQb3IgZXhlbXBsbzoKIAogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQogJCBnaXQgZGlmZiB2Mi41IEhFQUQJICMgY29tcGFyYSBvIEhFQUQgYXR1YWwgY29t
IHYyLjUKQEAgLTUzNyw4ICs1MzQsOCBAQCAkIGdpdCByZXNldCAtLWhhcmQgSEVBRF4gIyByZXNl
dGEgc2V1IHJhbW8gYXR1YWwgZSBzZXUgZGlyZXTDs3JpbyBkZQogCiBTZWphIGN1aWRhZG9zbyBj
b20gbyDDumx0aW1vIGNvbWFuZG86IGFsw6ltIGRlIHBlcmRlciBxdWFpc3F1ZXIgbXVkYW7Dp2Fz
CiBlbSBzZXUgZGlyZXTDs3JpbyBkZSB0cmFiYWxobywgZWxlIHRhbWLDqW0gcmVtb3ZlIHRvZG9z
IG9zIGNvbW1pdHMKLXBvc3RlcmlvcmVzIGRlc3NlIHJhbW8uICBTZSBlc3NlIHJhbW8gw6kgbyDD
um5pY28gcmFtbyBjb250ZW5kbyBlc3NlcwotY29tbWl0cywgZWxlcyBzZXLDo28gcGVyZGlkb3Mu
ICBUYW1iw6ltLCBuw6NvIHVzZSAnZ2l0LXJlc2V0JyBudW0gcmFtbworcG9zdGVyaW9yZXMgZGVz
c2UgcmFtby4gU2UgZXNzZSByYW1vIMOpIG8gw7puaWNvIHJhbW8gY29udGVuZG8gZXNzZXMKK2Nv
bW1pdHMsIGVsZXMgc2Vyw6NvIHBlcmRpZG9zLiBUYW1iw6ltLCBuw6NvIHVzZSAnZ2l0LXJlc2V0
JyBudW0gcmFtbwogcHVibGljYW1lbnRlIHZpc8OtdmVsIGRlIG9uZGUgb3V0cm9zIGRlc2Vudm9s
dmVkb3JlcyBwdXhhbSwgasOhIHF1ZSB2YWkKIGZvcsOnYXIgdW5pZmljYcOnw7VlcyBkZXNuZWNl
c3PDoXJpYXMgcGFyYSBxdWUgb3V0cm9zIGRlc2Vudm9sdmVkb3JlcyBsaW1wZW0KIGEgaGlzdMOz
cmlhLiBTZSB2b2PDqiBwcmVjaXNhIGRlc2ZhemVyIG11ZGFuw6dhcyBxdWUgdm9jw6ogZW1wdXJy
b3UsIHVzZQpAQCAtNTUxLDEwICs1NDgsMTAgQEAgcHJvamV0bywgZW50w6NvCiAkIGdpdCBncmVw
ICJoZWxsbyIgdjIuNQogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogCi1w
cm9jdXJhIHBvciB0b2RhcyBhcyBvY29ycmXDqm5jaWFzIGRlICJoZWxsbyIgZW0gdjIuNS4KK3By
b2N1cmEgcG9yIHRvZGFzIGFzIG9jb3Jyw6puY2lhcyBkZSAiaGVsbG8iIGVtIHYyLjUuCiAKIFNl
IHZvY8OqIGRlaXhhciBkZSBmb3JhIG8gbm9tZSBkbyBjb21taXQsICdnaXQtZ3JlcCcgaXLDoSBw
cm9jdXJhcgotcXVhaXNxdWVyIGRvcyBhcnF1aXZvcyBxdWUgZWxlIGdlcmVuY2lhIG5vIGRpcmV0
w7NyaW8gY29ycmVudGUuICBFbnTDo28KK3F1YWlzcXVlciBkb3MgYXJxdWl2b3MgcXVlIGVsZSBn
ZXJlbmNpYSBubyBkaXJldMOzcmlvIGNvcnJlbnRlLiBFbnTDo28KIAogLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogJCBnaXQgZ3JlcCAiaGVsbG8iCkBAIC01NjQsOCArNTYx
LDcgQEAgJCBnaXQgZ3JlcCAiaGVsbG8iCiBnaXQuCiAKIE11aXRvcyBjb21hbmRvcyBnaXQgdGFt
YsOpbSByZWNlYmVtIHVtIGNvbmp1bnRvIGRlIGNvbW1pdHMsIG8gcXVlIHBvZGUKLXNlciBlc3Bl
Y2lmaWNhZG8gZGUgdW0gYm9tIG7Dum1lcm8gZGUgZm9ybWFzLiAgQXF1aSBlc3TDo28gYWxndW5z
IGV4ZW1wbG9zCi1jb20gJ2dpdC1sb2cnOgorc2VyIGVzcGVjaWZpY2FkbyBkZSB2w6ByaWFzIGZv
cm1hcy4gQXF1aSBlc3TDo28gYWxndW5zIGV4ZW1wbG9zIGNvbSAnZ2l0LWxvZyc6CiAKIC0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KICQgZ2l0IGxvZyB2Mi41Li52Mi42ICAg
ICAgICAgICAgIyBjb21taXRzIGVudHJlIHYyLjUgZSB2Mi42CkBAIC01ODQsNyArNTgwLDcgQEAg
Y29tdW0gYWxndW0gdGVtcG8gYXRyw6FzLCBlbnTDo28KICQgZ2l0IGxvZyBzdGFibGUuLm1hc3Rl
cgogLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogCi1pcsOhIGxpc3RhcyBv
cyBjb21taXRzIGZlaXRvcyBubyByYW1vICJtYXN0ZXIiIG1hcyBuw6NvIG5vIHJhbW8KK2lyw6Eg
bGlzdGFyIG9zIGNvbW1pdHMgZmVpdG9zIG5vIHJhbW8gIm1hc3RlciIgbWFzIG7Do28gbm8gcmFt
bwogInN0YWJsZSIsIGVucXVhbnRvCiAKIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0KQEAgLTU5NCwyNiArNTkwLDI2IEBAICQgZ2l0IGxvZyBtYXN0ZXIuLnN0YWJsZQogaXLD
oSBsaXN0YXIgYSBsaXN0YSBkZSBjb21taXRzIGZlaXRvcyBubyByYW1vICJzdGFibGUiIG1hcyBu
w6NvIG5vIHJhbW8KICJtYXN0ZXIiLgogCi1PIGNvbWFuZG8gJ2dpdC1sb2cnIHRlbSB1bWEgZnJh
cXV6YTogZWxlIHByZWNpc2EgbW9zdHJhciBvcyBjb21taXRzIGVtCitPIGNvbWFuZG8gJ2dpdC1s
b2cnIHRlbSB1bWEgZnJhcXVlemE6IGVsZSBwcmVjaXNhIG1vc3RyYXIgb3MgY29tbWl0cyBlbQog
dW1hIGxpc3RhLiBRdWFuZG8gYSBoaXN0w7NyaWEgdGVtIGxpbmhhcyBkZSBkZXNlbnZvbHZpbWVu
dG8gcXVlCiBkaXZlcmdpcmFtIGUgZW50w6NvIGZvcmFtIHVuaWZpY2FkYXMgbm92YW1lbnRlLCBh
IG9yZGVtIGVtIHF1ZSAnZ2l0LWxvZycKLWFwcmVzZW50YSBlc3NhcyBtdWRhbsOnYXMgw6kgaW5z
aWduaWZpY2FudGUuCithcHJlc2VudGEgZXNzYXMgbXVkYW7Dp2FzIMOpIGlycmVsZXZhbnRlLgog
Ci1BIG1haW9yaWEgZG9zIHByb2pldG9zIGNvbSBtw7psdGlwbG9zIGNvbnRyaWJ1aWRvcmVzIChj
b21vIG8ga2VybmVsCi1saW51eCwgb3UgbyBnaXQgbWVzbW8pIHRlbSB1bmlmaWNhw6fDtWVzIGZy
ZXF1ZW50ZXMsIGUgJ2dpdGsnIGZheiB1bQotdHJhYmFsaG8gbWVsaG9yIGRlIHZpc3VhbGl6YXIg
c3VhIGhpc3TDs3JpYS4gIFBvciBleGVtcGxvLAorQSBtYWlvcmlhIGRvcyBwcm9qZXRvcyBjb20g
bcO6bHRpcGxvcyBjb250cmlidWlkb3JlcyAoY29tbyBvIGtlcm5lbCBkbworbGludXgsIG91IG8g
cHLDs3ByaW8gZ2l0KSB0ZW0gdW5pZmljYcOnw7VlcyBmcmVxdWVudGVzLCBlICdnaXRrJyBmYXog
dW0KK3RyYWJhbGhvIG1lbGhvciBkZSB2aXN1YWxpemFyIHN1YSBoaXN0w7NyaWEuIFBvciBleGVt
cGxvLAogCiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiAkIGdpdGsgLS1z
aW5jZT0iMiB3ZWVrcyBhZ28iIGRyaXZlcnMvCiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tCiAKLXBlcm1pdGUgdm9jw6ogbmF2ZWdhciBlbSBxdWFpc3F1ZXIgY29tbWl0cyBk
ZXNkZSBhcyDDumx0aW1hcyBkdWFzIHNlbWFuYXMKLWRlIGNvbW1pdHMgcXVlIG1vZGlmaWNhcmFt
IGFycXVpdm9zIHNvYiBvIGRpcmV0w7NyaW8gImRyaXZlcnMiLiAgKE5vdGE6CitwZXJtaXRlIGEg
dm9jw6ogbmF2ZWdhciBlbSBxdWFpc3F1ZXIgY29tbWl0cyBkZXNkZSBhcyDDumx0aW1hcyBkdWFz
IHNlbWFuYXMKK2RlIGNvbW1pdHMgcXVlIG1vZGlmaWNhcmFtIGFycXVpdm9zIHNvYiBvIGRpcmV0
w7NyaW8gImRyaXZlcnMiLiAoTm90YToKIHZvY8OqIHBvZGUgYWp1c3RhciBhcyBmb250ZXMgZG8g
Z2l0ayBzZWd1cmFuZG8gYSB0ZWNsYSBjb250cm9sIGVucXVhbnRvCiBwcmVzc2lvbmEgIi0iIG91
ICIrIi4pCiAKLUZpbmFsbWVudGUsIGEgbWFpb3JpYSBkb3MgY29tYW5kb3MgcXVlIHJlY2ViZW0g
bm9tZXMgZGUgYXJxdWl2bwotdGUgcGVybWl0aXLDo28gb3BjaW9uYWxtZW50ZSBwcmVjZWRlciBx
dWFscXVlciBub21lIGRlIGFycXVpdm8gcG9yIHVtCitGaW5hbG1lbnRlLCBhIG1haW9yaWEgZG9z
IGNvbWFuZG9zIHF1ZSByZWNlYmVtIG5vbWVzIGRlIGFycXVpdm8gcGVybWl0aXLDo28KK3RhbWLD
qW0sIG9wY2lvbmFsbWVudGUsIHByZWNlZGVyIHF1YWxxdWVyIG5vbWUgZGUgYXJxdWl2byBwb3Ig
dW0KIGNvbW1pdCwgcGFyYSBlc3BlY2lmaWNhciB1bWEgdmVyc8OjbyBwYXJ0aWN1bGFyIGRvIGFy
cXVpdm86CiAKIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KQEAgLTYzMCwz
MyArNjI2LDMzIEBAIFByw7N4aW1vcyBwYXNzb3MKIC0tLS0tLS0tLS0KIAogRXN0ZSB0dXRvcmlh
bCBkZXZlIHNlciBvIGJhc3RhbnRlIHBhcmEgb3BlcmFyIGNvbnRyb2xlIGRlIHJldmlzw6NvCi1k
aXN0cmlidcOtZG8gYsOhc2ljbyBwYXJhIHNldXMgcHJvamV0b3MuICBObyBlbnRhbnRvLCBwYXJh
IGVudGVuZGVyCitkaXN0cmlidcOtZG8gYsOhc2ljbyBwYXJhIHNldXMgcHJvamV0b3MuIE5vIGVu
dGFudG8sIHBhcmEgZW50ZW5kZXIKIHBsZW5hbWVudGUgYSBwcm9mdW5kaWRhZGUgZSBvIHBvZGVy
IGRvIGdpdCB2b2PDqiBwcmVjaXNhIGVudGVuZGVyIGR1YXMKIGlkw6lpYXMgc2ltcGxlcyBuYXMg
cXVhaXMgZWxlIHNlIGJhc2VpYToKIAogICAqIEEgYmFzZSBkZSBvYmpldG9zIMOpIHVtIHNpc3Rl
bWEgYmVtIGVsZWdhbnRlIHVzYWRvIHBhcmEgYXJtYXplbmFyIGEKICAgICBoaXN0w7NyaWEgZGUg
c2V1IHByb2pldG8tLWFycXVpdm9zLCBkaXJldMOzcmlvcywgZSBjb21taXRzLgogCi0gICogTyBh
cnF1aXZvIGRlIMOtbmRpY2Egw6kgdW0gY2FjaGUgZG8gZXN0YWRvIGRlIHVtYSDDoXJ2b3JlIGRl
IGRpcmV0w7NyaW8sCisgICogTyBhcnF1aXZvIGRlIMOtbmRpY2Ugw6kgdW0gY2FjaGUgZG8gZXN0
YWRvIGRlIHVtYSDDoXJ2b3JlIGRlIGRpcmV0w7NyaW8sCiAgICAgdXNhZG8gcGFyYSBjcmlhciBj
b21taXRzLCByZXN0YXVyYXIgZGlyZXTDs3Jpb3MgZGUgdHJhYmFsaG8sIGUKLSAgICBjb21wcmVl
bmRlciBhcyB2w6FyaWFzIMOhcnZvcmVzIGludm9sdmlkYXMgZW0gdW1hIHVuaWZpY2HDp8Ojby4K
KyAgICBhcm1hemVuYXIgYXMgdsOhcmlhcyDDoXJ2b3JlcyBlbnZvbHZpZGFzIGVtIHVtYSB1bmlm
aWNhw6fDo28uCiAKLVBhcnRlIGRvaXMgZGVzdGUgdHV0b3JpYWwgZXhwbGljYSBhIGJhc2UgZGUg
b2JqZXRvcywgbyBhcnF1aXZvIGRlCitBIHBhcnRlIGRvaXMgZGVzdGUgdHV0b3JpYWwgZXhwbGlj
YSBhIGJhc2UgZGUgb2JqZXRvcywgbyBhcnF1aXZvIGRlCiDDrW5kaWNlLCBlIGFsZ3VtYXMgb3V0
cmFzIGNvaXNpbmhhcyBxdWUgdm9jw6ogdmFpIHByZWNpc2FyIHByYSB1c2FyIG8KIG3DoXhpbW8g
ZG8gZ2l0LiBWb2PDqiBwb2RlIGVuY29udHLDoS1sYSBlbSBsaW5rZ2l0OmdpdHR1dG9yaWFsLTJb
N10uCiAKLVNlIHZvY8OqIG7Do28gcXVlciBjb250aW51YXIgZG8gamVpdG8gY2VydG8sIGFsZ3Vt
YXMgb3V0cmFzIGRpc2dyZXNzw7VlcwotcXVlIHBvZGVtIHNlciBpbnRlcmVzc2FudGVzIG5lc3Rl
IHBvbnRvIHPDo286CitTZSB2b2PDqiBuw6NvIHF1ZXIgY29udGludWFyIGNvbSBvIHR1dG9yaWFs
IGFnb3JhIG5lc3NlIG1vbWVudG8sIGFsZ3VtYXMKK291dHJhcyBkaWdyZXNzw7VlcyBxdWUgcG9k
ZW0gc2VyIGludGVyZXNzYW50ZXMgbmVzdGUgcG9udG8gc8OjbzoKIAogICAqIGxpbmtnaXQ6Z2l0
LWZvcm1hdC1wYXRjaFsxXSwgbGlua2dpdDpnaXQtYW1bMV06IEVzdGVzIGNvbnZlcnRlbQotICAg
IHPDqXJpZXMgZGUgY29tbWl0cyBlbSBwYXRjaGVzIGVtIGVtYWlsLCBlIHZpY2UtdmVyc2EsIMO6
dGVpcyBwYXJhCi0gICAgcHJvamV0b3MgY29tbyBvIGtlcm5lbCBsaW51eCBxdWUgZGVwZW5kZW0g
cGVzYWRhbWVudGUgZW0gcGF0Y2hlcworICAgIHPDqXJpZXMgZGUgY29tbWl0cyBlbSBwYXRjaGVz
IHBhcmEgZW1haWwsIGUgdmljZS12ZXJzYSwgw7p0ZWlzIHBhcmEKKyAgICBwcm9qZXRvcyBjb21v
IG8ga2VybmVsIGRvIGxpbnV4IHF1ZSBkZXBlbmRlbSBmb3J0ZW1lbnRlIGRlIHBhdGNoZXMKICAg
ICBlbnZpYWRvcyBwb3IgZW1haWwuCiAKICAgKiBsaW5rZ2l0OmdpdC1iaXNlY3RbMV06IFF1YW5k
byBow6EgdW1hIHJlZ3Jlc3PDo28gZW0gc2V1IHByb2pldG8sIHVtYQogICAgIGZvcm1hIGRlIHJh
c3RyZWFyIHVtIGJ1ZyDDqSBwcm9jdXJhbmRvIHBlbGEgaGlzdMOzcmlhIHBhcmEgZW5jb250cmFy
IG8KLSAgICBjb21taXQgY3VscGFkby4gIEdpdCBiaXNlY3QgcG9kZSBhanVkYXIgYSBleGVjdXRh
ciB1bWEgYnVzY2EgYmluw6FyaWEKLSAgICBwb3IgZXNzZSBjb21taXQuICBFbGUgw6kgaW50ZWxp
Z2VudGUgbyBiYXN0YW50ZSBwYXJhIGV4ZWN1dGFyIHVtYQorICAgIGNvbW1pdCBjdWxwYWRvLiBH
aXQgYmlzZWN0IHBvZGUgYWp1ZGFyIGEgZXhlY3V0YXIgdW1hIGJ1c2NhIGJpbsOhcmlhCisgICAg
cG9yIGVzc2UgY29tbWl0LiBFbGUgw6kgaW50ZWxpZ2VudGUgbyBiYXN0YW50ZSBwYXJhIGV4ZWN1
dGFyIHVtYQogICAgIGJ1c2NhIHByw7N4aW1hIGRhIMOzdGltYSBtZXNtbyBubyBjYXNvIGRlIHVt
YSBoaXN0w7NyaWEgY29tcGxleGEKICAgICBuw6NvLWxpbmVhciBjb20gbXVpdG9zIHJhbW9zIHVu
aWZpY2Fkb3MuCiAKQEAgLTY2NCw3ICs2NjAsNyBAQCBxdWUgcG9kZW0gc2VyIGludGVyZXNzYW50
ZXMgbmVzdGUgcG9udG8gc8OjbzoKIAogICAqIGxpbmtnaXQ6Z2l0Y3ZzLW1pZ3JhdGlvbls3XTog
R2l0IHBhcmEgdXN1w6FyaW9zIGRlIENWUy4KIAotVmVqYSBUYW1iw6ltCitWZWphIHRhbWLDqW0K
IC0tLS0tLS0tCiBsaW5rZ2l0OmdpdHR1dG9yaWFsLTJbN10sCiBsaW5rZ2l0OmdpdGN2cy1taWdy
YXRpb25bN10sCi0tIAoxLjYuNC4zNzMuZ2MyNjUxCgo=
--0016363b9302356b10046fe420d5--
