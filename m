From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [RFC/PATCH] l10n: de.po: translate 825 new messages
Date: Tue, 27 Nov 2012 12:42:29 +0100
Message-ID: <877gp7tgpm.fsf@pctrast.inf.ethz.ch>
References: <1349200849-7436-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>, <trast@student.ethz.ch>, <jk@jk.gs>,
	<stimming@tuhh.de>
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 12:49:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdJez-0003Rx-Lp
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 12:49:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019Ab2K0Lst convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Nov 2012 06:48:49 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:27861 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752452Ab2K0Lsr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Nov 2012 06:48:47 -0500
X-Greylist: delayed 372 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Nov 2012 06:48:46 EST
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 27 Nov
 2012 12:42:28 +0100
Received: from pctrast.inf.ethz.ch.ethz.ch (129.132.153.233) by
 CAS20.d.ethz.ch (172.31.51.110) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Tue, 27 Nov 2012 12:42:30 +0100
In-Reply-To: <1349200849-7436-1-git-send-email-ralf.thielow@gmail.com> (Ralf
	Thielow's message of "Tue, 2 Oct 2012 20:00:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210557>

>  #: builtin/pack-refs.c:6
>  msgid "git pack-refs [options]"
> -msgstr ""
> +msgstr "git pack-refs [Optionen]"
> =20
>  #: builtin/pack-refs.c:14
>  msgid "pack everything"
> -msgstr ""
> +msgstr "packt alles"
> =20
>  #: builtin/pack-refs.c:15
>  msgid "prune loose refs (default)"
> -msgstr ""
> +msgstr "entfernt lose Referenzen (Standard)"
> =20
>  #: builtin/prune-packed.c:7
>  msgid "git prune-packed [-n|--dry-run] [-q|--quiet]"
> -msgstr ""
> +msgstr "git prune-packed [-n|--dry-run] [-q|--quite]"
> =20
>  #: builtin/prune.c:12
>  msgid "git prune [-n] [-v] [--expire <time>] [--] [<head>...]"
> -msgstr ""
> +msgstr "git prune [-n] [-v] [--expire <Zeit>] [--] [<Zweigspitze>...=
]"
> =20
>  #: builtin/prune.c:132
> -#, fuzzy
>  msgid "do not remove, show only"
> -msgstr "W=C3=BCrde nicht entfernen %s\n"
> +msgstr "nicht entfernen, nur anzeigen"
> =20
>  #: builtin/prune.c:133
> -#, fuzzy
>  msgid "report pruned objects"
> -msgstr "kann Objekt %s nicht lesen"
> +msgstr "meldet entfernte Objekte"
> =20
>  #: builtin/prune.c:136
>  msgid "expire objects older than <time>"
> -msgstr ""
> +msgstr "l=C3=A4sst Objekte =C3=A4lter als <Zeit> verfallen"
> =20
>  #: builtin/push.c:14
> -#, fuzzy
>  msgid "git push [<options>] [<repository> [<refspec>...]]"
> -msgstr "git apply [Optionen] [<Patch>...]"
> +msgstr "git push [<Optionen>] [<Projektarchiv> [<Referenzspezifikati=
on>...]]"
> =20
>  #: builtin/push.c:45
>  msgid "tag shorthand without <tag>"
> @@ -7141,55 +7098,53 @@ msgid "--all and --mirror are incompatible"
>  msgstr "--all und --mirror sind inkompatibel"
> =20
>  #: builtin/push.c:382
> -#, fuzzy
>  msgid "repository"
> -msgstr "ung=C3=BCltiges Projektarchiv '%s'"
> +msgstr "Projektarchiv"
> =20
>  #: builtin/push.c:383
>  msgid "push all refs"
> -msgstr ""
> +msgstr "versendet alle Referenzen"
> =20
>  #: builtin/push.c:384
>  msgid "mirror all refs"
> -msgstr ""
> +msgstr "spiegelt alle Referenzen"
> =20
>  #: builtin/push.c:386
> -#, fuzzy
>  msgid "delete refs"
> -msgstr "gel=C3=B6scht"
> +msgstr "l=C3=B6scht Referenzen"
> =20
>  #: builtin/push.c:387
>  msgid "push tags (can't be used with --all or --mirror)"
>  msgstr ""
> +"versendet Markierungen (kann nicht mit --all oder --mirror benutzt =
werden)"
> =20
>  #: builtin/push.c:390
> -#, fuzzy
>  msgid "force updates"
> -msgstr "Aktualisierung erzwungen"
> +msgstr "erzwingt Aktualisierung"
> =20
>  #: builtin/push.c:391
>  msgid "check"
> -msgstr ""
> +msgstr "=C3=9Cberpr=C3=BCfung"
> =20
>  #: builtin/push.c:392
>  msgid "control recursive pushing of submodules"
> -msgstr ""
> +msgstr "steuert rekursives Versenden von Unterprojekten"
> =20
>  #: builtin/push.c:394
>  msgid "use thin pack"
> -msgstr ""
> +msgstr "benutzt kleinere Pakete"
> =20
>  #: builtin/push.c:395 builtin/push.c:396
>  msgid "receive pack program"
> -msgstr ""
> +msgstr "Programm zum Empfangen von Paketen"
> =20
>  #: builtin/push.c:397
>  msgid "set upstream for git pull/status"
> -msgstr ""
> +msgstr "setzt externes Projektarchiv f=C3=BCr \"git pull/status\""
> =20
>  #: builtin/push.c:400
>  msgid "prune locally removed refs"
> -msgstr ""
> +msgstr "entfernt lokal gel=C3=B6schte Referenzen"
> =20
>  #: builtin/push.c:410
>  msgid "--delete is incompatible with --all, --mirror and --tags"
> @@ -7205,155 +7160,160 @@ msgid ""
>  "[-u [--exclude-per-directory=3D<gitignore>] | -i]] [--no-sparse-che=
ckout] [--"
>  "index-output=3D<file>] (--empty | <tree-ish1> [<tree-ish2> [<tree-i=
sh3>]])"
>  msgstr ""
> +"git read-tree [[-m [--trivial] [--aggressive] | --reset | --prefix=3D=
<Prefix>] "
> +"[-u [--exclude-per-directory=3D<gitignore>] | -i]] [--no-sparse-che=
ckout] [--"
> +"index-output=3D<Datei>] (--empty | <Versionsreferenz1> [<Versionsre=
ferenz2> "
> +"[<Versionsreferenz3>]])"
> =20
>  #: builtin/read-tree.c:108
> -#, fuzzy
>  msgid "write resulting index to <file>"
> -msgstr "besch=C3=A4digte Bereitstellungsdatei"
> +msgstr "schreibt resultierende Bereitstellung nach <Datei>"
> =20
>  #: builtin/read-tree.c:111
> -#, fuzzy
>  msgid "only empty the index"
> -msgstr "Konnte die Bereitstellung nicht lesen"
> +msgstr "leert nur die Bereitstellung"
> =20
>  #: builtin/read-tree.c:113
> -#, fuzzy
>  msgid "Merging"
> -msgstr "Zusammenf=C3=BChrung:"
> +msgstr "Zusammenf=C3=BChrung"
> =20
>  #: builtin/read-tree.c:115
>  msgid "perform a merge in addition to a read"
> -msgstr ""
> +msgstr "f=C3=BChrt eine Zusammenf=C3=BChrung zus=C3=A4tzlich zum Les=
en aus"
> =20
>  #: builtin/read-tree.c:117
>  msgid "3-way merge if no file level merging required"
>  msgstr ""
> +"3-Wege-Zusammenf=C3=BChrung, wenn keine Zusammenf=C3=BChrung auf Da=
teiebene "
> +"erforderlich ist"
> =20
>  #: builtin/read-tree.c:119
>  msgid "3-way merge in presence of adds and removes"
>  msgstr ""
> +"3-Wege-Zusammenf=C3=BChrung bei Vorhandensein von hinzugef=C3=BCgte=
n/entfernten Zeilen"
> =20
>  #: builtin/read-tree.c:121
>  msgid "same as -m, but discard unmerged entries"
> -msgstr ""
> +msgstr "genau wie -m, verwirft aber nicht zusammengef=C3=BChrte Eint=
r=C3=A4ge"
> =20
>  #: builtin/read-tree.c:122
> -#, fuzzy
>  msgid "<subdirectory>/"
> -msgstr "Verzeichnis/Datei"
> +msgstr "<Unterverzeichnis>/"
> =20
>  #: builtin/read-tree.c:123
>  msgid "read the tree into the index under <subdirectory>/"
> -msgstr ""
> +msgstr "liest den Baum in die Bereitstellung unter <Unterverzeichnis=
>/"
> =20
>  #: builtin/read-tree.c:126
>  msgid "update working tree with merge result"
> -msgstr ""
> +msgstr "aktualisiert Arbeitsbaum mit Ergebnis der Zusammenf=C3=BChru=
ng"
> =20
>  #: builtin/read-tree.c:128
> -#, fuzzy
>  msgid "gitignore"
> -msgstr "Ignorierte"
> +msgstr "gitignore"
> =20
>  #: builtin/read-tree.c:129
>  msgid "allow explicitly ignored files to be overwritten"
> -msgstr ""
> +msgstr "erlaubt explizit ignorierte Dateien zu =C3=BCberschreiben"
> =20
>  #: builtin/read-tree.c:132
> -#, fuzzy
>  msgid "don't check the working tree after merging"
> -msgstr "Zeigt den Zustand des Arbeitszweiges an"
> +msgstr "pr=C3=BCft nicht den Arbeitsbaum nach der Zusammenf=C3=BChru=
ng"
> =20
>  #: builtin/read-tree.c:133
>  msgid "don't update the index or the work tree"
> -msgstr ""
> +msgstr "aktualisiert weder die Bereitstellung, noch den Arbeitsbaum"
> =20
>  #: builtin/read-tree.c:135
>  msgid "skip applying sparse checkout filter"
> -msgstr ""
> +msgstr "=C3=BCberspringt Anwendung des Filters f=C3=BCr sp=C3=A4rlic=
hes Auschecken"
> =20
>  #: builtin/read-tree.c:137
>  msgid "debug unpack-trees"
> -msgstr ""
> +msgstr "protokolliert Entpacken der B=C3=A4ume"
> =20
>  #: builtin/remote.c:11
>  msgid "git remote [-v | --verbose]"
> -msgstr ""
> +msgstr "git remove [-v | --verbose]"
> =20
>  #: builtin/remote.c:12
>  msgid ""
>  "git remote add [-t <branch>] [-m <master>] [-f] [--tags|--no-tags] =
[--"
>  "mirror=3D<fetch|push>] <name> <url>"
>  msgstr ""
> +"git remote add [-t <Zweig>] [-m <master>] [-f] [--tags|--no-tags] [=
--"
> +"mirror=3D<fetch|push>] <Name> <URL>"
> =20
>  #: builtin/remote.c:13 builtin/remote.c:32
>  msgid "git remote rename <old> <new>"
> -msgstr ""
> +msgstr "git remote rename <alt> <neu>"
> =20
>  #: builtin/remote.c:14 builtin/remote.c:37
>  msgid "git remote remove <name>"
> -msgstr ""
> +msgstr "git remote remove <Name>"
> =20
>  #: builtin/remote.c:15
>  msgid "git remote set-head <name> (-a | -d | <branch>)"
> -msgstr ""
> +msgstr "git remote set-head <Name> (-a | -d | <Zweig>)"
> =20
>  #: builtin/remote.c:16
>  msgid "git remote [-v | --verbose] show [-n] <name>"
> -msgstr ""
> +msgstr "git remote [-v | --verbose] show [-n] <Name>"
> =20
>  #: builtin/remote.c:17
>  msgid "git remote prune [-n | --dry-run] <name>"
> -msgstr ""
> +msgstr "git remote prune [-n | --dry-run] <Name>"
> =20
>  #: builtin/remote.c:18
>  msgid ""
>  "git remote [-v | --verbose] update [-p | --prune] [(<group> | <remo=
te>)...]"
>  msgstr ""
> +"git remote [-v | --verbose] update [-p | --prune] [(<Gruppe> | "
> +"<externesProjektarchiv>)...]"
> =20
>  #: builtin/remote.c:19
>  msgid "git remote set-branches [--add] <name> <branch>..."
> -msgstr ""
> +msgstr "git remote set-branches [--add] <Name> <Zweig>..."
> =20
>  #: builtin/remote.c:20 builtin/remote.c:68
>  msgid "git remote set-url [--push] <name> <newurl> [<oldurl>]"
> -msgstr ""
> +msgstr "git remote set-url [--push] <Name> <neueURL> [<alteURL>]"
> =20
>  #: builtin/remote.c:21 builtin/remote.c:69
>  msgid "git remote set-url --add <name> <newurl>"
> -msgstr ""
> +msgstr "git remote set-url --add <Name> <neueURL>"
> =20
>  #: builtin/remote.c:22 builtin/remote.c:70
>  msgid "git remote set-url --delete <name> <url>"
> -msgstr ""
> +msgstr "git remote set-url --delete <Name> <URL>"
> =20
>  #: builtin/remote.c:27
>  msgid "git remote add [<options>] <name> <url>"
> -msgstr ""
> +msgstr "git remote add [<Optionen>] <Name> <URL>"
> =20
>  #: builtin/remote.c:42
>  msgid "git remote set-head <name> (-a | -d | <branch>])"
> -msgstr ""
> +msgstr "git remote set-head <Name> (-a | -d | <Zweig>])"
> =20
>  #: builtin/remote.c:47
>  msgid "git remote set-branches <name> <branch>..."
> -msgstr ""
> +msgstr "git remote set-branches <Name> <Zweig>..."
> =20
>  #: builtin/remote.c:48
>  msgid "git remote set-branches --add <name> <branch>..."
> -msgstr ""
> +msgstr "git remote set-branches --add <Name> <Zweig>..."
> =20
>  #: builtin/remote.c:53
>  msgid "git remote show [<options>] <name>"
> -msgstr ""
> +msgstr "git remote show [<Optionen>] <Name>"
> =20
>  #: builtin/remote.c:58
>  msgid "git remote prune [<options>] <name>"
> -msgstr ""
> +msgstr "git remote prune [<Optionen>] <Name>"
> =20
>  #: builtin/remote.c:63
>  msgid "git remote update [<options>] [<group> | <remote>]..."
> -msgstr ""
> +msgstr "git remote update [<Optionen>] [<Gruppe> | <externesProjekta=
rchiv>]..."
> =20
>  #: builtin/remote.c:98
>  #, c-format
> @@ -7374,34 +7334,33 @@ msgid "unknown mirror argument: %s"
>  msgstr "unbekanntes Argument f=C3=BCr Option --mirror: %s"
> =20
>  #: builtin/remote.c:163
> -#, fuzzy
>  msgid "fetch the remote branches"
> -msgstr "  externer Zweig:%s"
> +msgstr "fordert die externen Zweige an"
> =20
>  #: builtin/remote.c:165
>  msgid "import all tags and associated objects when fetching"
> -msgstr ""
> +msgstr "importiert alle Markierungen und verbundene Objekte beim Anf=
ordern"
> =20
>  #: builtin/remote.c:168
>  msgid "or do not fetch any tag at all (--no-tags)"
> -msgstr ""
> +msgstr "oder fordere gar keine Zweige an (--no-tags)"
> =20
>  #: builtin/remote.c:170
>  msgid "branch(es) to track"
> -msgstr ""
> +msgstr "Zweige zur =C3=9Cbernahme"
> =20
>  #: builtin/remote.c:171
> -#, fuzzy
>  msgid "master branch"
> -msgstr "  externer Zweig:%s"
> +msgstr "Hauptzweig"
> =20
>  #: builtin/remote.c:172
>  msgid "push|fetch"
> -msgstr ""
> +msgstr "push|fetch"
> =20
>  #: builtin/remote.c:173
>  msgid "set up remote as a mirror to push to or fetch from"
>  msgstr ""
> +"Aufsetzen der Fernarchivs als Spiegelarchiv zum Versenden und Anfor=
dern"
> =20
>  #: builtin/remote.c:185
>  msgid "specifying a master branch makes no sense with --mirror"
> @@ -7410,7 +7369,7 @@ msgstr "Angabe eines Hauptzweiges macht mit --m=
irror keinen Sinn"
>  #: builtin/remote.c:187
>  msgid "specifying branches to track makes sense only with fetch mirr=
ors"
>  msgstr ""
> -"die Angabe von zu folgenden Zweigen macht nur mit dem Abholen von "
> +"die Angabe von zu folgenden Zweigen macht nur mit dem Anfordern von=
 "
>  "Spiegelarchiven Sinn"
> =20
>  #: builtin/remote.c:195 builtin/remote.c:646
> @@ -7605,9 +7564,8 @@ msgid "    %-*s pushes to %s"
>  msgstr "    %-*s versendet nach %s"
> =20
>  #: builtin/remote.c:1091
> -#, fuzzy
>  msgid "do not query remotes"
> -msgstr "W=C3=BCrde nicht entfernen %s\n"
> +msgstr "keine Abfrage von Fernarchiven"
> =20
>  #: builtin/remote.c:1118
>  #, c-format
> @@ -7671,11 +7629,11 @@ msgstr[1] "  Lokale Referenzen konfiguriert f=
=C3=BCr 'git push'%s:"
> =20
>  #: builtin/remote.c:1199
>  msgid "set refs/remotes/<name>/HEAD according to remote"
> -msgstr ""
> +msgstr "setzt refs/remotes/<Name>/HEAD gem=C3=A4=C3=9F dem Fernarchi=
v"
> =20
>  #: builtin/remote.c:1201
>  msgid "delete refs/remotes/<name>/HEAD"
> -msgstr ""
> +msgstr "entfernt refs/remotes/<Name>/HEAD"
> =20
>  #: builtin/remote.c:1216
>  msgid "Cannot determine remote HEAD"
> @@ -7734,7 +7692,7 @@ msgstr "* [veralteten Zweig entfernt] %s"
> =20
>  #: builtin/remote.c:1321
>  msgid "prune remotes after fetching"
> -msgstr ""
> +msgstr "entfernt veraltete Zweige im Fernarchiv nach dem Abholen"
> =20
>  #: builtin/remote.c:1387 builtin/remote.c:1461
>  #, c-format
> @@ -7742,9 +7700,8 @@ msgid "No such remote '%s'"
>  msgstr "Kein solches externes Projektarchiv '%s'"
> =20
>  #: builtin/remote.c:1407
> -#, fuzzy
>  msgid "add branch"
> -msgstr "Auf Zweig "
> +msgstr "f=C3=BCgt Zweig hinzu"
> =20
>  #: builtin/remote.c:1414
>  msgid "no remote specified"
> @@ -7752,16 +7709,15 @@ msgstr "kein externes Projektarchiv angegeben=
"
> =20
>  #: builtin/remote.c:1436
>  msgid "manipulate push URLs"
> -msgstr ""
> +msgstr "manipuliert URLs zum Versenden"
> =20
>  #: builtin/remote.c:1438
>  msgid "add URL"
> -msgstr ""
> +msgstr "f=C3=BCgt URL hinzu"
> =20
>  #: builtin/remote.c:1440
> -#, fuzzy
>  msgid "delete URLs"
> -msgstr "gel=C3=B6scht"
> +msgstr "l=C3=B6scht URLs"
> =20
>  #: builtin/remote.c:1447
>  msgid "--add --delete doesn't make sense"
> @@ -7783,53 +7739,53 @@ msgstr "Werde keine URLs entfernen, die nicht=
 f=C3=BCr den Versand bestimmt sind"
> =20
>  #: builtin/remote.c:1569
>  msgid "be verbose; must be placed before a subcommand"
> -msgstr ""
> +msgstr "erweiterte Ausgaben; muss vor einem Unterkommando angegeben =
werden"
> =20
>  #: builtin/replace.c:17
>  msgid "git replace [-f] <object> <replacement>"
> -msgstr ""
> +msgstr "git replace [-f] <Objekt> <Ersetzung>"
> =20
>  #: builtin/replace.c:18
>  msgid "git replace -d <object>..."
> -msgstr ""
> +msgstr "git replace -d <Objekt>..."
> =20
>  #: builtin/replace.c:19
>  msgid "git replace -l [<pattern>]"
> -msgstr ""
> +msgstr "git replace -l [<Muster>]"
> =20
>  #: builtin/replace.c:118
>  msgid "list replace refs"
> -msgstr ""
> +msgstr "listet ersetzende Referenzen auf"
> =20
>  #: builtin/replace.c:119
>  msgid "delete replace refs"
> -msgstr ""
> +msgstr "l=C3=B6scht ersetzende Referenzen"
> =20
>  #: builtin/replace.c:120
>  msgid "replace the ref if it exists"
> -msgstr ""
> +msgstr "ersetzt die Referenz, wenn sie existiert"
> =20
>  #: builtin/rerere.c:11
>  msgid "git rerere [clear | forget path... | status | remaining | dif=
f | gc]"
> -msgstr ""
> +msgstr "git rerere [clean | forget path... | status | remaining | di=
ff | gc]"
> =20
>  #: builtin/rerere.c:56
> -#, fuzzy
>  msgid "register clean resolutions in index"
> -msgstr "%s ist bereits bereitgestellt"
> +msgstr "registriert saubere Aufl=C3=B6sungen in der Bereitstellung"
> =20
>  #: builtin/reset.c:25
>  msgid ""
>  "git reset [--mixed | --soft | --hard | --merge | --keep] [-q] [<com=
mit>]"
>  msgstr ""
> +"git reset [--mixed | --soft | --hard | --merge | --keep] [-q] [<Ver=
sion>]"
> =20
>  #: builtin/reset.c:26
>  msgid "git reset [-q] <commit> [--] <paths>..."
> -msgstr ""
> +msgstr "git reset [-q] <Version> [--] <Pfade>..."
> =20
>  #: builtin/reset.c:27
>  msgid "git reset --patch [<commit>] [--] [<paths>...]"
> -msgstr ""
> +msgstr "git reset --patch [<Version>] [--] [<Pfade>...]"
> =20
>  #: builtin/reset.c:33
>  msgid "mixed"
> @@ -7890,23 +7846,23 @@ msgstr ""
> =20
>  #: builtin/reset.c:238
>  msgid "be quiet, only report errors"
> -msgstr ""
> +msgstr "weniger Ausgaben, meldet nur Fehler"
> =20
>  #: builtin/reset.c:240
>  msgid "reset HEAD and index"
> -msgstr ""
> +msgstr "setzt Zweigspitze (HEAD) und Bereitstellung zur=C3=BCck"
> =20
>  #: builtin/reset.c:241
>  msgid "reset only HEAD"
> -msgstr ""
> +msgstr "setzt nur Zweigspitze (HEAD) zur=C3=BCck"
> =20
>  #: builtin/reset.c:243 builtin/reset.c:245
>  msgid "reset HEAD, index and working tree"
> -msgstr ""
> +msgstr "setzt Zweigspitze (HEAD), Bereitstellung und Arbeitsbaum zur=
=C3=BCck"
> =20
>  #: builtin/reset.c:247
>  msgid "reset HEAD but keep local changes"
> -msgstr ""
> +msgstr "setzt Zweigspitze (HEAD) zur=C3=BCck, beh=C3=A4lt aber lokal=
e =C3=84nderungen"
> =20
>  #: builtin/reset.c:303
>  #, c-format
> @@ -7938,17 +7894,16 @@ msgid "Could not reset index file to revision=
 '%s'."
>  msgstr "Konnte Bereitstellungsdatei nicht zu Version '%s' zur=C3=BCc=
ksetzen."
> =20
>  #: builtin/rev-parse.c:339
> -#, fuzzy
>  msgid "git rev-parse --parseopt [options] -- [<args>...]"
> -msgstr "git apply [Optionen] [<Patch>...]"
> +msgstr "git rev-parse --parseopt [Optionen] -- [<Argumente>...]"
> =20
>  #: builtin/rev-parse.c:344
>  msgid "keep the `--` passed as an arg"
> -msgstr ""
> +msgstr "l=C3=A4sst `--` als Argument"
> =20
>  #: builtin/rev-parse.c:346
>  msgid "stop parsing after the first non-option argument"
> -msgstr ""
> +msgstr "stoppt das Parsen nach dem ersten Argument was keine Option =
ist"
> =20
>  #: builtin/rev-parse.c:464
>  msgid ""
> @@ -7958,23 +7913,28 @@ msgid ""
>  "\n"
>  "Run \"git rev-parse --parseopt -h\" for more information on the fir=
st usage."
>  msgstr ""
> +"git rev-parse --parseopt [Optionen] -- [<Argumente>...]\n"
> +"   or: git rev-parse --sq-quote [<Argumente>...]\n"
> +"   or: git rev-parse [Optionen] [<Argumente>...]\n"
> +"\n"
> +"F=C3=BChre \"git rev-parse --parseopt -h\" f=C3=BCr weitere Informa=
tionen bei erster "
> +"Verwendung aus."
> =20
>  #: builtin/revert.c:22
>  msgid "git revert [options] <commit-ish>"
> -msgstr ""
> +msgstr "git revert [options] <Versionsangabe>"
> =20
>  #: builtin/revert.c:23
>  msgid "git revert <subcommand>"
> -msgstr ""
> +msgstr "git revert <Unterkommando>"
> =20
>  #: builtin/revert.c:28
>  msgid "git cherry-pick [options] <commit-ish>"
> -msgstr ""
> +msgstr "git cherry-pick [Optionen] <Versionsangabe>"
> =20
>  #: builtin/revert.c:29
> -#, fuzzy
>  msgid "git cherry-pick <subcommand>"
> -msgstr "\"cherry-pick\" fehlgeschlagen"
> +msgstr "git cherry-pick <Unterkommando>"
> =20
>  #: builtin/revert.c:70 builtin/revert.c:92
>  #, c-format
> @@ -7983,68 +7943,59 @@ msgstr "%s: %s kann nicht mit %s benutzt werd=
en"
> =20
>  #: builtin/revert.c:103
>  msgid "end revert or cherry-pick sequence"
> -msgstr ""
> +msgstr "beendet \"revert\" oder \"cherry-pick\" Ablauf"
> =20
>  #: builtin/revert.c:104
>  msgid "resume revert or cherry-pick sequence"
> -msgstr ""
> +msgstr "setzt \"revert\" oder \"cherry-pick\" Ablauf fort"
> =20
>  #: builtin/revert.c:105
>  msgid "cancel revert or cherry-pick sequence"
> -msgstr ""
> +msgstr "bricht \"revert\" oder \"cherry-pick\" Ablauf ab"
> =20
>  #: builtin/revert.c:106
> -#, fuzzy
>  msgid "don't automatically commit"
> -msgstr "Kann nicht zu initialer Version zur=C3=BCcksetzen."
> +msgstr "tr=C3=A4gt nicht automatisch ein"
> =20
>  #: builtin/revert.c:107
> -#, fuzzy
>  msgid "edit the commit message"
> -msgstr "Leere Versionsbeschreibung"
> +msgstr "Bearbeitung der Versionsbeschreibung"
> =20
>  #: builtin/revert.c:110
>  msgid "parent number"
> -msgstr ""
> +msgstr "Nummer des Elternteils"
> =20
>  #: builtin/revert.c:112
> -#, fuzzy
>  msgid "merge strategy"
> -msgstr "Probiere Zusammenf=C3=BChrungsstrategie %s...\n"
> +msgstr "Zusammenf=C3=BChrungsstrategie"
> =20
>  #: builtin/revert.c:113
> -#, fuzzy
>  msgid "option"
> -msgstr "Aktion"
> +msgstr "Option"
> =20
>  #: builtin/revert.c:114
> -#, fuzzy
>  msgid "option for merge strategy"
> -msgstr "Probiere Zusammenf=C3=BChrungsstrategie %s...\n"
> +msgstr "Option f=C3=BCr Zusammenf=C3=BChrungsstrategie"
> =20
>  #: builtin/revert.c:125
>  msgid "append commit name"
> -msgstr ""
> +msgstr "h=C3=A4ngt Versionsnamen an"
> =20
>  #: builtin/revert.c:126
> -#, fuzzy
>  msgid "allow fast-forward"
> -msgstr "(kein Vorspulen)"
> +msgstr "erlaubt Vorspulen"
> =20
>  #: builtin/revert.c:127
> -#, fuzzy
>  msgid "preserve initially empty commits"
> -msgstr "Kann nicht zu initialer Version zur=C3=BCcksetzen."
> +msgstr "erh=C3=A4lt urspr=C3=BCngliche, leere Versionen"
> =20
>  #: builtin/revert.c:128
> -#, fuzzy
>  msgid "allow commits with empty messages"
> -msgstr "Version hat eine leere Beschreibung"
> +msgstr "erlaubt Version mit leerer Beschreibung"
> =20
>  #: builtin/revert.c:129
> -#, fuzzy
>  msgid "keep redundant, empty commits"
> -msgstr "Zusammenf=C3=BChrung hat keine Version zur=C3=BCckgegeben"
> +msgstr "beh=C3=A4lt redundante, leere Versionen"
> =20
>  #: builtin/revert.c:133
>  msgid "program error"
> @@ -8059,9 +8010,8 @@ msgid "cherry-pick failed"
>  msgstr "\"cherry-pick\" fehlgeschlagen"
> =20
>  #: builtin/rm.c:14
> -#, fuzzy
>  msgid "git rm [options] [--] <file>..."
> -msgstr "git apply [Optionen] [<Patch>...]"
> +msgstr "git rm [Optionen] [--] [<Datei>...]"
> =20
>  #: builtin/rm.c:109
>  #, c-format
> @@ -8093,26 +8043,24 @@ msgstr ""
>  "erzwingen)"
> =20
>  #: builtin/rm.c:134
> -#, fuzzy
>  msgid "do not list removed files"
> -msgstr "Kann ge=C3=A4nderte Dateien nicht aus der Bereitstellung her=
ausnehmen"
> +msgstr "listet keine entfernten Dateien auf"
> =20
>  #: builtin/rm.c:135
> -#, fuzzy
>  msgid "only remove from the index"
> -msgstr "konnte %s nicht aus der Bereitstellung entfernen"
> +msgstr "entfernt nur aus der Bereitstellung"
> =20
>  #: builtin/rm.c:136
>  msgid "override the up-to-date check"
> -msgstr ""
> +msgstr "=C3=BCberschreibt die \"up-to-date\" Pr=C3=BCfung"
> =20
>  #: builtin/rm.c:137
>  msgid "allow recursive removal"
> -msgstr ""
> +msgstr "erlaubt rekursive Entfernung"
> =20
>  #: builtin/rm.c:139
>  msgid "exit with a zero status even if nothing matched"
> -msgstr ""
> +msgstr "beendet mit R=C3=BCckgabewert 0, wenn keine =C3=9Cbereinstim=
mung gefunden wurde"
> =20
>  #: builtin/rm.c:194
>  #, c-format
> @@ -8127,6 +8075,8 @@ msgstr "git rm: konnte %s nicht entfernen"
>  #: builtin/shortlog.c:13
>  msgid "git shortlog [-n] [-s] [-e] [-w] [rev-opts] [--] [<commit-id>=
=2E.. ]"
>  msgstr ""
> +"git shortlog [-n] [-s] [-e] [-w] [rev-opts] [--] "
> +"[<Versionsidentifikation>... ]"
> =20
>  #: builtin/shortlog.c:157
>  #, c-format
> @@ -8135,23 +8085,23 @@ msgstr "fehlender Autor: %s"
> =20
>  #: builtin/shortlog.c:253
>  msgid "sort output according to the number of commits per author"
> -msgstr ""
> +msgstr "sortiert die Ausgabe entsprechend der Anzahl von Versionen p=
ro Autor"
> =20
>  #: builtin/shortlog.c:255
>  msgid "Suppress commit descriptions, only provides commit count"
> -msgstr ""
> +msgstr "Unterdr=C3=BCckt Versionsbeschreibungen, liefert nur Anzahl =
der Versionen"
> =20
>  #: builtin/shortlog.c:257
>  msgid "Show the email address of each author"
> -msgstr ""
> +msgstr "Zeigt die eMail-Adresse von jedem Autor"
> =20
>  #: builtin/shortlog.c:258
>  msgid "w[,i1[,i2]]"
> -msgstr ""
> +msgstr "w[,i1[,i2]]"
> =20
>  #: builtin/shortlog.c:259
>  msgid "Linewrap output"
> -msgstr ""
> +msgstr "Ausgabe mit Zeilenumbr=C3=BCchen"
> =20
>  #: builtin/show-branch.c:9
>  msgid ""
> @@ -8160,162 +8110,173 @@ msgid ""
>  "independent | --merge-base] [--no-name | --sha1-name] [--topics] [(=
<rev> | "
>  "<glob>)...]"
>  msgstr ""
> +"git show-branch [-a|--all] [-r|--remotes] [--topo-order | --date-or=
der] [--"
> +"current] [--color[=3D<Wann>] | --no-color] [--sparse] [--more=3D<Nu=
mmer> | --"
> +"list | --independent | --merge-base] [--no-name | --sha1-name] [--t=
opics] "
> +"[(<Revision> | <glob>)...]"
> =20
>  #: builtin/show-branch.c:10
>  msgid "git show-branch (-g|--reflog)[=3D<n>[,<base>]] [--list] [<ref=
>]"
>  msgstr ""
> +"git show-branch (-g|--reflog)[=3D<Nummer>[,<Basis>]] [--list] [<Ref=
erenz>]"
> =20
>  #: builtin/show-branch.c:651
> -#, fuzzy
>  msgid "show remote-tracking and local branches"
> -msgstr "Kein externer =C3=9Cbernahmezweig f=C3=BCr %s von %s"
> +msgstr "zeigt externer =C3=9Cbernahmezweige und lokale Zweige an"
> =20
>  #: builtin/show-branch.c:653
> -#, fuzzy
>  msgid "show remote-tracking branches"
> -msgstr "Kein externer =C3=9Cbernahmezweig f=C3=BCr %s von %s"
> +msgstr "zeigt externer =C3=9Cbernahmezweige an"
> =20
>  #: builtin/show-branch.c:655
>  msgid "color '*!+-' corresponding to the branch"
> -msgstr ""
> +msgstr "f=C3=A4rbt '*!+-' entsprechend des Zweiges ein"
> =20
>  #: builtin/show-branch.c:657
>  msgid "show <n> more commits after the common ancestor"
> -msgstr ""
> +msgstr "zeigt <Nummer> weitere Versionen nach dem gemeinsamen Vorfah=
ren"
> =20
>  #: builtin/show-branch.c:659
>  msgid "synonym to more=3D-1"
> -msgstr ""
> +msgstr "Synonym f=C3=BCr more=3D-1"
> =20
>  #: builtin/show-branch.c:660
>  msgid "suppress naming strings"
> -msgstr ""
> +msgstr "unterdr=C3=BCckt Namen"
> =20
>  #: builtin/show-branch.c:662
> -#, fuzzy
>  msgid "include the current branch"
> -msgstr "Du befindest dich auf keinem Zweig."
> +msgstr "bezieht den aktuellen Zweig ein"
> =20
>  #: builtin/show-branch.c:664
> -#, fuzzy
>  msgid "name commits with their object names"
> -msgstr "Konnte Notiz-Objekt nicht schreiben"
> +msgstr "benennt Versionen nach ihren Objektnamen"
> =20
>  #: builtin/show-branch.c:666
>  msgid "show possible merge bases"
> -msgstr ""
> +msgstr "zeigt m=C3=B6gliche Basen f=C3=BCr Zusammenf=C3=BChrung"
> =20
>  #: builtin/show-branch.c:668
>  msgid "show refs unreachable from any other ref"
> -msgstr ""
> +msgstr "zeigt Referenzen die unerreichbar von allen anderen Referenz=
en sind"
> =20
>  #: builtin/show-branch.c:670
>  msgid "show commits in topological order"
> -msgstr ""
> +msgstr "zeigt Versionen in topologischer Ordnung"
> =20
>  #: builtin/show-branch.c:672
>  msgid "show only commits not on the first branch"
> -msgstr ""
> +msgstr "zeigt nur Versionen, die sich nicht im ersten Zweig befinden=
"
> =20
>  #: builtin/show-branch.c:674
>  msgid "show merges reachable from only one tip"
>  msgstr ""
> +"zeigt Zusammenf=C3=BChrungen, die nur von einer Zweigspitze aus err=
eichbar sind"
> =20
>  #: builtin/show-branch.c:676
>  msgid "show commits where no parent comes before its children"
> -msgstr ""
> +msgstr "zeigt Versionen, wo kein Elternteil vor seinem Kind kommt"
> =20
>  #: builtin/show-branch.c:678
>  msgid "<n>[,<base>]"
> -msgstr ""
> +msgstr "<Nummer>[,<Basis>]"
> =20
>  #: builtin/show-branch.c:679
>  msgid "show <n> most recent ref-log entries starting at base"
>  msgstr ""
> +"zeigt die <Nummer> j=C3=BCngsten Eintr=C3=A4ge im Referenzprotokoll=
 beginnend an der "
> +"Basis"
> =20
>  #: builtin/show-ref.c:10
>  msgid ""
>  "git show-ref [-q|--quiet] [--verify] [--head] [-d|--dereference] [-=
s|--hash"
>  "[=3D<n>]] [--abbrev[=3D<n>]] [--tags] [--heads] [--] [pattern*] "
>  msgstr ""
> +"git show-ref [-q|--quiet] [--verify] [--head] [-d|--dereference] [-=
s|--hash"
> +"[=3D<Nummer>]] [--abbrev[=3D<Nummer>]] [--tags] [--heads] [--] [pat=
tern*] "
> =20
>  #: builtin/show-ref.c:11
>  msgid "git show-ref --exclude-existing[=3Dpattern] < ref-list"
> -msgstr ""
> +msgstr "git show-ref --exclude-existing[=3DMuster] < ref-list"
> =20
>  #: builtin/show-ref.c:182
> -#, fuzzy
>  msgid "only show tags (can be combined with heads)"
> -msgstr "--all kann nicht mit Referenzspezifikationen kombiniert werd=
en"
> +msgstr "zeigt nur Markierungen (kann mit \"heads\" kombiniert werden=
)"
> =20
>  #: builtin/show-ref.c:183
> -#, fuzzy
>  msgid "only show heads (can be combined with tags)"
> -msgstr "--all kann nicht mit Referenzspezifikationen kombiniert werd=
en"
> +msgstr "zeigt nur Zweigspitzen (kann mit \"tags\" kombiniert werden)=
"
> =20
>  #: builtin/show-ref.c:184
>  msgid "stricter reference checking, requires exact ref path"
> -msgstr ""
> +msgstr "strengere Referenzpr=C3=BCfung, erfordert exakten Referenzpf=
ad"
> =20
>  #: builtin/show-ref.c:187 builtin/show-ref.c:189
>  msgid "show the HEAD reference"
> -msgstr ""
> +msgstr "zeigt Referenz der Zweigspitze (HEAD)"
> =20
>  #: builtin/show-ref.c:191
> -#, fuzzy
>  msgid "dereference tags into object IDs"
> -msgstr "Referenz ist kein Baum: %s"
> +msgstr "dereferenziert Markierungen in Objekt-Identifikationen"
> =20
>  #: builtin/show-ref.c:193
>  msgid "only show SHA1 hash using <n> digits"
> -msgstr ""
> +msgstr "zeigt nur SHA1 Hash mit <Nummer> Ziffern"
> =20
>  #: builtin/show-ref.c:197
>  msgid "do not print results to stdout (useful with --verify)"
>  msgstr ""
> +"keine Ausgabe der Ergebnisse in die Standard-Ausgabe (n=C3=BCtzlich=
 mit --verify)"
> =20
>  #: builtin/show-ref.c:199
>  msgid "show refs from stdin that aren't in local repository"
>  msgstr ""
> +"zeigt Referenzen von der Standard-Eingabe, die sich nicht im lokale=
n "
> +"Projektarchiv befinden, an"
> =20
>  #: builtin/symbolic-ref.c:7
>  msgid "git symbolic-ref [options] name [ref]"
> -msgstr ""
> +msgstr "git symbolic-ref [Optionen] name [ref]"
> =20
>  #: builtin/symbolic-ref.c:38
>  msgid "suppress error message for non-symbolic (detached) refs"
>  msgstr ""
> +"unterdr=C3=BCckt Fehlermeldungen f=C3=BCr nicht-symbolische (losgel=
=C3=B6ste) Referenzen"
> =20
>  #: builtin/symbolic-ref.c:39
>  msgid "shorten ref output"
> -msgstr ""
> +msgstr "verk=C3=BCrzte Ausgabe der Referenzen"
> =20
>  #: builtin/symbolic-ref.c:40 builtin/update-ref.c:18
>  msgid "reason"
> -msgstr ""
> +msgstr "Grund"
> =20
>  #: builtin/symbolic-ref.c:40 builtin/update-ref.c:18
>  msgid "reason of the update"
> -msgstr ""
> +msgstr "Grund f=C3=BCr die Aktualisierung"
> =20
>  #: builtin/tag.c:22
>  msgid ""
>  "git tag [-a|-s|-u <key-id>] [-f] [-m <msg>|-F <file>] <tagname> [<h=
ead>]"
>  msgstr ""
> +"git tag [-a|-s|-u <Schl=C3=BCssel-id>] [-f] [-m <Nachricht>|-F <Dat=
ei>] "
> +"<Markierungsname> [<Zweig>]"
> =20
>  #: builtin/tag.c:23
>  msgid "git tag -d <tagname>..."
> -msgstr ""
> +msgstr "git tag -d <Markierungsname>..."
> =20
>  #: builtin/tag.c:24
>  msgid ""
>  "git tag -l [-n[<num>]] [--contains <commit>] [--points-at <object>]=
 \n"
>  "\t\t[<pattern>...]"
>  msgstr ""
> +"git tag -l [-n[<Nummer>]] [--contains <Version>] [--points-at <Obje=
kt>] \n"
> +"\t\t[<Muster>...]"
> =20
>  #: builtin/tag.c:26
>  msgid "git tag -v <tagname>..."
> -msgstr ""
> +msgstr "git tag -v <Markierungsname>..."
> =20
>  #: builtin/tag.c:60
>  #, c-format
> @@ -8408,63 +8369,59 @@ msgstr "fehlerhafter Objekt-Name '%s'"
> =20
>  #: builtin/tag.c:447
>  msgid "list tag names"
> -msgstr ""
> +msgstr "listet Markierungsnamen auf"
> =20
>  #: builtin/tag.c:449
>  msgid "print <n> lines of each tag message"
> -msgstr ""
> +msgstr "zeigt <Anzahl> Zeilen jeder Markierungsbeschreibung"
> =20
>  #: builtin/tag.c:451
> -#, fuzzy
>  msgid "delete tags"
> -msgstr "gel=C3=B6scht"
> +msgstr "l=C3=B6scht Markierungen"
> =20
>  #: builtin/tag.c:452
>  msgid "verify tags"
> -msgstr ""
> +msgstr "=C3=BCberpr=C3=BCft Markierungen"
> =20
>  #: builtin/tag.c:454
>  msgid "Tag creation options"
> -msgstr ""
> +msgstr "Optionen f=C3=BCr Erstellung von Markierungen"
> =20
>  #: builtin/tag.c:456
> -#, fuzzy
>  msgid "annotated tag, needs a message"
> -msgstr "annotierte Markierung %s hat keinen eingebetteten Namen"
> +msgstr "annotierte Markierung, ben=C3=B6tigt eine Beschreibung"
> =20
>  #: builtin/tag.c:458
> -#, fuzzy
>  msgid "tag message"
> -msgstr "keine Markierungsbeschreibung?"
> +msgstr "Markierungsbeschreibung"
> =20
>  #: builtin/tag.c:460
>  msgid "annotated and GPG-signed tag"
> -msgstr ""
> +msgstr "annotierte und GPG-signierte Markierung"
> =20
>  #: builtin/tag.c:464
> -#, fuzzy
>  msgid "use another key to sign the tag"
> -msgstr "konnte Markierung nicht signieren"
> +msgstr "benutzt einen Schl=C3=BCssel um die Markierung zu signieren"
> =20
>  #: builtin/tag.c:465
>  msgid "replace the tag if exists"
> -msgstr ""
> +msgstr "ersetzt die Markierung, wenn sie existiert"
> =20
>  #: builtin/tag.c:466
>  msgid "show tag list in columns"
> -msgstr ""
> +msgstr "zeigt Liste der Markierungen in Spalten"
> =20
>  #: builtin/tag.c:468
>  msgid "Tag listing options"
> -msgstr ""
> +msgstr "Optionen f=C3=BCr Auflistung der Markierungen"
> =20
>  #: builtin/tag.c:471
>  msgid "print only tags that contain the commit"
> -msgstr ""
> +msgstr "gibt nur Markierungen aus, die diese Version beinhalten"
> =20
>  #: builtin/tag.c:477
>  msgid "print only tags of the object"
> -msgstr ""
> +msgstr "gibt nur Markierungen von dem Objekt aus"
> =20
>  #: builtin/tag.c:506
>  msgid "--column and -n are incompatible"
> @@ -8516,182 +8473,184 @@ msgid "Updated tag '%s' (was %s)\n"
>  msgstr "Aktualisierte Markierung '%s' (war %s)\n"
> =20
>  #: builtin/update-index.c:401
> -#, fuzzy
>  msgid "git update-index [options] [--] [<file>...]"
> -msgstr "git apply [Optionen] [<Patch>...]"
> +msgstr "git update-index [Optionen] [--] [<Datei>...]"
> =20
>  #: builtin/update-index.c:717
>  msgid "continue refresh even when index needs update"
>  msgstr ""
> +"Aktualisierung fortsetzen, auch wenn die Bereitstellung aktualisier=
t werden "
> +"muss"
> =20
>  #: builtin/update-index.c:720
>  msgid "refresh: ignore submodules"
> -msgstr ""
> +msgstr "Aktualisierung: ignoriert Unterprojekte"
> =20
>  #: builtin/update-index.c:723
> -#, fuzzy
>  msgid "do not ignore new files"
> -msgstr "Kann Indexdatei nicht speichern"
> +msgstr "ignoriert keine neuen Dateien"
> =20
>  #: builtin/update-index.c:725
>  msgid "let files replace directories and vice-versa"
> -msgstr ""
> +msgstr "l=C3=A4sst Dateien Verzeichnisse ersetzen, und umgedreht"
> =20
>  #: builtin/update-index.c:727
>  msgid "notice files missing from worktree"
> -msgstr ""
> +msgstr "beachtet fehlende Dateien im Arbeitsbaum"
> =20
>  #: builtin/update-index.c:729
>  msgid "refresh even if index contains unmerged entries"
>  msgstr ""
> +"aktualisiert, auch wenn die Bereitstellung nicht zusammengef=C3=BCh=
rte Eintr=C3=A4ge "
> +"beinhaltet"
> =20
>  #: builtin/update-index.c:732
>  msgid "refresh stat information"
> -msgstr ""
> +msgstr "aktualisiert Dateiinformationen"
> =20
>  #: builtin/update-index.c:736
>  msgid "like --refresh, but ignore assume-unchanged setting"
> -msgstr ""
> +msgstr "wie --refresh, ignoriert aber \"assume-unchanged\" Einstellu=
ng"
> =20
>  #: builtin/update-index.c:740
>  msgid "<mode> <object> <path>"
> -msgstr ""
> +msgstr "<Modus> <Objekt> <Pfad>"
> =20
>  #: builtin/update-index.c:741
> -#, fuzzy
>  msgid "add the specified entry to the index"
> -msgstr "stellt Dateiinhalte zur Eintragung bereit"
> +msgstr "stellt den angegebenen Eintrag zur Eintragung bereit"
> =20
>  #: builtin/update-index.c:745
>  msgid "(+/-)x"
> -msgstr ""
> +msgstr "(+/-)x"
> =20
>  #: builtin/update-index.c:746
>  msgid "override the executable bit of the listed files"
> -msgstr ""
> +msgstr "=C3=BCberschreibt das \"ausf=C3=BChrbar\"-Bit der aufgeliste=
ten Dateien"
> =20
>  #: builtin/update-index.c:750
>  msgid "mark files as \"not changing\""
> -msgstr ""
> +msgstr "markiert Dateien als \"not changing\""
> =20
>  #: builtin/update-index.c:753
>  msgid "clear assumed-unchanged bit"
> -msgstr ""
> +msgstr "l=C3=B6scht \"assumed-unchanged\"-Bit"
> =20
>  #: builtin/update-index.c:756
>  msgid "mark files as \"index-only\""
> -msgstr ""
> +msgstr "markiert Dateien als \"index-only\""
> =20
>  #: builtin/update-index.c:759
>  msgid "clear skip-worktree bit"
> -msgstr ""
> +msgstr "l=C3=B6scht \"skip-worktree\"-Bit"
> =20
>  #: builtin/update-index.c:762
>  msgid "add to index only; do not add content to object database"
>  msgstr ""
> +"f=C3=BCgt nur der Bereitstellung hinzu; Inhalt wird nicht der Objek=
t-Datenbank "
> +"hinzugef=C3=BCgt"
> =20
>  #: builtin/update-index.c:764
>  msgid "remove named paths even if present in worktree"
> -msgstr ""
> +msgstr "entfernt benannte Pfade, auch wenn sie sich im Arbeitsbaum b=
efinden"
> =20
>  #: builtin/update-index.c:766
>  msgid "with --stdin: input lines are terminated by null bytes"
> -msgstr ""
> +msgstr "mit --stdin: eingegebene Zeilen sind durch NUL-Bytes abgesch=
lossen"
> =20
>  #: builtin/update-index.c:768
> -#, fuzzy
>  msgid "read list of paths to be updated from standard input"
> -msgstr "(lese Log-Nachricht von Standard-Eingabe)\n"
> +msgstr "liest Liste der zu aktualisierenden Pfade von der Standard-E=
ingabe"
> =20
>  #: builtin/update-index.c:772
> -#, fuzzy
>  msgid "add entries from standard input to the index"
> -msgstr "Konnte Log nicht von Standard-Eingabe lesen."
> +msgstr "f=C3=BCgt Eintr=C3=A4ge von der Standard-Eingabe der Bereits=
tellung hinzu"
> =20
>  #: builtin/update-index.c:776
>  msgid "repopulate stages #2 and #3 for the listed paths"
>  msgstr ""
> +"wiederholte Ausf=C3=BChrung der Phasen #2 und #3 f=C3=BCr die aufge=
listeten Pfade"
> =20
>  #: builtin/update-index.c:780
>  msgid "only update entries that differ from HEAD"
>  msgstr ""
> +"aktualisiert nur Eintr=C3=A4ge, die unterschiedlich zur Zweigspitze=
 (HEAD) sind"
> =20
>  #: builtin/update-index.c:784
>  msgid "ignore files missing from worktree"
> -msgstr ""
> +msgstr "ignoriert fehlende Dateien im Arbeitsbaum"
> =20
>  #: builtin/update-index.c:787
>  msgid "report actions to standard output"
> -msgstr ""
> +msgstr "gibt die Aktionen in der Standard-Ausgabe aus"
> =20
>  #: builtin/update-index.c:789
>  msgid "(for porcelains) forget saved unresolved conflicts"
> -msgstr ""
> +msgstr "(f=C3=BCr Fremdprogramme) keine gespeicherten, nicht aufgel=C3=
=B6ste Konflikte"
> =20
>  #: builtin/update-index.c:793
>  msgid "write index in this format"
> -msgstr ""
> +msgstr "schreibt Bereitstellungsdatei in diesem Format"
> =20
>  #: builtin/update-ref.c:7
>  msgid "git update-ref [options] -d <refname> [<oldval>]"
> -msgstr ""
> +msgstr "git update-ref [Optionen] -d <Referenzname> [<alterWert>]"
> =20
>  #: builtin/update-ref.c:8
>  msgid "git update-ref [options]    <refname> <newval> [<oldval>]"
> -msgstr ""
> +msgstr "git update-ref [Optionen]    <Referenzname> <neuerWert> [<al=
terWert>]"
> =20
>  #: builtin/update-ref.c:19
>  msgid "delete the reference"
> -msgstr ""
> +msgstr "l=C3=B6scht diese Referenz"
> =20
>  #: builtin/update-ref.c:21
>  msgid "update <refname> not the one it points to"
> -msgstr ""
> +msgstr "aktualisiert <Referenzname>, nicht den Verweis"
> =20
>  #: builtin/update-server-info.c:6
>  msgid "git update-server-info [--force]"
> -msgstr ""
> +msgstr "git update-server-info [--force]"
> =20
>  #: builtin/update-server-info.c:14
>  msgid "update the info files from scratch"
> -msgstr ""
> +msgstr "aktualisiert die Informationsdateien von Grund auf"
> =20
>  #: builtin/verify-pack.c:56
>  msgid "git verify-pack [-v|--verbose] [-s|--stat-only] <pack>..."
> -msgstr ""
> +msgstr "git verify-pack [-v|--verbose] [-s|--stat-only] <Paket>..."
> =20
>  #: builtin/verify-pack.c:66
> -#, fuzzy
>  msgid "verbose"
>  msgstr "erweiterte Ausgaben"
> =20
>  #: builtin/verify-pack.c:68
>  msgid "show statistics only"
> -msgstr ""
> +msgstr "zeigt nur Statistiken"
> =20
>  #: builtin/verify-tag.c:17
>  msgid "git verify-tag [-v|--verbose] <tag>..."
> -msgstr ""
> +msgstr "git verify-tag [-v|--verbose] <Markierung>..."
> =20
>  #: builtin/verify-tag.c:73
>  msgid "print tag contents"
> -msgstr ""
> +msgstr "gibt Markierungsinhalte aus"
> =20
>  #: builtin/write-tree.c:13
>  msgid "git write-tree [--missing-ok] [--prefix=3D<prefix>/]"
> -msgstr ""
> +msgstr "git write-tree [--missing-ok] [--prefix=3D<Prefix>/]"
> =20
>  #: builtin/write-tree.c:26
>  msgid "<prefix>/"
> -msgstr ""
> +msgstr "<Prefix>/"
> =20
>  #: builtin/write-tree.c:27
>  msgid "write tree object for a subdirectory <prefix>"
> -msgstr ""
> +msgstr "schreibt das Baumobjekt f=C3=BCr ein Unterverzeichnis <Prefi=
x>"
> =20
>  #: builtin/write-tree.c:30
>  msgid "only useful for debugging"
> -msgstr ""
> +msgstr "nur n=C3=BCtzlich f=C3=BCr Fehlersuche"
> =20
>  #: git.c:16
>  msgid "See 'git help <command>' for more information on a specific c=
ommand."
> @@ -8713,7 +8672,7 @@ msgstr "weniger Ausgaben"
> =20
>  #: parse-options.h:236
>  msgid "use <n> digits to display SHA-1s"
> -msgstr "benutze <n> Ziffern zur Anzeige von SHA-1s"
> +msgstr "benutze <Anzahl> Ziffern zur Anzeige von SHA-1s"
> =20
>  #: common-cmds.h:8
>  msgid "Add file contents to the index"
> @@ -8983,6 +8942,8 @@ msgid ""
>  "The copy of the patch that failed is found in:\n"
>  "   $dotest/patch"
>  msgstr ""
> +"Die Kopie des fehlgeschlagenen Patches befindet sich in:\n"
> +"   $dotest/patch"
> =20
>  #: git-am.sh:876
>  msgid "applying to an empty history"


--=20
Thomas Rast
trast@{inf,student}.ethz.ch
