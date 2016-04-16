From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH] gitk: Add Portuguese translation
Date: Sat, 16 Apr 2016 19:29:59 +0000
Message-ID: <1460834999-13544-1-git-send-email-vascomalmeida@sapo.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 21:30:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arVvC-00059S-Sf
	for gcvg-git-2@plane.gmane.org; Sat, 16 Apr 2016 21:30:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751840AbcDPTaR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 16 Apr 2016 15:30:17 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:41352 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751671AbcDPTaO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2016 15:30:14 -0400
Received: (qmail 21265 invoked from network); 16 Apr 2016 19:30:12 -0000
Received: (qmail 9347 invoked from network); 16 Apr 2016 19:30:12 -0000
Received: from unknown (HELO linux-iv58.site) (vascomalmeida@sapo.pt@[147.203.126.100])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth02 (qmail-ptmail-1.0.0) with ESMTPSA
          for <git@vger.kernel.org>; 16 Apr 2016 19:30:09 -0000
X-PTMail-RemoteIP: 147.203.126.100
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291733>

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 po/pt.po | 1377 ++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 1 file changed, 1377 insertions(+)
 create mode 100644 po/pt.po

diff --git a/po/pt.po b/po/pt.po
new file mode 100644
index 0000000..596aded
--- /dev/null
+++ b/po/pt.po
@@ -0,0 +1,1377 @@
+# Portuguese translations for gitk package.
+# Copyright (C) 2016 Paul Mackerras
+# This file is distributed under the same license as the gitk package.
+# Vasco Almeida <vascomalmeida@sapo.pt>, 2016.
+#
+msgid ""
+msgstr ""
+"Project-Id-Version: gitk\n"
+"Report-Msgid-Bugs-To: \n"
+"POT-Creation-Date: 2016-04-15 16:52+0000\n"
+"PO-Revision-Date: 2016-04-16 18:20+0000\n"
+"Last-Translator: Vasco Almeida <vascomalmeida@sapo.pt>\n"
+"Language-Team: Portuguese <>\n"
+"Language: pt\n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=3DUTF-8\n"
+"Content-Transfer-Encoding: 8bit\n"
+"Plural-Forms: nplurals=3D2; plural=3D(n !=3D 1);\n"
+"X-Generator: Gtranslator 2.91.6\n"
+
+#: gitk:140
+msgid "Couldn't get list of unmerged files:"
+msgstr "N=C3=A3o foi poss=C3=ADvel obter lista de ficheiros n=C3=A3o i=
ntegrados:"
+
+#: gitk:212 gitk:2399
+msgid "Color words"
+msgstr "Colorir palavras"
+
+#: gitk:217 gitk:2399 gitk:8239 gitk:8272
+msgid "Markup words"
+msgstr "Marcar palavras"
+
+#: gitk:324
+msgid "Error parsing revisions:"
+msgstr "Erro ao analisar revis=C3=B5es:"
+
+#: gitk:380
+msgid "Error executing --argscmd command:"
+msgstr "Erro ao executar o comando de --argscmd:"
+
+#: gitk:393
+msgid "No files selected: --merge specified but no files are unmerged.=
"
+msgstr ""
+"Nenhum ficheiro selecionado: --merge especificado mas n=C3=A3o h=C3=A1=
 ficheiros por "
+"integrar."
+
+#: gitk:396
+msgid ""
+"No files selected: --merge specified but no unmerged files are within=
 file "
+"limit."
+msgstr ""
+"Nenhum ficheiro selecionado: --merge especificado mas n=C3=A3o h=C3=A1=
 ficheiros por "
+"integrar ao n=C3=ADvel de ficheiro."
+
+#: gitk:418 gitk:566
+msgid "Error executing git log:"
+msgstr "Erro ao executar git log:"
+
+#: gitk:436 gitk:582
+msgid "Reading"
+msgstr "A ler"
+
+#: gitk:496 gitk:4544
+msgid "Reading commits..."
+msgstr "A ler commits..."
+
+#: gitk:499 gitk:1637 gitk:4547
+msgid "No commits selected"
+msgstr "Nenhum commit selecionado"
+
+#: gitk:1445 gitk:4064 gitk:12469
+msgid "Command line"
+msgstr "Linha de comandos"
+
+#: gitk:1511
+msgid "Can't parse git log output:"
+msgstr "N=C3=A3o =C3=A9 poss=C3=ADvel analisar a sa=C3=ADda de git log=
:"
+
+#: gitk:1740
+msgid "No commit information available"
+msgstr "N=C3=A3o h=C3=A1 informa=C3=A7=C3=A3o dispon=C3=ADvel sobre o =
commit"
+
+#: gitk:1903 gitk:1932 gitk:4334 gitk:9702 gitk:11274 gitk:11554
+msgid "OK"
+msgstr "OK"
+
+#: gitk:1934 gitk:4336 gitk:9215 gitk:9294 gitk:9424 gitk:9473 gitk:97=
04
+#: gitk:11275 gitk:11555
+msgid "Cancel"
+msgstr "Cancelar"
+
+#: gitk:2083
+msgid "&Update"
+msgstr "At&ualizar"
+
+#: gitk:2084
+msgid "&Reload"
+msgstr "&Recarregar"
+
+#: gitk:2085
+msgid "Reread re&ferences"
+msgstr "Reler re&fer=C3=AAncias"
+
+#: gitk:2086
+msgid "&List references"
+msgstr "&Listar refer=C3=AAncias"
+
+#: gitk:2088
+msgid "Start git &gui"
+msgstr "Iniciar git &gui"
+
+#: gitk:2090
+msgid "&Quit"
+msgstr "Sair"
+
+#: gitk:2082
+msgid "&File"
+msgstr "&Ficheiro"
+
+#: gitk:2094
+msgid "&Preferences"
+msgstr "&Prefer=C3=AAncias"
+
+#: gitk:2093
+msgid "&Edit"
+msgstr "&Editar"
+
+#: gitk:2098
+msgid "&New view..."
+msgstr "&Nova vista..."
+
+#: gitk:2099
+msgid "&Edit view..."
+msgstr "&Editar vista..."
+
+#: gitk:2100
+msgid "&Delete view"
+msgstr "Eliminar vista"
+
+#: gitk:2102
+msgid "&All files"
+msgstr "Todos os ficheiros"
+
+#: gitk:2097
+msgid "&View"
+msgstr "&Ver"
+
+#: gitk:2107 gitk:2117
+msgid "&About gitk"
+msgstr "Sobre o gitk"
+
+#: gitk:2108 gitk:2122
+msgid "&Key bindings"
+msgstr "Atalhos"
+
+#: gitk:2106 gitk:2121
+msgid "&Help"
+msgstr "Ajuda"
+
+#: gitk:2199 gitk:8671
+msgid "SHA1 ID:"
+msgstr "ID SHA1:"
+
+#: gitk:2243
+msgid "Row"
+msgstr "Linha"
+
+#: gitk:2281
+msgid "Find"
+msgstr "Procurar"
+
+#: gitk:2309
+msgid "commit"
+msgstr "commit"
+
+#: gitk:2313 gitk:2315 gitk:4706 gitk:4729 gitk:4753 gitk:6774 gitk:68=
46
+#: gitk:6931
+msgid "containing:"
+msgstr "contendo:"
+
+#: gitk:2316 gitk:3545 gitk:3550 gitk:4782
+msgid "touching paths:"
+msgstr "altera os caminhos:"
+
+#: gitk:2317 gitk:4796
+msgid "adding/removing string:"
+msgstr "adiciona/remove a cadeia:"
+
+#: gitk:2318 gitk:4798
+msgid "changing lines matching:"
+msgstr "altera linhas com:"
+
+#: gitk:2327 gitk:2329 gitk:4785
+msgid "Exact"
+msgstr "Exato"
+
+#: gitk:2329 gitk:4873 gitk:6742
+msgid "IgnCase"
+msgstr "IgnMai=C3=BAsculas"
+
+#: gitk:2329 gitk:4755 gitk:4871 gitk:6738
+msgid "Regexp"
+msgstr "Regexp"
+
+#: gitk:2331 gitk:2332 gitk:4893 gitk:4923 gitk:4930 gitk:6867 gitk:69=
35
+msgid "All fields"
+msgstr "Todos os campos"
+
+#: gitk:2332 gitk:4890 gitk:4923 gitk:6805
+msgid "Headline"
+msgstr "Cabe=C3=A7alho"
+
+#: gitk:2333 gitk:4890 gitk:6805 gitk:6935 gitk:7408
+msgid "Comments"
+msgstr "Coment=C3=A1rios"
+
+#: gitk:2333 gitk:4890 gitk:4895 gitk:4930 gitk:6805 gitk:7343 gitk:88=
49
+#: gitk:8864
+msgid "Author"
+msgstr "Autor"
+
+#: gitk:2333 gitk:4890 gitk:6805 gitk:7345
+msgid "Committer"
+msgstr "Committer"
+
+#: gitk:2367
+msgid "Search"
+msgstr "Pesquisar"
+
+#: gitk:2375
+msgid "Diff"
+msgstr "Diff"
+
+#: gitk:2377
+msgid "Old version"
+msgstr "Vers=C3=A3o antiga"
+
+#: gitk:2379
+msgid "New version"
+msgstr "Vers=C3=A3o nova"
+
+#: gitk:2382
+msgid "Lines of context"
+msgstr "Linha de contexto"
+
+#: gitk:2392
+msgid "Ignore space change"
+msgstr "Ignorar espa=C3=A7os"
+
+#: gitk:2396 gitk:2398 gitk:7978 gitk:8225
+msgid "Line diff"
+msgstr "Diff de linha"
+
+#: gitk:2463
+msgid "Patch"
+msgstr "Patch"
+
+#: gitk:2465
+msgid "Tree"
+msgstr "=C3=81rvore"
+
+#: gitk:2635 gitk:2656
+msgid "Diff this -> selected"
+msgstr "Diff este -> sele=C3=A7=C3=A3o"
+
+#: gitk:2636 gitk:2657
+msgid "Diff selected -> this"
+msgstr "Diff sele=C3=A7=C3=A3o -> este"
+
+#: gitk:2637 gitk:2658
+msgid "Make patch"
+msgstr "Gerar patch"
+
+#: gitk:2638 gitk:9273
+msgid "Create tag"
+msgstr "Criar tag"
+
+#: gitk:2639
+msgid "Copy commit summary"
+msgstr "Copiar sum=C3=A1rio do commit"
+
+#: gitk:2640 gitk:9404
+msgid "Write commit to file"
+msgstr "Escrever commit num ficheiro"
+
+#: gitk:2641 gitk:9461
+msgid "Create new branch"
+msgstr "Criar novo ramo"
+
+#: gitk:2642
+msgid "Cherry-pick this commit"
+msgstr "Efetuar cherry-pick deste commit"
+
+#: gitk:2643
+msgid "Reset HEAD branch to here"
+msgstr "Repor ramo HEAD para aqui"
+
+#: gitk:2644
+msgid "Mark this commit"
+msgstr "Marcar este commit"
+
+#: gitk:2645
+msgid "Return to mark"
+msgstr "Voltar =C3=A0 marca"
+
+#: gitk:2646
+msgid "Find descendant of this and mark"
+msgstr "Encontrar descendeste deste e da marca"
+
+#: gitk:2647
+msgid "Compare with marked commit"
+msgstr "Comparar com o commit marcado"
+
+#: gitk:2648 gitk:2659
+msgid "Diff this -> marked commit"
+msgstr "Diff este -> commit marcado"
+
+#: gitk:2649 gitk:2660
+msgid "Diff marked commit -> this"
+msgstr "Diff commit marcado -> este"
+
+#: gitk:2650
+msgid "Revert this commit"
+msgstr "Reverter este commit"
+
+#: gitk:2666
+msgid "Check out this branch"
+msgstr "Extrair este ramo"
+
+#: gitk:2667
+msgid "Remove this branch"
+msgstr "Remover este ramo"
+
+#: gitk:2668
+msgid "Copy branch name"
+msgstr "Copiar nome do ramo"
+
+#: gitk:2675
+msgid "Highlight this too"
+msgstr "Real=C3=A7ar este tamb=C3=A9m"
+
+#: gitk:2676
+msgid "Highlight this only"
+msgstr "Real=C3=A7ar apenas este"
+
+#: gitk:2677
+msgid "External diff"
+msgstr "Diff externo"
+
+#: gitk:2678
+msgid "Blame parent commit"
+msgstr "Culpar commit pai"
+
+#: gitk:2679
+msgid "Copy path"
+msgstr "Copiar caminho"
+
+#: gitk:2686
+msgid "Show origin of this line"
+msgstr "Mostrar origem deste ficheiro"
+
+#: gitk:2687
+msgid "Run git gui blame on this line"
+msgstr "Executar git gui blame sobre esta linha"
+
+#: gitk:3031
+msgid "About gitk"
+msgstr "Sobre o gitk"
+
+#: gitk:3033
+msgid ""
+"\n"
+"Gitk - a commit viewer for git\n"
+"\n"
+"Copyright =C2=A9 2005-2014 Paul Mackerras\n"
+"\n"
+"Use and redistribute under the terms of the GNU General Public Licens=
e"
+msgstr ""
+"\n"
+"Gitk - um visualizador de commits do git\n"
+"\n"
+"Copyright =C2=A9 2005-2014 Paul Mackerras\n"
+"\n"
+"Use e redistribua sob os termos da GNU General Public License"
+
+#: gitk:3041 gitk:3108 gitk:9890
+msgid "Close"
+msgstr "Fechar"
+
+#: gitk:3062
+msgid "Gitk key bindings"
+msgstr "Atalhos do gitk"
+
+#: gitk:3065
+msgid "Gitk key bindings:"
+msgstr "Atalhos do gitk:"
+
+#: gitk:3067
+#, tcl-format
+msgid "<%s-Q>\t\tQuit"
+msgstr "<%s-Q>\t\tSair"
+
+#: gitk:3068
+#, tcl-format
+msgid "<%s-W>\t\tClose window"
+msgstr "<%s-W>\t\tFechar janela"
+
+#: gitk:3069
+msgid "<Home>\t\tMove to first commit"
+msgstr "<Home>\t\tMover para o primeiro commit"
+
+#: gitk:3070
+msgid "<End>\t\tMove to last commit"
+msgstr "<End>\t\tMover para o =C3=BAltimo commit"
+
+#: gitk:3071
+msgid "<Up>, p, k\tMove up one commit"
+msgstr "<Cima>, p, k\tMover para o commit acima"
+
+#: gitk:3072
+msgid "<Down>, n, j\tMove down one commit"
+msgstr "<Baixo>, n, j\tMover para o commit abaixo"
+
+#: gitk:3073
+msgid "<Left>, z, h\tGo back in history list"
+msgstr "<Esquerda>, z, h\tRecuar no hist=C3=B3rico"
+
+#: gitk:3074
+msgid "<Right>, x, l\tGo forward in history list"
+msgstr "<Direita>, x, l\tAvan=C3=A7ar no hist=C3=B3rico"
+
+#: gitk:3075
+#, tcl-format
+msgid "<%s-n>\tGo to n-th parent of current commit in history list"
+msgstr "<%s-n>\tIr para o n-=C3=A9simo pai do commit atual no hist=C3=B3=
rico"
+
+#: gitk:3076
+msgid "<PageUp>\tMove up one page in commit list"
+msgstr "<PageUp>\tMover a lista de commits uma p=C3=A1gina para cima"
+
+#: gitk:3077
+msgid "<PageDown>\tMove down one page in commit list"
+msgstr "<PageDown>\tMover a lista de commits uma p=C3=A1gina para baix=
o"
+
+#: gitk:3078
+#, tcl-format
+msgid "<%s-Home>\tScroll to top of commit list"
+msgstr "<%s-Home>\tDeslocar para o topo da lista"
+
+#: gitk:3079
+#, tcl-format
+msgid "<%s-End>\tScroll to bottom of commit list"
+msgstr "<%s-End>\tDeslocar para o fim da lista"
+
+#: gitk:3080
+#, tcl-format
+msgid "<%s-Up>\tScroll commit list up one line"
+msgstr "<%s-Up>\tDeslocar a lista de commits uma linha para cima"
+
+#: gitk:3081
+#, tcl-format
+msgid "<%s-Down>\tScroll commit list down one line"
+msgstr "<%s-Down>\tDescolar a lista de commits uma linha para baixo"
+
+#: gitk:3082
+#, tcl-format
+msgid "<%s-PageUp>\tScroll commit list up one page"
+msgstr "<%s-PageUp>\tDeslocar a lista de commits uma p=C3=A1gina para =
cima"
+
+#: gitk:3083
+#, tcl-format
+msgid "<%s-PageDown>\tScroll commit list down one page"
+msgstr "<%s-PageDown>\tDeslocar a lista de commits uma p=C3=A1gina par=
a baixo"
+
+#: gitk:3084
+msgid "<Shift-Up>\tFind backwards (upwards, later commits)"
+msgstr "<Shift-Up>\tProcurar para tr=C3=A1s (para cima, commits poster=
iores)"
+
+#: gitk:3085
+msgid "<Shift-Down>\tFind forwards (downwards, earlier commits)"
+msgstr "<Shift-Down>\tProcurar para a frente (para baixo, commits ante=
riores)"
+
+#: gitk:3086
+msgid "<Delete>, b\tScroll diff view up one page"
+msgstr "<Delete>, b\tDeslocar vista diff uma p=C3=A1gina para cima"
+
+#: gitk:3087
+msgid "<Backspace>\tScroll diff view up one page"
+msgstr "<Backspace>\tDeslocar vista diff uma p=C3=A1gina para cima"
+
+#: gitk:3088
+msgid "<Space>\t\tScroll diff view down one page"
+msgstr "<Space>\t\tDeslocar vista diff uma p=C3=A1gina para baixo"
+
+#: gitk:3089
+msgid "u\t\tScroll diff view up 18 lines"
+msgstr "u\t\tDeslocar vista diff 18 linhas para cima"
+
+#: gitk:3090
+msgid "d\t\tScroll diff view down 18 lines"
+msgstr "d\t\tDeslocar vista diff 18 linhas para baixo"
+
+#: gitk:3091
+#, tcl-format
+msgid "<%s-F>\t\tFind"
+msgstr "<%s-F>\t\tProcurar"
+
+#: gitk:3092
+#, tcl-format
+msgid "<%s-G>\t\tMove to next find hit"
+msgstr "<%s-G>\t\tMover para a ocorr=C3=AAncia seguinte"
+
+#: gitk:3093
+msgid "<Return>\tMove to next find hit"
+msgstr "<Return>\tMover para a ocorr=C3=AAncia seguinte"
+
+#: gitk:3094
+msgid "g\t\tGo to commit"
+msgstr "g\t\tIr para o commit"
+
+#: gitk:3095
+msgid "/\t\tFocus the search box"
+msgstr "/\t\tFocar a caixa de pesquisa"
+
+#: gitk:3096
+msgid "?\t\tMove to previous find hit"
+msgstr "?\t\tMover para a ocorr=C3=AAncia anterior"
+
+#: gitk:3097
+msgid "f\t\tScroll diff view to next file"
+msgstr "f\t\tDeslocar vista diff  para o ficheiro seguinte"
+
+#: gitk:3098
+#, tcl-format
+msgid "<%s-S>\t\tSearch for next hit in diff view"
+msgstr "<%s-S>\t\tProcurar pela ocorr=C3=AAncia seguinte na vista diff=
"
+
+#: gitk:3099
+#, tcl-format
+msgid "<%s-R>\t\tSearch for previous hit in diff view"
+msgstr "<%s-R>\t\tProcurar pela ocorr=C3=AAncia anterior na vista diff=
"
+
+#: gitk:3100
+#, tcl-format
+msgid "<%s-KP+>\tIncrease font size"
+msgstr "<%s-KP+>\tAumentar o tamanho da letra"
+
+#: gitk:3101
+#, tcl-format
+msgid "<%s-plus>\tIncrease font size"
+msgstr "<%s-plus>\tAumentar o tamanho da letra"
+
+#: gitk:3102
+#, tcl-format
+msgid "<%s-KP->\tDecrease font size"
+msgstr "<%s-KP->\tDiminuir o tamanho da letra"
+
+#: gitk:3103
+#, tcl-format
+msgid "<%s-minus>\tDecrease font size"
+msgstr "<%s-minus>\tDiminuir o tamanho da letra"
+
+#: gitk:3104
+msgid "<F5>\t\tUpdate"
+msgstr "<F5>\t\tAtualizar"
+
+#: gitk:3569 gitk:3578
+#, tcl-format
+msgid "Error creating temporary directory %s:"
+msgstr "Erro ao criar ficheiro tempor=C3=A1rio %s:"
+
+#: gitk:3591
+#, tcl-format
+msgid "Error getting \"%s\" from %s:"
+msgstr "Erro ao obter \"%s\" de %s:"
+
+#: gitk:3654
+msgid "command failed:"
+msgstr "o comando falhou:"
+
+#: gitk:3803
+msgid "No such commit"
+msgstr "Commit inexistente"
+
+#: gitk:3817
+msgid "git gui blame: command failed:"
+msgstr "git gui blame: o comando falhou:"
+
+#: gitk:3848
+#, tcl-format
+msgid "Couldn't read merge head: %s"
+msgstr "N=C3=A3o foi poss=C3=ADvel ler a cabe=C3=A7a de merge: %s"
+
+#: gitk:3856
+#, tcl-format
+msgid "Error reading index: %s"
+msgstr "Erro ao ler o =C3=ADndice: %s"
+
+#: gitk:3881
+#, tcl-format
+msgid "Couldn't start git blame: %s"
+msgstr "N=C3=A3o foi poss=C3=ADvel iniciar git blame: %s"
+
+#: gitk:3884 gitk:6773
+msgid "Searching"
+msgstr "A procurar"
+
+#: gitk:3916
+#, tcl-format
+msgid "Error running git blame: %s"
+msgstr "Erro ao executar git blame: %s"
+
+#: gitk:3944
+#, tcl-format
+msgid "That line comes from commit %s,  which is not in this view"
+msgstr "Essa linha prov=C3=A9m do commit %s, que n=C3=A3o est=C3=A1 ne=
sta vista"
+
+#: gitk:3958
+msgid "External diff viewer failed:"
+msgstr "Visualizador diff externo falhou:"
+
+#: gitk:4062
+msgid "All files"
+msgstr "Todos os ficheiros"
+
+#: gitk:4086
+msgid "View"
+msgstr "Vista"
+
+#: gitk:4089
+msgid "Gitk view definition"
+msgstr "Defini=C3=A7=C3=A3o de vistas do gitk "
+
+#: gitk:4093
+msgid "Remember this view"
+msgstr "Recordar esta vista"
+
+#: gitk:4094
+msgid "References (space separated list):"
+msgstr "Refer=C3=AAncias (lista separada por espa=C3=A7o):"
+
+#: gitk:4095
+msgid "Branches & tags:"
+msgstr "Ramos e tags:"
+
+#: gitk:4096
+msgid "All refs"
+msgstr "Todas as refer=C3=AAncias"
+
+#: gitk:4097
+msgid "All (local) branches"
+msgstr "Todos os ramos (locais)"
+
+#: gitk:4098
+msgid "All tags"
+msgstr "Todas as tags"
+
+#: gitk:4099
+msgid "All remote-tracking branches"
+msgstr "Todos os ramos remotos seguidos"
+
+#: gitk:4100
+msgid "Commit Info (regular expressions):"
+msgstr "Informa=C3=A7=C3=A3o Sobre o Commit (express=C3=B5es regulares=
):"
+
+#: gitk:4101
+msgid "Author:"
+msgstr "Autor:"
+
+#: gitk:4102
+msgid "Committer:"
+msgstr "Committer:"
+
+#: gitk:4103
+msgid "Commit Message:"
+msgstr "Mensagem de commit:"
+
+#: gitk:4104
+msgid "Matches all Commit Info criteria"
+msgstr "Corresponde a todos os crit=C3=A9rios da Informa=C3=A7=C3=A3o =
Sobre o Commit"
+
+#: gitk:4105
+msgid "Matches no Commit Info criteria"
+msgstr "N=C3=A3o corresponde a nenhum crit=C3=A9rio da Informa=C3=A7=C3=
=A3o Sobre o Commit"
+
+#: gitk:4106
+msgid "Changes to Files:"
+msgstr "Altera=C3=A7=C3=B5es nos Ficheiros:"
+
+#: gitk:4107
+msgid "Fixed String"
+msgstr "Cadeia Fixa"
+
+#: gitk:4108
+msgid "Regular Expression"
+msgstr "Express=C3=A3o Regular"
+
+#: gitk:4109
+msgid "Search string:"
+msgstr "Procurar pela cadeia:"
+
+#: gitk:4110
+msgid ""
+"Commit Dates (\"2 weeks ago\", \"2009-03-17 15:27:38\", \"March 17, 2=
009 "
+"15:27:38\"):"
+msgstr ""
+"Datas de Commit (\"2 weeks ago\", \"2009-03-17 15:27:38\", \"March 17=
, 2009 "
+"15:27:38\"):"
+
+#: gitk:4111
+msgid "Since:"
+msgstr "Desde:"
+
+#: gitk:4112
+msgid "Until:"
+msgstr "At=C3=A9:"
+
+#: gitk:4113
+msgid "Limit and/or skip a number of revisions (positive integer):"
+msgstr "Limitar e/ou ignorar um n=C3=BAmero de revis=C3=B5es (inteiro =
positivo):"
+
+#: gitk:4114
+msgid "Number to show:"
+msgstr "N=C3=BAmero a mostrar:"
+
+#: gitk:4115
+msgid "Number to skip:"
+msgstr "N=C3=BAmero a ignorar:"
+
+#: gitk:4116
+msgid "Miscellaneous options:"
+msgstr "Op=C3=A7=C3=B5es diversas:"
+
+#: gitk:4117
+msgid "Strictly sort by date"
+msgstr "Ordenar estritamente pela data"
+
+#: gitk:4118
+msgid "Mark branch sides"
+msgstr "Marcar lado dos ramos"
+
+#: gitk:4119
+msgid "Limit to first parent"
+msgstr "Restringir ao primeiro pai"
+
+#: gitk:4120
+msgid "Simple history"
+msgstr "Hist=C3=B3rico simples"
+
+#: gitk:4121
+msgid "Additional arguments to git log:"
+msgstr "Argumentos adicionais ao git log:"
+
+#: gitk:4122
+msgid "Enter files and directories to include, one per line:"
+msgstr "Introduza ficheiros e diret=C3=B3rios para incluir, um por lin=
ha:"
+
+#: gitk:4123
+msgid "Command to generate more commits to include:"
+msgstr "Comando para gerar mais commits para incluir:"
+
+#: gitk:4247
+msgid "Gitk: edit view"
+msgstr "Gitk: editar vista"
+
+#: gitk:4255
+msgid "-- criteria for selecting revisions"
+msgstr "-- crit=C3=A9rio para selecionar revis=C3=B5es"
+
+#: gitk:4260
+msgid "View Name"
+msgstr "Nome da Vista"
+
+#: gitk:4335
+msgid "Apply (F5)"
+msgstr "Aplicar (F5)"
+
+#: gitk:4373
+msgid "Error in commit selection arguments:"
+msgstr "Erro nos argumentos de sele=C3=A7=C3=A3o de commits:"
+
+#: gitk:4428 gitk:4481 gitk:4943 gitk:4957 gitk:6227 gitk:12410 gitk:1=
2411
+msgid "None"
+msgstr "Nenhum"
+
+#: gitk:5040 gitk:5045
+msgid "Descendant"
+msgstr "Descendente"
+
+#: gitk:5041
+msgid "Not descendant"
+msgstr "N=C3=A3o descendente"
+
+#: gitk:5048 gitk:5053
+msgid "Ancestor"
+msgstr "Antecessor"
+
+#: gitk:5049
+msgid "Not ancestor"
+msgstr "N=C3=A3o antecessor"
+
+#: gitk:5343
+msgid "Local changes checked in to index but not committed"
+msgstr "Altera=C3=A7=C3=B5es locais preparadas no =C3=ADndice mas n=C3=
=A3o inclu=C3=ADdas num commit"
+
+#: gitk:5379
+msgid "Local uncommitted changes, not checked in to index"
+msgstr "Altera=C3=A7=C3=B5es locais pendentes para commit, n=C3=A3o pr=
eparadas no =C3=ADndice"
+
+#: gitk:7153
+msgid "and many more"
+msgstr "e muitos mais"
+
+#: gitk:7156
+msgid "many"
+msgstr "muitos"
+
+#: gitk:7347
+msgid "Tags:"
+msgstr "Tags:"
+
+#: gitk:7364 gitk:7370 gitk:8844
+msgid "Parent"
+msgstr "Pai"
+
+#: gitk:7375
+msgid "Child"
+msgstr "Filho"
+
+#: gitk:7384
+msgid "Branch"
+msgstr "Ramo"
+
+#: gitk:7387
+msgid "Follows"
+msgstr "Sucede"
+
+#: gitk:7390
+msgid "Precedes"
+msgstr "Precede"
+
+#: gitk:7985
+#, tcl-format
+msgid "Error getting diffs: %s"
+msgstr "Erro ao obter diffs: %s"
+
+#: gitk:8669
+msgid "Goto:"
+msgstr "Ir para:"
+
+#: gitk:8690
+#, tcl-format
+msgid "Short SHA1 id %s is ambiguous"
+msgstr "O id SHA1 abreviado %s =C3=A9 amb=C3=ADguo"
+
+#: gitk:8697
+#, tcl-format
+msgid "Revision %s is not known"
+msgstr "A revis=C3=A3o %s n=C3=A3o =C3=A9 conhecida"
+
+#: gitk:8707
+#, tcl-format
+msgid "SHA1 id %s is not known"
+msgstr "O id SHA1 %s n=C3=A3o =C3=A9 conhecido"
+
+#: gitk:8709
+#, tcl-format
+msgid "Revision %s is not in the current view"
+msgstr "A revis=C3=A3o %s n=C3=A3o se encontra na vista atual"
+
+#: gitk:8851 gitk:8866
+msgid "Date"
+msgstr "Data"
+
+#: gitk:8854
+msgid "Children"
+msgstr "Filhos"
+
+#: gitk:8917
+#, tcl-format
+msgid "Reset %s branch to here"
+msgstr "Repor o ramo %s para aqui"
+
+#: gitk:8919
+msgid "Detached head: can't reset"
+msgstr "Cabe=C3=A7a destacada: n=C3=A3o =C3=A9 poss=C3=ADvel repor"
+
+#: gitk:9024 gitk:9030
+msgid "Skipping merge commit "
+msgstr "A ignorar commit de merge"
+
+#: gitk:9039 gitk:9044
+msgid "Error getting patch ID for "
+msgstr "Erro ao obter ID de patch de "
+
+#: gitk:9040 gitk:9045
+msgid " - stopping\n"
+msgstr "- a interromper\n"
+
+#: gitk:9050 gitk:9053 gitk:9061 gitk:9075 gitk:9084
+msgid "Commit "
+msgstr "Commit "
+
+#: gitk:9054
+msgid ""
+" is the same patch as\n"
+"       "
+msgstr ""
+"=C3=A9 o mesmo patch que\n"
+"       "
+
+#: gitk:9062
+msgid ""
+" differs from\n"
+"       "
+msgstr ""
+" difere de\n"
+"       "
+
+#: gitk:9064
+msgid ""
+"Diff of commits:\n"
+"\n"
+msgstr ""
+"Diff dos commits:\n"
+"\n"
+
+#: gitk:9076 gitk:9085
+#, tcl-format
+msgid " has %s children - stopping\n"
+msgstr " tem %s filhos - a interromper\n"
+
+#: gitk:9104
+#, tcl-format
+msgid "Error writing commit to file: %s"
+msgstr "Erro ao escrever commit no ficheiro: %s"
+
+#: gitk:9110
+#, tcl-format
+msgid "Error diffing commits: %s"
+msgstr "Erro ao calcular as diferen=C3=A7as dos commits: %s"
+
+#: gitk:9156
+msgid "Top"
+msgstr "Topo"
+
+#: gitk:9157
+msgid "From"
+msgstr "De"
+
+#: gitk:9162
+msgid "To"
+msgstr "Para"
+
+#: gitk:9186
+msgid "Generate patch"
+msgstr "Gerar patch"
+
+#: gitk:9188
+msgid "From:"
+msgstr "De:"
+
+#: gitk:9197
+msgid "To:"
+msgstr "Para:"
+
+#: gitk:9206
+msgid "Reverse"
+msgstr "Reverter"
+
+#: gitk:9208 gitk:9418
+msgid "Output file:"
+msgstr "Ficheiro de sa=C3=ADda:"
+
+#: gitk:9214
+msgid "Generate"
+msgstr "Gerar"
+
+#: gitk:9252
+msgid "Error creating patch:"
+msgstr "Erro ao criar patch:"
+
+#: gitk:9275 gitk:9406 gitk:9463
+msgid "ID:"
+msgstr "ID:"
+
+#: gitk:9284
+msgid "Tag name:"
+msgstr "Nome da tag:"
+
+#: gitk:9287
+msgid "Tag message is optional"
+msgstr "A mensagem da tag =C3=A9 opcional"
+
+#: gitk:9289
+msgid "Tag message:"
+msgstr "Mensagem da tag:"
+
+#: gitk:9293 gitk:9472
+msgid "Create"
+msgstr "Criar"
+
+#: gitk:9311
+msgid "No tag name specified"
+msgstr "Nenhum nome de tag especificado"
+
+#: gitk:9315
+#, tcl-format
+msgid "Tag \"%s\" already exists"
+msgstr "A tag \"%s\" j=C3=A1 existe"
+
+#: gitk:9325
+msgid "Error creating tag:"
+msgstr "Erro ao criar tag:"
+
+#: gitk:9415
+msgid "Command:"
+msgstr "Comando:"
+
+#: gitk:9423
+msgid "Write"
+msgstr "Escrever"
+
+#: gitk:9441
+msgid "Error writing commit:"
+msgstr "Erro ao escrever commit:"
+
+#: gitk:9468
+msgid "Name:"
+msgstr "Nome:"
+
+#: gitk:9491
+msgid "Please specify a name for the new branch"
+msgstr "Especifique um nome para o novo ramo"
+
+#: gitk:9496
+#, tcl-format
+msgid "Branch '%s' already exists. Overwrite?"
+msgstr "O ramo '%s' j=C3=A1 existe. Substitu=C3=AD-lo?"
+
+#: gitk:9563
+#, tcl-format
+msgid "Commit %s is already included in branch %s -- really re-apply i=
t?"
+msgstr "O commit %s j=C3=A1 est=C3=A1 inclu=C3=ADdo no ramo %s -- reap=
lic=C3=A1-lo mesmo assim?"
+
+#: gitk:9568
+msgid "Cherry-picking"
+msgstr "A efetuar cherry-pick"
+
+#: gitk:9577
+#, tcl-format
+msgid ""
+"Cherry-pick failed because of local changes to file '%s'.\n"
+"Please commit, reset or stash your changes and try again."
+msgstr ""
+"Falha ao efetuar cherry-pick devido a altera=C3=A7=C3=B5es locais no =
ficheiro '%s'."
+"Fa=C3=A7a commit, stash ou reset das altera=C3=A7=C3=B5es e tente de =
novo."
+
+#: gitk:9583
+msgid ""
+"Cherry-pick failed because of merge conflict.\n"
+"Do you wish to run git citool to resolve it?"
+msgstr ""
+"Falha ao efetuar cherry-pick devido a conflito de merge.\n"
+"Deseja executar git citool para resolv=C3=AA-lo?"
+
+#: gitk:9599 gitk:9657
+msgid "No changes committed"
+msgstr "N=C3=A3o foi efetuado commit de nenhum altera=C3=A7=C3=A3o"
+
+#: gitk:9626
+#, tcl-format
+msgid "Commit %s is not included in branch %s -- really revert it?"
+msgstr "O commit %s n=C3=A3o est=C3=A1 inclu=C3=ADdo no ramo %s -- rev=
ert=C3=AA-lo mesmo assim?"
+
+#: gitk:9631
+msgid "Reverting"
+msgstr "A reverter"
+
+#: gitk:9639
+#, tcl-format
+msgid ""
+"Revert failed because of local changes to the following files:%s Plea=
se "
+"commit, reset or stash  your changes and try again."
+msgstr ""
+"Falha ao reverter devido a altera=C3=A7=C3=B5es locais nos seguintes =
ficheiros: %s "
+"Fa=C3=A7a commit, stash ou reset das altera=C3=A7=C3=B5es e tente de =
novo."
+
+#: gitk:9643
+msgid ""
+"Revert failed because of merge conflict.\n"
+" Do you wish to run git citool to resolve it?"
+msgstr ""
+"Falha ao reverter devido a conflito de merge.\n"
+"Deseja executar git citool para resolv=C3=AA-lo?"
+
+#: gitk:9686
+msgid "Confirm reset"
+msgstr "Confirmar reposi=C3=A7=C3=A3o"
+
+#: gitk:9688
+#, tcl-format
+msgid "Reset branch %s to %s?"
+msgstr "Repor o ramo %s para %s?"
+
+#: gitk:9690
+msgid "Reset type:"
+msgstr "Tipo de reposi=C3=A7=C3=A3o:"
+
+#: gitk:9693
+msgid "Soft: Leave working tree and index untouched"
+msgstr "Suave: Deixar a =C3=A1rvore de trabalho e o =C3=ADndice intact=
os"
+
+#: gitk:9696
+msgid "Mixed: Leave working tree untouched, reset index"
+msgstr "Misto: Deixar a =C3=A1rvore de trabalho intacta, repor =C3=ADn=
dice"
+
+#: gitk:9699
+msgid ""
+"Hard: Reset working tree and index\n"
+"(discard ALL local changes)"
+msgstr ""
+"Forte: Repor =C3=A1rvore de trabalho e =C3=ADndice\n"
+"(descartar TODAS as altera=C3=A7=C3=B5es locais)"
+
+#: gitk:9716
+msgid "Resetting"
+msgstr "A repor"
+
+#: gitk:9776
+msgid "Checking out"
+msgstr "A extrair"
+
+#: gitk:9829
+msgid "Cannot delete the currently checked-out branch"
+msgstr "N=C3=A3o =C3=A9 poss=C3=ADvel eliminar o ramo extra=C3=ADdo"
+
+#: gitk:9835
+#, tcl-format
+msgid ""
+"The commits on branch %s aren't on any other branch.\n"
+"Really delete branch %s?"
+msgstr ""
+"Os commits no ramo %s n=C3=A3o est=C3=A3o em mais nenhum ramo.\n"
+"Eliminar o ramo %s mesmo assim?"
+
+#: gitk:9866
+#, tcl-format
+msgid "Tags and heads: %s"
+msgstr "Tags e cabe=C3=A7as: %s"
+
+#: gitk:9883
+msgid "Filter"
+msgstr "Filtrar"
+
+#: gitk:10179
+msgid ""
+"Error reading commit topology information; branch and preceding/follo=
wing "
+"tag information will be incomplete."
+msgstr ""
+"Erro ao ler informa=C3=A7=C3=A3o de topologia do commit; a informa=C3=
=A7=C3=A3o do ramo e da tag "
+"precedente/seguinte ficar=C3=A1 incompleta."
+
+#: gitk:11156
+msgid "Tag"
+msgstr "Tag"
+
+#: gitk:11160
+msgid "Id"
+msgstr "Id"
+
+#: gitk:11243
+msgid "Gitk font chooser"
+msgstr "Escolha de tipo de letra do gitk"
+
+#: gitk:11260
+msgid "B"
+msgstr "B"
+
+#: gitk:11263
+msgid "I"
+msgstr "I"
+
+#: gitk:11381
+msgid "Commit list display options"
+msgstr "Op=C3=A7=C3=B5es de visualiza=C3=A7=C3=A3o da lista de commits=
"
+
+#: gitk:11384
+msgid "Maximum graph width (lines)"
+msgstr "Largura m=C3=A1xima do gr=C3=A1fico (linhas)"
+
+#: gitk:11388
+#, no-tcl-format
+msgid "Maximum graph width (% of pane)"
+msgstr "Largura m=C3=A1xima do gr=C3=A1fico (% do painel)"
+
+#: gitk:11391
+msgid "Show local changes"
+msgstr "Mostrar altera=C3=A7=C3=B5es locais"
+
+#: gitk:11394
+msgid "Auto-select SHA1 (length)"
+msgstr "Selecionar automaticamente SHA1 (largura)"
+
+#: gitk:11398
+msgid "Hide remote refs"
+msgstr "Ocultar refer=C3=AAncias remotas"
+
+#: gitk:11402
+msgid "Diff display options"
+msgstr "Op=C3=A7=C3=B5es de visualiza=C3=A7=C3=A3o de diferen=C3=A7as"
+
+#: gitk:11404
+msgid "Tab spacing"
+msgstr "Espa=C3=A7amento da tabula=C3=A7=C3=A3o"
+
+#: gitk:11407
+msgid "Display nearby tags/heads"
+msgstr "Mostrar tags/cabe=C3=A7as pr=C3=B3ximas"
+
+#: gitk:11410
+msgid "Maximum # tags/heads to show"
+msgstr "N=C2=BA m=C3=A1ximo de tags/cabe=C3=A7as a mostrar"
+
+#: gitk:11413
+msgid "Limit diffs to listed paths"
+msgstr "Limitar diffs aos caminhos listados"
+
+#: gitk:11416
+msgid "Support per-file encodings"
+msgstr "Suportar codifica=C3=A7=C3=A3o por cada ficheiro"
+
+#: gitk:11422 gitk:11569
+msgid "External diff tool"
+msgstr "Ferramenta diff externa"
+
+#: gitk:11423
+msgid "Choose..."
+msgstr "Escolher..."
+
+#: gitk:11428
+msgid "General options"
+msgstr "Op=C3=A7=C3=B5es gerais"
+
+#: gitk:11431
+msgid "Use themed widgets"
+msgstr "Usar widgets com estilo"
+
+#: gitk:11433
+msgid "(change requires restart)"
+msgstr "(necessita de reiniciar)"
+
+#: gitk:11435
+msgid "(currently unavailable)"
+msgstr "(n=C3=A3o dispon=C3=ADvel de momento)"
+
+#: gitk:11446
+msgid "Colors: press to choose"
+msgstr "Cores: pressione para escolher"
+
+#: gitk:11449
+msgid "Interface"
+msgstr "Interface"
+
+#: gitk:11450
+msgid "interface"
+msgstr "interface"
+
+#: gitk:11453
+msgid "Background"
+msgstr "Fundo"
+
+#: gitk:11454 gitk:11484
+msgid "background"
+msgstr "fundo"
+
+#: gitk:11457
+msgid "Foreground"
+msgstr "Primeiro plano"
+
+#: gitk:11458
+msgid "foreground"
+msgstr "primeiro plano"
+
+#: gitk:11461
+msgid "Diff: old lines"
+msgstr "Diff: linhas antigas"
+
+#: gitk:11462
+msgid "diff old lines"
+msgstr "diff linhas antigas"
+
+#: gitk:11466
+msgid "Diff: new lines"
+msgstr "Diff: linhas novas"
+
+#: gitk:11467
+msgid "diff new lines"
+msgstr "diff linhas novas"
+
+#: gitk:11471
+msgid "Diff: hunk header"
+msgstr "Diff: cabe=C3=A7alho do excerto "
+
+#: gitk:11473
+msgid "diff hunk header"
+msgstr "diff cabe=C3=A7alho do excerto"
+
+#: gitk:11477
+msgid "Marked line bg"
+msgstr "Fundo da linha marcada"
+
+#: gitk:11479
+msgid "marked line background"
+msgstr "fundo da linha marcada"
+
+#: gitk:11483
+msgid "Select bg"
+msgstr "Selecionar fundo"
+
+#: gitk:11492
+msgid "Fonts: press to choose"
+msgstr "Tipo de letra: pressione para escolher"
+
+#: gitk:11494
+msgid "Main font"
+msgstr "Tipo de letra principal"
+
+#: gitk:11495
+msgid "Diff display font"
+msgstr "Tipo de letra para mostrar as diferen=C3=A7as"
+
+#: gitk:11496
+msgid "User interface font"
+msgstr "Tipo de letra da interface de utilizador"
+
+#: gitk:11518
+msgid "Gitk preferences"
+msgstr "Prefer=C3=AAncias do gitk"
+
+#: gitk:11527
+msgid "General"
+msgstr "Geral"
+
+#: gitk:11528
+msgid "Colors"
+msgstr "Cores"
+
+#: gitk:11529
+msgid "Fonts"
+msgstr "Tipos de letra"
+
+#: gitk:11579
+#, tcl-format
+msgid "Gitk: choose color for %s"
+msgstr "Gitk: escolher cor de %s"
+
+#: gitk:12092
+msgid ""
+"Sorry, gitk cannot run with this version of Tcl/Tk.\n"
+" Gitk requires at least Tcl/Tk 8.4."
+msgstr ""
+"N=C3=A3o =C3=A9 poss=C3=ADvel executar o gitk com esta vers=C3=A3o do=
 Tcl/Tk.\n"
+" O gitk requer pelo menos Tcl/Tk 8.4."
+
+#: gitk:12302
+msgid "Cannot find a git repository here."
+msgstr "N=C3=A3o foi encontrado nenhum reposit=C3=B3rio git aqui."
+
+#: gitk:12349
+#, tcl-format
+msgid "Ambiguous argument '%s': both revision and filename"
+msgstr "Argumento '%s' amb=C3=ADguo: pode ser uma revis=C3=A3o ou um f=
icheiro"
+
+#: gitk:12361
+msgid "Bad arguments to gitk:"
+msgstr "Argumentos do gitk incorretos:"
--=20
2.1.4
