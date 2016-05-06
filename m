From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH v2] git-gui: l10n: add Portuguese translation
Date: Fri,  6 May 2016 16:06:42 +0000
Message-ID: <1462550802-20601-1-git-send-email-vascomalmeida@sapo.pt>
References: <1462447421-6294-1-git-send-email-vascomalmeida@sapo.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	"Shawn O . Pearce" <spearce@spearce.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 18:07:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayiI6-0002UO-Ak
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 18:07:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758250AbcEFQHm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 May 2016 12:07:42 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:55058 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758083AbcEFQHj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 12:07:39 -0400
Received: (qmail 11240 invoked from network); 6 May 2016 16:07:36 -0000
Received: (qmail 14832 invoked from network); 6 May 2016 16:07:36 -0000
Received: from unknown (HELO localhost.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 6 May 2016 16:07:33 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1462447421-6294-1-git-send-email-vascomalmeida@sapo.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293793>

Add Portuguese glossary.

Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
---
 po/glossary/pt_pt.po |  293 ++++++
 po/pt_pt.po          | 2716 ++++++++++++++++++++++++++++++++++++++++++=
++++++++
 2 files changed, 3009 insertions(+)
 create mode 100644 po/glossary/pt_pt.po
 create mode 100644 po/pt_pt.po

diff --git a/po/glossary/pt_pt.po b/po/glossary/pt_pt.po
new file mode 100644
index 0000000..adc3b54
--- /dev/null
+++ b/po/glossary/pt_pt.po
@@ -0,0 +1,293 @@
+# Portuguese translations for git-gui glossary.
+# Copyright (C) 2016 Shawn Pearce, et al.
+# This file is distributed under the same license as the git package.
+# Vasco Almeida <vascomalmeida@sapo.pt>, 2016.
+msgid ""
+msgstr ""
+"Project-Id-Version: git-gui glossary\n"
+"POT-Creation-Date: 2016-05-06 10:22+0000\n"
+"PO-Revision-Date: 2016-05-06 12:32+0000\n"
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
+msgstr "submeter"
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
+
+#. "a commit that succeeds the current one in git's graph of commits (=
not necessarily directly)"
+msgid "ancestor"
+msgstr "antecessor"
+
+#. "prematurely stop and abandon an operation"
+msgid "abort"
+msgstr "abortar"
+
+#. "a repository with only .git directory, without working directory"
+msgid "bare repository"
+msgstr "reposit=C3=B3rio nu"
+
+#. "a parent version of the current file"
+msgid "base"
+msgstr "base"
+
+#. "get the authors responsible for each line in a file"
+msgid "blame"
+msgstr "culpar"
+
+#. "to select and apply a single commit without merging"
+msgid "cherry-pick"
+msgstr "efetuar cherry-pick (escolher-a-dedo?, selecionar?)"
+
+#. "a commit that directly succeeds the current one in git's graph of =
commits"
+msgid "child"
+msgstr "filho"
+
+#. "clean the state of the git repository, often after manually stoppe=
d operation"
+msgid "cleanup"
+msgstr "limpar"
+
+#. "a message that gets attached with any commit"
+msgid "commit message"
+msgstr "mensagem de commit"
+
+#. "a commit that precedes the current one in git's graph of commits (=
not necessarily directly)"
+msgid "descendant"
+msgstr "descendente"
+
+#. "checkout of a revision rather than a some head"
+msgid "detached checkout"
+msgstr "extra=C3=A7=C3=A3o destacada"
+
+#. "any merge strategy that works on a file by file basis"
+msgid "file level merging"
+msgstr "integra=C3=A7=C3=A3o ao n=C3=ADvel de ficheiros"
+
+#. "the last revision in a branch"
+msgid "head"
+msgstr "cabe=C3=A7a"
+
+#. "script that gets executed automatically on some event"
+msgid "hook"
+msgstr "gancho"
+
+#. "the first checkout during a clone operation"
+msgid "initial checkout"
+msgstr "extra=C3=A7=C3=A3o inicial"
+
+#. "a branch that resides in the local git repository"
+msgid "local branch"
+msgstr "ramo local"
+
+#. "a Git object that is not part of any pack"
+msgid "loose object"
+msgstr "objeto solto"
+
+#. "a branch called by convention 'master' that exists in a newly crea=
ted git repository"
+msgid "master branch"
+msgstr "ramo mestre"
+
+#. "a remote called by convention 'origin' that the current git reposi=
tory has been cloned from"
+msgid "origin"
+msgstr "origem"
+
+#. "a file containing many git objects packed together"
+msgid "pack [noun]"
+msgstr "pacote"
+
+#. "a Git object part of some pack"
+msgid "packed object"
+msgstr "objeto compactado"
+
+#. "a commit that directly precedes the current one in git's graph of =
commits"
+msgid "parent"
+msgstr "pai"
+
+#. "the log file containing all states of the HEAD reference (in other=
 words past pristine states of the working copy)"
+msgid "reflog"
+msgstr "reflog"
+
+#. "decide which changes from alternative versions of a file should pe=
rsist in Git"
+msgid "resolve (a conflict)"
+msgstr "resolver (um conflito)"
+
+#. "abandon changes and go to pristine version"
+msgid "revert changes"
+msgstr "reverter altera=C3=A7=C3=B5es"
+
+#. "expression that signifies a revision in git"
+msgid "revision expression"
+msgstr "express=C3=A3o de revis=C3=A3o"
+
+#. "add some content of files and directories to the staging area in p=
reparation for a commit"
+msgid "stage/unstage"
+msgstr "preparar/retirar"
+
+#. "temporarily save changes in a stack without committing"
+msgid "stash"
+msgstr "empilhar"
+
+#. "file whose content is tracked/not tracked by git"
+msgid "tracked/untracked"
+msgstr "controlado/n=C3=A3o controlado"
diff --git a/po/pt_pt.po b/po/pt_pt.po
new file mode 100644
index 0000000..0ef3c79
--- /dev/null
+++ b/po/pt_pt.po
@@ -0,0 +1,2716 @@
+# Portuguese translations for git-gui package.
+# Copyright (C) 2016 Shawn Pearce, et al.
+# This file is distributed under the same license as the git package.
+# Vasco Almeida <vascomalmeida@sapo.pt>, 2016.
+msgid ""
+msgstr ""
+"Project-Id-Version: git-gui\n"
+"Report-Msgid-Bugs-To: \n"
+"POT-Creation-Date: 2016-05-06 09:36+0000\n"
+"PO-Revision-Date: 2016-05-06 13:09+0000\n"
+"Last-Translator: Vasco Almeida <vascomalmeida@sapo.pt>\n"
+"Language-Team: Portuguese\n"
+"Language: pt\n"
+"MIME-Version: 1.0\n"
+"Content-Type: text/plain; charset=3DUTF-8\n"
+"Content-Transfer-Encoding: 8bit\n"
+"Plural-Forms: nplurals=3D2; plural=3D(n !=3D 1);\n"
+"X-Generator: Virtaal 0.7.1\n"
+
+#: git-gui.sh:861
+#, tcl-format
+msgid "Invalid font specified in %s:"
+msgstr "Tipo de letra inv=C3=A1lido especificado em %s:"
+
+#: git-gui.sh:915
+msgid "Main Font"
+msgstr "Tipo de letra principal"
+
+#: git-gui.sh:916
+msgid "Diff/Console Font"
+msgstr "Tipo de letra Diferen=C3=A7as/Consola"
+
+#: git-gui.sh:931 git-gui.sh:945 git-gui.sh:958 git-gui.sh:1048
+#: git-gui.sh:1067 git-gui.sh:3125
+msgid "git-gui: fatal error"
+msgstr "git-gui: erro fatal"
+
+#: git-gui.sh:932
+msgid "Cannot find git in PATH."
+msgstr "N=C3=A3o =C3=A9 poss=C3=ADvel encontrar o git em PATH."
+
+#: git-gui.sh:959
+msgid "Cannot parse Git version string:"
+msgstr "N=C3=A3o =C3=A9 poss=C3=ADvel analisar a vers=C3=A3o do Git:"
+
+#: git-gui.sh:984
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
+#: git-gui.sh:1281
+msgid "Git directory not found:"
+msgstr "Diret=C3=B3rio Git n=C3=A3o encontrado:"
+
+#: git-gui.sh:1315
+msgid "Cannot move to top of working directory:"
+msgstr "N=C3=A3o =C3=A9 poss=C3=ADvel mover para o topo do diret=C3=B3=
rio de trabalho:"
+
+#: git-gui.sh:1323
+msgid "Cannot use bare repository:"
+msgstr "N=C3=A3o =C3=A9 poss=C3=ADvel usar reposit=C3=B3rio nu:"
+
+#: git-gui.sh:1331
+msgid "No working directory"
+msgstr "Nenhum diret=C3=B3rio de trabalho"
+
+#: git-gui.sh:1503 lib/checkout_op.tcl:306
+msgid "Refreshing file status..."
+msgstr "A atualizar estado do ficheiro..."
+
+#: git-gui.sh:1563
+msgid "Scanning for modified files ..."
+msgstr "A procurar por ficheiros modificados..."
+
+#: git-gui.sh:1639
+msgid "Calling prepare-commit-msg hook..."
+msgstr ""
+"A invocar gancho preparar-mensagem-de-commit (prepare-commit-msg hook=
)..."
+
+#: git-gui.sh:1656
+msgid "Commit declined by prepare-commit-msg hook."
+msgstr ""
+"Commit recusado pelo gancho preparar-mensagem-de-commit (prepare-comm=
it-msg "
+"hook)."
+
+#: git-gui.sh:1814 lib/browser.tcl:252
+msgid "Ready."
+msgstr "Pronto."
+
+#: git-gui.sh:1978
+#, tcl-format
+msgid ""
+"Display limit (gui.maxfilesdisplayed =3D %s) reached, not showing all=
 %s files."
+msgstr ""
+"Limite de visualiza=C3=A7=C3=A3o (gui.maxfilesdisplayed =3D %s) ating=
ido, n=C3=A3o s=C3=A3o "
+"mostrados todos os %s ficheiros."
+
+#: git-gui.sh:2101
+msgid "Unmodified"
+msgstr "N=C3=A3o modificado"
+
+#: git-gui.sh:2103
+msgid "Modified, not staged"
+msgstr "Modificado, n=C3=A3o preparado"
+
+#: git-gui.sh:2104 git-gui.sh:2116
+msgid "Staged for commit"
+msgstr "Preparado para commit"
+
+#: git-gui.sh:2105 git-gui.sh:2117
+msgid "Portions staged for commit"
+msgstr "Por=C3=A7=C3=B5es preparadas para commit"
+
+#: git-gui.sh:2106 git-gui.sh:2118
+msgid "Staged for commit, missing"
+msgstr "Preparado para commit, em falta"
+
+#: git-gui.sh:2108
+msgid "File type changed, not staged"
+msgstr "Tipo de ficheiro modificado, n=C3=A3o preparado"
+
+#: git-gui.sh:2109 git-gui.sh:2110
+msgid "File type changed, old type staged for commit"
+msgstr "Tipo de ficheiro modificado, tipo antigo preparado para commit=
"
+
+#: git-gui.sh:2111
+msgid "File type changed, staged"
+msgstr "Tipo de ficheiro modificado, preparado"
+
+#: git-gui.sh:2112
+msgid "File type change staged, modification not staged"
+msgstr "Tipo de ficheiro modificado, modifica=C3=A7=C3=A3o n=C3=A3o pr=
eparada"
+
+#: git-gui.sh:2113
+msgid "File type change staged, file missing"
+msgstr "Tipo de ficheiro modificado, ficheiro em falta"
+
+#: git-gui.sh:2115
+msgid "Untracked, not staged"
+msgstr "N=C3=A3o controlado, n=C3=A3o preparado"
+
+#: git-gui.sh:2120
+msgid "Missing"
+msgstr "Em falta"
+
+#: git-gui.sh:2121
+msgid "Staged for removal"
+msgstr "Preparado para remo=C3=A7=C3=A3o"
+
+#: git-gui.sh:2122
+msgid "Staged for removal, still present"
+msgstr "Preparado para remo=C3=A7=C3=A3o, ainda presente"
+
+#: git-gui.sh:2124 git-gui.sh:2125 git-gui.sh:2126 git-gui.sh:2127
+#: git-gui.sh:2128 git-gui.sh:2129
+msgid "Requires merge resolution"
+msgstr "Requer resolu=C3=A7=C3=A3o de integra=C3=A7=C3=A3o"
+
+#: git-gui.sh:2164
+msgid "Starting gitk... please wait..."
+msgstr "A iniciar gitk... aguarde..."
+
+#: git-gui.sh:2176
+msgid "Couldn't find gitk in PATH"
+msgstr "N=C3=A3o foi poss=C3=ADvel encontrar gitk em PATH"
+
+#: git-gui.sh:2235
+msgid "Couldn't find git gui in PATH"
+msgstr "N=C3=A3o foi poss=C3=ADvel encontrar git gui em PATH"
+
+#: git-gui.sh:2654 lib/choose_repository.tcl:41
+msgid "Repository"
+msgstr "Reposit=C3=B3rio"
+
+#: git-gui.sh:2655
+msgid "Edit"
+msgstr "Editar"
+
+#: git-gui.sh:2657 lib/choose_rev.tcl:567
+msgid "Branch"
+msgstr "Ramo"
+
+#: git-gui.sh:2660 lib/choose_rev.tcl:554
+msgid "Commit@@noun"
+msgstr "Commit"
+
+#: git-gui.sh:2663 lib/merge.tcl:123 lib/merge.tcl:152 lib/merge.tcl:1=
70
+msgid "Merge"
+msgstr "Integrar"
+
+#: git-gui.sh:2664 lib/choose_rev.tcl:563
+msgid "Remote"
+msgstr "Remoto"
+
+#: git-gui.sh:2667
+msgid "Tools"
+msgstr "Ferramentas"
+
+#: git-gui.sh:2676
+msgid "Explore Working Copy"
+msgstr "Explorar c=C3=B3pia de trabalho"
+
+#: git-gui.sh:2682
+msgid "Git Bash"
+msgstr "Git Bash"
+
+#: git-gui.sh:2692
+msgid "Browse Current Branch's Files"
+msgstr "Navegar pelos ficheiro do ramo atual"
+
+#: git-gui.sh:2696
+msgid "Browse Branch Files..."
+msgstr "Navegar pelos ficheiros do ramo..."
+
+#: git-gui.sh:2701
+msgid "Visualize Current Branch's History"
+msgstr "Visualizar hist=C3=B3rico do ramo atual"
+
+#: git-gui.sh:2705
+msgid "Visualize All Branch History"
+msgstr "Visualizar hist=C3=B3rico de todos os ramos"
+
+#: git-gui.sh:2712
+#, tcl-format
+msgid "Browse %s's Files"
+msgstr "Navegar pelos ficheiro de %s"
+
+#: git-gui.sh:2714
+#, tcl-format
+msgid "Visualize %s's History"
+msgstr "Visualizar hist=C3=B3rico de %s"
+
+#: git-gui.sh:2719 lib/database.tcl:40 lib/database.tcl:66
+msgid "Database Statistics"
+msgstr "Estat=C3=ADsticas da base de dados"
+
+#: git-gui.sh:2722 lib/database.tcl:33
+msgid "Compress Database"
+msgstr "Comprimir base de dados"
+
+#: git-gui.sh:2725
+msgid "Verify Database"
+msgstr "Verificar base de dados"
+
+#: git-gui.sh:2732 git-gui.sh:2736 git-gui.sh:2740 lib/shortcut.tcl:8
+#: lib/shortcut.tcl:40 lib/shortcut.tcl:72
+msgid "Create Desktop Icon"
+msgstr "Criar =C3=ADcone no ambiente de trabalho"
+
+#: git-gui.sh:2748 lib/choose_repository.tcl:193 lib/choose_repository=
=2Etcl:201
+msgid "Quit"
+msgstr "Sair"
+
+#: git-gui.sh:2756
+msgid "Undo"
+msgstr "Desfazer"
+
+#: git-gui.sh:2759
+msgid "Redo"
+msgstr "Refazer"
+
+#: git-gui.sh:2763 git-gui.sh:3368
+msgid "Cut"
+msgstr "Cortar"
+
+#: git-gui.sh:2766 git-gui.sh:3371 git-gui.sh:3445 git-gui.sh:3530
+#: lib/console.tcl:69
+msgid "Copy"
+msgstr "Copiar"
+
+#: git-gui.sh:2769 git-gui.sh:3374
+msgid "Paste"
+msgstr "Colar"
+
+#: git-gui.sh:2772 git-gui.sh:3377 lib/remote_branch_delete.tcl:39
+#: lib/branch_delete.tcl:28
+msgid "Delete"
+msgstr "Eliminar"
+
+#: git-gui.sh:2776 git-gui.sh:3381 git-gui.sh:3534 lib/console.tcl:71
+msgid "Select All"
+msgstr "Selecionar tudo"
+
+#: git-gui.sh:2785
+msgid "Create..."
+msgstr "Criar..."
+
+#: git-gui.sh:2791
+msgid "Checkout..."
+msgstr "Extrair..."
+
+#: git-gui.sh:2797
+msgid "Rename..."
+msgstr "Mudar nome..."
+
+#: git-gui.sh:2802
+msgid "Delete..."
+msgstr "Eliminar..."
+
+#: git-gui.sh:2807
+msgid "Reset..."
+msgstr "Repor..."
+
+#: git-gui.sh:2817
+msgid "Done"
+msgstr "Conclu=C3=ADdo"
+
+#: git-gui.sh:2819
+msgid "Commit@@verb"
+msgstr "Submeter"
+
+#: git-gui.sh:2828 git-gui.sh:3309
+msgid "New Commit"
+msgstr "Novo commit"
+
+#: git-gui.sh:2836 git-gui.sh:3316
+msgid "Amend Last Commit"
+msgstr "Emendar =C3=BAltimo commit"
+
+#: git-gui.sh:2846 git-gui.sh:3270 lib/remote_branch_delete.tcl:101
+msgid "Rescan"
+msgstr "Reanalisar"
+
+#: git-gui.sh:2852
+msgid "Stage To Commit"
+msgstr "Preparar para commit"
+
+#: git-gui.sh:2858
+msgid "Stage Changed Files To Commit"
+msgstr "Preparar ficheiros modificados para commit"
+
+#: git-gui.sh:2864
+msgid "Unstage From Commit"
+msgstr "Retirar do commit"
+
+#: git-gui.sh:2870 lib/index.tcl:442
+msgid "Revert Changes"
+msgstr "Reverter altera=C3=A7=C3=B5es"
+
+#: git-gui.sh:2878 git-gui.sh:3581 git-gui.sh:3612
+msgid "Show Less Context"
+msgstr "Mostrar menos contexto"
+
+#: git-gui.sh:2882 git-gui.sh:3585 git-gui.sh:3616
+msgid "Show More Context"
+msgstr "Mostrar mais contexto"
+
+#: git-gui.sh:2889 git-gui.sh:3283 git-gui.sh:3392
+msgid "Sign Off"
+msgstr "Assinar por baixo"
+
+#: git-gui.sh:2905
+msgid "Local Merge..."
+msgstr "Integra=C3=A7=C3=A3o local..."
+
+#: git-gui.sh:2910
+msgid "Abort Merge..."
+msgstr "Abortar integra=C3=A7=C3=A3o..."
+
+#: git-gui.sh:2922 git-gui.sh:2950
+msgid "Add..."
+msgstr "Adicionar..."
+
+#: git-gui.sh:2926
+msgid "Push..."
+msgstr "Publicar..."
+
+#: git-gui.sh:2930
+msgid "Delete Branch..."
+msgstr "Eliminar ramo..."
+
+#: git-gui.sh:2940 git-gui.sh:3563
+msgid "Options..."
+msgstr "Op=C3=A7=C3=B5es..."
+
+#: git-gui.sh:2951
+msgid "Remove..."
+msgstr "Remover..."
+
+#: git-gui.sh:2960 lib/choose_repository.tcl:55
+msgid "Help"
+msgstr "Ajuda"
+
+#: git-gui.sh:2964 git-gui.sh:2968 lib/choose_repository.tcl:49
+#: lib/choose_repository.tcl:58 lib/about.tcl:14
+#, tcl-format
+msgid "About %s"
+msgstr "Sobre %s"
+
+#: git-gui.sh:2992
+msgid "Online Documentation"
+msgstr "Documenta=C3=A7=C3=A3o online"
+
+#: git-gui.sh:2995 lib/choose_repository.tcl:52 lib/choose_repository.=
tcl:61
+msgid "Show SSH Key"
+msgstr "Mostrar chave SSH"
+
+#: git-gui.sh:3014 git-gui.sh:3146
+msgid "Usage"
+msgstr "Utiliza=C3=A7=C3=A3o"
+
+#: git-gui.sh:3095 lib/blame.tcl:573
+msgid "Error"
+msgstr "Erro"
+
+#: git-gui.sh:3126
+#, tcl-format
+msgid "fatal: cannot stat path %s: No such file or directory"
+msgstr ""
+"fatal: n=C3=A3o =C3=A9 poss=C3=ADvel obter estado do caminho %s: Fich=
eiro ou diret=C3=B3rio "
+"inexistente"
+
+#: git-gui.sh:3159
+msgid "Current Branch:"
+msgstr "Ramo atual:"
+
+#: git-gui.sh:3185
+msgid "Staged Changes (Will Commit)"
+msgstr "Altera=C3=A7=C3=B5es preparadas (para commit)"
+
+#: git-gui.sh:3205
+msgid "Unstaged Changes"
+msgstr "Altera=C3=A7=C3=B5es n=C3=A3o preparadas"
+
+#: git-gui.sh:3276
+msgid "Stage Changed"
+msgstr "Preparar modificados"
+
+#: git-gui.sh:3295 lib/transport.tcl:137 lib/transport.tcl:229
+msgid "Push"
+msgstr "Publicar"
+
+#: git-gui.sh:3330
+msgid "Initial Commit Message:"
+msgstr "Mensagem de commit inicial:"
+
+#: git-gui.sh:3331
+msgid "Amended Commit Message:"
+msgstr "Mensagem de commit emendada:"
+
+#: git-gui.sh:3332
+msgid "Amended Initial Commit Message:"
+msgstr "Mensagem de commit inicial emendada:"
+
+#: git-gui.sh:3333
+msgid "Amended Merge Commit Message:"
+msgstr "Mensagem de commit de integra=C3=A7=C3=A3o emendada:"
+
+#: git-gui.sh:3334
+msgid "Merge Commit Message:"
+msgstr "Mensagem de commit de integra=C3=A7=C3=A3o:"
+
+#: git-gui.sh:3335
+msgid "Commit Message:"
+msgstr "Mensagem de commit:"
+
+#: git-gui.sh:3384 git-gui.sh:3538 lib/console.tcl:73
+msgid "Copy All"
+msgstr "Copiar tudo"
+
+#: git-gui.sh:3408 lib/blame.tcl:105
+msgid "File:"
+msgstr "Ficheiro:"
+
+#: git-gui.sh:3526
+msgid "Refresh"
+msgstr "Atualizar"
+
+#: git-gui.sh:3547
+msgid "Decrease Font Size"
+msgstr "Diminuir tamanho de letra"
+
+#: git-gui.sh:3551
+msgid "Increase Font Size"
+msgstr "Aumentar tamanho de letra"
+
+#: git-gui.sh:3559 lib/blame.tcl:294
+msgid "Encoding"
+msgstr "Codifica=C3=A7=C3=A3o"
+
+#: git-gui.sh:3570
+msgid "Apply/Reverse Hunk"
+msgstr "Aplicar/Reverter excerto"
+
+#: git-gui.sh:3575
+msgid "Apply/Reverse Line"
+msgstr "Aplicar/Reverter linha"
+
+#: git-gui.sh:3594
+msgid "Run Merge Tool"
+msgstr "Executar ferramenta de integra=C3=A7=C3=A3o"
+
+#: git-gui.sh:3599
+msgid "Use Remote Version"
+msgstr "Usar a vers=C3=A3o remota"
+
+#: git-gui.sh:3603
+msgid "Use Local Version"
+msgstr "Usar a vers=C3=A3o local"
+
+#: git-gui.sh:3607
+msgid "Revert To Base"
+msgstr "Reverter para a base"
+
+#: git-gui.sh:3625
+msgid "Visualize These Changes In The Submodule"
+msgstr "Visualizar estas altera=C3=A7=C3=B5es no subm=C3=B3dulo"
+
+#: git-gui.sh:3629
+msgid "Visualize Current Branch History In The Submodule"
+msgstr "Visualizar hist=C3=B3rico do ramo atual no subm=C3=B3dulo"
+
+#: git-gui.sh:3633
+msgid "Visualize All Branch History In The Submodule"
+msgstr "Visualizar hist=C3=B3rico de todos os ramos no subm=C3=B3dulo"
+
+#: git-gui.sh:3638
+msgid "Start git gui In The Submodule"
+msgstr "Iniciar git gui no subm=C3=B3dulo"
+
+#: git-gui.sh:3673
+msgid "Unstage Hunk From Commit"
+msgstr "Retirar excerto do commit"
+
+#: git-gui.sh:3675
+msgid "Unstage Lines From Commit"
+msgstr "Retirar linhas do commit"
+
+#: git-gui.sh:3677
+msgid "Unstage Line From Commit"
+msgstr "Retirar linha do commit"
+
+#: git-gui.sh:3680
+msgid "Stage Hunk For Commit"
+msgstr "Preparar excerto para commit"
+
+#: git-gui.sh:3682
+msgid "Stage Lines For Commit"
+msgstr "Preparar linhas para commit"
+
+#: git-gui.sh:3684
+msgid "Stage Line For Commit"
+msgstr "Preparar linha para commit"
+
+#: git-gui.sh:3709
+msgid "Initializing..."
+msgstr "A inicializar..."
+
+#: git-gui.sh:3852
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
+#: git-gui.sh:3881
+msgid ""
+"\n"
+"This is due to a known issue with the\n"
+"Tcl binary distributed by Cygwin."
+msgstr ""
+"\n"
+"Devido a um problema conhecido com o\n"
+"bin=C3=A1rio Tcl distribu=C3=ADdo pelo Cygwin."
+
+#: git-gui.sh:3886
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
+#: lib/line.tcl:17
+msgid "Goto Line:"
+msgstr "Ir para a linha:"
+
+#: lib/line.tcl:23
+msgid "Go"
+msgstr "Ir"
+
+#: lib/console.tcl:59
+msgid "Working... please wait..."
+msgstr "A processar... aguarde..."
+
+#: lib/console.tcl:81 lib/checkout_op.tcl:146 lib/sshkey.tcl:55
+#: lib/database.tcl:30
+msgid "Close"
+msgstr "Fechar"
+
+#: lib/console.tcl:186
+msgid "Success"
+msgstr "Sucesso"
+
+#: lib/console.tcl:200
+msgid "Error: Command Failed"
+msgstr "Erro: falha ao executar comando"
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
+#: lib/checkout_op.tcl:202 lib/branch_rename.tcl:102
+#, tcl-format
+msgid "Branch '%s' already exists."
+msgstr "O ramo '%s' j=C3=A1 existe."
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
+#: lib/checkout_op.tcl:567 lib/tools_dlg.tcl:336 lib/merge.tcl:166
+msgid "Visualize"
+msgstr "Visualizar"
+
+#: lib/checkout_op.tcl:571 lib/branch_create.tcl:85
+msgid "Reset"
+msgstr "Repor"
+
+#: lib/checkout_op.tcl:579 lib/transport.tcl:141 lib/remote_add.tcl:34
+#: lib/browser.tcl:292 lib/branch_checkout.tcl:30 lib/choose_font.tcl:=
45
+#: lib/option.tcl:127 lib/tools_dlg.tcl:41 lib/tools_dlg.tcl:202
+#: lib/tools_dlg.tcl:345 lib/branch_rename.tcl:32
+#: lib/remote_branch_delete.tcl:43 lib/branch_create.tcl:37
+#: lib/branch_delete.tcl:34 lib/merge.tcl:174
+msgid "Cancel"
+msgstr "Cancelar"
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
+#: lib/transport.tcl:6 lib/remote_add.tcl:132
+#, tcl-format
+msgid "fetch %s"
+msgstr "obter %s"
+
+#: lib/transport.tcl:7
+#, tcl-format
+msgid "Fetching new changes from %s"
+msgstr "Obter novas altera=C3=A7=C3=B5es de %s"
+
+#: lib/transport.tcl:18
+#, tcl-format
+msgid "remote prune %s"
+msgstr "poda remota de %s"
+
+#: lib/transport.tcl:19
+#, tcl-format
+msgid "Pruning tracking branches deleted from %s"
+msgstr "A podar ramos de monitoriza=C3=A7=C3=A3o eliminados de %s"
+
+#: lib/transport.tcl:25
+msgid "fetch all remotes"
+msgstr "obter de todos os remotos"
+
+#: lib/transport.tcl:26
+msgid "Fetching new changes from all remotes"
+msgstr "A obter novas altera=C3=A7=C3=B5es de todos os remotos"
+
+#: lib/transport.tcl:40
+msgid "remote prune all remotes"
+msgstr "poda remota de todos os remotos"
+
+#: lib/transport.tcl:41
+msgid "Pruning tracking branches deleted from all remotes"
+msgstr "A podar ramos de monitoriza=C3=A7=C3=A3o eliminados de todos o=
s remotos"
+
+#: lib/transport.tcl:54 lib/transport.tcl:92 lib/transport.tcl:110
+#: lib/remote_add.tcl:162
+#, tcl-format
+msgid "push %s"
+msgstr "publicar %s"
+
+#: lib/transport.tcl:55
+#, tcl-format
+msgid "Pushing changes to %s"
+msgstr "A publicar altera=C3=A7=C3=B5es em %s"
+
+#: lib/transport.tcl:93
+#, tcl-format
+msgid "Mirroring to %s"
+msgstr "A espelhar em %s"
+
+#: lib/transport.tcl:111
+#, tcl-format
+msgid "Pushing %s %s to %s"
+msgstr "A publicar %s %s em %s"
+
+#: lib/transport.tcl:132
+msgid "Push Branches"
+msgstr "Publicar ramos"
+
+#: lib/transport.tcl:147
+msgid "Source Branches"
+msgstr "Ramos de origem"
+
+#: lib/transport.tcl:162
+msgid "Destination Repository"
+msgstr "Reposit=C3=B3rio de destino"
+
+#: lib/transport.tcl:165 lib/remote_branch_delete.tcl:51
+msgid "Remote:"
+msgstr "Remoto:"
+
+#: lib/transport.tcl:187 lib/remote_branch_delete.tcl:72
+msgid "Arbitrary Location:"
+msgstr "Localiza=C3=A7=C3=A3o arbitr=C3=A1ria:"
+
+#: lib/transport.tcl:205
+msgid "Transfer Options"
+msgstr "Op=C3=A7=C3=B5es de transfer=C3=AAncia"
+
+#: lib/transport.tcl:207
+msgid "Force overwrite existing branch (may discard changes)"
+msgstr "For=C3=A7ar substitui=C3=A7=C3=A3o de ramos existente (pode de=
scartar altera=C3=A7=C3=B5es)"
+
+#: lib/transport.tcl:211
+msgid "Use thin pack (for slow network connections)"
+msgstr "Usar pacote fino (para conex=C3=B5es de rede lentas)"
+
+#: lib/transport.tcl:215
+msgid "Include tags"
+msgstr "Incluir tags"
+
+#: lib/remote_add.tcl:20
+msgid "Add Remote"
+msgstr "Adicionar remoto"
+
+#: lib/remote_add.tcl:25
+msgid "Add New Remote"
+msgstr "Adicionar novo remoto"
+
+#: lib/remote_add.tcl:30 lib/tools_dlg.tcl:37
+msgid "Add"
+msgstr "Adicionar"
+
+#: lib/remote_add.tcl:39
+msgid "Remote Details"
+msgstr "Detalhes do remoto"
+
+#: lib/remote_add.tcl:41 lib/tools_dlg.tcl:51 lib/branch_create.tcl:44
+msgid "Name:"
+msgstr "Nome:"
+
+#: lib/remote_add.tcl:50
+msgid "Location:"
+msgstr "Localiza=C3=A7=C3=A3o:"
+
+#: lib/remote_add.tcl:60
+msgid "Further Action"
+msgstr "A=C3=A7=C3=A3o adicional"
+
+#: lib/remote_add.tcl:63
+msgid "Fetch Immediately"
+msgstr "Obter imediatamente"
+
+#: lib/remote_add.tcl:69
+msgid "Initialize Remote Repository and Push"
+msgstr "Inicializar reposit=C3=B3rio remoto e publicar"
+
+#: lib/remote_add.tcl:75
+msgid "Do Nothing Else Now"
+msgstr "N=C3=A3o fazer mais nada agora"
+
+#: lib/remote_add.tcl:100
+msgid "Please supply a remote name."
+msgstr "Forne=C3=A7a um nome para o remoto."
+
+#: lib/remote_add.tcl:113
+#, tcl-format
+msgid "'%s' is not an acceptable remote name."
+msgstr "'%s' n=C3=A3o pode ser aceite como nome de remoto."
+
+#: lib/remote_add.tcl:124
+#, tcl-format
+msgid "Failed to add remote '%s' of location '%s'."
+msgstr "Falha ao adicionar remoto '%s' localizado em '%s'."
+
+#: lib/remote_add.tcl:133
+#, tcl-format
+msgid "Fetching the %s"
+msgstr "A obter de %s"
+
+#: lib/remote_add.tcl:156
+#, tcl-format
+msgid "Do not know how to initialize repository at location '%s'."
+msgstr "N=C3=A3o se sabe como inicializar o reposit=C3=B3rio localizad=
o em '%s'."
+
+#: lib/remote_add.tcl:163
+#, tcl-format
+msgid "Setting up the %s (at %s)"
+msgstr "A configurar %s (em %s)"
+
+#: lib/browser.tcl:17
+msgid "Starting..."
+msgstr "A iniciar..."
+
+#: lib/browser.tcl:27
+msgid "File Browser"
+msgstr "Navegador de ficheiros"
+
+#: lib/browser.tcl:132 lib/browser.tcl:149
+#, tcl-format
+msgid "Loading %s..."
+msgstr "A carregar %s..."
+
+#: lib/browser.tcl:193
+msgid "[Up To Parent]"
+msgstr "[Subir]"
+
+#: lib/browser.tcl:275 lib/browser.tcl:282
+msgid "Browse Branch Files"
+msgstr "Navegar pelos ficheiros do ramo"
+
+#: lib/browser.tcl:288 lib/choose_repository.tcl:422
+#: lib/choose_repository.tcl:509 lib/choose_repository.tcl:518
+#: lib/choose_repository.tcl:1074
+msgid "Browse"
+msgstr "Navegar"
+
+#: lib/browser.tcl:297 lib/branch_checkout.tcl:35 lib/tools_dlg.tcl:32=
1
+msgid "Revision"
+msgstr "Revis=C3=A3o"
+
+#: lib/tools.tcl:75
+#, tcl-format
+msgid "Running %s requires a selected file."
+msgstr "Deve selecionar um ficheiro para executar %s."
+
+#: lib/tools.tcl:91
+#, tcl-format
+msgid "Are you sure you want to run %1$s on file \"%2$s\"?"
+msgstr "Tem a certeza que pretende executar %1$s sobre o ficheiro \"%2=
$s\"?"
+
+#: lib/tools.tcl:95
+#, tcl-format
+msgid "Are you sure you want to run %s?"
+msgstr "Tem a certeza que pretende executar %s?"
+
+#: lib/tools.tcl:116
+#, tcl-format
+msgid "Tool: %s"
+msgstr "Ferramenta: %s"
+
+#: lib/tools.tcl:117
+#, tcl-format
+msgid "Running: %s"
+msgstr "A executar: %s"
+
+#: lib/tools.tcl:155
+#, tcl-format
+msgid "Tool completed successfully: %s"
+msgstr "A ferramenta conclu=C3=AD com sucesso: %s"
+
+#: lib/tools.tcl:157
+#, tcl-format
+msgid "Tool failed: %s"
+msgstr "A ferramenta falhou: %s"
+
+#: lib/branch_checkout.tcl:16 lib/branch_checkout.tcl:21
+msgid "Checkout Branch"
+msgstr "Extrair ramo"
+
+#: lib/branch_checkout.tcl:26
+msgid "Checkout"
+msgstr "Extrair"
+
+#: lib/branch_checkout.tcl:39 lib/option.tcl:310 lib/branch_create.tcl=
:69
+msgid "Options"
+msgstr "Op=C3=A7=C3=B5es"
+
+#: lib/branch_checkout.tcl:42 lib/branch_create.tcl:92
+msgid "Fetch Tracking Branch"
+msgstr "Obter ramo de monitoriza=C3=A7=C3=A3o"
+
+#: lib/branch_checkout.tcl:47
+msgid "Detach From Local Branch"
+msgstr "Destacar do ramo local"
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
+#: lib/status_bar.tcl:87
+#, tcl-format
+msgid "%s ... %*i of %*i %s (%3i%%)"
+msgstr "%s ... %*i de %*i %s (%3i%%)"
+
+#: lib/diff.tcl:77
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
+#: lib/diff.tcl:117
+#, tcl-format
+msgid "Loading diff of %s..."
+msgstr "A carregar diferen=C3=A7as de %s..."
+
+#: lib/diff.tcl:140
+msgid ""
+"LOCAL: deleted\n"
+"REMOTE:\n"
+msgstr ""
+"LOCAL: eliminado\n"
+"REMOTO:\n"
+
+#: lib/diff.tcl:145
+msgid ""
+"REMOTE: deleted\n"
+"LOCAL:\n"
+msgstr ""
+"REMOTO: eliminado\n"
+"LOCAL:\n"
+
+#: lib/diff.tcl:152
+msgid "LOCAL:\n"
+msgstr "LOCAL:\n"
+
+#: lib/diff.tcl:155
+msgid "REMOTE:\n"
+msgstr "REMOTO:\n"
+
+#: lib/diff.tcl:217 lib/diff.tcl:355
+#, tcl-format
+msgid "Unable to display %s"
+msgstr "N=C3=A3o =C3=A9 poss=C3=ADvel mostrar %s"
+
+#: lib/diff.tcl:218
+msgid "Error loading file:"
+msgstr "Erro ao carregar ficheiro:"
+
+#: lib/diff.tcl:225
+msgid "Git Repository (subproject)"
+msgstr "Reposit=C3=B3rio Git (subprojeto)"
+
+#: lib/diff.tcl:237
+msgid "* Binary file (not showing content)."
+msgstr "* Ficheiro bin=C3=A1rio (conte=C3=BAdo n=C3=A3o exibido)."
+
+#: lib/diff.tcl:242
+#, tcl-format
+msgid ""
+"* Untracked file is %d bytes.\n"
+"* Showing only first %d bytes.\n"
+msgstr ""
+"* O ficheiro n=C3=A3o controlado tem %d bytes.\n"
+"* Exibido apenas os primeiros %d bytes.\n"
+
+#: lib/diff.tcl:248
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
+#: lib/diff.tcl:356 lib/blame.tcl:1128
+msgid "Error loading diff:"
+msgstr "Erro ao carregar diferen=C3=A7as:"
+
+#: lib/diff.tcl:578
+msgid "Failed to unstage selected hunk."
+msgstr "Falha ao retirar excerto selecionado do =C3=ADndice."
+
+#: lib/diff.tcl:585
+msgid "Failed to stage selected hunk."
+msgstr "Falha ao preparar excerto selecionado."
+
+#: lib/diff.tcl:664
+msgid "Failed to unstage selected line."
+msgstr "Falha ao retirar linha selecionada do =C3=ADndice."
+
+#: lib/diff.tcl:672
+msgid "Failed to stage selected line."
+msgstr "Falha ao preparar linha selecionada."
+
+#: lib/remote.tcl:200
+msgid "Push to"
+msgstr "Publicar em"
+
+#: lib/remote.tcl:218
+msgid "Remove Remote"
+msgstr "Remover remoto"
+
+#: lib/remote.tcl:223
+msgid "Prune from"
+msgstr "Podar de"
+
+#: lib/remote.tcl:228
+msgid "Fetch from"
+msgstr "Obter de"
+
+#: lib/choose_font.tcl:41
+msgid "Select"
+msgstr "Selecionar"
+
+#: lib/choose_font.tcl:55
+msgid "Font Family"
+msgstr "Fam=C3=ADlia de tipo de letra"
+
+#: lib/choose_font.tcl:76
+msgid "Font Size"
+msgstr "Tamanho de letra"
+
+#: lib/choose_font.tcl:93
+msgid "Font Example"
+msgstr "Exemplo do tipo de letra"
+
+#: lib/choose_font.tcl:105
+msgid ""
+"This is example text.\n"
+"If you like this text, it can be your font."
+msgstr ""
+"Este texto =C3=A9 um exemplo.\n"
+"Se gostar deste texto, pode defini-lo como tipo de letra."
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
+#: lib/option.tcl:119
+msgid "Restore Defaults"
+msgstr "Restaurar predefini=C3=A7=C3=B5es"
+
+#: lib/option.tcl:123
+msgid "Save"
+msgstr "Guardar"
+
+#: lib/option.tcl:133
+#, tcl-format
+msgid "%s Repository"
+msgstr "Reposit=C3=B3rio %s"
+
+#: lib/option.tcl:134
+msgid "Global (All Repositories)"
+msgstr "Global (todos os reposit=C3=B3rios)"
+
+#: lib/option.tcl:140
+msgid "User Name"
+msgstr "Nome de utilizador"
+
+#: lib/option.tcl:141
+msgid "Email Address"
+msgstr "Endere=C3=A7o de e-mail"
+
+#: lib/option.tcl:143
+msgid "Summarize Merge Commits"
+msgstr "Resumir commits de integra=C3=A7=C3=A3o"
+
+#: lib/option.tcl:144
+msgid "Merge Verbosity"
+msgstr "Verbosidade de integra=C3=A7=C3=A3o"
+
+#: lib/option.tcl:145
+msgid "Show Diffstat After Merge"
+msgstr "Mostrar estat=C3=ADsticas de diferen=C3=A7as depois de integra=
r"
+
+#: lib/option.tcl:146
+msgid "Use Merge Tool"
+msgstr "Usar ferramenta de integra=C3=A7=C3=A3o"
+
+#: lib/option.tcl:148
+msgid "Trust File Modification Timestamps"
+msgstr "Confiar na data de modifica=C3=A7=C3=A3o dos ficheiros"
+
+#: lib/option.tcl:149
+msgid "Prune Tracking Branches During Fetch"
+msgstr "Podar ramos de monitoriza=C3=A7=C3=A3o ao obter"
+
+#: lib/option.tcl:150
+msgid "Match Tracking Branches"
+msgstr "Corresponder ramos de monitoriza=C3=A7=C3=A3o"
+
+#: lib/option.tcl:151
+msgid "Use Textconv For Diffs and Blames"
+msgstr "Usar textconv para mostrar diferen=C3=A7as e culpar"
+
+#: lib/option.tcl:152
+msgid "Blame Copy Only On Changed Files"
+msgstr "Detetar c=C3=B3pia apenas em ficheiros modificados"
+
+#: lib/option.tcl:153
+msgid "Maximum Length of Recent Repositories List"
+msgstr "Comprimento m=C3=A1ximo da lista de reposit=C3=B3rios recentes=
"
+
+#: lib/option.tcl:154
+msgid "Minimum Letters To Blame Copy On"
+msgstr "N=C3=BAmero m=C3=ADnimo de letras para detetar c=C3=B3pia"
+
+#: lib/option.tcl:155
+msgid "Blame History Context Radius (days)"
+msgstr "Raio de contexto hist=C3=B3rico para culpar (dias)"
+
+#: lib/option.tcl:156
+msgid "Number of Diff Context Lines"
+msgstr "N=C3=BAmero de linhas de contexto ao mostrar diferen=C3=A7as"
+
+#: lib/option.tcl:157
+msgid "Additional Diff Parameters"
+msgstr "Par=C3=A2metros de diff adicionais"
+
+#: lib/option.tcl:158
+msgid "Commit Message Text Width"
+msgstr "Largura do texto da mensagem de commit"
+
+#: lib/option.tcl:159
+msgid "New Branch Name Template"
+msgstr "Modelo para nome de novo ramo"
+
+#: lib/option.tcl:160
+msgid "Default File Contents Encoding"
+msgstr "Codifica=C3=A7=C3=A3o predefinida dos conte=C3=BAdos de fichei=
ros"
+
+#: lib/option.tcl:161
+msgid "Warn before committing to a detached head"
+msgstr "Avisar antes de submeter numa cabe=C3=A7a destacada"
+
+#: lib/option.tcl:162
+msgid "Staging of untracked files"
+msgstr "Preparar ficheiros n=C3=A3o controlados"
+
+#: lib/option.tcl:163
+msgid "Show untracked files"
+msgstr "Mostrar ficheiros n=C3=A3o controlados"
+
+#: lib/option.tcl:164
+msgid "Tab spacing"
+msgstr "Espa=C3=A7amento da tabula=C3=A7=C3=A3o"
+
+#: lib/option.tcl:210
+msgid "Change"
+msgstr "Alterar"
+
+#: lib/option.tcl:254
+msgid "Spelling Dictionary:"
+msgstr "Dicion=C3=A1rio ortogr=C3=A1fico:"
+
+#: lib/option.tcl:284
+msgid "Change Font"
+msgstr "Alterar tipo de letra"
+
+#: lib/option.tcl:288
+#, tcl-format
+msgid "Choose %s"
+msgstr "Escolher %s"
+
+#: lib/option.tcl:294
+msgid "pt."
+msgstr "pt."
+
+#: lib/option.tcl:308
+msgid "Preferences"
+msgstr "Prefer=C3=AAncias"
+
+#: lib/option.tcl:345
+msgid "Failed to completely save options:"
+msgstr "Falha ao guardar todas as op=C3=A7=C3=B5es:"
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
+#: lib/mergetool.tcl:246
+#, tcl-format
+msgid "Not a GUI merge tool: '%s'"
+msgstr "N=C3=A3o =C3=A9 uma ferramenta GUI de integra=C3=A7=C3=A3o: '%=
s'"
+
+#: lib/mergetool.tcl:275
+#, tcl-format
+msgid "Unsupported merge tool '%s'"
+msgstr "Ferramenta de integra=C3=A7=C3=A3o '%s' n=C3=A3o suportada"
+
+#: lib/mergetool.tcl:310
+msgid "Merge tool is already running, terminate it?"
+msgstr "A ferramenta de integra=C3=A7=C3=A3o j=C3=A1 est=C3=A1 a execu=
tar, termin=C3=A1-la?"
+
+#: lib/mergetool.tcl:330
+#, tcl-format
+msgid ""
+"Error retrieving versions:\n"
+"%s"
+msgstr ""
+"Erro ao obter vers=C3=B5es:\n"
+"%s"
+
+#: lib/mergetool.tcl:350
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
+#: lib/mergetool.tcl:354
+msgid "Running merge tool..."
+msgstr "A executar a ferramenta de integra=C3=A7=C3=A3o..."
+
+#: lib/mergetool.tcl:382 lib/mergetool.tcl:390
+msgid "Merge tool failed."
+msgstr "A ferramenta de integra=C3=A7=C3=A3o falhou."
+
+#: lib/tools_dlg.tcl:22
+msgid "Add Tool"
+msgstr "Adicionar ferramenta"
+
+#: lib/tools_dlg.tcl:28
+msgid "Add New Tool Command"
+msgstr "Adicionar novo comando de ferramenta"
+
+#: lib/tools_dlg.tcl:34
+msgid "Add globally"
+msgstr "Adicionar globalmente"
+
+#: lib/tools_dlg.tcl:46
+msgid "Tool Details"
+msgstr "Detalhes da ferramenta"
+
+#: lib/tools_dlg.tcl:49
+msgid "Use '/' separators to create a submenu tree:"
+msgstr "Use separadores '/' para criar uma =C3=A1rvore de submenus:"
+
+#: lib/tools_dlg.tcl:60
+msgid "Command:"
+msgstr "Comando:"
+
+#: lib/tools_dlg.tcl:71
+msgid "Show a dialog before running"
+msgstr "Mostrar um di=C3=A1logo antes de executar"
+
+#: lib/tools_dlg.tcl:77
+msgid "Ask the user to select a revision (sets $REVISION)"
+msgstr "Pedir ao utilizador para selecionar uma revis=C3=A3o (define $=
REVISION)"
+
+#: lib/tools_dlg.tcl:82
+msgid "Ask the user for additional arguments (sets $ARGS)"
+msgstr "Pedir ao utilizador argumentos adicionais (define $ARGS)"
+
+#: lib/tools_dlg.tcl:89
+msgid "Don't show the command output window"
+msgstr "N=C3=A3o mostrar a janela com a sa=C3=ADda do comando"
+
+#: lib/tools_dlg.tcl:94
+msgid "Run only if a diff is selected ($FILENAME not empty)"
+msgstr "Executar s=C3=B3 se for selecionada um diferen=C3=A7a ($FILENA=
ME n=C3=A3o vazio)"
+
+#: lib/tools_dlg.tcl:118
+msgid "Please supply a name for the tool."
+msgstr "Forne=C3=A7a um nome para a ferramenta."
+
+#: lib/tools_dlg.tcl:126
+#, tcl-format
+msgid "Tool '%s' already exists."
+msgstr "A ferramenta '%s' j=C3=A1 existe."
+
+#: lib/tools_dlg.tcl:148
+#, tcl-format
+msgid ""
+"Could not add tool:\n"
+"%s"
+msgstr ""
+"N=C3=A3o foi poss=C3=ADvel adicionar ferramenta:\n"
+"%s"
+
+#: lib/tools_dlg.tcl:187
+msgid "Remove Tool"
+msgstr "Remover ferramenta"
+
+#: lib/tools_dlg.tcl:193
+msgid "Remove Tool Commands"
+msgstr "Remover comandos de ferramenta"
+
+#: lib/tools_dlg.tcl:198
+msgid "Remove"
+msgstr "Remover"
+
+#: lib/tools_dlg.tcl:231
+msgid "(Blue denotes repository-local tools)"
+msgstr "(Azul denota ferramentas locais do reposit=C3=B3rio)"
+
+#: lib/tools_dlg.tcl:292
+#, tcl-format
+msgid "Run Command: %s"
+msgstr "Executar comando: %s"
+
+#: lib/tools_dlg.tcl:306
+msgid "Arguments"
+msgstr "Argumentos"
+
+#: lib/tools_dlg.tcl:341
+msgid "OK"
+msgstr "OK"
+
+#: lib/search.tcl:48
+msgid "Find:"
+msgstr "Procurar:"
+
+#: lib/search.tcl:50
+msgid "Next"
+msgstr "Seguinte"
+
+#: lib/search.tcl:51
+msgid "Prev"
+msgstr "Anterior"
+
+#: lib/search.tcl:52
+msgid "RegExp"
+msgstr "ExpReg"
+
+#: lib/search.tcl:54
+msgid "Case"
+msgstr "Mai=C3=BAsculas"
+
+#: lib/shortcut.tcl:21 lib/shortcut.tcl:62
+msgid "Cannot write shortcut:"
+msgstr "N=C3=A3o =C3=A9 poss=C3=ADvel escrever atalho:"
+
+#: lib/shortcut.tcl:137
+msgid "Cannot write icon:"
+msgstr "N=C3=A3o =C3=A9 poss=C3=ADvel escrever =C3=ADcone:"
+
+#: lib/branch_rename.tcl:15 lib/branch_rename.tcl:23
+msgid "Rename Branch"
+msgstr "Mudar nome de ramo"
+
+#: lib/branch_rename.tcl:28
+msgid "Rename"
+msgstr "Mudar nome"
+
+#: lib/branch_rename.tcl:38
+msgid "Branch:"
+msgstr "Ramo:"
+
+#: lib/branch_rename.tcl:46
+msgid "New Name:"
+msgstr "Novo nome:"
+
+#: lib/branch_rename.tcl:81
+msgid "Please select a branch to rename."
+msgstr "Selecione um ramo para mudar de nome."
+
+#: lib/branch_rename.tcl:92 lib/branch_create.tcl:154
+msgid "Please supply a branch name."
+msgstr "Indique um nome para o ramo."
+
+#: lib/branch_rename.tcl:112 lib/branch_create.tcl:165
+#, tcl-format
+msgid "'%s' is not an acceptable branch name."
+msgstr "'%s' n=C3=A3o pode ser aceite como nome de ramo."
+
+#: lib/branch_rename.tcl:123
+#, tcl-format
+msgid "Failed to rename '%s'."
+msgstr "Falha ao mudar o nome de '%s'."
+
+#: lib/remote_branch_delete.tcl:29 lib/remote_branch_delete.tcl:34
+msgid "Delete Branch Remotely"
+msgstr "Remover ramo remotamente"
+
+#: lib/remote_branch_delete.tcl:48
+msgid "From Repository"
+msgstr "Do reposit=C3=B3rio"
+
+#: lib/remote_branch_delete.tcl:88
+msgid "Branches"
+msgstr "Ramos"
+
+#: lib/remote_branch_delete.tcl:110
+msgid "Delete Only If"
+msgstr "Eliminar s=C3=B3 se"
+
+#: lib/remote_branch_delete.tcl:112
+msgid "Merged Into:"
+msgstr "Integrar em:"
+
+#: lib/remote_branch_delete.tcl:120 lib/branch_delete.tcl:53
+msgid "Always (Do not perform merge checks)"
+msgstr "Sempre (n=C3=A3o realizar verifica=C3=A7=C3=A3o de integra=C3=A7=
=C3=A3o)"
+
+#: lib/remote_branch_delete.tcl:153
+msgid "A branch is required for 'Merged Into'."
+msgstr "=C3=89 necess=C3=A1rio um ramo em 'Integrar em'."
+
+#: lib/remote_branch_delete.tcl:185
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
+#: lib/remote_branch_delete.tcl:190
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
+#: lib/remote_branch_delete.tcl:208
+msgid "Please select one or more branches to delete."
+msgstr "Selecione um ou mais ramos para eliminar."
+
+#: lib/remote_branch_delete.tcl:218 lib/branch_delete.tcl:115
+msgid ""
+"Recovering deleted branches is difficult.\n"
+"\n"
+"Delete the selected branches?"
+msgstr ""
+"Recuperar ramos eliminados =C3=A9 dif=C3=ADcil.\n"
+"\n"
+"Eliminar os ramos selecionado?"
+
+#: lib/remote_branch_delete.tcl:227
+#, tcl-format
+msgid "Deleting branches from %s"
+msgstr "A eliminar ramos de %s"
+
+#: lib/remote_branch_delete.tcl:300
+msgid "No repository selected."
+msgstr "Nenhum reposit=C3=B3rio selecionado."
+
+#: lib/remote_branch_delete.tcl:305
+#, tcl-format
+msgid "Scanning %s..."
+msgstr "A analisar %s..."
+
+#: lib/choose_repository.tcl:33
+msgid "Git Gui"
+msgstr "Git Gui"
+
+#: lib/choose_repository.tcl:92 lib/choose_repository.tcl:412
+msgid "Create New Repository"
+msgstr "Criar novo reposit=C3=B3rio"
+
+#: lib/choose_repository.tcl:98
+msgid "New..."
+msgstr "Novo..."
+
+#: lib/choose_repository.tcl:105 lib/choose_repository.tcl:496
+msgid "Clone Existing Repository"
+msgstr "Clonar reposit=C3=B3rio existente"
+
+#: lib/choose_repository.tcl:116
+msgid "Clone..."
+msgstr "Clonar..."
+
+#: lib/choose_repository.tcl:123 lib/choose_repository.tcl:1064
+msgid "Open Existing Repository"
+msgstr "Abrir reposit=C3=B3rio existente"
+
+#: lib/choose_repository.tcl:129
+msgid "Open..."
+msgstr "Abrir..."
+
+#: lib/choose_repository.tcl:142
+msgid "Recent Repositories"
+msgstr "Reposit=C3=B3rios recentes"
+
+#: lib/choose_repository.tcl:148
+msgid "Open Recent Repository:"
+msgstr "Abrir reposit=C3=B3rio recente:"
+
+#: lib/choose_repository.tcl:316 lib/choose_repository.tcl:323
+#: lib/choose_repository.tcl:330
+#, tcl-format
+msgid "Failed to create repository %s:"
+msgstr "Falha ao criar o reposit=C3=B3rio %s:"
+
+#: lib/choose_repository.tcl:407 lib/branch_create.tcl:33
+msgid "Create"
+msgstr "Criar"
+
+#: lib/choose_repository.tcl:417
+msgid "Directory:"
+msgstr "Diret=C3=B3rio:"
+
+#: lib/choose_repository.tcl:447 lib/choose_repository.tcl:573
+#: lib/choose_repository.tcl:1098
+msgid "Git Repository"
+msgstr "Reposit=C3=B3rio Git"
+
+#: lib/choose_repository.tcl:472
+#, tcl-format
+msgid "Directory %s already exists."
+msgstr "O diret=C3=B3rio %s j=C3=A1 existe."
+
+#: lib/choose_repository.tcl:476
+#, tcl-format
+msgid "File %s already exists."
+msgstr "O ficheiro %s j=C3=A1 existe."
+
+#: lib/choose_repository.tcl:491
+msgid "Clone"
+msgstr "Clonar"
+
+#: lib/choose_repository.tcl:504
+msgid "Source Location:"
+msgstr "Localiza=C3=A7=C3=A3o de origem:"
+
+#: lib/choose_repository.tcl:513
+msgid "Target Directory:"
+msgstr "Diret=C3=B3rio de destino:"
+
+#: lib/choose_repository.tcl:523
+msgid "Clone Type:"
+msgstr "Tipo de clone:"
+
+#: lib/choose_repository.tcl:528
+msgid "Standard (Fast, Semi-Redundant, Hardlinks)"
+msgstr "Padr=C3=A3o (r=C3=A1pido, semi-redundante, liga=C3=A7=C3=B5es =
fixas)"
+
+#: lib/choose_repository.tcl:533
+msgid "Full Copy (Slower, Redundant Backup)"
+msgstr "C=C3=B3pia Total (lento, c=C3=B3pia de seguran=C3=A7a redundan=
te)"
+
+#: lib/choose_repository.tcl:538
+msgid "Shared (Fastest, Not Recommended, No Backup)"
+msgstr "Partilhado (mais r=C3=A1pido, n=C3=A3o recomendado, sem c=C3=B3=
pia)"
+
+#: lib/choose_repository.tcl:545
+msgid "Recursively clone submodules too"
+msgstr "Clonar recursivamente subm=C3=B3dulos tamb=C3=A9m"
+
+#: lib/choose_repository.tcl:579 lib/choose_repository.tcl:626
+#: lib/choose_repository.tcl:772 lib/choose_repository.tcl:842
+#: lib/choose_repository.tcl:1104 lib/choose_repository.tcl:1112
+#, tcl-format
+msgid "Not a Git repository: %s"
+msgstr "N=C3=A3o =C3=A9 um reposit=C3=B3rio Git: %s"
+
+#: lib/choose_repository.tcl:615
+msgid "Standard only available for local repository."
+msgstr "Padr=C3=A3o s=C3=B3 dispon=C3=ADvel em reposit=C3=B3rios locai=
s."
+
+#: lib/choose_repository.tcl:619
+msgid "Shared only available for local repository."
+msgstr "Partilhado s=C3=B3 dispon=C3=ADvel em reposit=C3=B3rios locais=
=2E"
+
+#: lib/choose_repository.tcl:640
+#, tcl-format
+msgid "Location %s already exists."
+msgstr "A localiza=C3=A7=C3=A3o %s j=C3=A1 existe."
+
+#: lib/choose_repository.tcl:651
+msgid "Failed to configure origin"
+msgstr "Falha ao configurar origem"
+
+#: lib/choose_repository.tcl:663
+msgid "Counting objects"
+msgstr "A contar objetos"
+
+#: lib/choose_repository.tcl:664
+msgid "buckets"
+msgstr "baldes"
+
+#: lib/choose_repository.tcl:688
+#, tcl-format
+msgid "Unable to copy objects/info/alternates: %s"
+msgstr "N=C3=A3o =C3=A9 poss=C3=ADvel copiar objects/info/alternates: =
%s"
+
+#: lib/choose_repository.tcl:724
+#, tcl-format
+msgid "Nothing to clone from %s."
+msgstr "Nada para clonar de %s."
+
+#: lib/choose_repository.tcl:726 lib/choose_repository.tcl:940
+#: lib/choose_repository.tcl:952
+msgid "The 'master' branch has not been initialized."
+msgstr "O ramo 'master' n=C3=A3o foi inicializado."
+
+#: lib/choose_repository.tcl:739
+msgid "Hardlinks are unavailable.  Falling back to copying."
+msgstr "Liga=C3=A7=C3=B5es fixas indispon=C3=ADveis. A recorrer a c=C3=
=B3pia."
+
+#: lib/choose_repository.tcl:751
+#, tcl-format
+msgid "Cloning from %s"
+msgstr "A clonar de %s"
+
+#: lib/choose_repository.tcl:782
+msgid "Copying objects"
+msgstr "A copiar objetos"
+
+#: lib/choose_repository.tcl:783
+msgid "KiB"
+msgstr "KiB"
+
+#: lib/choose_repository.tcl:807
+#, tcl-format
+msgid "Unable to copy object: %s"
+msgstr "N=C3=A3o =C3=A9 poss=C3=ADvel copiar objeto: %s"
+
+#: lib/choose_repository.tcl:817
+msgid "Linking objects"
+msgstr "A ligar objetos"
+
+#: lib/choose_repository.tcl:818
+msgid "objects"
+msgstr "objetos"
+
+#: lib/choose_repository.tcl:826
+#, tcl-format
+msgid "Unable to hardlink object: %s"
+msgstr "N=C3=A3o =C3=A9 poss=C3=ADvel criar liga=C3=A7=C3=A3o fixa de =
objeto: %s"
+
+#: lib/choose_repository.tcl:881
+msgid "Cannot fetch branches and objects.  See console output for deta=
ils."
+msgstr ""
+"N=C3=A3o =C3=A9 poss=C3=ADvel obter ramos e objetos. Ver sa=C3=ADda n=
a consola para detalhes."
+
+#: lib/choose_repository.tcl:892
+msgid "Cannot fetch tags.  See console output for details."
+msgstr "N=C3=A3o =C3=A9 poss=C3=ADvel obter tags. Ver sa=C3=ADda na co=
nsola para detalhes."
+
+#: lib/choose_repository.tcl:916
+msgid "Cannot determine HEAD.  See console output for details."
+msgstr "N=C3=A3o =C3=A9 poss=C3=ADvel determinar HEAD. Ver sa=C3=ADda =
na consola para detalhes."
+
+#: lib/choose_repository.tcl:925
+#, tcl-format
+msgid "Unable to cleanup %s"
+msgstr "N=C3=A3o foi poss=C3=ADvel limpar %s"
+
+#: lib/choose_repository.tcl:931
+msgid "Clone failed."
+msgstr "Falha ao clonar."
+
+#: lib/choose_repository.tcl:938
+msgid "No default branch obtained."
+msgstr "N=C3=A3o foi obtido nenhum ramo predefinido."
+
+#: lib/choose_repository.tcl:949
+#, tcl-format
+msgid "Cannot resolve %s as a commit."
+msgstr "N=C3=A3o =C3=A9 poss=C3=ADvel resolver %s como um commit."
+
+#: lib/choose_repository.tcl:961
+msgid "Creating working directory"
+msgstr "A criar diret=C3=B3rio de trabalho"
+
+#: lib/choose_repository.tcl:962 lib/index.tcl:70 lib/index.tcl:136
+#: lib/index.tcl:207
+msgid "files"
+msgstr "ficheiros"
+
+#: lib/choose_repository.tcl:981
+msgid "Cannot clone submodules."
+msgstr "N=C3=A3o =C3=A9 poss=C3=ADvel clonar subm=C3=B3dulos."
+
+#: lib/choose_repository.tcl:990
+msgid "Cloning submodules"
+msgstr "A clonar subm=C3=B3dulos"
+
+#: lib/choose_repository.tcl:1015
+msgid "Initial file checkout failed."
+msgstr "Falha de extra=C3=A7=C3=A3o inicial de ficheiro."
+
+#: lib/choose_repository.tcl:1059
+msgid "Open"
+msgstr "Abrir"
+
+#: lib/choose_repository.tcl:1069
+msgid "Repository:"
+msgstr "Reposit=C3=B3rio:"
+
+#: lib/choose_repository.tcl:1118
+#, tcl-format
+msgid "Failed to open repository %s:"
+msgstr "Falha ao abrir o reposit=C3=B3rio %s:"
+
+#: lib/about.tcl:26
+msgid "git-gui - a graphical user interface for Git."
+msgstr "git-gui - uma interface gr=C3=A1fica do Git."
+
+#: lib/blame.tcl:73
+msgid "File Viewer"
+msgstr "Visualizador de ficheiros"
+
+#: lib/blame.tcl:79
+msgid "Commit:"
+msgstr "Commit:"
+
+#: lib/blame.tcl:280
+msgid "Copy Commit"
+msgstr "Copiar commit"
+
+#: lib/blame.tcl:284
+msgid "Find Text..."
+msgstr "Procurar texto..."
+
+#: lib/blame.tcl:288
+msgid "Goto Line..."
+msgstr "Ir para a linha..."
+
+#: lib/blame.tcl:297
+msgid "Do Full Copy Detection"
+msgstr "Efetuar dete=C3=A7=C3=A3o de c=C3=B3pia integral"
+
+#: lib/blame.tcl:301
+msgid "Show History Context"
+msgstr "Mostrar contexto hist=C3=B3rico"
+
+#: lib/blame.tcl:304
+msgid "Blame Parent Commit"
+msgstr "Culpar commit pai"
+
+#: lib/blame.tcl:466
+#, tcl-format
+msgid "Reading %s..."
+msgstr "A ler %s..."
+
+#: lib/blame.tcl:594
+msgid "Loading copy/move tracking annotations..."
+msgstr "A carregar anota=C3=A7=C3=B5es de c=C3=B3pia/movimento..."
+
+#: lib/blame.tcl:614
+msgid "lines annotated"
+msgstr "linhas anotadas"
+
+#: lib/blame.tcl:806
+msgid "Loading original location annotations..."
+msgstr "A carregar anota=C3=A7=C3=B5es da localiza=C3=A7=C3=A3o origin=
al..."
+
+#: lib/blame.tcl:809
+msgid "Annotation complete."
+msgstr "Anota=C3=A7=C3=A3o conclu=C3=ADda."
+
+#: lib/blame.tcl:839
+msgid "Busy"
+msgstr "A processar"
+
+#: lib/blame.tcl:840
+msgid "Annotation process is already running."
+msgstr "O processo de anota=C3=A7=C3=A3o j=C3=A1 est=C3=A1 em execu=C3=
=A7=C3=A3o."
+
+#: lib/blame.tcl:879
+msgid "Running thorough copy detection..."
+msgstr "A executar dete=C3=A7=C3=A3o de c=C3=B3pia integral..."
+
+#: lib/blame.tcl:947
+msgid "Loading annotation..."
+msgstr "A carregar anota=C3=A7=C3=A3o..."
+
+#: lib/blame.tcl:1000
+msgid "Author:"
+msgstr "Autor:"
+
+#: lib/blame.tcl:1004
+msgid "Committer:"
+msgstr "Committer:"
+
+#: lib/blame.tcl:1009
+msgid "Original File:"
+msgstr "Ficheiro original:"
+
+#: lib/blame.tcl:1057
+msgid "Cannot find HEAD commit:"
+msgstr "N=C3=A3o =C3=A9 poss=C3=ADvel encontrar commit HEAD:"
+
+#: lib/blame.tcl:1112
+msgid "Cannot find parent commit:"
+msgstr "N=C3=A3o =C3=A9 poss=C3=ADvel encontrar commit pai:"
+
+#: lib/blame.tcl:1127
+msgid "Unable to display parent"
+msgstr "N=C3=A3o =C3=A9 poss=C3=ADvel mostrar pai"
+
+#: lib/blame.tcl:1269
+msgid "Originally By:"
+msgstr "Originalmente por:"
+
+#: lib/blame.tcl:1275
+msgid "In File:"
+msgstr "No ficheiro:"
+
+#: lib/blame.tcl:1280
+msgid "Copied Or Moved Here By:"
+msgstr "Copiado ou Movido para aqui por:"
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
+#: lib/sshkey.tcl:58
+msgid "Copy To Clipboard"
+msgstr "Copiar para a =C3=A1rea de transfer=C3=AAncia"
+
+#: lib/sshkey.tcl:72
+msgid "Your OpenSSH Public Key"
+msgstr "A sua chave OpenSSH p=C3=BAblica"
+
+#: lib/sshkey.tcl:80
+msgid "Generating..."
+msgstr "A gerar..."
+
+#: lib/sshkey.tcl:86
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
+#: lib/sshkey.tcl:113
+msgid "Generation failed."
+msgstr "Falha ao gerar."
+
+#: lib/sshkey.tcl:120
+msgid "Generation succeeded, but no keys found."
+msgstr "Gerada com sucesso, mas n=C3=A3o foi encontrada nenhum chave."
+
+#: lib/sshkey.tcl:123
+#, tcl-format
+msgid "Your key is in: %s"
+msgstr "A sua chave encontra-se em: %s"
+
+#: lib/branch_create.tcl:23
+msgid "Create Branch"
+msgstr "Criar ramo"
+
+#: lib/branch_create.tcl:28
+msgid "Create New Branch"
+msgstr "Cria novo ramo"
+
+#: lib/branch_create.tcl:42
+msgid "Branch Name"
+msgstr "Nome do ramo"
+
+#: lib/branch_create.tcl:57
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
+#: lib/branch_create.tcl:97
+msgid "Checkout After Creation"
+msgstr "Extrair depois de criar"
+
+#: lib/branch_create.tcl:132
+msgid "Please select a tracking branch."
+msgstr "Selecione um ramo de monitoriza=C3=A7=C3=A3o."
+
+#: lib/branch_create.tcl:141
+#, tcl-format
+msgid "Tracking branch %s is not a branch in the remote repository."
+msgstr "O ramo de monitoriza=C3=A7=C3=A3o %s n=C3=A3o =C3=A9 um ramo n=
o reposit=C3=B3rio remoto."
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
+#: lib/commit.tcl:173
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
+"ficheiro antes de submeter.\n"
+
+#: lib/commit.tcl:181
+#, tcl-format
+msgid ""
+"Unknown file state %s detected.\n"
+"\n"
+"File %s cannot be committed by this program.\n"
+msgstr ""
+"Detetado estado de ficheiro %s desconhecido.\n"
+"\n"
+"Este programa n=C3=A3o pode submeter o ficheiro %s.\n"
+
+#: lib/commit.tcl:189
+msgid ""
+"No changes to commit.\n"
+"\n"
+"You must stage at least 1 file before you can commit.\n"
+msgstr ""
+"Nenhum altera=C3=A7=C3=A3o para submeter.\n"
+"\n"
+"Deve preparar pelo menos 1 ficheiro antes de submeter.\n"
+
+#: lib/commit.tcl:204
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
+#: lib/commit.tcl:235
+msgid "Calling pre-commit hook..."
+msgstr "A invocar gancho de pr=C3=A9-commit (pre-commit hook)..."
+
+#: lib/commit.tcl:250
+msgid "Commit declined by pre-commit hook."
+msgstr "Commit recusado pela retina de pr=C3=A9-commit (pre-commit hoo=
k)."
+
+#: lib/commit.tcl:269
+msgid ""
+"You are about to commit on a detached head. This is a potentially dan=
gerous "
+"thing to do because if you switch to another branch you will lose you=
r "
+"changes and it can be difficult to retrieve them later from the reflo=
g. You "
+"should probably cancel this commit and create a new branch to continu=
e.\n"
+" \n"
+" Do you really want to proceed with your Commit?"
+msgstr ""
+"Est=C3=A1 prestes a submeter numa cabe=C3=A7a destacada. Faz=C3=AA-lo=
 =C3=A9 potencialmente "
+"perigoso, porque, se mudar para outro ramo, perder=C3=A1 as suas alte=
ra=C3=A7=C3=B5es e "
+"pode ser dif=C3=ADcil recuper=C3=A1-las do reflog posteriormente. Pro=
vavelmente deve "
+"cancelar este commit e criar um novo ramo para continuar.\n"
+"\n"
+"Pretende mesmo continuar com o commit?"
+
+#: lib/commit.tcl:290
+msgid "Calling commit-msg hook..."
+msgstr "A invocar gancho de mensagem-de-commit (commit-msg hook)..."
+
+#: lib/commit.tcl:305
+msgid "Commit declined by commit-msg hook."
+msgstr "Commit recusado pelo gancho de mensagem-de-commit (commit-msg =
hook)."
+
+#: lib/commit.tcl:318
+msgid "Committing changes..."
+msgstr "A submeter altera=C3=A7=C3=B5es..."
+
+#: lib/commit.tcl:334
+msgid "write-tree failed:"
+msgstr "write-tree falhou:"
+
+#: lib/commit.tcl:335 lib/commit.tcl:379 lib/commit.tcl:400
+msgid "Commit failed."
+msgstr "Falha ao submeter."
+
+#: lib/commit.tcl:352
+#, tcl-format
+msgid "Commit %s appears to be corrupt"
+msgstr "O commit %s parece estar corrompido"
+
+#: lib/commit.tcl:357
+msgid ""
+"No changes to commit.\n"
+"\n"
+"No files were modified by this commit and it was not a merge commit.\=
n"
+"\n"
+"A rescan will be automatically started now.\n"
+msgstr ""
+"N=C3=A3o h=C3=A1 altera=C3=A7=C3=B5es para submeter.\n"
+"\n"
+"Nenhum ficheiro foi modificado por este commit e n=C3=A3o era um comm=
it de "
+"integra=C3=A7=C3=A3o.\n"
+"\n"
+"Ir=C3=A1-se reanalisar agora automaticamente.\n"
+
+#: lib/commit.tcl:364
+msgid "No changes to commit."
+msgstr "N=C3=A3o h=C3=A1 altera=C3=A7=C3=B5es para submeter."
+
+#: lib/commit.tcl:378
+msgid "commit-tree failed:"
+msgstr "commit-tree falhou:"
+
+#: lib/commit.tcl:399
+msgid "update-ref failed:"
+msgstr "update-ref falhou:"
+
+#: lib/commit.tcl:492
+#, tcl-format
+msgid "Created commit %s: %s"
+msgstr "Commit %s criado: %s"
+
+#: lib/branch_delete.tcl:16
+msgid "Delete Branch"
+msgstr "Eliminar ramo"
+
+#: lib/branch_delete.tcl:21
+msgid "Delete Local Branch"
+msgstr "Eliminar ramo local"
+
+#: lib/branch_delete.tcl:39
+msgid "Local Branches"
+msgstr "Ramos locais"
+
+#: lib/branch_delete.tcl:51
+msgid "Delete Only If Merged Into"
+msgstr "Eliminar s=C3=B3 se foi integrado"
+
+#: lib/branch_delete.tcl:103
+#, tcl-format
+msgid "The following branches are not completely merged into %s:"
+msgstr "Os seguintes ramos n=C3=A3o foram completamente integrados em =
%s:"
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
+#: lib/index.tcl:6
+msgid "Unable to unlock the index."
+msgstr "N=C3=A3o =C3=A9 poss=C3=ADvel desbloquear o =C3=ADndice."
+
+#: lib/index.tcl:17
+msgid "Index Error"
+msgstr "Erro de =C3=8Dndice"
+
+#: lib/index.tcl:19
+msgid ""
+"Updating the Git index failed.  A rescan will be automatically starte=
d to "
+"resynchronize git-gui."
+msgstr ""
+"Falha ao atualizar o =C3=ADndice do Git. Ir=C3=A1-se reanalisar autom=
aticamente para "
+"ressincronizar o git-gui."
+
+#: lib/index.tcl:30
+msgid "Continue"
+msgstr "Continuar"
+
+#: lib/index.tcl:33
+msgid "Unlock Index"
+msgstr "Desbloquear =C3=ADndice"
+
+#: lib/index.tcl:294
+msgid "Unstaging selected files from commit"
+msgstr "A retirar ficheiros selecionados do commit"
+
+#: lib/index.tcl:298
+#, tcl-format
+msgid "Unstaging %s from commit"
+msgstr "A retirar %s do commit"
+
+#: lib/index.tcl:337
+msgid "Ready to commit."
+msgstr "Pronto para submeter."
+
+#: lib/index.tcl:346
+msgid "Adding selected files"
+msgstr "A adicionar ficheiros selecionados"
+
+#: lib/index.tcl:350
+#, tcl-format
+msgid "Adding %s"
+msgstr "A adicionar %s"
+
+#: lib/index.tcl:380
+#, tcl-format
+msgid "Stage %d untracked files?"
+msgstr "Preparar %d ficheiros n=C3=A3o controlados?"
+
+#: lib/index.tcl:388
+msgid "Adding all changed files"
+msgstr "A adicionar todos os ficheiros controlados"
+
+#: lib/index.tcl:428
+#, tcl-format
+msgid "Revert changes in file %s?"
+msgstr "Reverter altera=C3=A7=C3=B5es no ficheiro %s?"
+
+#: lib/index.tcl:430
+#, tcl-format
+msgid "Revert changes in these %i files?"
+msgstr "Reverter altera=C3=A7=C3=B5es nestes %i ficheiros?"
+
+#: lib/index.tcl:438
+msgid "Any unstaged changes will be permanently lost by the revert."
+msgstr ""
+"Qualquer altera=C3=A7=C3=A3o n=C3=A3o preparada ser=C3=A1 permanentem=
ente perdida ao reverter."
+
+#: lib/index.tcl:441
+msgid "Do Nothing"
+msgstr "N=C3=A3o fazer nada"
+
+#: lib/index.tcl:459
+msgid "Reverting selected files"
+msgstr "A reverter ficheiros selecionados"
+
+#: lib/index.tcl:463
+#, tcl-format
+msgid "Reverting %s"
+msgstr "A reverter %s"
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
+#: lib/date.tcl:25
+#, tcl-format
+msgid "Invalid date from Git: %s"
+msgstr "Data do Git inv=C3=A1lida: %s"
+
+#: lib/choose_rev.tcl:52
+msgid "This Detached Checkout"
+msgstr "Esta extra=C3=A7=C3=A3o destacada"
+
+#: lib/choose_rev.tcl:60
+msgid "Revision Expression:"
+msgstr "Express=C3=A3o de revis=C3=A3o:"
+
+#: lib/choose_rev.tcl:72
+msgid "Local Branch"
+msgstr "Ramo local"
+
+#: lib/choose_rev.tcl:77
+msgid "Tracking Branch"
+msgstr "Ramo de monitoriza=C3=A7=C3=A3o"
+
+#: lib/choose_rev.tcl:82 lib/choose_rev.tcl:544
+msgid "Tag"
+msgstr "Tag"
+
+#: lib/choose_rev.tcl:321
+#, tcl-format
+msgid "Invalid revision: %s"
+msgstr "Revis=C3=A3o inv=C3=A1lida: %s"
+
+#: lib/choose_rev.tcl:342
+msgid "No revision selected."
+msgstr "Nenhum revis=C3=A3o selecionada."
+
+#: lib/choose_rev.tcl:350
+msgid "Revision expression is empty."
+msgstr "A express=C3=A3o de revis=C3=A3o est=C3=A1 vazia."
+
+#: lib/choose_rev.tcl:537
+msgid "Updated"
+msgstr "Atualizado"
+
+#: lib/choose_rev.tcl:565
+msgid "URL"
+msgstr "URL"
+
+#: lib/database.tcl:42
+msgid "Number of loose objects"
+msgstr "N=C3=BAmero de objetos soltos"
+
+#: lib/database.tcl:43
+msgid "Disk space used by loose objects"
+msgstr "Espa=C3=A7o em disco usados por objetos soltos"
+
+#: lib/database.tcl:44
+msgid "Number of packed objects"
+msgstr "N=C3=BAmero de objetos compactados"
+
+#: lib/database.tcl:45
+msgid "Number of packs"
+msgstr "N=C3=BAmeros de pacotes"
+
+#: lib/database.tcl:46
+msgid "Disk space used by packed objects"
+msgstr "Espa=C3=A7o em disco usado por objetos compactados"
+
+#: lib/database.tcl:47
+msgid "Packed objects waiting for pruning"
+msgstr "Objetos compactados =C3=A0 espera de poda"
+
+#: lib/database.tcl:48
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
+#: lib/error.tcl:20 lib/error.tcl:116
+msgid "error"
+msgstr "erro"
+
+#: lib/error.tcl:36
+msgid "warning"
+msgstr "aviso"
+
+#: lib/error.tcl:96
+msgid "You must correct the above errors before committing."
+msgstr "Deve corrigir os erros acima antes de submeter."
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
+"Deve resolv=C3=AA-los, preparar o ficheiro e submeter para concluir a=
 integra=C3=A7=C3=A3o "
+"atual. S=C3=B3 ent=C3=A3o pode iniciar outra integra=C3=A7=C3=A3o.\n"
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
+#: lib/merge.tcl:108
+#, tcl-format
+msgid "%s of %s"
+msgstr "%s de %s"
+
+#: lib/merge.tcl:122
+#, tcl-format
+msgid "Merging %s and %s..."
+msgstr "A integrar %s e %s..."
+
+#: lib/merge.tcl:133
+msgid "Merge completed successfully."
+msgstr "Integra=C3=A7=C3=A3o conclu=C3=ADda com sucesso."
+
+#: lib/merge.tcl:135
+msgid "Merge failed.  Conflict resolution is required."
+msgstr "Integra=C3=A7=C3=A3o falhada. =C3=89 necess=C3=A1rio resolver =
conflitos."
+
+#: lib/merge.tcl:160
+#, tcl-format
+msgid "Merge Into %s"
+msgstr "Integrar em %s"
+
+#: lib/merge.tcl:179
+msgid "Revision To Merge"
+msgstr "Revis=C3=A3o a integrar"
+
+#: lib/merge.tcl:214
+msgid ""
+"Cannot abort while amending.\n"
+"\n"
+"You must finish amending this commit.\n"
+msgstr ""
+"N=C3=A3o =C3=A9 poss=C3=ADvel abortar enquanto se emenda.\n"
+"\n"
+"Deve acabar de emendar este commit.\n"
+
+#: lib/merge.tcl:224
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
+"submetidas.\n"
+"\n"
+"Continuar a abortar a integra=C3=A7=C3=A3o atual?"
+
+#: lib/merge.tcl:230
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
=C3=B5es n=C3=A3o submetidas.\n"
+"\n"
+"Continuar a repor as altera=C3=A7=C3=B5es atuais?"
+
+#: lib/merge.tcl:241
+msgid "Aborting"
+msgstr "A abortar"
+
+#: lib/merge.tcl:241
+msgid "files reset"
+msgstr "ficheiros repostos"
+
+#: lib/merge.tcl:269
+msgid "Abort failed."
+msgstr "Falha ao abortar."
+
+#: lib/merge.tcl:271
+msgid "Abort completed.  Ready."
+msgstr "Aborto conclu=C3=ADdo. Pronto."
+
+#~ msgid "Displaying only %s of %s files."
+#~ msgstr "A mostrar apenas %s de %s ficheiros."
+
+#~ msgid "Case-Sensitive"
+#~ msgstr "Distinguir Mai=C3=BAsculas"
--=20
2.7.3
