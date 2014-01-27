From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH v2] l10n: de.po: translate 27 new messages
Date: Mon, 27 Jan 2014 07:18:45 +0100
Message-ID: <1390803525-3075-1-git-send-email-ralf.thielow@gmail.com>
References: <CANYiYbFu1JSayZMdaLg2qAiNaNebgzQkSK7SyMNhFan1wzWzOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org, worldhello.net@gmail.com
X-From: git-owner@vger.kernel.org Mon Jan 27 07:19:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7fXA-0005I2-UP
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jan 2014 07:19:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbaA0GSx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Jan 2014 01:18:53 -0500
Received: from mail-ee0-f47.google.com ([74.125.83.47]:55508 "EHLO
	mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751069AbaA0GSw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jan 2014 01:18:52 -0500
Received: by mail-ee0-f47.google.com with SMTP id d49so1998305eek.20
        for <git@vger.kernel.org>; Sun, 26 Jan 2014 22:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=0fz23Jp5ovAbOBQzCPeGg//ToF3NFO+WjPaeNOBOpPA=;
        b=yGHgivsVTI5hb/qLz06wgzMCNtoA4+dPvj1lkZ+y1tC48WPPm0VRC11LTO6IiLDkwQ
         3oT5dgnM7p71TiG1WY89PyDQK2d6OeFndR0LBY8PyMNB1c4a9BHo2COFa80/aNi2L7vP
         LVduwhSvL89VS38nNlYZihLnv5uZrUnlwl7bzYMUmc69yXtBYOCg5lexPWeIflfNYuB6
         A0nqTK5beEX22s049rfd+UVjzWydrSJha2W0auGJo7jhghQ5pi1SeaKz2/mzwcNkCgk8
         fqzuHTop5nM2FbCi2qF5CMA9kWkQAYszmhVudqZxPH3ZVZS+SyuPa7d2XPWw2ooF0VOr
         P01g==
X-Received: by 10.14.203.7 with SMTP id e7mr19686528eeo.58.1390803530825;
        Sun, 26 Jan 2014 22:18:50 -0800 (PST)
Received: from localhost (dslb-178-005-115-210.pools.arcor-ip.net. [178.5.115.210])
        by mx.google.com with ESMTPSA id u7sm38146987eep.11.2014.01.26.22.18.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 26 Jan 2014 22:18:50 -0800 (PST)
X-Mailer: git-send-email 1.8.5.3.493.gb139ac2
In-Reply-To: <CANYiYbFu1JSayZMdaLg2qAiNaNebgzQkSK7SyMNhFan1wzWzOw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241132>

Translate 27 new messages came from git.pot update in
df49095 (l10n: git.pot: v1.9 round 1 (27 new, 11 removed).

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---

2014-01-24 Jiang Xin <worldhello.net@gmail.com>:
>
> Inconsistent ending colons, some have and some not.
>

Oops. Thanks! Here is v2.

 po/de.po | 90 ++++++++++++++++++++++++++++++++------------------------=
--------
 1 file changed, 45 insertions(+), 45 deletions(-)

diff --git a/po/de.po b/po/de.po
index 9c03238..b824f45 100644
--- a/po/de.po
+++ b/po/de.po
@@ -442,9 +442,9 @@ msgstr[0] "vor %lu Jahr"
 msgstr[1] "vor %lu Jahren"
=20
 #: diffcore-order.c:24
-#, fuzzy, c-format
+#, c-format
 msgid "failed to read orderfile '%s'"
-msgstr "Fehler beim Lesen des Objektes '%s'."
+msgstr "Fehler beim Lesen der Reihenfolgedatei '%s'."
=20
 #: diff.c:113
 #, c-format
@@ -975,21 +975,23 @@ msgid ""
 "There is nothing to exclude from by :(exclude) patterns.\n"
 "Perhaps you forgot to add either ':/' or '.' ?"
 msgstr ""
+"Es gibt nichts, was durch :(exclude) Muster ausgeschlossen wird.\n"
+"Vielleicht haben Sie vergessen entweder ':/' oder '.' hinzuzuf=C3=BCg=
en?"
=20
 #: remote.c:753
-#, fuzzy, c-format
+#, c-format
 msgid "Cannot fetch both %s and %s to %s"
-msgstr "Kann keine Commit-Beschreibung f=C3=BCr %s bekommen"
+msgstr "Kann 'fetch' nicht f=C3=BCr %s und %s nach %s ausf=C3=BChren."
=20
 #: remote.c:757
 #, c-format
 msgid "%s usually tracks %s, not %s"
-msgstr ""
+msgstr "%s folgt =C3=BCblicherweise %s, nicht %s"
=20
 #: remote.c:761
 #, c-format
 msgid "%s tracks both %s and %s"
-msgstr ""
+msgstr "%s folgt %s und %s"
=20
 #.
 #. * This last possibility doesn't occur because
@@ -997,9 +999,8 @@ msgstr ""
 #. * the end of the list.
 #.
 #: remote.c:769
-#, fuzzy
 msgid "Internal error"
-msgstr "interner Fehler"
+msgstr "Interner Fehler"
=20
 #: remote.c:1871
 #, c-format
@@ -1575,33 +1576,28 @@ msgid "both modified:"
 msgstr "von beiden ge=C3=A4ndert:"
=20
 #: wt-status.c:275
-#, fuzzy
 msgid "new file"
-msgstr "neue Datei:   %s"
+msgstr "neue Datei"
=20
 #: wt-status.c:277
 msgid "copied"
-msgstr ""
+msgstr "kopiert"
=20
 #: wt-status.c:279
-#, fuzzy
 msgid "deleted"
 msgstr "gel=C3=B6scht"
=20
 #: wt-status.c:285
-#, fuzzy
 msgid "typechange"
-msgstr "Typ=C3=A4nderung: %s"
+msgstr "Typ=C3=A4nderung"
=20
 #: wt-status.c:287
-#, fuzzy
 msgid "unknown"
-msgstr "unbekannt:    %s"
+msgstr "unbekannt"
=20
 #: wt-status.c:289
-#, fuzzy
 msgid "unmerged"
-msgstr "zusammenf=C3=BChren"
+msgstr "nicht zusammengef=C3=BChrt"
=20
 #: wt-status.c:336
 msgid "new commits, "
@@ -1633,6 +1629,8 @@ msgid ""
 "Do not touch the line above.\n"
 "Everything below will be removed."
 msgstr ""
+"=C3=84ndern Sie nicht die Zeile oberhalb.\n"
+"Alles unterhalb wird entfernt."
=20
 #: wt-status.c:899
 msgid "You have unmerged paths."
@@ -3991,14 +3989,14 @@ msgid "reference repository '%s' is not a local=
 repository."
 msgstr "Referenziertes Repository '%s' ist kein lokales Repository."
=20
 #: builtin/clone.c:256
-#, fuzzy, c-format
+#, c-format
 msgid "reference repository '%s' is shallow"
-msgstr "Referenziertes Repository '%s' ist kein lokales Repository."
+msgstr "Referenziertes Repository '%s' ist unvollst=C3=A4ndig (shallow=
)."
=20
 #: builtin/clone.c:259
-#, fuzzy, c-format
+#, c-format
 msgid "reference repository '%s' is grafted"
-msgstr "referenziert Repository"
+msgstr "Referenziertes Repository '%s' ist gesondert eingeh=C3=A4ngt (=
graft)."
=20
 #: builtin/clone.c:321
 #, c-format
@@ -4099,16 +4097,16 @@ msgstr ""
=20
 #: builtin/clone.c:805
 msgid "source repository is shallow, ignoring --local"
-msgstr ""
+msgstr "Quelle ist ein unvollst=C3=A4ndiges Repository (shallow), igno=
riere --local"
=20
 #: builtin/clone.c:810
 msgid "--local is ignored"
 msgstr "--local wird ignoriert"
=20
 #: builtin/clone.c:814 builtin/fetch.c:1119
-#, fuzzy, c-format
+#, c-format
 msgid "depth %s is not a positive number"
-msgstr "Objekt %s ist kein Blob"
+msgstr "Tiefe %s ist keine positive Zahl"
=20
 #: builtin/clone.c:824
 #, c-format
@@ -5215,9 +5213,8 @@ msgid "default mode for recursion"
 msgstr "Standard-Modus f=C3=BCr Rekursion"
=20
 #: builtin/fetch.c:109
-#, fuzzy
 msgid "accept refs that update .git/shallow"
-msgstr "Konnte aktualisierte .gitmodules-Datei nicht lesen"
+msgstr "akzeptiert Referenzen die .git/shallow aktualisieren"
=20
 #: builtin/fetch.c:347
 msgid "Couldn't find remote ref HEAD"
@@ -5287,7 +5284,8 @@ msgstr "%s hat nicht alle erforderlichen Objekte =
gesendet\n"
 #: builtin/fetch.c:579
 #, c-format
 msgid "reject %s because shallow roots are not allowed to be updated"
-msgstr ""
+msgstr "%s wurde zur=C3=BCckgewiesen, da Ursprungs-Commits von unvolls=
t=C3=A4ndigen\n"
+"Repositories (shallow) nicht aktualisiert werden d=C3=BCrfen."
=20
 #: builtin/fetch.c:667 builtin/fetch.c:750
 #, c-format
@@ -7181,9 +7179,8 @@ msgid "git merge-base --is-ancestor <commit> <com=
mit>"
 msgstr "git merge-base --is-ancestor <Commit> <Commit>"
=20
 #: builtin/merge-base.c:33
-#, fuzzy
 msgid "git merge-base --fork-point <ref> [<commit>]"
-msgstr "git merge-base --is-ancestor <Commit> <Commit>"
+msgstr "git merge-base --fork-point <Referenz> [<Commit>]"
=20
 #: builtin/merge-base.c:214
 msgid "output all common ancestors"
@@ -7203,7 +7200,7 @@ msgstr "ist der Erste ein Vorg=C3=A4nger-Commit v=
on dem Anderen?"
=20
 #: builtin/merge-base.c:222
 msgid "find where <commit> forked from reflog of <ref>"
-msgstr ""
+msgstr "findet wo <Commit> von Reflog von <Referenz> abgespalten wurde=
"
=20
 #: builtin/merge-file.c:8
 msgid ""
@@ -7333,9 +7330,8 @@ msgid "multiple sources for the same target"
 msgstr "mehrere Quellen f=C3=BCr das selbe Ziel"
=20
 #: builtin/mv.c:218
-#, fuzzy
 msgid "destination directory does not exist"
-msgstr "Repository '%s' existiert nicht."
+msgstr "Zielverzeichnis existiert nicht"
=20
 #: builtin/mv.c:233
 #, c-format
@@ -8008,7 +8004,6 @@ msgstr ""
 "Remote-Branch zu aktualisieren."
=20
 #: builtin/push.c:207
-#, fuzzy
 msgid ""
 "push.default is unset; its implicit value is changing in\n"
 "Git 2.0 from 'matching' to 'simple'. To squelch this message\n"
@@ -8044,11 +8039,18 @@ msgstr ""
 "\n"
 "  git config --global push.default simple\n"
 "\n"
-"F=C3=BChren Sie 'git help config' aus und suchen Sie nach 'push.defau=
lt' f=C3=BCr "
+"Wenn 'push.default' auf den Wert 'matching' gesetzt ist, werden lokal=
e\n"
+"Branches zu den Remote-Branches mit den selben Namen versendet.\n"
+"\n"
+"In Git 2.0 wird das Standardverhalten zu 'simple' ge=C3=A4ndert. Hier=
bei wird\n"
+"der aktuelle Branch zu dem entsprechenden Remote-Branch versendet, de=
n\n"
+"'git pull' zur Aktualisierung des aktuellen Branches verwendet.\n"
+"\n"
+"F=C3=BChren Sie 'git help config' aus und suchen Sie nach 'push.defau=
lt' f=C3=BCr\n"
 "weitere Informationen.\n"
-"(Der Modus 'simple' wurde in Git 1.7.11 eingef=C3=BChrt. Benutze den =
=C3=A4hnlichen "
-"Modus 'current' anstatt 'simple', falls Sie gelegentlich =C3=A4ltere =
Versionen "
-"von Git benutzen.)"
+"(Der Modus 'simple' wurde in Git 1.7.11 eingef=C3=BChrt. Benutzen Sie=
 den =C3=A4hnlichen\n"
+"Modus 'current' anstatt 'simple', falls Sie gelegentlich =C3=A4ltere =
Versionen von\n"
+"Git benutzen.)"
=20
 #: builtin/push.c:274
 msgid ""
@@ -8933,9 +8935,8 @@ msgid "git replace -d <object>..."
 msgstr "git replace -d <Objekt>..."
=20
 #: builtin/replace.c:19
-#, fuzzy
 msgid "git replace [--format=3D<format>] [-l [<pattern>]]"
-msgstr "git replace -l [<Muster>]"
+msgstr "git replace [--format=3D<Format>] [-l [<Muster>]]"
=20
 #: builtin/replace.c:174
 msgid "list replace refs"
@@ -8950,9 +8951,8 @@ msgid "replace the ref if it exists"
 msgstr "ersetzt die Referenz, wenn sie existiert"
=20
 #: builtin/replace.c:177
-#, fuzzy
 msgid "use this format"
-msgstr "verwendet kleinere Pakete"
+msgstr "benutzt das angegebene Format"
=20
 #: builtin/rerere.c:12
 msgid "git rerere [clear | forget path... | status | remaining | diff =
| gc]"
@@ -9101,7 +9101,7 @@ msgstr "stoppt das Parsen nach dem ersten Argumen=
t was keine Option ist"
=20
 #: builtin/rev-parse.c:369
 msgid "output in stuck long form"
-msgstr ""
+msgstr "Ausgabe in Langform mit Argumenten an den Optionen (getrennt d=
urch '=3D')"
=20
 #: builtin/rev-parse.c:486
 msgid ""
@@ -10241,9 +10241,9 @@ msgstr ""
 "<gueltigerbranch>'."
=20
 #: git-bisect.sh:140
-#, fuzzy
 msgid "won't bisect on cg-seek'ed tree"
-msgstr "bin=C3=A4re Suche auf gesuchtem Branch nicht m=C3=B6glich"
+msgstr ""
+"bin=C3=A4re Suche auf einem durch 'cg-seek' ge=C3=A4ndertem Verzeichn=
is nicht m=C3=B6glich"
=20
 #: git-bisect.sh:144
 msgid "Bad HEAD - strange symbolic ref"
--=20
1.8.5.3.493.gb139ac2
