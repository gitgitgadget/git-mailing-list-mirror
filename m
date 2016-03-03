From: Phillip Sz <phillip.szelat@gmail.com>
Subject: Re: [PATCH] l10n: de.po: translate "command" as "Befehl"
Date: Thu, 3 Mar 2016 21:35:12 +0100
Message-ID: <56D8A000.2080403@gmail.com>
References: <1457028452-32020-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	matthias.ruester@gmail.com, magnus.goerlitz@googlemail.com
To: Ralf Thielow <ralf.thielow@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 03 21:35:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abZy3-0000zT-Cx
	for gcvg-git-2@plane.gmane.org; Thu, 03 Mar 2016 21:35:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752260AbcCCUfX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Mar 2016 15:35:23 -0500
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37560 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213AbcCCUfV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2016 15:35:21 -0500
Received: by mail-wm0-f54.google.com with SMTP id p65so5914704wmp.0
        for <git@vger.kernel.org>; Thu, 03 Mar 2016 12:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=jHSTIPeSmlqswVok9xBLXR80YOMqMEpsviL8Ixnsq2E=;
        b=quqfCxUfwkAY7DY+BfTCc4nnHATFspE8n7TZYMuLTx/RwkGriEKJU2dr4Xck3sekoY
         hXo+myLGntIATcQK1NeWnz9KIp20adZVPW8W7PnyaFU88qCi5ERaWZgWJrtl0J7jm3Lr
         NS/KzOTDZLPlxZFtVmTK1WN0po1Y5BbRUfb+8tx5okXP2R+bbi5bMd33HR2WoyX7e8su
         T2iYmkT9aswlcVXalNNIov1rM2Tg4gxO/tUytwEWYIRdXSv8zcugbnj/S5WeL3+vF4m0
         s4czrZq9NWHF+DxrlqNYfN33p9hCGf3nw0pQg/gVL+O5Gl4XYb3Ra5PR2JeADP2uCPBj
         QDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=jHSTIPeSmlqswVok9xBLXR80YOMqMEpsviL8Ixnsq2E=;
        b=Z1OLdqNLukgRL7W3xj8aJK8awM2vyQY/sdVR53UwNLMYI7B7xfoKAdOcLVTXb50x1Q
         MHenSQIEyUqIJIOfiZxI+mhPkJK9zceL4h/GBFZ0db0sBObQQtHfIzTWI5DSIca1iRU6
         L5i1nizUbYjo4TaU7qtwFNWwlEezh8bVkzGTYNIrjsAe0BieHAoFtVBDk/ELinYIOtEJ
         biCmfDIHcK/WtcLC7MFLIRiHRxxlk7AdJixeVMVUZg+vnGdzlPR7KjOcs8I7s8gpzMuc
         Uqi/SGI8r4f0Qyi0nxxe6JExD/4+JS2q64ie5efoU5mNJc4wLrFSqJuSY0rJNoN1c5Bv
         HLlw==
X-Gm-Message-State: AD7BkJLjMtxO6rHUJNhnSpGVPvJIEdDgGAGYQpst3P7EFSv88b06y1/ZN80k8h2G5x6G1w==
X-Received: by 10.28.129.10 with SMTP id c10mr966993wmd.35.1457037320139;
        Thu, 03 Mar 2016 12:35:20 -0800 (PST)
Received: from [192.168.178.84] (i577AB3CA.versanet.de. [87.122.179.202])
        by smtp.googlemail.com with ESMTPSA id u202sm125404wmd.24.2016.03.03.12.35.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 03 Mar 2016 12:35:19 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <1457028452-32020-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288208>


Acked-by: Phillip Sz <phillip.szelat@gmail.com>

> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---
>  po/de.po | 80 ++++++++++++++++++++++++++++++++----------------------=
----------
>  1 file changed, 40 insertions(+), 40 deletions(-)
>=20
> diff --git a/po/de.po b/po/de.po
> index 5422ee3..8d1ccbb 100644
> --- a/po/de.po
> +++ b/po/de.po
> @@ -396,7 +396,7 @@ msgstr "Ung=C3=BCltiger Modus f=C3=BCr Objekterst=
ellung: %s"
>  #: config.c:1216
>  msgid "unable to parse command-line config"
>  msgstr ""
> -"Konnte die =C3=BCber die Kommandozeile angegebene Konfiguration nic=
ht parsen."
> +"Konnte die =C3=BCber die Befehlszeile angegebene Konfiguration nich=
t parsen."
> =20
>  #: config.c:1277
>  msgid "unknown error occured while reading the configuration files"
> @@ -407,8 +407,8 @@ msgstr ""
>  #, c-format
>  msgid "unable to parse '%s' from command-line config"
>  msgstr ""
> -"Konnte Wert '%s' aus der =C3=BCber die Kommandozeile angegebenen\n"
> -"Konfiguration nicht parsen."
> +"Konnte Wert '%s' aus der =C3=BCber die Befehlszeile angegebenen Kon=
figuration\n"
> +"nicht parsen."
> =20
>  #: config.c:1603
>  #, c-format
> @@ -607,15 +607,15 @@ msgstr "'%s': read() zu kurz %s"
>  #: help.c:207
>  #, c-format
>  msgid "available git commands in '%s'"
> -msgstr "Vorhandene Git-Kommandos in '%s'"
> +msgstr "Vorhandene Git-Befehle in '%s'"
> =20
>  #: help.c:214
>  msgid "git commands available from elsewhere on your $PATH"
> -msgstr "Vorhandene Git-Kommandos anderswo in Ihrem $PATH"
> +msgstr "Vorhandene Git-Befehle anderswo in Ihrem $PATH"
> =20
>  #: help.c:246
>  msgid "These are common Git commands used in various situations:"
> -msgstr "Allgemeine Git-Kommandos, verwendet in verschiedenen Situati=
onen:"
> +msgstr "Allgemeine Git-Befehle, verwendet in verschiedenen Situation=
en:"
> =20
>  #: help.c:311
>  #, c-format
> @@ -623,12 +623,12 @@ msgid ""
>  "'%s' appears to be a git command, but we were not\n"
>  "able to execute it. Maybe git-%s is broken?"
>  msgstr ""
> -"'%s' scheint ein git-Kommando zu sein, konnte aber\n"
> +"'%s' scheint ein git-Befehl zu sein, konnte aber\n"
>  "nicht ausgef=C3=BChrt werden. Vielleicht ist git-%s fehlerhaft?"
> =20
>  #: help.c:368
>  msgid "Uh oh. Your system reports no Git commands at all."
> -msgstr "Uh oh. Keine Git-Kommandos auf Ihrem System vorhanden."
> +msgstr "Uh oh. Keine Git-Befehle auf Ihrem System vorhanden."
> =20
>  #: help.c:390
>  #, c-format
> @@ -636,7 +636,7 @@ msgid ""
>  "WARNING: You called a Git command named '%s', which does not exist.=
\n"
>  "Continuing under the assumption that you meant '%s'"
>  msgstr ""
> -"Warnung: Sie haben das nicht existierende Git-Kommando '%s' ausgef=C3=
=BChrt.\n"
> +"Warnung: Sie haben den nicht existierenden Git-Befehl '%s' ausgef=C3=
=BChrt.\n"
>  "Setze fort unter der Annahme, dass Sie '%s' gemeint haben."
> =20
>  #: help.c:395
> @@ -647,7 +647,7 @@ msgstr "Automatische Ausf=C3=BChrung in %0.1f Sek=
unden ..."
>  #: help.c:402
>  #, c-format
>  msgid "git: '%s' is not a git command. See 'git --help'."
> -msgstr "git: '%s' ist kein Git-Kommando. Siehe 'git --help'."
> +msgstr "git: '%s' ist kein Git-Befehl. Siehe 'git --help'."
> =20
>  #: help.c:406 help.c:466
>  msgid ""
> @@ -1048,7 +1048,7 @@ msgstr "Pfadspezifikation '%s' befindet sich in=
 Submodul '%.*s'"
>  #, c-format
>  msgid "%s: pathspec magic not supported by this command: %s"
>  msgstr ""
> -"%s: Pfadspezifikationsangabe wird von diesem Kommando nicht unterst=
=C3=BCtzt: %s"
> +"%s: Pfadspezifikationsangabe wird von diesem Befehl nicht unterst=C3=
=BCtzt: %s"
> =20
>  #: pathspec.c:432
>  #, c-format
> @@ -1944,14 +1944,14 @@ msgstr ""
> =20
>  #: wt-status.c:1105
>  msgid "No commands done."
> -msgstr "Keine Kommandos ausgef=C3=BChrt."
> +msgstr "Keine Befehle ausgef=C3=BChrt."
> =20
>  #: wt-status.c:1108
>  #, c-format
>  msgid "Last command done (%d command done):"
>  msgid_plural "Last commands done (%d commands done):"
> -msgstr[0] "Zuletzt ausgef=C3=BChrtes Kommando (%d Kommando ausgef=C3=
=BChrt):"
> -msgstr[1] "Zuletzt ausgef=C3=BChrte Kommandos (%d Kommandos ausgef=C3=
=BChrt):"
> +msgstr[0] "Zuletzt ausgef=C3=BChrter Befehl (%d Befehl ausgef=C3=BCh=
rt):"
> +msgstr[1] "Zuletzt ausgef=C3=BChrte Befehle (%d Befehle ausgef=C3=BC=
hrt):"
> =20
>  #: wt-status.c:1119
>  #, c-format
> @@ -1960,14 +1960,14 @@ msgstr "  (mehr Informationen in Datei %s)"
> =20
>  #: wt-status.c:1124
>  msgid "No commands remaining."
> -msgstr "Keine Kommandos verbleibend."
> +msgstr "Keine Befehle verbleibend."
> =20
>  #: wt-status.c:1127
>  #, c-format
>  msgid "Next command to do (%d remaining command):"
>  msgid_plural "Next commands to do (%d remaining commands):"
> -msgstr[0] "N=C3=A4chstes auszuf=C3=BChrendes Kommando (%d Kommando v=
erbleibend):"
> -msgstr[1] "N=C3=A4chste auszuf=C3=BChrende Kommandos (%d Kommandos v=
erbleibend):"
> +msgstr[0] "N=C3=A4chster auszuf=C3=BChrender Befehl (%d Befehle verb=
leibend):"
> +msgstr[1] "N=C3=A4chste auszuf=C3=BChrende Befehle (%d Befehle verbl=
eibend):"
> =20
>  #: wt-status.c:1135
>  msgid "  (use \"git rebase --edit-todo\" to view and edit)"
> @@ -4525,7 +4525,7 @@ msgstr ""
> =20
>  #: builtin/clean.c:836
>  msgid "*** Commands ***"
> -msgstr "*** Kommandos ***"
> +msgstr "*** Befehle ***"
> =20
>  #: builtin/clean.c:837
>  msgid "What now"
> @@ -4929,7 +4929,7 @@ msgstr ""
>  "Ihr Name und E-Mail Adresse wurden automatisch auf Basis\n"
>  "Ihres Benutzer- und Rechnernamens konfiguriert. Bitte pr=C3=BCfen S=
ie, dass\n"
>  "diese zutreffend sind. Sie k=C3=B6nnen diese Meldung unterdr=C3=BCc=
ken, indem Sie\n"
> -"diese explizit setzen. F=C3=BChren Sie dazu das folgende Kommando a=
us und folgen\n"
> +"diese explizit setzen. F=C3=BChren Sie dazu den folgenden Befehl au=
s und folgen\n"
>  "Sie den Anweisungen in Ihrem Editor, um die Konfigurationsdatei zu =
"
>  "bearbeiten:\n"
>  "\n"
> @@ -4973,7 +4973,7 @@ msgid ""
>  "remove the commit entirely with \"git reset HEAD^\".\n"
>  msgstr ""
>  "Sie fragten den j=C3=BCngsten Commit nachzubessern, aber das w=C3=BC=
rde diesen leer\n"
> -"machen. Sie k=C3=B6nnen Ihr Kommando mit --allow-empty wiederholen,=
 oder diesen\n"
> +"machen. Sie k=C3=B6nnen Ihren Befehl mit --allow-empty wiederholen,=
 oder diesen\n"
>  "Commit mit \"git reset HEAD^\" vollst=C3=A4ndig entfernen.\n"
> =20
>  #: builtin/commit.c:78
> @@ -6692,7 +6692,7 @@ msgstr "Datei verarbeiten, als ob sie von diese=
m Pfad w=C3=A4re"
> =20
>  #: builtin/help.c:41
>  msgid "print all available commands"
> -msgstr "alle vorhandenen Kommandos anzeigen"
> +msgstr "alle vorhandenen Befehle anzeigen"
> =20
>  #: builtin/help.c:42
>  msgid "print list of useful guides"
> @@ -6712,7 +6712,7 @@ msgstr "Info-Seite anzeigen"
> =20
>  #: builtin/help.c:52
>  msgid "git help [--all] [--guides] [--man | --web | --info] [<comman=
d>]"
> -msgstr "git help [--all] [--guides] [--man | --web | --info] [<Komma=
ndo>]"
> +msgstr "git help [--all] [--guides] [--man | --web | --info] [<Befeh=
l>]"
> =20
>  #: builtin/help.c:64
>  #, c-format
> @@ -6752,7 +6752,7 @@ msgid ""
>  "'%s': cmd for supported man viewer.\n"
>  "Please consider using 'man.<tool>.path' instead."
>  msgstr ""
> -"'%s': Kommando f=C3=BCr unterst=C3=BCtzten Handbuchbetrachter.\n"
> +"'%s': Programm f=C3=BCr unterst=C3=BCtzten Handbuchbetrachter.\n"
>  "Sie k=C3=B6nnten stattdessen 'man.<Werkzeug>.path' benutzen."
> =20
>  #: builtin/help.c:337
> @@ -6774,7 +6774,7 @@ msgstr "Definition von Attributen pro Pfad"
> =20
>  #: builtin/help.c:412
>  msgid "Everyday Git With 20 Commands Or So"
> -msgstr "T=C3=A4gliche Benutzung von Git mit ungef=C3=A4hr 20 Kommand=
os"
> +msgstr "T=C3=A4gliche Benutzung von Git mit ungef=C3=A4hr 20 Befehle=
n"
> =20
>  #: builtin/help.c:413
>  msgid "A Git glossary"
> @@ -8492,7 +8492,7 @@ msgstr "Objekte von der Standard-Eingabe lesen"
>  #: builtin/notes.c:480
>  msgid "load rewriting config for <command> (implies --stdin)"
>  msgstr ""
> -"Konfiguration f=C3=BCr <Kommando> beim Umschreiben von Versionen la=
den "
> +"Konfiguration f=C3=BCr <Befehl> zum Umschreiben von Commits laden "
>  "(impliziert --stdin)"
> =20
>  #: builtin/notes.c:498
> @@ -8519,7 +8519,7 @@ msgid ""
>  "The -m/-F/-c/-C options have been deprecated for the 'edit' subcomm=
and.\n"
>  "Please use 'git notes add -f -m/-F/-c/-C' instead.\n"
>  msgstr ""
> -"Die Optionen -m/-F/-c/-C sind f=C3=BCr das Unterkommando 'edit' ver=
altet.\n"
> +"Die Optionen -m/-F/-c/-C sind f=C3=BCr den Unterbefehl 'edit' veral=
tet.\n"
>  "Bitte benutzen Sie stattdessen 'git notes add -f -m/-F/-c/-C'.\n"
> =20
>  #: builtin/notes.c:764
> @@ -8585,7 +8585,7 @@ msgstr "Notizen von <Notiz-Referenz> verwenden"
>  #: builtin/notes.c:1012 builtin/remote.c:1647
>  #, c-format
>  msgid "Unknown subcommand: %s"
> -msgstr "Unbekanntes Unterkommando: %s"
> +msgstr "Unbekannter Unterbefehl: %s"
> =20
>  #: builtin/pack-objects.c:28
>  msgid ""
> @@ -8897,7 +8897,7 @@ msgstr ""
>  "Sie f=C3=BChrten \"pull\" von Remote-Repository '%s' aus, ohne eine=
n\n"
>  "Branch anzugeben. Da das nicht das konfigurierte Standard-Remote-\n=
"
>  "Repository f=C3=BCr den aktuellen Branch ist, m=C3=BCssen Sie einen=
 Branch auf\n"
> -"der Kommandozeile angeben."
> +"der Befehlszeile angeben."
> =20
>  #: builtin/pull.c:447
>  msgid "You are not currently on a branch."
> @@ -9227,7 +9227,7 @@ msgid ""
>  "    git push <name>\n"
>  msgstr ""
>  "Kein Ziel f=C3=BCr \"push\" konfiguriert.\n"
> -"Entweder spezifizieren Sie die URL von der Kommandozeile oder konfi=
gurieren "
> +"Entweder spezifizieren Sie die URL von der Befehlszeile oder konfig=
urieren "
>  "ein Remote-Repository unter Benutzung von\n"
>  "\n"
>  "    git remote add <Name> <URL>\n"
> @@ -9934,7 +9934,7 @@ msgstr "Werde keine URLs entfernen, die nicht f=
=C3=BCr \"push\" bestimmt sind"
> =20
>  #: builtin/remote.c:1616
>  msgid "be verbose; must be placed before a subcommand"
> -msgstr "erweiterte Ausgaben; muss vor einem Unterkommando angegeben =
werden"
> +msgstr "erweiterte Ausgaben; muss vor einem Unterbefehl angegeben we=
rden"
> =20
>  #: builtin/repack.c:17
>  msgid "git repack [<options>]"
> @@ -10280,7 +10280,7 @@ msgstr "git revert [<Optionen>] <Commit-Angab=
e>..."
> =20
>  #: builtin/revert.c:23
>  msgid "git revert <subcommand>"
> -msgstr "git revert <Unterkommando>"
> +msgstr "git revert <Unterbefehl>"
> =20
>  #: builtin/revert.c:28
>  msgid "git cherry-pick [<options>] <commit-ish>..."
> @@ -10288,7 +10288,7 @@ msgstr "git cherry-pick [<Optionen>] <Commit-=
Angabe>..."
> =20
>  #: builtin/revert.c:29
>  msgid "git cherry-pick <subcommand>"
> -msgstr "git cherry-pick <Unterkommando>"
> +msgstr "git cherry-pick <Unterbefehl>"
> =20
>  #: builtin/revert.c:71
>  #, c-format
> @@ -10740,12 +10740,12 @@ msgstr "Konnte Submodul-Verzeichnis '%s' ni=
cht finden."
> =20
>  #: builtin/submodule--helper.c:273
>  msgid "fatal: submodule--helper subcommand must be called with a sub=
command"
> -msgstr "fatal: submodule--helper muss mit einem Unterkommando aufger=
ufen werden"
> +msgstr "fatal: submodule--helper muss mit einem Unterbefehl aufgeruf=
en werden"
> =20
>  #: builtin/submodule--helper.c:280
>  #, c-format
>  msgid "fatal: '%s' is not a valid submodule--helper subcommand"
> -msgstr "fatal: '%s' ist kein g=C3=BCltiges Unterkommando von submodu=
le--helper"
> +msgstr "fatal: '%s' ist kein g=C3=BCltiger Unterbefehl von submodule=
--helper"
> =20
>  #: builtin/symbolic-ref.c:7
>  msgid "git symbolic-ref [<options>] <name> [<ref>]"
> @@ -11362,9 +11362,9 @@ msgid ""
>  "concept guides. See 'git help <command>' or 'git help <concept>'\n"
>  "to read about a specific subcommand or concept."
>  msgstr ""
> -"'git help -a' und 'git help -g' listet verf=C3=BCgbare Unterkommand=
os und\n"
> -"einige Anleitungen zu Git-Konzepten auf. Benutzen Sie 'git help <Ko=
mmando>'\n"
> -"oder 'git help <Konzept>', um mehr =C3=BCber ein spezifisches Komma=
ndo oder\n"
> +"'git help -a' und 'git help -g' listet verf=C3=BCgbare Unterbefehle=
 und\n"
> +"einige Anleitungen zu Git-Konzepten auf. Benutzen Sie 'git help <Be=
fehl>'\n"
> +"oder 'git help <Konzept>', um mehr =C3=BCber einen spezifischen Bef=
ehl oder\n"
>  "Konzept zu erfahren."
> =20
>  #: common-cmds.h:9
> @@ -11682,7 +11682,7 @@ msgstr "'$term' ist kein g=C3=BCltiger Begrif=
f"
>  #: git-bisect.sh:578
>  #, sh-format
>  msgid "can't use the builtin command '$term' as a term"
> -msgstr "Kann eingebautes Kommando '$term' nicht als Begriff verwende=
n"
> +msgstr "Kann eingebauten Befehl '$term' nicht als Begriff verwenden"
> =20
>  #: git-bisect.sh:587 git-bisect.sh:593
>  #, sh-format
> @@ -11693,7 +11693,7 @@ msgstr "Kann Bedeutung von '$term' nicht =C3=A4=
ndern."
>  #, sh-format
>  msgid "Invalid command: you're currently in a $TERM_BAD/$TERM_GOOD b=
isect."
>  msgstr ""
> -"Ung=C3=BCltiges Kommando: Sie sind gerade bei einer bin=C3=A4ren $T=
ERM_BAD/$TERM_GOOD "
> +"Ung=C3=BCltiger Befehl: Sie sind gerade bei einer bin=C3=A4ren $TER=
M_BAD/$TERM_GOOD "
>  "Suche."
> =20
>  #: git-bisect.sh:636
> @@ -11799,7 +11799,7 @@ msgstr ""
>  "\t$cmd_live_rebase\n"
>  "Wenn das nicht der Fall ist, probieren Sie bitte\n"
>  "\t$cmd_clear_stale_rebase\n"
> -"und f=C3=BChren Sie dieses Kommando nochmal aus. Es wird angehalten=
, falls noch\n"
> +"und f=C3=BChren Sie diesen Befehl nochmal aus. Es wird angehalten, =
falls noch\n"
>  "etwas Sch=C3=BCtzenswertes vorhanden ist."
> =20
>  #: git-rebase.sh:468
>=20
