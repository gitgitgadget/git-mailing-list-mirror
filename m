From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH] git-gui: l10n: add Portuguese translation
Date: Thu,  5 May 2016 11:23:41 +0000
Message-ID: <1462447421-6294-1-git-send-email-vascomalmeida@sapo.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	"Shawn O . Pearce" <spearce@spearce.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 05 13:25:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayHPc-0000aQ-PP
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 13:25:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754614AbcEELZ0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 May 2016 07:25:26 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:37146 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754554AbcEELZV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 07:25:21 -0400
Received: (qmail 18073 invoked from network); 5 May 2016 11:25:18 -0000
Received: (qmail 12905 invoked from network); 5 May 2016 11:25:18 -0000
Received: from unknown (HELO localhost.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 5 May 2016 11:25:14 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.7.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293646>

Add Portuguese glossary.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 po/glossary/pt_pt.po |  177 ++++
 po/pt_pt.po          | 2574 ++++++++++++++++++++++++++++++++++++++++++=
++++++++
 2 files changed, 2751 insertions(+)
 create mode 100644 po/glossary/pt_pt.po
 create mode 100644 po/pt_pt.po

diff --git a/po/glossary/pt_pt.po b/po/glossary/pt_pt.po
new file mode 100644
index 0000000..239b965
--- /dev/null
+++ b/po/glossary/pt_pt.po
@@ -0,0 +1,177 @@
+# Portuguese translations for git-gui glossary.
+# Copyright (C) 2016 Shawn Pearce, et al.
+# This file is distributed under the same license as the git package.
+# Vasco Almeida <vascomalmeida@sapo.pt>, 2016.
+msgid ""
+msgstr ""
+"Project-Id-Version: git-gui glossary\n"
+"POT-Creation-Date: 2008-01-07 21:20+0100\n"
+"PO-Revision-Date: 2016-05-04 18:44+0000\n"
+"Last-Translator: Vasco Almeida <vascomalmeida@sapo.pt>\n"
+"Language-Team: Portuguese\n"
+"Language: pt\n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=3DUTF-8\n"
+"Content-Transfer-Encoding: 8bit\n"
+"Plural-Forms: nplurals=3D2; plural=3D(n !=3D 1);\n"
+"X-Generator: Virtaal 0.7.1\n"
+
+#. "English Definition (Dear translator: This file will never be visib=
le to the user! It should only serve as a tool for you, the translator.=
 Nothing more.)"
+msgid ""
+"English Term (Dear translator: This file will never be visible to the=
 user!)"
+msgstr ""
+"Outro SCM em portugu=C3=AAs:\n"
+"http://svn.code.sf.net/p/tortoisesvn/code/trunk/Languages/pt/Tortoise=
UI.po e "
+"\n"
+"http://svn.code.sf.net/p/tortoisesvn/code/trunk/Languages/pt/Tortoise=
Doc.po\n"
+" em html: https://tortoisesvn.net/docs/release/TortoiseSVN_pt/index.h=
tml\n"
+"\n"
+"https://translations.launchpad.net/tortoisehg (med=C3=ADocre)"
+
+#. ""
+msgid "amend"
+msgstr "emendar"
+
+#. ""
+msgid "annotate"
+msgstr "anotar"
+
+#. "A 'branch' is an active line of development."
+msgid "branch [noun]"
+msgstr "ramo"
+
+#. ""
+msgid "branch [verb]"
+msgstr "criar ramo"
+
+#. ""
+msgid "checkout [noun]"
+msgstr "extra=C3=A7=C3=A3o"
+
+#. "The action of updating the working tree to a revision which was st=
ored in the object database."
+msgid "checkout [verb]"
+msgstr "extrair"
+
+#. ""
+msgid "clone [verb]"
+msgstr "clonar"
+
+#. "A single point in the git history."
+msgid "commit [noun]"
+msgstr "commit"
+
+#. "The action of storing a new snapshot of the project's state in the=
 git history."
+msgid "commit [verb]"
+msgstr "fazer commit"
+
+#. ""
+msgid "diff [noun]"
+msgstr "diferen=C3=A7as"
+
+#. ""
+msgid "diff [verb]"
+msgstr "mostrar diferen=C3=A7as"
+
+#. "A fast-forward is a special type of merge where you have a revisio=
n and you are merging another branch's changes that happen to be a desc=
endant of what you have."
+msgid "fast forward merge"
+msgstr "integra=C3=A7=C3=A3o por avan=C3=A7o r=C3=A1pido"
+
+#. "Fetching a branch means to get the branch's head from a remote rep=
ository, to find out which objects are missing from the local object da=
tabase, and to get them, too."
+msgid "fetch"
+msgstr "obter"
+
+#. "One context of consecutive lines in a whole patch, which consists =
of many such hunks"
+msgid "hunk"
+msgstr "excerto"
+
+#. "A collection of files. The index is a stored version of your worki=
ng tree."
+msgid "index (in git-gui: staging area)"
+msgstr "=C3=ADndice"
+
+#. "A successful merge results in the creation of a new commit represe=
nting the result of the merge."
+msgid "merge [noun]"
+msgstr "integra=C3=A7=C3=A3o"
+
+#. "To bring the contents of another branch into the current branch."
+msgid "merge [verb]"
+msgstr "integrar"
+
+#. ""
+msgid "message"
+msgstr "mensagem"
+
+#. "Deletes all stale tracking branches under <name>. These stale bran=
ches have already been removed from the remote repository referenced by=
 <name>, but are still locally available in 'remotes/<name>'."
+msgid "prune"
+msgstr "podar"
+
+#. "Pulling a branch means to fetch it and merge it."
+msgid "pull"
+msgstr "puxar"
+
+#. "Pushing a branch means to get the branch's head ref from a remote =
repository, and ... (well, can someone please explain it for mere morta=
ls?)"
+msgid "push"
+msgstr "publicar"
+
+#. ""
+msgid "redo"
+msgstr "refazer"
+
+#. "An other repository ('remote'). One might have a set of remotes wh=
ose branches one tracks."
+msgid "remote"
+msgstr "remoto"
+
+#. "A collection of refs (?) together with an object database containi=
ng all objects which are reachable from the refs... (oops, you've lost =
me here. Again, please an explanation for mere mortals?)"
+msgid "repository"
+msgstr "reposit=C3=B3rio"
+
+#. ""
+msgid "reset"
+msgstr "repor"
+
+#. ""
+msgid "revert"
+msgstr "reverter"
+
+#. "A particular state of files and directories which was stored in th=
e object database."
+msgid "revision"
+msgstr "revis=C3=A3o"
+
+#. ""
+msgid "sign off"
+msgstr "assinar por baixo"
+
+#. ""
+msgid "staging area"
+msgstr "=C3=A1rea de est=C3=A1gio"
+
+#. ""
+msgid "status"
+msgstr "estado"
+
+#. "A ref pointing to a tag or commit object"
+msgid "tag [noun]"
+msgstr "tag"
+
+#. ""
+msgid "tag [verb]"
+msgstr "criar tag"
+
+#. "A regular git branch that is used to follow changes from another r=
epository."
+msgid "tracking branch"
+msgstr "ramo de monitoriza=C3=A7=C3=A3o"
+
+#. ""
+msgid "undo"
+msgstr "desfazer"
+
+#. ""
+msgid "update"
+msgstr "atualizar"
+
+#. ""
+msgid "verify"
+msgstr "verificar"
+
+#. "The tree of actual checked out files."
+msgid "working copy, working tree"
+msgstr "c=C3=B3pia de trabalho, =C3=A1rvore de trabalho"
diff --git a/po/pt_pt.po b/po/pt_pt.po
new file mode 100644
index 0000000..c473394
--- /dev/null
+++ b/po/pt_pt.po
@@ -0,0 +1,2574 @@
+# Portuguese translations for git-gui package.
+# Copyright (C) 2016 Shawn Pearce, et al.
+# This file is distributed under the same license as the git package.
+# Vasco Almeida <vascomalmeida@sapo.pt>, 2016.
+msgid ""
+msgstr ""
+"Project-Id-Version: git-gui\n"
+"Report-Msgid-Bugs-To: \n"
+"POT-Creation-Date: 2010-01-26 15:47-0800\n"
+"PO-Revision-Date: 2016-05-05 10:45+0000\n"
+"Last-Translator: Vasco Almeida <vascomalmeida@sapo.pt>\n"
+"Language-Team: Portuguese\n"
+"Language: pt\n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=3DUTF-8\n"
+"Content-Transfer-Encoding: 8bit\n"
+"Plural-Forms: nplurals=3D2; plural=3D(n !=3D 1);\n"
+"X-Generator: Virtaal 0.7.1\n"
+
+#: git-gui.sh:41 git-gui.sh:793 git-gui.sh:807 git-gui.sh:820 git-gui.=
sh:903
+#: git-gui.sh:922
+msgid "git-gui: fatal error"
+msgstr "git-gui: erro fatal"
+
+#: git-gui.sh:743
+#, tcl-format
+msgid "Invalid font specified in %s:"
+msgstr "Tipo de letra inv=C3=A1lido especificado em %s:"
+
+#: git-gui.sh:779
+msgid "Main Font"
+msgstr "Tipo de letra principal"
+
+#: git-gui.sh:780
+msgid "Diff/Console Font"
+msgstr "Tipo de letra Diferen=C3=A7as/Consola"
+
+#: git-gui.sh:794
+msgid "Cannot find git in PATH."
+msgstr "N=C3=A3o =C3=A9 poss=C3=ADvel encontrar o git em PATH."
+
+#: git-gui.sh:821
+msgid "Cannot parse Git version string:"
+msgstr "N=C3=A3o =C3=A9 poss=C3=ADvel analisar a vers=C3=A3o do Git:"
+
+#: git-gui.sh:839
+#, tcl-format
+msgid ""
+"Git version cannot be determined.\n"
+"\n"
+"%s claims it is version '%s'.\n"
+"\n"
+"%s requires at least Git 1.5.0 or later.\n"
+"\n"
+"Assume '%s' is version 1.5.0?\n"
+msgstr ""
+"A vers=C3=A3o do Git n=C3=A3o p=C3=B4de ser determinada.\n"
+"\n"
+"%s alega que est=C3=A1 na vers=C3=A3o '%s'.\n"
+"\n"
+"%s requer pelo menos Git 1.5.0 ou mais recente.\n"
+"\n"
+"Assumir que '%s' est=C3=A1 na vers=C3=A3o 1.5.0?\n"
+
+#: git-gui.sh:1128
+msgid "Git directory not found:"
+msgstr "Diret=C3=B3rio Git n=C3=A3o encontrado:"
+
+#: git-gui.sh:1146
+msgid "Cannot move to top of working directory:"
+msgstr "N=C3=A3o =C3=A9 poss=C3=ADvel mover para o topo do diret=C3=B3=
rio de trabalho:"
+
+#: git-gui.sh:1154
+msgid "Cannot use bare repository:"
+msgstr "N=C3=A3o =C3=A9 poss=C3=ADvel usar reposit=C3=B3rio nu:"
+
+#: git-gui.sh:1162
+msgid "No working directory"
+msgstr "Nenhum diret=C3=B3rio de trabalho"
+
+#: git-gui.sh:1334 lib/checkout_op.tcl:306
+msgid "Refreshing file status..."
+msgstr "A atualizar estado do ficheiro..."
+
+#: git-gui.sh:1390
+msgid "Scanning for modified files ..."
+msgstr "A procurar por ficheiros modificados..."
+
+#: git-gui.sh:1454
+msgid "Calling prepare-commit-msg hook..."
+msgstr ""
+"A invocar gancho preparar-mensagem-de-commit (prepare-commit-msg hook=
)..."
+
+#: git-gui.sh:1471
+msgid "Commit declined by prepare-commit-msg hook."
+msgstr ""
+"Commit recusado pelo gancho preparar-mensagem-de-commit (prepare-comm=
it-msg "
+"hook)."
+
+#: git-gui.sh:1629 lib/browser.tcl:246
+msgid "Ready."
+msgstr "Pronto."
+
+#: git-gui.sh:1787
+#, tcl-format
+msgid "Displaying only %s of %s files."
+msgstr "A mostrar apenas %s de %s ficheiros."
+
+#: git-gui.sh:1913
+msgid "Unmodified"
+msgstr "N=C3=A3o modificado"
+
+#: git-gui.sh:1915
+msgid "Modified, not staged"
+msgstr "Modificado, n=C3=A3o preparado"
+
+#: git-gui.sh:1916 git-gui.sh:1924
+msgid "Staged for commit"
+msgstr "Preparado para commit"
+
+#: git-gui.sh:1917 git-gui.sh:1925
+msgid "Portions staged for commit"
+msgstr "Por=C3=A7=C3=B5es preparadas para commit"
+
+#: git-gui.sh:1918 git-gui.sh:1926
+msgid "Staged for commit, missing"
+msgstr "Preparado para commit, em falta"
+
+#: git-gui.sh:1920
+msgid "File type changed, not staged"
+msgstr "Tipo de ficheiro alterado, n=C3=A3o preparado"
+
+#: git-gui.sh:1921
+msgid "File type changed, staged"
+msgstr "Tipo de ficheiro alterado, preparado"
+
+#: git-gui.sh:1923
+msgid "Untracked, not staged"
+msgstr "N=C3=A3o controlado, n=C3=A3o preparado"
+
+#: git-gui.sh:1928
+msgid "Missing"
+msgstr "Em falta"
+
+#: git-gui.sh:1929
+msgid "Staged for removal"
+msgstr "Preparado para remo=C3=A7=C3=A3o"
+
+#: git-gui.sh:1930
+msgid "Staged for removal, still present"
+msgstr "Preparado para remo=C3=A7=C3=A3o, ainda presente"
+
+#: git-gui.sh:1932 git-gui.sh:1933 git-gui.sh:1934 git-gui.sh:1935
+#: git-gui.sh:1936 git-gui.sh:1937
+msgid "Requires merge resolution"
+msgstr "Requer resolu=C3=A7=C3=A3o de integra=C3=A7=C3=A3o"
+
+#: git-gui.sh:1972
+msgid "Starting gitk... please wait..."
+msgstr "A iniciar gitk... aguarde..."
+
+#: git-gui.sh:1984
+msgid "Couldn't find gitk in PATH"
+msgstr "N=C3=A3o foi poss=C3=ADvel encontrar gitk em PATH"
+
+#: git-gui.sh:2043
+msgid "Couldn't find git gui in PATH"
+msgstr "N=C3=A3o foi poss=C3=ADvel encontrar git gui em PATH"
+
+#: git-gui.sh:2455 lib/choose_repository.tcl:36
+msgid "Repository"
+msgstr "Reposit=C3=B3rio"
+
+#: git-gui.sh:2456
+msgid "Edit"
+msgstr "Editar"
+
+#: git-gui.sh:2458 lib/choose_rev.tcl:561
+msgid "Branch"
+msgstr "Ramo"
+
+#: git-gui.sh:2461 lib/choose_rev.tcl:548
+msgid "Commit@@noun"
+msgstr "Commit"
+
+#: git-gui.sh:2464 lib/merge.tcl:121 lib/merge.tcl:150 lib/merge.tcl:1=
68
+msgid "Merge"
+msgstr "Integrar"
+
+#: git-gui.sh:2465 lib/choose_rev.tcl:557
+msgid "Remote"
+msgstr "Remoto"
+
+#: git-gui.sh:2468
+msgid "Tools"
+msgstr "Ferramentas"
+
+#: git-gui.sh:2477
+msgid "Explore Working Copy"
+msgstr "Explorar c=C3=B3pia de trabalho"
+
+#: git-gui.sh:2483
+msgid "Browse Current Branch's Files"
+msgstr "Navegar pelos ficheiro do ramo atual"
+
+#: git-gui.sh:2487
+msgid "Browse Branch Files..."
+msgstr "Navegar pelos ficheiros do ramo..."
+
+#: git-gui.sh:2492
+msgid "Visualize Current Branch's History"
+msgstr "Visualizar hist=C3=B3rico do ramo atual"
+
+#: git-gui.sh:2496
+msgid "Visualize All Branch History"
+msgstr "Visualizar hist=C3=B3rico de todos os ramos"
+
+#: git-gui.sh:2503
+#, tcl-format
+msgid "Browse %s's Files"
+msgstr "Navegar pelos ficheiro de %s"
+
+#: git-gui.sh:2505
+#, tcl-format
+msgid "Visualize %s's History"
+msgstr "Visualizar hist=C3=B3rico de %s"
+
+#: git-gui.sh:2510 lib/database.tcl:27 lib/database.tcl:67
+msgid "Database Statistics"
+msgstr "Estat=C3=ADsticas da base de dados"
+
+#: git-gui.sh:2513 lib/database.tcl:34
+msgid "Compress Database"
+msgstr "Comprimir base de dados"
+
+#: git-gui.sh:2516
+msgid "Verify Database"
+msgstr "Verificar base de dados"
+
+#: git-gui.sh:2523 git-gui.sh:2527 git-gui.sh:2531 lib/shortcut.tcl:8
+#: lib/shortcut.tcl:40 lib/shortcut.tcl:72
+msgid "Create Desktop Icon"
+msgstr "Criar =C3=ADcone no ambiente de trabalho"
+
+#: git-gui.sh:2539 lib/choose_repository.tcl:183 lib/choose_repository=
=2Etcl:191
+msgid "Quit"
+msgstr "Sair"
+
+#: git-gui.sh:2547
+msgid "Undo"
+msgstr "Desfazer"
+
+#: git-gui.sh:2550
+msgid "Redo"
+msgstr "Refazer"
+
+#: git-gui.sh:2554 git-gui.sh:3109
+msgid "Cut"
+msgstr "Cortar"
+
+#: git-gui.sh:2557 git-gui.sh:3112 git-gui.sh:3186 git-gui.sh:3259
+#: lib/console.tcl:69
+msgid "Copy"
+msgstr "Copiar"
+
+#: git-gui.sh:2560 git-gui.sh:3115
+msgid "Paste"
+msgstr "Colar"
+
+#: git-gui.sh:2563 git-gui.sh:3118 lib/branch_delete.tcl:26
+#: lib/remote_branch_delete.tcl:38
+msgid "Delete"
+msgstr "Eliminar"
+
+#: git-gui.sh:2567 git-gui.sh:3122 git-gui.sh:3263 lib/console.tcl:71
+msgid "Select All"
+msgstr "Selecionar tudo"
+
+#: git-gui.sh:2576
+msgid "Create..."
+msgstr "Criar..."
+
+#: git-gui.sh:2582
+msgid "Checkout..."
+msgstr "Extrair..."
+
+#: git-gui.sh:2588
+msgid "Rename..."
+msgstr "Mudar nome..."
+
+#: git-gui.sh:2593
+msgid "Delete..."
+msgstr "Eliminar..."
+
+#: git-gui.sh:2598
+msgid "Reset..."
+msgstr "Repor..."
+
+#: git-gui.sh:2608
+msgid "Done"
+msgstr "Conclu=C3=ADdo"
+
+#: git-gui.sh:2610
+msgid "Commit@@verb"
+msgstr "Fazer commit"
+
+#: git-gui.sh:2619 git-gui.sh:3050
+msgid "New Commit"
+msgstr "Novo commit"
+
+#: git-gui.sh:2627 git-gui.sh:3057
+msgid "Amend Last Commit"
+msgstr "Emendar =C3=BAltimo commit"
+
+#: git-gui.sh:2637 git-gui.sh:3011 lib/remote_branch_delete.tcl:99
+msgid "Rescan"
+msgstr "Reanalisar"
+
+#: git-gui.sh:2643
+msgid "Stage To Commit"
+msgstr "Preparar para commit"
+
+#: git-gui.sh:2649
+msgid "Stage Changed Files To Commit"
+msgstr "Preparar ficheiros modificados para commit"
+
+#: git-gui.sh:2655
+msgid "Unstage From Commit"
+msgstr "Retirar do commit"
+
+#: git-gui.sh:2661 lib/index.tcl:412
+msgid "Revert Changes"
+msgstr "Reverter altera=C3=A7=C3=B5es"
+
+#: git-gui.sh:2669 git-gui.sh:3310 git-gui.sh:3341
+msgid "Show Less Context"
+msgstr "Mostrar menos contexto"
+
+#: git-gui.sh:2673 git-gui.sh:3314 git-gui.sh:3345
+msgid "Show More Context"
+msgstr "Mostrar mais contexto"
+
+#: git-gui.sh:2680 git-gui.sh:3024 git-gui.sh:3133
+msgid "Sign Off"
+msgstr "Assinar por baixo"
+
+#: git-gui.sh:2696
+msgid "Local Merge..."
+msgstr "Integra=C3=A7=C3=A3o local..."
+
+#: git-gui.sh:2701
+msgid "Abort Merge..."
+msgstr "Abortar integra=C3=A7=C3=A3o..."
+
+#: git-gui.sh:2713 git-gui.sh:2741
+msgid "Add..."
+msgstr "Adicionar..."
+
+#: git-gui.sh:2717
+msgid "Push..."
+msgstr "Publicar..."
+
+#: git-gui.sh:2721
+msgid "Delete Branch..."
+msgstr "Eliminar ramo..."
+
+#: git-gui.sh:2731 git-gui.sh:3292
+msgid "Options..."
+msgstr "Op=C3=A7=C3=B5es..."
+
+#: git-gui.sh:2742
+msgid "Remove..."
+msgstr "Remover..."
+
+#: git-gui.sh:2751 lib/choose_repository.tcl:50
+msgid "Help"
+msgstr "Ajuda"
+
+#: git-gui.sh:2755 git-gui.sh:2759 lib/about.tcl:14
+#: lib/choose_repository.tcl:44 lib/choose_repository.tcl:53
+#, tcl-format
+msgid "About %s"
+msgstr "Sobre %s"
+
+#: git-gui.sh:2783
+msgid "Online Documentation"
+msgstr "Documenta=C3=A7=C3=A3o online"
+
+#: git-gui.sh:2786 lib/choose_repository.tcl:47 lib/choose_repository.=
tcl:56
+msgid "Show SSH Key"
+msgstr "Mostrar chave SSH"
+
+#: git-gui.sh:2893
+#, tcl-format
+msgid "fatal: cannot stat path %s: No such file or directory"
+msgstr ""
+"fatal: n=C3=A3o =C3=A9 poss=C3=ADvel obter estado do caminho %s: Fich=
eiro ou diret=C3=B3rio "
+"inexistente"
+
+#: git-gui.sh:2926
+msgid "Current Branch:"
+msgstr "Ramo atual:"
+
+#: git-gui.sh:2947
+msgid "Staged Changes (Will Commit)"
+msgstr "Altera=C3=A7=C3=B5es preparadas (para commit)"
+
+#: git-gui.sh:2967
+msgid "Unstaged Changes"
+msgstr "Altera=C3=A7=C3=B5es n=C3=A3o preparadas"
+
+#: git-gui.sh:3017
+msgid "Stage Changed"
+msgstr "Preparar modificados"
+
+#: git-gui.sh:3036 lib/transport.tcl:104 lib/transport.tcl:193
+msgid "Push"
+msgstr "Publicar"
+
+#: git-gui.sh:3071
+msgid "Initial Commit Message:"
+msgstr "Mensagem de commit inicial:"
+
+#: git-gui.sh:3072
+msgid "Amended Commit Message:"
+msgstr "Mensagem de commit emendada:"
+
+#: git-gui.sh:3073
+msgid "Amended Initial Commit Message:"
+msgstr "Mensagem de commit inicial emendada:"
+
+#: git-gui.sh:3074
+msgid "Amended Merge Commit Message:"
+msgstr "Mensagem de commit de integra=C3=A7=C3=A3o emendada:"
+
+#: git-gui.sh:3075
+msgid "Merge Commit Message:"
+msgstr "Mensagem de commit de integra=C3=A7=C3=A3o:"
+
+#: git-gui.sh:3076
+msgid "Commit Message:"
+msgstr "Mensagem de commit:"
+
+#: git-gui.sh:3125 git-gui.sh:3267 lib/console.tcl:73
+msgid "Copy All"
+msgstr "Copiar tudo"
+
+#: git-gui.sh:3149 lib/blame.tcl:104
+msgid "File:"
+msgstr "Ficheiro:"
+
+#: git-gui.sh:3255
+msgid "Refresh"
+msgstr "Atualizar"
+
+#: git-gui.sh:3276
+msgid "Decrease Font Size"
+msgstr "Diminuir tamanho de letra"
+
+#: git-gui.sh:3280
+msgid "Increase Font Size"
+msgstr "Aumentar tamanho de letra"
+
+#: git-gui.sh:3288 lib/blame.tcl:281
+msgid "Encoding"
+msgstr "Codifica=C3=A7=C3=A3o"
+
+#: git-gui.sh:3299
+msgid "Apply/Reverse Hunk"
+msgstr "Aplicar/Reverter excerto"
+
+#: git-gui.sh:3304
+msgid "Apply/Reverse Line"
+msgstr "Aplicar/Reverter linha"
+
+#: git-gui.sh:3323
+msgid "Run Merge Tool"
+msgstr "Executar ferramenta de integra=C3=A7=C3=A3o"
+
+#: git-gui.sh:3328
+msgid "Use Remote Version"
+msgstr "Usar a vers=C3=A3o remota"
+
+#: git-gui.sh:3332
+msgid "Use Local Version"
+msgstr "Usar a vers=C3=A3o local"
+
+#: git-gui.sh:3336
+msgid "Revert To Base"
+msgstr "Reverter para a base"
+
+#: git-gui.sh:3354
+msgid "Visualize These Changes In The Submodule"
+msgstr "Visualizar estas altera=C3=A7=C3=B5es no subm=C3=B3dulo"
+
+#: git-gui.sh:3358
+msgid "Visualize Current Branch History In The Submodule"
+msgstr "Visualizar hist=C3=B3rico do ramo atual no subm=C3=B3dulo"
+
+#: git-gui.sh:3362
+msgid "Visualize All Branch History In The Submodule"
+msgstr "Visualizar hist=C3=B3rico de todos os ramos no subm=C3=B3dulo"
+
+#: git-gui.sh:3367
+msgid "Start git gui In The Submodule"
+msgstr "Iniciar git gui no subm=C3=B3dulo"
+
+#: git-gui.sh:3389
+msgid "Unstage Hunk From Commit"
+msgstr "Retirar excerto do commit"
+
+#: git-gui.sh:3391
+msgid "Unstage Lines From Commit"
+msgstr "Retirar linhas do commit"
+
+#: git-gui.sh:3393
+msgid "Unstage Line From Commit"
+msgstr "Retirar linha do commit"
+
+#: git-gui.sh:3396
+msgid "Stage Hunk For Commit"
+msgstr "Preparar excerto para commit"
+
+#: git-gui.sh:3398
+msgid "Stage Lines For Commit"
+msgstr "Preparar linhas para commit"
+
+#: git-gui.sh:3400
+msgid "Stage Line For Commit"
+msgstr "Preparar linha para commit"
+
+#: git-gui.sh:3424
+msgid "Initializing..."
+msgstr "A inicializar..."
+
+#: git-gui.sh:3541
+#, tcl-format
+msgid ""
+"Possible environment issues exist.\n"
+"\n"
+"The following environment variables are probably\n"
+"going to be ignored by any Git subprocess run\n"
+"by %s:\n"
+"\n"
+msgstr ""
+"Existem poss=C3=ADveis erros de ambiente.\n"
+"\n"
+"As seguintes vari=C3=A1veis de ambiente ser=C3=A3o provavelmente\n"
+"ignoradas pelos subprocessos do Git executados\n"
+"por %s:\n"
+"\n"
+
+#: git-gui.sh:3570
+msgid ""
+"\n"
+"This is due to a known issue with the\n"
+"Tcl binary distributed by Cygwin."
+msgstr ""
+"\n"
+"Devido a um problema conhecido com o\n"
+"bin=C3=A1rio Tcl distribu=C3=ADdo pelo Cygwin."
+
+#: git-gui.sh:3575
+#, tcl-format
+msgid ""
+"\n"
+"\n"
+"A good replacement for %s\n"
+"is placing values for the user.name and\n"
+"user.email settings into your personal\n"
+"~/.gitconfig file.\n"
+msgstr ""
+"\n"
+"\n"
+"Um bom substituto para %s\n"
+"=C3=A9 colocar valores das defini=C3=A7=C3=B5es user.name e\n"
+"user.email no ficheiro pessoal ~/.gitconfig.\n"
+
+#: lib/about.tcl:26
+msgid "git-gui - a graphical user interface for Git."
+msgstr "git-gui - uma interface gr=C3=A1fica do Git."
+
+#: lib/blame.tcl:72
+msgid "File Viewer"
+msgstr "Visualizador de ficheiros"
+
+#: lib/blame.tcl:78
+msgid "Commit:"
+msgstr "Commit:"
+
+#: lib/blame.tcl:271
+msgid "Copy Commit"
+msgstr "Copiar commit"
+
+#: lib/blame.tcl:275
+msgid "Find Text..."
+msgstr "Procurar texto..."
+
+#: lib/blame.tcl:284
+msgid "Do Full Copy Detection"
+msgstr "Efetuar dete=C3=A7=C3=A3o de c=C3=B3pia integral"
+
+#: lib/blame.tcl:288
+msgid "Show History Context"
+msgstr "Mostrar contexto hist=C3=B3rico"
+
+#: lib/blame.tcl:291
+msgid "Blame Parent Commit"
+msgstr "Culpar commit pai"
+
+#: lib/blame.tcl:450
+#, tcl-format
+msgid "Reading %s..."
+msgstr "A ler %s..."
+
+#: lib/blame.tcl:557
+msgid "Loading copy/move tracking annotations..."
+msgstr "A carregar anota=C3=A7=C3=B5es de c=C3=B3pia/movimento..."
+
+#: lib/blame.tcl:577
+msgid "lines annotated"
+msgstr "linhas anotadas"
+
+#: lib/blame.tcl:769
+msgid "Loading original location annotations..."
+msgstr "A carregar anota=C3=A7=C3=B5es da localiza=C3=A7=C3=A3o origin=
al..."
+
+#: lib/blame.tcl:772
+msgid "Annotation complete."
+msgstr "Anota=C3=A7=C3=A3o conclu=C3=ADda."
+
+#: lib/blame.tcl:802
+msgid "Busy"
+msgstr "A processar"
+
+#: lib/blame.tcl:803
+msgid "Annotation process is already running."
+msgstr "O processo de anota=C3=A7=C3=A3o j=C3=A1 est=C3=A1 em execu=C3=
=A7=C3=A3o."
+
+#: lib/blame.tcl:842
+msgid "Running thorough copy detection..."
+msgstr "A executar dete=C3=A7=C3=A3o de c=C3=B3pia integral..."
+
+#: lib/blame.tcl:910
+msgid "Loading annotation..."
+msgstr "A carregar anota=C3=A7=C3=A3o..."
+
+#: lib/blame.tcl:963
+msgid "Author:"
+msgstr "Autor:"
+
+#: lib/blame.tcl:967
+msgid "Committer:"
+msgstr "Committer:"
+
+#: lib/blame.tcl:972
+msgid "Original File:"
+msgstr "Ficheiro original:"
+
+#: lib/blame.tcl:1020
+msgid "Cannot find HEAD commit:"
+msgstr "N=C3=A3o =C3=A9 poss=C3=ADvel encontrar commit HEAD:"
+
+#: lib/blame.tcl:1075
+msgid "Cannot find parent commit:"
+msgstr "N=C3=A3o =C3=A9 poss=C3=ADvel encontrar commit pai:"
+
+#: lib/blame.tcl:1090
+msgid "Unable to display parent"
+msgstr "N=C3=A3o =C3=A9 poss=C3=ADvel mostrar pai"
+
+#: lib/blame.tcl:1091 lib/diff.tcl:320
+msgid "Error loading diff:"
+msgstr "Erro ao carregar diferen=C3=A7as:"
+
+#: lib/blame.tcl:1231
+msgid "Originally By:"
+msgstr "Originalmente por:"
+
+#: lib/blame.tcl:1237
+msgid "In File:"
+msgstr "No ficheiro:"
+
+#: lib/blame.tcl:1242
+msgid "Copied Or Moved Here By:"
+msgstr "Copiado ou Movido para aqui por:"
+
+#: lib/branch_checkout.tcl:14 lib/branch_checkout.tcl:19
+msgid "Checkout Branch"
+msgstr "Extrair ramo"
+
+#: lib/branch_checkout.tcl:23
+msgid "Checkout"
+msgstr "Extrair"
+
+#: lib/branch_checkout.tcl:27 lib/branch_create.tcl:35
+#: lib/branch_delete.tcl:32 lib/branch_rename.tcl:30 lib/browser.tcl:2=
82
+#: lib/checkout_op.tcl:579 lib/choose_font.tcl:43 lib/merge.tcl:172
+#: lib/option.tcl:125 lib/remote_add.tcl:32 lib/remote_branch_delete.t=
cl:42
+#: lib/tools_dlg.tcl:40 lib/tools_dlg.tcl:204 lib/tools_dlg.tcl:352
+#: lib/transport.tcl:108
+msgid "Cancel"
+msgstr "Cancelar"
+
+#: lib/branch_checkout.tcl:32 lib/browser.tcl:287 lib/tools_dlg.tcl:32=
8
+msgid "Revision"
+msgstr "Revis=C3=A3o"
+
+#: lib/branch_checkout.tcl:36 lib/branch_create.tcl:69 lib/option.tcl:=
280
+msgid "Options"
+msgstr "Op=C3=A7=C3=B5es"
+
+#: lib/branch_checkout.tcl:39 lib/branch_create.tcl:92
+msgid "Fetch Tracking Branch"
+msgstr "Obter ramo de monitoriza=C3=A7=C3=A3o"
+
+#: lib/branch_checkout.tcl:44
+msgid "Detach From Local Branch"
+msgstr "Destacar do ramo local"
+
+#: lib/branch_create.tcl:22
+msgid "Create Branch"
+msgstr "Criar ramo"
+
+#: lib/branch_create.tcl:27
+msgid "Create New Branch"
+msgstr "Cria novo ramo"
+
+#: lib/branch_create.tcl:31 lib/choose_repository.tcl:381
+msgid "Create"
+msgstr "Criar"
+
+#: lib/branch_create.tcl:40
+msgid "Branch Name"
+msgstr "Nome do ramo"
+
+#: lib/branch_create.tcl:43 lib/remote_add.tcl:39 lib/tools_dlg.tcl:50
+msgid "Name:"
+msgstr "Nome:"
+
+#: lib/branch_create.tcl:58
+msgid "Match Tracking Branch Name"
+msgstr "Corresponder ao nome do ramo de monitoriza=C3=A7=C3=A3o"
+
+#: lib/branch_create.tcl:66
+msgid "Starting Revision"
+msgstr "Revis=C3=A3o inicial"
+
+#: lib/branch_create.tcl:72
+msgid "Update Existing Branch:"
+msgstr "Atualizar ramo existente:"
+
+#: lib/branch_create.tcl:75
+msgid "No"
+msgstr "N=C3=A3o"
+
+#: lib/branch_create.tcl:80
+msgid "Fast Forward Only"
+msgstr "Apenas avan=C3=A7o r=C3=A1pido (fast-forward)"
+
+#: lib/branch_create.tcl:85 lib/checkout_op.tcl:571
+msgid "Reset"
+msgstr "Repor"
+
+#: lib/branch_create.tcl:97
+msgid "Checkout After Creation"
+msgstr "Extrair depois de criar"
+
+#: lib/branch_create.tcl:131
+msgid "Please select a tracking branch."
+msgstr "Selecione um ramo de monitoriza=C3=A7=C3=A3o."
+
+#: lib/branch_create.tcl:140
+#, tcl-format
+msgid "Tracking branch %s is not a branch in the remote repository."
+msgstr "O ramo de monitoriza=C3=A7=C3=A3o %s n=C3=A3o =C3=A9 um ramo n=
o reposit=C3=B3rio remoto."
+
+#: lib/branch_create.tcl:153 lib/branch_rename.tcl:86
+msgid "Please supply a branch name."
+msgstr "Indique um nome para o ramo."
+
+#: lib/branch_create.tcl:164 lib/branch_rename.tcl:106
+#, tcl-format
+msgid "'%s' is not an acceptable branch name."
+msgstr "'%s' n=C3=A3o pode ser aceite como nome de ramo."
+
+#: lib/branch_delete.tcl:15
+msgid "Delete Branch"
+msgstr "Eliminar ramo"
+
+#: lib/branch_delete.tcl:20
+msgid "Delete Local Branch"
+msgstr "Eliminar ramo local"
+
+#: lib/branch_delete.tcl:37
+msgid "Local Branches"
+msgstr "Ramos locais"
+
+#: lib/branch_delete.tcl:52
+msgid "Delete Only If Merged Into"
+msgstr "Eliminar s=C3=B3 se foi integrado"
+
+#: lib/branch_delete.tcl:54 lib/remote_branch_delete.tcl:119
+msgid "Always (Do not perform merge checks)"
+msgstr "Sempre (n=C3=A3o realizar verifica=C3=A7=C3=A3o de integra=C3=A7=
=C3=A3o)"
+
+#: lib/branch_delete.tcl:103
+#, tcl-format
+msgid "The following branches are not completely merged into %s:"
+msgstr "Os seguintes ramo n=C3=A3o foram completamente integrados em %=
s:"
+
+#: lib/branch_delete.tcl:115 lib/remote_branch_delete.tcl:217
+msgid ""
+"Recovering deleted branches is difficult.\n"
+"\n"
+"Delete the selected branches?"
+msgstr ""
+"Recuperar ramos eliminados =C3=A9 dif=C3=ADcil.\n"
+"\n"
+"Eliminar os ramos selecionado?"
+
+#: lib/branch_delete.tcl:141
+#, tcl-format
+msgid ""
+"Failed to delete branches:\n"
+"%s"
+msgstr ""
+"Falha ao eliminar ramos:\n"
+"%s"
+
+#: lib/branch_rename.tcl:14 lib/branch_rename.tcl:22
+msgid "Rename Branch"
+msgstr "Mudar nome de ramo"
+
+#: lib/branch_rename.tcl:26
+msgid "Rename"
+msgstr "Mudar nome"
+
+#: lib/branch_rename.tcl:36
+msgid "Branch:"
+msgstr "Ramo:"
+
+#: lib/branch_rename.tcl:39
+msgid "New Name:"
+msgstr "Novo nome:"
+
+#: lib/branch_rename.tcl:75
+msgid "Please select a branch to rename."
+msgstr "Selecione um ramo para mudar de nome."
+
+#: lib/branch_rename.tcl:96 lib/checkout_op.tcl:202
+#, tcl-format
+msgid "Branch '%s' already exists."
+msgstr "O ramo '%s' j=C3=A1 existe."
+
+#: lib/branch_rename.tcl:117
+#, tcl-format
+msgid "Failed to rename '%s'."
+msgstr "Falha ao mudar o nome de '%s'."
+
+#: lib/browser.tcl:17
+msgid "Starting..."
+msgstr "A iniciar..."
+
+#: lib/browser.tcl:26
+msgid "File Browser"
+msgstr "Navegador de ficheiros"
+
+#: lib/browser.tcl:126 lib/browser.tcl:143
+#, tcl-format
+msgid "Loading %s..."
+msgstr "A carregar %s..."
+
+#: lib/browser.tcl:187
+msgid "[Up To Parent]"
+msgstr "[Subir]"
+
+#: lib/browser.tcl:267 lib/browser.tcl:273
+msgid "Browse Branch Files"
+msgstr "Navegar pelos ficheiros do ramo"
+
+#: lib/browser.tcl:278 lib/choose_repository.tcl:398
+#: lib/choose_repository.tcl:486 lib/choose_repository.tcl:497
+#: lib/choose_repository.tcl:1028
+msgid "Browse"
+msgstr "Navegar"
+
+#: lib/checkout_op.tcl:85
+#, tcl-format
+msgid "Fetching %s from %s"
+msgstr "A obter %s de %s"
+
+#: lib/checkout_op.tcl:133
+#, tcl-format
+msgid "fatal: Cannot resolve %s"
+msgstr "fatal: N=C3=A3o =C3=A9 poss=C3=ADvel resolver %s"
+
+#: lib/checkout_op.tcl:146 lib/console.tcl:81 lib/database.tcl:31
+#: lib/sshkey.tcl:53
+msgid "Close"
+msgstr "Fechar"
+
+#: lib/checkout_op.tcl:175
+#, tcl-format
+msgid "Branch '%s' does not exist."
+msgstr "O ramo '%s' n=C3=A3o existe."
+
+#: lib/checkout_op.tcl:194
+#, tcl-format
+msgid "Failed to configure simplified git-pull for '%s'."
+msgstr "Falha ao configurar git-pull simplificado de '%s'."
+
+#: lib/checkout_op.tcl:229
+#, tcl-format
+msgid ""
+"Branch '%s' already exists.\n"
+"\n"
+"It cannot fast-forward to %s.\n"
+"A merge is required."
+msgstr ""
+"O ramo '%s' j=C3=A1 existe.\n"
+"\n"
+"N=C3=A3o pode ser avan=C3=A7ado rapidamente para %s.\n"
+"Integra=C3=A7=C3=A3o necess=C3=A1ria."
+
+#: lib/checkout_op.tcl:243
+#, tcl-format
+msgid "Merge strategy '%s' not supported."
+msgstr "A estrat=C3=A9gia de integra=C3=A7=C3=A3o '%s' n=C3=A3o =C3=A9=
 suportada."
+
+#: lib/checkout_op.tcl:262
+#, tcl-format
+msgid "Failed to update '%s'."
+msgstr "Falha ao atualizar '%s'."
+
+#: lib/checkout_op.tcl:274
+msgid "Staging area (index) is already locked."
+msgstr "A =C3=A1rea de est=C3=A1gio (=C3=ADndice) j=C3=A1 est=C3=A1 bl=
oqueada."
+
+#: lib/checkout_op.tcl:289
+msgid ""
+"Last scanned state does not match repository state.\n"
+"\n"
+"Another Git program has modified this repository since the last scan.=
  A "
+"rescan must be performed before the current branch can be changed.\n"
+"\n"
+"The rescan will be automatically started now.\n"
+msgstr ""
+"O =C3=BAltimo estado analisado n=C3=A3o corresponde ao estado do repo=
sit=C3=B3rio.\n"
+"\n"
+"Outro programa Git modificou este reposit=C3=B3rio deste a =C3=BAltim=
a an=C3=A1lise. Deve-"
+"se reanalisar antes do ramo atual poder ser alterado.\n"
+"\n"
+"Ir=C3=A1-se reanalisar automaticamente agora.\n"
+
+#: lib/checkout_op.tcl:345
+#, tcl-format
+msgid "Updating working directory to '%s'..."
+msgstr "A atualizar o diret=C3=B3rio de trabalho para '%s'..."
+
+#: lib/checkout_op.tcl:346
+msgid "files checked out"
+msgstr "ficheiros extra=C3=ADdos"
+
+#: lib/checkout_op.tcl:376
+#, tcl-format
+msgid "Aborted checkout of '%s' (file level merging is required)."
+msgstr ""
+"Extra=C3=A7=C3=A3o de '%s' abortada (=C3=A9 necess=C3=A1rio integrar =
ao n=C3=ADvel de ficheiros)."
+
+#: lib/checkout_op.tcl:377
+msgid "File level merge required."
+msgstr "Integra=C3=A7=C3=A3o ao n=C3=ADvel de ficheiros necess=C3=A1ri=
a."
+
+#: lib/checkout_op.tcl:381
+#, tcl-format
+msgid "Staying on branch '%s'."
+msgstr "Permanecer no ramo '%s'."
+
+#: lib/checkout_op.tcl:452
+msgid ""
+"You are no longer on a local branch.\n"
+"\n"
+"If you wanted to be on a branch, create one now starting from 'This D=
etached "
+"Checkout'."
+msgstr ""
+"J=C3=A1 n=C3=A3o se encontra num ramo local.\n"
+"\n"
+"Se queria estar sobre um ramo, crie um a partir de 'Esta extra=C3=A7=C3=
=A3o destacada'."
+
+#: lib/checkout_op.tcl:503 lib/checkout_op.tcl:507
+#, tcl-format
+msgid "Checked out '%s'."
+msgstr "'%s' extra=C3=ADdo."
+
+#: lib/checkout_op.tcl:535
+#, tcl-format
+msgid "Resetting '%s' to '%s' will lose the following commits:"
+msgstr "Ao repor '%s' para '%s' perder=C3=A1 os seguintes commits:"
+
+#: lib/checkout_op.tcl:557
+msgid "Recovering lost commits may not be easy."
+msgstr "Recuperar commits perdidos pode n=C3=A3o ser f=C3=A1cil."
+
+#: lib/checkout_op.tcl:562
+#, tcl-format
+msgid "Reset '%s'?"
+msgstr "Repor '%s'?"
+
+#: lib/checkout_op.tcl:567 lib/merge.tcl:164 lib/tools_dlg.tcl:343
+msgid "Visualize"
+msgstr "Visualizar"
+
+#: lib/checkout_op.tcl:635
+#, tcl-format
+msgid ""
+"Failed to set current branch.\n"
+"\n"
+"This working directory is only partially switched.  We successfully u=
pdated "
+"your files, but failed to update an internal Git file.\n"
+"\n"
+"This should not have occurred.  %s will now close and give up."
+msgstr ""
+"Falha ao definir ramo atual.\n"
+"\n"
+"Apenas se mudou o diret=C3=B3rio de trabalho parcialmente. Os ficheir=
os foram "
+"atualizados com sucesso, mas n=C3=A3o foi poss=C3=ADvel atualizar o f=
icheiro Git "
+"interno.\n"
+"\n"
+"N=C3=A3o devia ter ocorrido. %s ir=C3=A1 terminar e desistir."
+
+#: lib/choose_font.tcl:39
+msgid "Select"
+msgstr "Selecionar"
+
+#: lib/choose_font.tcl:53
+msgid "Font Family"
+msgstr "Fam=C3=ADlia de tipo de letra"
+
+#: lib/choose_font.tcl:74
+msgid "Font Size"
+msgstr "Tamanho de letra"
+
+#: lib/choose_font.tcl:91
+msgid "Font Example"
+msgstr "Exemplo do tipo de letra"
+
+#: lib/choose_font.tcl:103
+msgid ""
+"This is example text.\n"
+"If you like this text, it can be your font."
+msgstr ""
+"Este texto =C3=A9 um exemplo.\n"
+"Se gostar deste texto, pode defini-lo como tipo de letra."
+
+#: lib/choose_repository.tcl:28
+msgid "Git Gui"
+msgstr "Git Gui"
+
+#: lib/choose_repository.tcl:87 lib/choose_repository.tcl:386
+msgid "Create New Repository"
+msgstr "Criar novo reposit=C3=B3rio"
+
+#: lib/choose_repository.tcl:93
+msgid "New..."
+msgstr "Novo..."
+
+#: lib/choose_repository.tcl:100 lib/choose_repository.tcl:471
+msgid "Clone Existing Repository"
+msgstr "Clonar reposit=C3=B3rio existente"
+
+#: lib/choose_repository.tcl:106
+msgid "Clone..."
+msgstr "Clonar..."
+
+#: lib/choose_repository.tcl:113 lib/choose_repository.tcl:1016
+msgid "Open Existing Repository"
+msgstr "Abrir reposit=C3=B3rio existente"
+
+#: lib/choose_repository.tcl:119
+msgid "Open..."
+msgstr "Abrir..."
+
+#: lib/choose_repository.tcl:132
+msgid "Recent Repositories"
+msgstr "Reposit=C3=B3rios recentes"
+
+#: lib/choose_repository.tcl:138
+msgid "Open Recent Repository:"
+msgstr "Abrir reposit=C3=B3rio recente:"
+
+#: lib/choose_repository.tcl:306 lib/choose_repository.tcl:313
+#: lib/choose_repository.tcl:320
+#, tcl-format
+msgid "Failed to create repository %s:"
+msgstr "Falha ao criar o reposit=C3=B3rio %s:"
+
+#: lib/choose_repository.tcl:391
+msgid "Directory:"
+msgstr "Diret=C3=B3rio:"
+
+#: lib/choose_repository.tcl:423 lib/choose_repository.tcl:550
+#: lib/choose_repository.tcl:1052
+msgid "Git Repository"
+msgstr "Reposit=C3=B3rio Git"
+
+#: lib/choose_repository.tcl:448
+#, tcl-format
+msgid "Directory %s already exists."
+msgstr "O diret=C3=B3rio %s j=C3=A1 existe."
+
+#: lib/choose_repository.tcl:452
+#, tcl-format
+msgid "File %s already exists."
+msgstr "O ficheiro %s j=C3=A1 existe."
+
+#: lib/choose_repository.tcl:466
+msgid "Clone"
+msgstr "Clonar"
+
+#: lib/choose_repository.tcl:479
+msgid "Source Location:"
+msgstr "Localiza=C3=A7=C3=A3o de origem:"
+
+#: lib/choose_repository.tcl:490
+msgid "Target Directory:"
+msgstr "Diret=C3=B3rio de destino:"
+
+#: lib/choose_repository.tcl:502
+msgid "Clone Type:"
+msgstr "Tipo de clone:"
+
+#: lib/choose_repository.tcl:508
+msgid "Standard (Fast, Semi-Redundant, Hardlinks)"
+msgstr "Padr=C3=A3o (r=C3=A1pido, semi-redundante, liga=C3=A7=C3=B5es =
fixas)"
+
+#: lib/choose_repository.tcl:514
+msgid "Full Copy (Slower, Redundant Backup)"
+msgstr "C=C3=B3pia Total (lento, c=C3=B3pia de seguran=C3=A7a redundan=
te)"
+
+#: lib/choose_repository.tcl:520
+msgid "Shared (Fastest, Not Recommended, No Backup)"
+msgstr "Partilhado (mais r=C3=A1pido, n=C3=A3o recomendado, sem c=C3=B3=
pia)"
+
+#: lib/choose_repository.tcl:556 lib/choose_repository.tcl:603
+#: lib/choose_repository.tcl:749 lib/choose_repository.tcl:819
+#: lib/choose_repository.tcl:1058 lib/choose_repository.tcl:1066
+#, tcl-format
+msgid "Not a Git repository: %s"
+msgstr "N=C3=A3o =C3=A9 um reposit=C3=B3rio Git: %s"
+
+#: lib/choose_repository.tcl:592
+msgid "Standard only available for local repository."
+msgstr "Padr=C3=A3o s=C3=B3 dispon=C3=ADvel em reposit=C3=B3rios locai=
s."
+
+#: lib/choose_repository.tcl:596
+msgid "Shared only available for local repository."
+msgstr "Partilhado s=C3=B3 dispon=C3=ADvel em reposit=C3=B3rios locais=
=2E"
+
+#: lib/choose_repository.tcl:617
+#, tcl-format
+msgid "Location %s already exists."
+msgstr "A localiza=C3=A7=C3=A3o %s j=C3=A1 existe."
+
+#: lib/choose_repository.tcl:628
+msgid "Failed to configure origin"
+msgstr "Falha ao configurar origem"
+
+#: lib/choose_repository.tcl:640
+msgid "Counting objects"
+msgstr "A contar objetos"
+
+#: lib/choose_repository.tcl:641
+msgid "buckets"
+msgstr "baldes"
+
+#: lib/choose_repository.tcl:665
+#, tcl-format
+msgid "Unable to copy objects/info/alternates: %s"
+msgstr "N=C3=A3o =C3=A9 poss=C3=ADvel copiar objects/info/alternates: =
%s"
+
+#: lib/choose_repository.tcl:701
+#, tcl-format
+msgid "Nothing to clone from %s."
+msgstr "Nada para clonar de %s."
+
+#: lib/choose_repository.tcl:703 lib/choose_repository.tcl:917
+#: lib/choose_repository.tcl:929
+msgid "The 'master' branch has not been initialized."
+msgstr "O ramo 'master' n=C3=A3o foi inicializado."
+
+#: lib/choose_repository.tcl:716
+msgid "Hardlinks are unavailable.  Falling back to copying."
+msgstr "Liga=C3=A7=C3=B5es fixas indispon=C3=ADveis. A recorrer a c=C3=
=B3pia."
+
+#: lib/choose_repository.tcl:728
+#, tcl-format
+msgid "Cloning from %s"
+msgstr "A clonar de %s"
+
+#: lib/choose_repository.tcl:759
+msgid "Copying objects"
+msgstr "A copiar objetos"
+
+#: lib/choose_repository.tcl:760
+msgid "KiB"
+msgstr "KiB"
+
+#: lib/choose_repository.tcl:784
+#, tcl-format
+msgid "Unable to copy object: %s"
+msgstr "N=C3=A3o =C3=A9 poss=C3=ADvel copiar objeto: %s"
+
+#: lib/choose_repository.tcl:794
+msgid "Linking objects"
+msgstr "A ligar objetos"
+
+#: lib/choose_repository.tcl:795
+msgid "objects"
+msgstr "objetos"
+
+#: lib/choose_repository.tcl:803
+#, tcl-format
+msgid "Unable to hardlink object: %s"
+msgstr "N=C3=A3o =C3=A9 poss=C3=ADvel criar liga=C3=A7=C3=A3o fixa de =
objeto: %s"
+
+#: lib/choose_repository.tcl:858
+msgid "Cannot fetch branches and objects.  See console output for deta=
ils."
+msgstr ""
+"N=C3=A3o =C3=A9 poss=C3=ADvel obter ramos e objetos. Ver sa=C3=ADda n=
a consola para detalhes."
+
+#: lib/choose_repository.tcl:869
+msgid "Cannot fetch tags.  See console output for details."
+msgstr "N=C3=A3o =C3=A9 poss=C3=ADvel obter tags. Ver sa=C3=ADda na co=
nsola para detalhes."
+
+#: lib/choose_repository.tcl:893
+msgid "Cannot determine HEAD.  See console output for details."
+msgstr "N=C3=A3o =C3=A9 poss=C3=ADvel determinar HEAD. Ver sa=C3=ADda =
na consola para detalhes."
+
+#: lib/choose_repository.tcl:902
+#, tcl-format
+msgid "Unable to cleanup %s"
+msgstr "N=C3=A3o foi poss=C3=ADvel limpar %s"
+
+#: lib/choose_repository.tcl:908
+msgid "Clone failed."
+msgstr "Falha ao clonar."
+
+#: lib/choose_repository.tcl:915
+msgid "No default branch obtained."
+msgstr "N=C3=A3o foi obtido nenhum ramo predefinido."
+
+#: lib/choose_repository.tcl:926
+#, tcl-format
+msgid "Cannot resolve %s as a commit."
+msgstr "N=C3=A3o =C3=A9 poss=C3=ADvel resolver %s como um commit."
+
+#: lib/choose_repository.tcl:938
+msgid "Creating working directory"
+msgstr "A criar diret=C3=B3rio de trabalho"
+
+#: lib/choose_repository.tcl:939 lib/index.tcl:67 lib/index.tcl:130
+#: lib/index.tcl:198
+msgid "files"
+msgstr "ficheiros"
+
+#: lib/choose_repository.tcl:968
+msgid "Initial file checkout failed."
+msgstr "Falha de extra=C3=A7=C3=A3o inicial de ficheiro."
+
+#: lib/choose_repository.tcl:1011
+msgid "Open"
+msgstr "Abrir"
+
+#: lib/choose_repository.tcl:1021
+msgid "Repository:"
+msgstr "Reposit=C3=B3rio:"
+
+#: lib/choose_repository.tcl:1072
+#, tcl-format
+msgid "Failed to open repository %s:"
+msgstr "Falha ao abrir o reposit=C3=B3rio %s:"
+
+#: lib/choose_rev.tcl:53
+msgid "This Detached Checkout"
+msgstr "Esta extra=C3=A7=C3=A3o destacada"
+
+#: lib/choose_rev.tcl:60
+msgid "Revision Expression:"
+msgstr "Express=C3=A3o de revis=C3=A3o:"
+
+#: lib/choose_rev.tcl:74
+msgid "Local Branch"
+msgstr "Ramo local"
+
+#: lib/choose_rev.tcl:79
+msgid "Tracking Branch"
+msgstr "Ramo de monitoriza=C3=A7=C3=A3o"
+
+#: lib/choose_rev.tcl:84 lib/choose_rev.tcl:538
+msgid "Tag"
+msgstr "Tag"
+
+#: lib/choose_rev.tcl:317
+#, tcl-format
+msgid "Invalid revision: %s"
+msgstr "Revis=C3=A3o inv=C3=A1lida: %s"
+
+#: lib/choose_rev.tcl:338
+msgid "No revision selected."
+msgstr "Nenhum revis=C3=A3o selecionada."
+
+#: lib/choose_rev.tcl:346
+msgid "Revision expression is empty."
+msgstr "A express=C3=A3o de revis=C3=A3o est=C3=A1 vazia."
+
+#: lib/choose_rev.tcl:531
+msgid "Updated"
+msgstr "Atualizado"
+
+#: lib/choose_rev.tcl:559
+msgid "URL"
+msgstr "URL"
+
+#: lib/commit.tcl:9
+msgid ""
+"There is nothing to amend.\n"
+"\n"
+"You are about to create the initial commit.  There is no commit befor=
e this "
+"to amend.\n"
+msgstr ""
+"N=C3=A3o h=C3=A1 nada para emendar.\n"
+"\n"
+"Est=C3=A1 prestes a criar o commit inicial. N=C3=A3o h=C3=A1 nenhum c=
ommit antes deste para "
+"emendar.\n"
+
+#: lib/commit.tcl:18
+msgid ""
+"Cannot amend while merging.\n"
+"\n"
+"You are currently in the middle of a merge that has not been fully "
+"completed.  You cannot amend the prior commit unless you first abort =
the "
+"current merge activity.\n"
+msgstr ""
+"N=C3=A3o =C3=A9 poss=C3=ADvel emendar ao mesmo tempo que se integra.\=
n"
+"\n"
+"H=C3=A1 uma integra=C3=A7=C3=A3o em curso que n=C3=A3o foi conclu=C3=AD=
da. N=C3=A3o pode emendar o commit "
+"anterior a n=C3=A3o ser que primeiro aborte a atividade da integra=C3=
=A7=C3=A3o atual.\n"
+
+#: lib/commit.tcl:48
+msgid "Error loading commit data for amend:"
+msgstr "Erro ao carregar dados do commit para emendar:"
+
+#: lib/commit.tcl:75
+msgid "Unable to obtain your identity:"
+msgstr "N=C3=A3o =C3=A9 poss=C3=ADvel obter a sua identidade:"
+
+#: lib/commit.tcl:80
+msgid "Invalid GIT_COMMITTER_IDENT:"
+msgstr "GIT_COMMITTER_IDENT inv=C3=A1lido:"
+
+#: lib/commit.tcl:129
+#, tcl-format
+msgid "warning: Tcl does not support encoding '%s'."
+msgstr "aviso: Tcl n=C3=A3o suporta a codifica=C3=A7=C3=A3o '%s'."
+
+#: lib/commit.tcl:149
+msgid ""
+"Last scanned state does not match repository state.\n"
+"\n"
+"Another Git program has modified this repository since the last scan.=
  A "
+"rescan must be performed before another commit can be created.\n"
+"\n"
+"The rescan will be automatically started now.\n"
+msgstr ""
+"O =C3=BAltimo estado analisado n=C3=A3o corresponde ao estado do repo=
sit=C3=B3rio.\n"
+"\n"
+"Outro programa Git modificou este reposit=C3=B3rio deste a =C3=BAltim=
a an=C3=A1lise. Deve-"
+"se reanalisar antes que se possa criar outro commit.\n"
+"\n"
+"Ir=C3=A1-se reanalisar automaticamente agora.\n"
+
+#: lib/commit.tcl:172
+#, tcl-format
+msgid ""
+"Unmerged files cannot be committed.\n"
+"\n"
+"File %s has merge conflicts.  You must resolve them and stage the fil=
e "
+"before committing.\n"
+msgstr ""
+"N=C3=A3o pode fazer commit de ficheiros n=C3=A3o integrados.\n"
+"\n"
+"O ficheiro %s tem conflitos de integra=C3=A7=C3=A3o. Deve resolv=C3=AA=
-los e preparar o "
+"ficheiro antes de fazer commit.\n"
+
+#: lib/commit.tcl:180
+#, tcl-format
+msgid ""
+"Unknown file state %s detected.\n"
+"\n"
+"File %s cannot be committed by this program.\n"
+msgstr ""
+"Estado de ficheiro desconhecido %s detetado.\n"
+"\n"
+"Este programa n=C3=A3o pode fazer commit do ficheiro %s.\n"
+
+#: lib/commit.tcl:188
+msgid ""
+"No changes to commit.\n"
+"\n"
+"You must stage at least 1 file before you can commit.\n"
+msgstr ""
+"Nenhum altera=C3=A7=C3=A3o para fazer commit.\n"
+"\n"
+"Deve preparar pelo menos 1 ficheiro antes de fazer commit.\n"
+
+#: lib/commit.tcl:203
+msgid ""
+"Please supply a commit message.\n"
+"\n"
+"A good commit message has the following format:\n"
+"\n"
+"- First line: Describe in one sentence what you did.\n"
+"- Second line: Blank\n"
+"- Remaining lines: Describe why this change is good.\n"
+msgstr ""
+"Forne=C3=A7a uma mensagem de commit.\n"
+"\n"
+"Um boa mensagem de commit tem o seguinte formato:\n"
+"\n"
+"- Primeira linha: descreve numa frase o que fez.\n"
+"- Segunda linha: em branco.\n"
+"- Linhas restantes: descreve porque esta altera=C3=A7=C3=A3o =C3=A9 v=
antajosa.\n"
+
+#: lib/commit.tcl:234
+msgid "Calling pre-commit hook..."
+msgstr "A invocar gancho de pr=C3=A9-commit (pre-commit hook)..."
+
+#: lib/commit.tcl:249
+msgid "Commit declined by pre-commit hook."
+msgstr "Commit recusado pela retina de pr=C3=A9-commit (pre-commit hoo=
k)."
+
+#: lib/commit.tcl:272
+msgid "Calling commit-msg hook..."
+msgstr "A invocar gancho de mensagem-de-commit (commit-msg hook)..."
+
+#: lib/commit.tcl:287
+msgid "Commit declined by commit-msg hook."
+msgstr "Commit recusado pelo gancho de mensagem-de-commit (commit-msg =
hook)."
+
+#: lib/commit.tcl:300
+msgid "Committing changes..."
+msgstr "A fazer commit das altera=C3=A7=C3=B5es..."
+
+#: lib/commit.tcl:316
+msgid "write-tree failed:"
+msgstr "write-tree falhou:"
+
+#: lib/commit.tcl:317 lib/commit.tcl:361 lib/commit.tcl:382
+msgid "Commit failed."
+msgstr "Falha ao fazer commit."
+
+#: lib/commit.tcl:334
+#, tcl-format
+msgid "Commit %s appears to be corrupt"
+msgstr "O commit %s parece estar corrompido"
+
+#: lib/commit.tcl:339
+msgid ""
+"No changes to commit.\n"
+"\n"
+"No files were modified by this commit and it was not a merge commit.\=
n"
+"\n"
+"A rescan will be automatically started now.\n"
+msgstr ""
+"N=C3=A3o h=C3=A1 altera=C3=A7=C3=B5es para fazer commit.\n"
+"\n"
+"Nenhum ficheiro foi modificado por este commit e n=C3=A3o era um comm=
it de "
+"integra=C3=A7=C3=A3o.\n"
+"\n"
+"Ir=C3=A1-se reanalisar agora automaticamente.\n"
+
+#: lib/commit.tcl:346
+msgid "No changes to commit."
+msgstr "N=C3=A3o h=C3=A1 altera=C3=A7=C3=B5es para fazer commit."
+
+#: lib/commit.tcl:360
+msgid "commit-tree failed:"
+msgstr "commit-tree falhou:"
+
+#: lib/commit.tcl:381
+msgid "update-ref failed:"
+msgstr "update-ref falhou:"
+
+#: lib/commit.tcl:469
+#, tcl-format
+msgid "Created commit %s: %s"
+msgstr "Commit %s criado: %s"
+
+#: lib/console.tcl:59
+msgid "Working... please wait..."
+msgstr "A processar... aguarde..."
+
+#: lib/console.tcl:186
+msgid "Success"
+msgstr "Sucesso"
+
+#: lib/console.tcl:200
+msgid "Error: Command Failed"
+msgstr "Erro: falha ao executar comando"
+
+#: lib/database.tcl:43
+msgid "Number of loose objects"
+msgstr "N=C3=BAmero de objetos soltos"
+
+#: lib/database.tcl:44
+msgid "Disk space used by loose objects"
+msgstr "Espa=C3=A7o em disco usados por objetos soltos"
+
+#: lib/database.tcl:45
+msgid "Number of packed objects"
+msgstr "N=C3=BAmero de objetos compactados"
+
+#: lib/database.tcl:46
+msgid "Number of packs"
+msgstr "N=C3=BAmeros de pacotes"
+
+#: lib/database.tcl:47
+msgid "Disk space used by packed objects"
+msgstr "Espa=C3=A7o em disco usado por objetos compactados"
+
+#: lib/database.tcl:48
+msgid "Packed objects waiting for pruning"
+msgstr "Objetos compactados =C3=A0 espera de poda"
+
+#: lib/database.tcl:49
+msgid "Garbage files"
+msgstr "Ficheiros de lixo"
+
+#: lib/database.tcl:72
+msgid "Compressing the object database"
+msgstr "A comprimir a base de dados de objetos"
+
+#: lib/database.tcl:83
+msgid "Verifying the object database with fsck-objects"
+msgstr "A verificar a base de dados de objetos com fsck-objects"
+
+#: lib/database.tcl:107
+#, tcl-format
+msgid ""
+"This repository currently has approximately %i loose objects.\n"
+"\n"
+"To maintain optimal performance it is strongly recommended that you c=
ompress "
+"the database.\n"
+"\n"
+"Compress the database now?"
+msgstr ""
+"Este reposit=C3=B3rio tem aproximadamente %i objetos soltos.\n"
+"\n"
+"Para manter o desempenho =C3=B3timo =C3=A9 veemente recomendado que c=
omprima a base de "
+"dados.\n"
+"\n"
+"Comprimir a base de dados agora?"
+
+#: lib/date.tcl:25
+#, tcl-format
+msgid "Invalid date from Git: %s"
+msgstr "Data do Git inv=C3=A1lida: %s"
+
+#: lib/diff.tcl:64
+#, tcl-format
+msgid ""
+"No differences detected.\n"
+"\n"
+"%s has no changes.\n"
+"\n"
+"The modification date of this file was updated by another application=
, but "
+"the content within the file was not changed.\n"
+"\n"
+"A rescan will be automatically started to find other files which may =
have "
+"the same state."
+msgstr ""
+"Nenhum diferen=C3=A7a detetada.\n"
+"\n"
+"%s n=C3=A3o tem altera=C3=A7=C3=B5es.\n"
+"\n"
+"A data de modifica=C3=A7=C3=A3o deste ficheiro foi atualizada por out=
ra aplica=C3=A7=C3=A3o, mas "
+"o conte=C3=BAdo no interior do ficheiro n=C3=A3o foi alterado.\n"
+"\n"
+"Ir=C3=A1-se reanalisar automaticamente para encontrar outros ficheiro=
s que "
+"estejam no mesmo estado."
+
+#: lib/diff.tcl:104
+#, tcl-format
+msgid "Loading diff of %s..."
+msgstr "A carregar diferen=C3=A7as de %s..."
+
+#: lib/diff.tcl:125
+msgid ""
+"LOCAL: deleted\n"
+"REMOTE:\n"
+msgstr ""
+"LOCAL: eliminado\n"
+"REMOTO:\n"
+
+#: lib/diff.tcl:130
+msgid ""
+"REMOTE: deleted\n"
+"LOCAL:\n"
+msgstr ""
+"REMOTO: eliminado\n"
+"LOCAL:\n"
+
+#: lib/diff.tcl:137
+msgid "LOCAL:\n"
+msgstr "LOCAL:\n"
+
+#: lib/diff.tcl:140
+msgid "REMOTE:\n"
+msgstr "REMOTO:\n"
+
+#: lib/diff.tcl:202 lib/diff.tcl:319
+#, tcl-format
+msgid "Unable to display %s"
+msgstr "N=C3=A3o =C3=A9 poss=C3=ADvel mostrar %s"
+
+#: lib/diff.tcl:203
+msgid "Error loading file:"
+msgstr "Erro ao carregar ficheiro:"
+
+#: lib/diff.tcl:210
+msgid "Git Repository (subproject)"
+msgstr "Reposit=C3=B3rio Git (subprojeto)"
+
+#: lib/diff.tcl:222
+msgid "* Binary file (not showing content)."
+msgstr "* Ficheiro bin=C3=A1rio (conte=C3=BAdo n=C3=A3o exibido)."
+
+#: lib/diff.tcl:227
+#, tcl-format
+msgid ""
+"* Untracked file is %d bytes.\n"
+"* Showing only first %d bytes.\n"
+msgstr ""
+"* O ficheiro n=C3=A3o controlado tem %d bytes.\n"
+"* Exibido apenas os primeiros %d bytes.\n"
+
+#: lib/diff.tcl:233
+#, tcl-format
+msgid ""
+"\n"
+"* Untracked file clipped here by %s.\n"
+"* To see the entire file, use an external editor.\n"
+msgstr ""
+"\n"
+"* Ficheiro n=C3=A3o controlado recortado aqui por %s.\n"
+"* Para ver o ficheiro inteiro, use um editor externo.\n"
+
+#: lib/diff.tcl:482
+msgid "Failed to unstage selected hunk."
+msgstr "Falha ao retirar excerto selecionado do =C3=ADndice."
+
+#: lib/diff.tcl:489
+msgid "Failed to stage selected hunk."
+msgstr "Falha ao preparar excerto selecionado."
+
+#: lib/diff.tcl:568
+msgid "Failed to unstage selected line."
+msgstr "Falha ao retirar linha selecionada do =C3=ADndice."
+
+#: lib/diff.tcl:576
+msgid "Failed to stage selected line."
+msgstr "Falha ao preparar linha selecionada."
+
+#: lib/encoding.tcl:443
+msgid "Default"
+msgstr "Predefini=C3=A7=C3=A3o"
+
+#: lib/encoding.tcl:448
+#, tcl-format
+msgid "System (%s)"
+msgstr "Sistema (%s)"
+
+#: lib/encoding.tcl:459 lib/encoding.tcl:465
+msgid "Other"
+msgstr "Outro"
+
+#: lib/error.tcl:20 lib/error.tcl:114
+msgid "error"
+msgstr "erro"
+
+#: lib/error.tcl:36
+msgid "warning"
+msgstr "aviso"
+
+#: lib/error.tcl:94
+msgid "You must correct the above errors before committing."
+msgstr "Deve corrigir os erros acima antes de fazer commit."
+
+#: lib/index.tcl:6
+msgid "Unable to unlock the index."
+msgstr "N=C3=A3o =C3=A9 poss=C3=ADvel desbloquear o =C3=ADndice."
+
+#: lib/index.tcl:15
+msgid "Index Error"
+msgstr "Erro de =C3=8Dndice"
+
+#: lib/index.tcl:17
+msgid ""
+"Updating the Git index failed.  A rescan will be automatically starte=
d to "
+"resynchronize git-gui."
+msgstr ""
+"Falha ao atualizar o =C3=ADndice do Git. Ir=C3=A1-se reanalisar autom=
aticamente para "
+"ressincronizar o git-gui."
+
+#: lib/index.tcl:28
+msgid "Continue"
+msgstr "Continuar"
+
+#: lib/index.tcl:31
+msgid "Unlock Index"
+msgstr "Desbloquear =C3=ADndice"
+
+#: lib/index.tcl:289
+#, tcl-format
+msgid "Unstaging %s from commit"
+msgstr "A retirar %s do commit"
+
+#: lib/index.tcl:328
+msgid "Ready to commit."
+msgstr "Pronto para fazer commit."
+
+#: lib/index.tcl:341
+#, tcl-format
+msgid "Adding %s"
+msgstr "A adicionar %s"
+
+#: lib/index.tcl:398
+#, tcl-format
+msgid "Revert changes in file %s?"
+msgstr "Reverter altera=C3=A7=C3=B5es no ficheiro %s?"
+
+#: lib/index.tcl:400
+#, tcl-format
+msgid "Revert changes in these %i files?"
+msgstr "Reverter altera=C3=A7=C3=B5es nestes %i ficheiros?"
+
+#: lib/index.tcl:408
+msgid "Any unstaged changes will be permanently lost by the revert."
+msgstr ""
+"Qualquer altera=C3=A7=C3=A3o n=C3=A3o preparada ser=C3=A1 permanentem=
ente perdida ao reverter."
+
+#: lib/index.tcl:411
+msgid "Do Nothing"
+msgstr "N=C3=A3o fazer nada"
+
+#: lib/index.tcl:429
+msgid "Reverting selected files"
+msgstr "A reverter ficheiros selecionados"
+
+#: lib/index.tcl:433
+#, tcl-format
+msgid "Reverting %s"
+msgstr "A reverter %s"
+
+#: lib/merge.tcl:13
+msgid ""
+"Cannot merge while amending.\n"
+"\n"
+"You must finish amending this commit before starting any type of merg=
e.\n"
+msgstr ""
+"N=C3=A3o poss=C3=ADvel integrar ao mesmo tempo que se emenda.\n"
+"\n"
+"Deve acabar de emendar este commit antes de iniciar qualquer tipo de =
"
+"integra=C3=A7=C3=A3o.\n"
+
+#: lib/merge.tcl:27
+msgid ""
+"Last scanned state does not match repository state.\n"
+"\n"
+"Another Git program has modified this repository since the last scan.=
  A "
+"rescan must be performed before a merge can be performed.\n"
+"\n"
+"The rescan will be automatically started now.\n"
+msgstr ""
+"O =C3=BAltimo estado analisado n=C3=A3o corresponde ao estado do repo=
sit=C3=B3rio.\n"
+"\n"
+"Outro programa Git modificou este reposit=C3=B3rio deste a =C3=BAltim=
a an=C3=A1lise. Deve-"
+"se reanalisar antes de se poder integrar.\n"
+"\n"
+"Ir=C3=A1-se reanalisar agora automaticamente.\n"
+
+#: lib/merge.tcl:45
+#, tcl-format
+msgid ""
+"You are in the middle of a conflicted merge.\n"
+"\n"
+"File %s has merge conflicts.\n"
+"\n"
+"You must resolve them, stage the file, and commit to complete the cur=
rent "
+"merge.  Only then can you begin another merge.\n"
+msgstr ""
+"Integra=C3=A7=C3=A3o com conflitos em curso.\n"
+"\n"
+"O ficheiro %s tem conflitos de integra=C3=A7=C3=A3o.\n"
+"\n"
+"Deve resolv=C3=AA-los, preparar o ficheiro e fazer commit para conclu=
ir a "
+"integra=C3=A7=C3=A3o atual. S=C3=B3 ent=C3=A3o pode iniciar outra int=
egra=C3=A7=C3=A3o.\n"
+
+#: lib/merge.tcl:55
+#, tcl-format
+msgid ""
+"You are in the middle of a change.\n"
+"\n"
+"File %s is modified.\n"
+"\n"
+"You should complete the current commit before starting a merge.  Doin=
g so "
+"will help you abort a failed merge, should the need arise.\n"
+msgstr ""
+"Tem altera=C3=A7=C3=B5es presentes.\n"
+"\n"
+"O ficheiro %s foi modificado.\n"
+"\n"
+"Deve concluir o commit atual antes de iniciar uma integra=C3=A7=C3=A3=
o. Assim, ajuda-o "
+"a abortar uma integra=C3=A7=C3=A3o falhada, caso necess=C3=A1rio.\n"
+
+#: lib/merge.tcl:107
+#, tcl-format
+msgid "%s of %s"
+msgstr "%s de %s"
+
+#: lib/merge.tcl:120
+#, tcl-format
+msgid "Merging %s and %s..."
+msgstr "A integrar %s e %s..."
+
+#: lib/merge.tcl:131
+msgid "Merge completed successfully."
+msgstr "Integra=C3=A7=C3=A3o conclu=C3=ADda com sucesso."
+
+#: lib/merge.tcl:133
+msgid "Merge failed.  Conflict resolution is required."
+msgstr "Integra=C3=A7=C3=A3o falhada. =C3=89 necess=C3=A1rio resolver =
conflitos."
+
+#: lib/merge.tcl:158
+#, tcl-format
+msgid "Merge Into %s"
+msgstr "Integrar em %s"
+
+#: lib/merge.tcl:177
+msgid "Revision To Merge"
+msgstr "Revis=C3=A3o a integrar"
+
+#: lib/merge.tcl:212
+msgid ""
+"Cannot abort while amending.\n"
+"\n"
+"You must finish amending this commit.\n"
+msgstr ""
+"N=C3=A3o =C3=A9 poss=C3=ADvel abortar enquanto se emenda.\n"
+"\n"
+"Deve acabar de emendar este commit.\n"
+
+#: lib/merge.tcl:222
+msgid ""
+"Abort merge?\n"
+"\n"
+"Aborting the current merge will cause *ALL* uncommitted changes to be=
 lost.\n"
+"\n"
+"Continue with aborting the current merge?"
+msgstr ""
+"Abortar integra=C3=A7=C3=A3o?\n"
+"\n"
+"Ao abortar a integra=C3=A7=C3=A3o atual perder=C3=A1 *TODAS* as alter=
a=C3=A7=C3=A3o que n=C3=A3o foram "
+"inclu=C3=ADdas em commit.\n"
+"\n"
+"Proceder para abortar a integra=C3=A7=C3=A3o atual?"
+
+#: lib/merge.tcl:228
+msgid ""
+"Reset changes?\n"
+"\n"
+"Resetting the changes will cause *ALL* uncommitted changes to be lost=
=2E\n"
+"\n"
+"Continue with resetting the current changes?"
+msgstr ""
+"Repor altera=C3=A7=C3=B5es?\n"
+"\n"
+"Ao repor as altera=C3=A7=C3=B5es perder=C3=A1 *TODAS* as altera=C3=A7=
=C3=B5es n=C3=A3o inclu=C3=ADda em commit."
+"\n"
+"\n"
+"Proceder para repor as altera=C3=A7=C3=B5es atuais?"
+
+#: lib/merge.tcl:239
+msgid "Aborting"
+msgstr "A abortar"
+
+#: lib/merge.tcl:239
+msgid "files reset"
+msgstr "ficheiros repostos"
+
+#: lib/merge.tcl:267
+msgid "Abort failed."
+msgstr "Falha ao abortar."
+
+#: lib/merge.tcl:269
+msgid "Abort completed.  Ready."
+msgstr "Aborto conclu=C3=ADdo. Pronto."
+
+#: lib/mergetool.tcl:8
+msgid "Force resolution to the base version?"
+msgstr "For=C3=A7ar resolu=C3=A7=C3=A3o para a vers=C3=A3o base?"
+
+#: lib/mergetool.tcl:9
+msgid "Force resolution to this branch?"
+msgstr "For=C3=A7ar resolu=C3=A7=C3=A3o para este ramo?"
+
+#: lib/mergetool.tcl:10
+msgid "Force resolution to the other branch?"
+msgstr "For=C3=A7ar resolu=C3=A7=C3=A3o para o outro ramo?"
+
+#: lib/mergetool.tcl:14
+#, tcl-format
+msgid ""
+"Note that the diff shows only conflicting changes.\n"
+"\n"
+"%s will be overwritten.\n"
+"\n"
+"This operation can be undone only by restarting the merge."
+msgstr ""
+"Note que as diferen=C3=A7as mostram apenas altera=C3=A7=C3=B5es em co=
nflito.\n"
+"\n"
+"%s ser=C3=A1 substitu=C3=ADdo.\n"
+"\n"
+"Esta opera=C3=A7=C3=A3o s=C3=B3 pode ser anulada reiniciando a integr=
a=C3=A7=C3=A3o."
+
+#: lib/mergetool.tcl:45
+#, tcl-format
+msgid "File %s seems to have unresolved conflicts, still stage?"
+msgstr ""
+"O ficheiro %s parece ter conflitos n=C3=A3o resolvidos, prepar=C3=A1-=
lo mesmo assim?"
+
+#: lib/mergetool.tcl:60
+#, tcl-format
+msgid "Adding resolution for %s"
+msgstr "A adicionar resolu=C3=A7=C3=A3o de %s"
+
+#: lib/mergetool.tcl:141
+msgid "Cannot resolve deletion or link conflicts using a tool"
+msgstr ""
+"N=C3=A3o =C3=A9 poss=C3=ADvel resolver conflitos de exclus=C3=A3o ou =
liga=C3=A7=C3=A3o usando uma "
+"ferramenta"
+
+#: lib/mergetool.tcl:146
+msgid "Conflict file does not exist"
+msgstr "O ficheiro em conflito n=C3=A3o existe"
+
+#: lib/mergetool.tcl:264
+#, tcl-format
+msgid "Not a GUI merge tool: '%s'"
+msgstr "N=C3=A3o =C3=A9 uma ferramenta GUI de integra=C3=A7=C3=A3o: '%=
s'"
+
+#: lib/mergetool.tcl:268
+#, tcl-format
+msgid "Unsupported merge tool '%s'"
+msgstr "Ferramenta de integra=C3=A7=C3=A3o '%s' n=C3=A3o suportada"
+
+#: lib/mergetool.tcl:303
+msgid "Merge tool is already running, terminate it?"
+msgstr "A ferramenta de integra=C3=A7=C3=A3o j=C3=A1 est=C3=A1 a execu=
tar, termin=C3=A1-la?"
+
+#: lib/mergetool.tcl:323
+#, tcl-format
+msgid ""
+"Error retrieving versions:\n"
+"%s"
+msgstr ""
+"Erro ao obter vers=C3=B5es:\n"
+"%s"
+
+#: lib/mergetool.tcl:343
+#, tcl-format
+msgid ""
+"Could not start the merge tool:\n"
+"\n"
+"%s"
+msgstr ""
+"N=C3=A3o foi poss=C3=ADvel iniciar a ferramenta de integra=C3=A7=C3=A3=
o:\n"
+"\n"
+"%s"
+
+#: lib/mergetool.tcl:347
+msgid "Running merge tool..."
+msgstr "A executar a ferramenta de integra=C3=A7=C3=A3o..."
+
+#: lib/mergetool.tcl:375 lib/mergetool.tcl:383
+msgid "Merge tool failed."
+msgstr "A ferramenta de integra=C3=A7=C3=A3o falhou."
+
+#: lib/option.tcl:11
+#, tcl-format
+msgid "Invalid global encoding '%s'"
+msgstr "Codifica=C3=A7=C3=A3o global '%s' inv=C3=A1lida"
+
+#: lib/option.tcl:19
+#, tcl-format
+msgid "Invalid repo encoding '%s'"
+msgstr "Codifica=C3=A7=C3=A3o do reposit=C3=B3rio '%s' inv=C3=A1lida"
+
+#: lib/option.tcl:117
+msgid "Restore Defaults"
+msgstr "Restaurar predefini=C3=A7=C3=B5es"
+
+#: lib/option.tcl:121
+msgid "Save"
+msgstr "Guardar"
+
+#: lib/option.tcl:131
+#, tcl-format
+msgid "%s Repository"
+msgstr "Reposit=C3=B3rio %s"
+
+#: lib/option.tcl:132
+msgid "Global (All Repositories)"
+msgstr "Global (todos os reposit=C3=B3rios)"
+
+#: lib/option.tcl:138
+msgid "User Name"
+msgstr "Nome de utilizador"
+
+#: lib/option.tcl:139
+msgid "Email Address"
+msgstr "Endere=C3=A7o de e-mail"
+
+#: lib/option.tcl:141
+msgid "Summarize Merge Commits"
+msgstr "Resumir commits de integra=C3=A7=C3=A3o"
+
+#: lib/option.tcl:142
+msgid "Merge Verbosity"
+msgstr "Verbosidade de integra=C3=A7=C3=A3o"
+
+#: lib/option.tcl:143
+msgid "Show Diffstat After Merge"
+msgstr "Mostrar estat=C3=ADsticas de diferen=C3=A7as depois de integra=
r"
+
+#: lib/option.tcl:144
+msgid "Use Merge Tool"
+msgstr "Usar ferramenta de integra=C3=A7=C3=A3o"
+
+#: lib/option.tcl:146
+msgid "Trust File Modification Timestamps"
+msgstr "Confiar no carimbo de data/hora de modifica=C3=A7=C3=A3o do fi=
cheiro"
+
+#: lib/option.tcl:147
+msgid "Prune Tracking Branches During Fetch"
+msgstr "Podar ramos de monitoriza=C3=A7=C3=A3o ao obter"
+
+#: lib/option.tcl:148
+msgid "Match Tracking Branches"
+msgstr "Corresponder ramos de monitoriza=C3=A7=C3=A3o"
+
+#: lib/option.tcl:149
+msgid "Blame Copy Only On Changed Files"
+msgstr "Culpar c=C3=B3pia apenas em ficheiros modificados"
+
+#: lib/option.tcl:150
+msgid "Minimum Letters To Blame Copy On"
+msgstr "M=C3=ADnimo de letras para culpar a c=C3=B3pia"
+
+#: lib/option.tcl:151
+msgid "Blame History Context Radius (days)"
+msgstr "Raio de contexto de hist=C3=B3rico para culpar (dias)"
+
+#: lib/option.tcl:152
+msgid "Number of Diff Context Lines"
+msgstr "N=C3=BAmero de linhas de contexto nas diferen=C3=A7as"
+
+#: lib/option.tcl:153
+msgid "Commit Message Text Width"
+msgstr "Largura do texto da mensagem de commit"
+
+#: lib/option.tcl:154
+msgid "New Branch Name Template"
+msgstr "Modelo de novo nome de ramo"
+
+#: lib/option.tcl:155
+msgid "Default File Contents Encoding"
+msgstr "Codifica=C3=A7=C3=A3o predefinida dos conte=C3=BAdos de fichei=
ros"
+
+#: lib/option.tcl:203
+msgid "Change"
+msgstr "Alterar"
+
+#: lib/option.tcl:230
+msgid "Spelling Dictionary:"
+msgstr "Dicion=C3=A1rio ortogr=C3=A1fico:"
+
+#: lib/option.tcl:254
+msgid "Change Font"
+msgstr "Alterar tipo de letra"
+
+#: lib/option.tcl:258
+#, tcl-format
+msgid "Choose %s"
+msgstr "Escolher %s"
+
+#: lib/option.tcl:264
+msgid "pt."
+msgstr "pt."
+
+#: lib/option.tcl:278
+msgid "Preferences"
+msgstr "Prefer=C3=AAncias"
+
+#: lib/option.tcl:314
+msgid "Failed to completely save options:"
+msgstr "Falha ao guardar todas as op=C3=A7=C3=B5es:"
+
+#: lib/remote.tcl:163
+msgid "Remove Remote"
+msgstr "Remover remoto"
+
+#: lib/remote.tcl:168
+msgid "Prune from"
+msgstr "Podar de"
+
+#: lib/remote.tcl:173
+msgid "Fetch from"
+msgstr "Obter de"
+
+#: lib/remote.tcl:215
+msgid "Push to"
+msgstr "Publicar em"
+
+#: lib/remote_add.tcl:19
+msgid "Add Remote"
+msgstr "Adicionar remoto"
+
+#: lib/remote_add.tcl:24
+msgid "Add New Remote"
+msgstr "Adicionar novo remoto"
+
+#: lib/remote_add.tcl:28 lib/tools_dlg.tcl:36
+msgid "Add"
+msgstr "Adicionar"
+
+#: lib/remote_add.tcl:37
+msgid "Remote Details"
+msgstr "Detalhes do remoto"
+
+#: lib/remote_add.tcl:50
+msgid "Location:"
+msgstr "Localiza=C3=A7=C3=A3o:"
+
+#: lib/remote_add.tcl:62
+msgid "Further Action"
+msgstr "A=C3=A7=C3=A3o adicional"
+
+#: lib/remote_add.tcl:65
+msgid "Fetch Immediately"
+msgstr "Obter imediatamente"
+
+#: lib/remote_add.tcl:71
+msgid "Initialize Remote Repository and Push"
+msgstr "Inicializar reposit=C3=B3rio remoto e publicar"
+
+#: lib/remote_add.tcl:77
+msgid "Do Nothing Else Now"
+msgstr "N=C3=A3o fazer mais nada agora"
+
+#: lib/remote_add.tcl:101
+msgid "Please supply a remote name."
+msgstr "Forne=C3=A7a um nome para o remoto."
+
+#: lib/remote_add.tcl:114
+#, tcl-format
+msgid "'%s' is not an acceptable remote name."
+msgstr "'%s' n=C3=A3o pode ser aceite como nome de remoto."
+
+#: lib/remote_add.tcl:125
+#, tcl-format
+msgid "Failed to add remote '%s' of location '%s'."
+msgstr "Falha ao adicionar remoto '%s' localizado em '%s'."
+
+#: lib/remote_add.tcl:133 lib/transport.tcl:6
+#, tcl-format
+msgid "fetch %s"
+msgstr "obter %s"
+
+#: lib/remote_add.tcl:134
+#, tcl-format
+msgid "Fetching the %s"
+msgstr "A obter de %s"
+
+#: lib/remote_add.tcl:157
+#, tcl-format
+msgid "Do not know how to initialize repository at location '%s'."
+msgstr "N=C3=A3o se sabe como inicializar o reposit=C3=B3rio localizad=
o em '%s'."
+
+#: lib/remote_add.tcl:163 lib/transport.tcl:25 lib/transport.tcl:63
+#: lib/transport.tcl:81
+#, tcl-format
+msgid "push %s"
+msgstr "publicar %s"
+
+#: lib/remote_add.tcl:164
+#, tcl-format
+msgid "Setting up the %s (at %s)"
+msgstr "A configurar %s (em %s)"
+
+#: lib/remote_branch_delete.tcl:29 lib/remote_branch_delete.tcl:34
+msgid "Delete Branch Remotely"
+msgstr "Remover ramo remotamente"
+
+#: lib/remote_branch_delete.tcl:47
+msgid "From Repository"
+msgstr "Do reposit=C3=B3rio"
+
+#: lib/remote_branch_delete.tcl:50 lib/transport.tcl:134
+msgid "Remote:"
+msgstr "Remoto:"
+
+#: lib/remote_branch_delete.tcl:66 lib/transport.tcl:149
+msgid "Arbitrary Location:"
+msgstr "Localiza=C3=A7=C3=A3o arbitr=C3=A1ria:"
+
+#: lib/remote_branch_delete.tcl:84
+msgid "Branches"
+msgstr "Ramos"
+
+#: lib/remote_branch_delete.tcl:109
+msgid "Delete Only If"
+msgstr "Eliminar s=C3=B3 se"
+
+#: lib/remote_branch_delete.tcl:111
+msgid "Merged Into:"
+msgstr "Integrar em:"
+
+#: lib/remote_branch_delete.tcl:152
+msgid "A branch is required for 'Merged Into'."
+msgstr "=C3=89 necess=C3=A1rio um ramo em 'Integrar em'."
+
+#: lib/remote_branch_delete.tcl:184
+#, tcl-format
+msgid ""
+"The following branches are not completely merged into %s:\n"
+"\n"
+" - %s"
+msgstr ""
+"Os seguintes ramos n=C3=A3o foram completamente integrados em %s:\n"
+"\n"
+" - %s"
+
+#: lib/remote_branch_delete.tcl:189
+#, tcl-format
+msgid ""
+"One or more of the merge tests failed because you have not fetched th=
e "
+"necessary commits.  Try fetching from %s first."
+msgstr ""
+"Um ou mais testes de integra=C3=A7=C3=A3o falharam porque n=C3=A3o ob=
teve os commits "
+"necess=C3=A1rios. Tente primeiro obter de %s."
+
+#: lib/remote_branch_delete.tcl:207
+msgid "Please select one or more branches to delete."
+msgstr "Selecione um ou mais ramos para eliminar."
+
+#: lib/remote_branch_delete.tcl:226
+#, tcl-format
+msgid "Deleting branches from %s"
+msgstr "A eliminar ramos de %s"
+
+#: lib/remote_branch_delete.tcl:292
+msgid "No repository selected."
+msgstr "Nenhum reposit=C3=B3rio selecionado."
+
+#: lib/remote_branch_delete.tcl:297
+#, tcl-format
+msgid "Scanning %s..."
+msgstr "A analisar %s..."
+
+#: lib/search.tcl:21
+msgid "Find:"
+msgstr "Procurar:"
+
+#: lib/search.tcl:23
+msgid "Next"
+msgstr "Seguinte"
+
+#: lib/search.tcl:24
+msgid "Prev"
+msgstr "Anterior"
+
+#: lib/search.tcl:25
+msgid "Case-Sensitive"
+msgstr "Distinguir Mai=C3=BAsculas"
+
+#: lib/shortcut.tcl:21 lib/shortcut.tcl:62
+msgid "Cannot write shortcut:"
+msgstr "N=C3=A3o =C3=A9 poss=C3=ADvel escrever atalho:"
+
+#: lib/shortcut.tcl:137
+msgid "Cannot write icon:"
+msgstr "N=C3=A3o =C3=A9 poss=C3=ADvel escrever =C3=ADcone:"
+
+#: lib/spellcheck.tcl:57
+msgid "Unsupported spell checker"
+msgstr "Corretor ortogr=C3=A1fico n=C3=A3o suportado"
+
+#: lib/spellcheck.tcl:65
+msgid "Spell checking is unavailable"
+msgstr "Corre=C3=A7=C3=A3o ortogr=C3=A1fica indispon=C3=ADvel"
+
+#: lib/spellcheck.tcl:68
+msgid "Invalid spell checking configuration"
+msgstr "Configura=C3=A7=C3=A3o inv=C3=A1lida do corretor ortogr=C3=A1f=
ico"
+
+#: lib/spellcheck.tcl:70
+#, tcl-format
+msgid "Reverting dictionary to %s."
+msgstr "A reverter dicion=C3=A1rio para %s."
+
+#: lib/spellcheck.tcl:73
+msgid "Spell checker silently failed on startup"
+msgstr "O corretor ortogr=C3=A1fico falhou silenciosamente ao iniciar"
+
+#: lib/spellcheck.tcl:80
+msgid "Unrecognized spell checker"
+msgstr "Corretor ortogr=C3=A1fico n=C3=A3o reconhecido"
+
+#: lib/spellcheck.tcl:186
+msgid "No Suggestions"
+msgstr "Sem sugest=C3=B5es"
+
+#: lib/spellcheck.tcl:388
+msgid "Unexpected EOF from spell checker"
+msgstr "EOF (fim de ficheiro) inesperado do corretor ortogr=C3=A1fico"
+
+#: lib/spellcheck.tcl:392
+msgid "Spell Checker Failed"
+msgstr "Corretor ortogr=C3=A1fico falhou"
+
+#: lib/sshkey.tcl:31
+msgid "No keys found."
+msgstr "Nenhum chave encontrada."
+
+#: lib/sshkey.tcl:34
+#, tcl-format
+msgid "Found a public key in: %s"
+msgstr "Chave p=C3=BAblica encontrada em: %s"
+
+#: lib/sshkey.tcl:40
+msgid "Generate Key"
+msgstr "Gerar chave"
+
+#: lib/sshkey.tcl:56
+msgid "Copy To Clipboard"
+msgstr "Copiar para a =C3=A1rea de transfer=C3=AAncia"
+
+#: lib/sshkey.tcl:70
+msgid "Your OpenSSH Public Key"
+msgstr "A sua chave OpenSSH p=C3=BAblica"
+
+#: lib/sshkey.tcl:78
+msgid "Generating..."
+msgstr "A gerar..."
+
+#: lib/sshkey.tcl:84
+#, tcl-format
+msgid ""
+"Could not start ssh-keygen:\n"
+"\n"
+"%s"
+msgstr ""
+"N=C3=A3o foi poss=C3=ADvel iniciar ssh-keygen:\n"
+"\n"
+"%s"
+
+#: lib/sshkey.tcl:111
+msgid "Generation failed."
+msgstr "Falha ao gerar."
+
+#: lib/sshkey.tcl:118
+msgid "Generation succeeded, but no keys found."
+msgstr "Gerada com sucesso, mas n=C3=A3o foi encontrada nenhum chave."
+
+#: lib/sshkey.tcl:121
+#, tcl-format
+msgid "Your key is in: %s"
+msgstr "A sua chave encontra-se em: %s"
+
+#: lib/status_bar.tcl:83
+#, tcl-format
+msgid "%s ... %*i of %*i %s (%3i%%)"
+msgstr "%s ... %*i de %*i %s (%3i%%)"
+
+#: lib/tools.tcl:75
+#, tcl-format
+msgid "Running %s requires a selected file."
+msgstr "Deve selecionar um ficheiro para executar %s."
+
+#: lib/tools.tcl:90
+#, tcl-format
+msgid "Are you sure you want to run %s?"
+msgstr "Tem a certeza que pretende executar %s?"
+
+#: lib/tools.tcl:110
+#, tcl-format
+msgid "Tool: %s"
+msgstr "Ferramenta: %s"
+
+#: lib/tools.tcl:111
+#, tcl-format
+msgid "Running: %s"
+msgstr "A executar: %s"
+
+#: lib/tools.tcl:149
+#, tcl-format
+msgid "Tool completed successfully: %s"
+msgstr "A ferramenta conclu=C3=AD com sucesso: %s"
+
+#: lib/tools.tcl:151
+#, tcl-format
+msgid "Tool failed: %s"
+msgstr "A ferramenta falhou: %s"
+
+#: lib/tools_dlg.tcl:22
+msgid "Add Tool"
+msgstr "Adicionar ferramenta"
+
+#: lib/tools_dlg.tcl:28
+msgid "Add New Tool Command"
+msgstr "Adicionar novo comando de ferramenta"
+
+#: lib/tools_dlg.tcl:33
+msgid "Add globally"
+msgstr "Adicionar globalmente"
+
+#: lib/tools_dlg.tcl:45
+msgid "Tool Details"
+msgstr "Detalhes da ferramenta"
+
+#: lib/tools_dlg.tcl:48
+msgid "Use '/' separators to create a submenu tree:"
+msgstr "Use separadores '/' para criar uma =C3=A1rvore de submenus:"
+
+#: lib/tools_dlg.tcl:61
+msgid "Command:"
+msgstr "Comando:"
+
+#: lib/tools_dlg.tcl:74
+msgid "Show a dialog before running"
+msgstr "Mostrar um di=C3=A1logo antes de executar"
+
+#: lib/tools_dlg.tcl:80
+msgid "Ask the user to select a revision (sets $REVISION)"
+msgstr "Pedir ao utilizador para selecionar uma revis=C3=A3o (define $=
REVISION)"
+
+#: lib/tools_dlg.tcl:85
+msgid "Ask the user for additional arguments (sets $ARGS)"
+msgstr "Pedir ao utilizador argumentos adicionais (define $ARGS)"
+
+#: lib/tools_dlg.tcl:92
+msgid "Don't show the command output window"
+msgstr "N=C3=A3o mostrar a janela com a sa=C3=ADda do comando"
+
+#: lib/tools_dlg.tcl:97
+msgid "Run only if a diff is selected ($FILENAME not empty)"
+msgstr "Executar s=C3=B3 se for selecionada um diferen=C3=A7a ($FILENA=
ME n=C3=A3o vazio)"
+
+#: lib/tools_dlg.tcl:121
+msgid "Please supply a name for the tool."
+msgstr "Forne=C3=A7a um nome para a ferramenta."
+
+#: lib/tools_dlg.tcl:129
+#, tcl-format
+msgid "Tool '%s' already exists."
+msgstr "A ferramenta '%s' j=C3=A1 existe."
+
+#: lib/tools_dlg.tcl:151
+#, tcl-format
+msgid ""
+"Could not add tool:\n"
+"%s"
+msgstr ""
+"N=C3=A3o foi poss=C3=ADvel adicionar ferramenta:\n"
+"%s"
+
+#: lib/tools_dlg.tcl:190
+msgid "Remove Tool"
+msgstr "Remover ferramenta"
+
+#: lib/tools_dlg.tcl:196
+msgid "Remove Tool Commands"
+msgstr "Remover comandos de ferramenta"
+
+#: lib/tools_dlg.tcl:200
+msgid "Remove"
+msgstr "Remover"
+
+#: lib/tools_dlg.tcl:236
+msgid "(Blue denotes repository-local tools)"
+msgstr "(Azul denota ferramentas locais do reposit=C3=B3rio)"
+
+#: lib/tools_dlg.tcl:297
+#, tcl-format
+msgid "Run Command: %s"
+msgstr "Executar comando: %s"
+
+#: lib/tools_dlg.tcl:311
+msgid "Arguments"
+msgstr "Argumentos"
+
+#: lib/tools_dlg.tcl:348
+msgid "OK"
+msgstr "OK"
+
+#: lib/transport.tcl:7
+#, tcl-format
+msgid "Fetching new changes from %s"
+msgstr "Obter novas altera=C3=A7=C3=B5es de %s"
+
+#: lib/transport.tcl:18
+#, tcl-format
+msgid "remote prune %s"
+msgstr "podar remoto %s"
+
+#: lib/transport.tcl:19
+#, tcl-format
+msgid "Pruning tracking branches deleted from %s"
+msgstr "A podar ramo de monitoriza=C3=A7=C3=A3o eliminados de %s"
+
+#: lib/transport.tcl:26
+#, tcl-format
+msgid "Pushing changes to %s"
+msgstr "A publicar altera=C3=A7=C3=B5es em %s"
+
+#: lib/transport.tcl:64
+#, tcl-format
+msgid "Mirroring to %s"
+msgstr "A espelhar em %s"
+
+#: lib/transport.tcl:82
+#, tcl-format
+msgid "Pushing %s %s to %s"
+msgstr "A publicar %s %s em %s"
+
+#: lib/transport.tcl:100
+msgid "Push Branches"
+msgstr "Publicar ramos"
+
+#: lib/transport.tcl:114
+msgid "Source Branches"
+msgstr "Ramos de origem"
+
+#: lib/transport.tcl:131
+msgid "Destination Repository"
+msgstr "Reposit=C3=B3rio de destino"
+
+#: lib/transport.tcl:169
+msgid "Transfer Options"
+msgstr "Op=C3=A7=C3=B5es de transfer=C3=AAncia"
+
+#: lib/transport.tcl:171
+msgid "Force overwrite existing branch (may discard changes)"
+msgstr "For=C3=A7ar substitui=C3=A7=C3=A3o de ramos existente (pode de=
scartar altera=C3=A7=C3=B5es)"
+
+#: lib/transport.tcl:175
+msgid "Use thin pack (for slow network connections)"
+msgstr "Usar pacote fino (para conex=C3=B5es de rede lentas)"
+
+#: lib/transport.tcl:179
+msgid "Include tags"
+msgstr "Incluir tags"
--=20
2.7.3
