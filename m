From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH 1/1] l10n: de.po: =?utf-8?Q?use?=
 =?utf-8?B?ICJibGEg4oCmIg==?= instead of "bla..."
Date: Tue, 24 Mar 2015 18:10:44 +0100
Message-ID: <20150324171044.GA4414@ralf-ubuntu>
References: <1426942357-5618-1-git-send-email-phillip.szelat@gmail.com>
 <CAN0XMO+JLfzkYwP5rKkT6RyLJ-XuH1k=9vKmi1X0xb1SjTOdvg@mail.gmail.com>
 <551190F2.10808@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Phillip Sz <phillip.szelat@gmail.com>, git <git@vger.kernel.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Jan =?iso-8859-1?Q?Kr=FCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>,
	Matthias =?iso-8859-1?Q?R=FCster?= <matthias.ruester@gmail.com>,
	Magnus =?iso-8859-1?Q?G=F6rlitz?= 
	<magnus.goerlitz@googlemail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Mar 24 18:11:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaSLy-0008Aq-4n
	for gcvg-git-2@plane.gmane.org; Tue, 24 Mar 2015 18:10:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbbCXRKw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Mar 2015 13:10:52 -0400
Received: from mail-wg0-f43.google.com ([74.125.82.43]:33248 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752298AbbCXRKs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2015 13:10:48 -0400
Received: by wgbcc7 with SMTP id cc7so176278600wgb.0
        for <git@vger.kernel.org>; Tue, 24 Mar 2015 10:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=xbCVCD1C8VRqP4jF9MkFxTDvzpefry9mQh1BGoR5CDo=;
        b=juF+sPng/Xe5hfsWBtbKKAycCBbmxx6WT30rSyyl5BUsVo+2ZpeGUlAtx8fL3NDHUM
         1HldEP6mP/XN1Ej+Zs8qkrjM0FFOJE1pTTnuNcXPf4fThRKpZ4Jc4ewnAezPxgDAVuyb
         oiHZlEBQiAuNnHdt4DF4cR/QnOFzqyFs0CY2N+gvaytvvfeB3zWO7MIcHPLtwCOwOS7C
         mFM7y6qbv2+l9F4ngrjXVezzmgEOMsPMjSfyzNB2spmUOEn8JnfFs1lFp15JIx4Zz3YM
         nObqaBJYqNYIg6plxfDId6NkmG7FSjdylP2XtnFvPMW28Vjh2Rot4YL9fqpHrDtRYT8q
         0Q3Q==
X-Received: by 10.194.6.228 with SMTP id e4mr9581829wja.63.1427217046384;
        Tue, 24 Mar 2015 10:10:46 -0700 (PDT)
Received: from localhost (dslb-178-000-084-015.178.000.pools.vodafone-ip.de. [178.0.84.15])
        by mx.google.com with ESMTPSA id fm10sm407442wib.7.2015.03.24.10.10.45
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 24 Mar 2015 10:10:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <551190F2.10808@drmicha.warpmail.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266202>

Michael J Gruber <git@drmicha.warpmail.net> wrote:
> Ralf Thielow venit, vidit, dixit 21.03.2015 22:21:
> > Am 21. M=E4rz 2015 um 13:52 schrieb Phillip Sz <phillip.szelat@gmai=
l.com>:
> >>
> >> I think we should use it like this, as most open-source projects d=
o.
> >> Also we should use a space before the three dots as per http://www=
=2Eduden.de/sprachwissen/rechtschreibregeln/auslassungspunkte
> >>
> >=20
> > I don't think this rule of ellipsis applies here as the dots are me=
ant
> > to be a pattern to tell users that an argument can be passed multip=
le
> > times.
> >=20
>=20
> "..." is used in (at least) 2 cases:
>=20
> * ellipsis
> * continuation arguments
>=20
> The patch changes both, but the Duden rule applies to the first case
> only (and is different from "legacy rules", I think).
>=20
> Also, you might want to check the format of other commit messages and
> reword yours accordingly.
>=20

Let's apply this instead.

-- >8 --
=46rom: Phillip Sz <phillip.szelat@gmail.com>
Date: Sat, 21 Mar 2015 13:52:37 +0100
Subject: [PATCH] l10n: de.po: add space before ellipsis

Signed-off-by: Phillip Sz <phillip.szelat@gmail.com>
Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/po/de.po b/po/de.po
index 11fbd0f..9fa3f4c 100644
--- a/po/de.po
+++ b/po/de.po
@@ -616,7 +616,7 @@ msgstr ""
 #: help.c:373
 #, c-format
 msgid "in %0.1f seconds automatically..."
-msgstr "Automatische Ausf=FChrung in %0.1f Sekunden..."
+msgstr "Automatische Ausf=FChrung in %0.1f Sekunden ..."
=20
 #: help.c:380
 #, c-format
@@ -1271,12 +1271,12 @@ msgstr "Kann keine Commit-Beschreibung f=FCr %s=
 bekommen"
 #: sequencer.c:611
 #, c-format
 msgid "could not revert %s... %s"
-msgstr "Konnte \"revert\" nicht auf %s ausf=FChren... %s"
+msgstr "Konnte \"revert\" nicht auf %s ausf=FChren ... %s"
=20
 #: sequencer.c:612
 #, c-format
 msgid "could not apply %s... %s"
-msgstr "Konnte %s nicht anwenden... %s"
+msgstr "Konnte %s nicht anwenden ... %s"
=20
 #: sequencer.c:648
 msgid "empty commit set passed"
@@ -2436,7 +2436,7 @@ msgstr "%s: Patch konnte nicht angewendet werden"
 #: builtin/apply.c:3653
 #, c-format
 msgid "Checking patch %s..."
-msgstr "Pr=FCfe Patch %s..."
+msgstr "Pr=FCfe Patch %s ..."
=20
 #: builtin/apply.c:3746 builtin/checkout.c:231 builtin/reset.c:135
 #, c-format
@@ -4091,7 +4091,7 @@ msgstr "Konnte zu klonenden Remote-Branch %s nich=
t finden."
 #: builtin/clone.c:561
 #, c-format
 msgid "Checking connectivity... "
-msgstr "Pr=FCfe Konnektivit=E4t... "
+msgstr "Pr=FCfe Konnektivit=E4t ... "
=20
 #: builtin/clone.c:564
 msgid "remote did not send all necessary objects"
@@ -4165,12 +4165,12 @@ msgstr "Konnte Arbeitsverzeichnis '%s' nicht er=
stellen."
 #: builtin/clone.c:870
 #, c-format
 msgid "Cloning into bare repository '%s'...\n"
-msgstr "Klone in Bare-Repository '%s'...\n"
+msgstr "Klone in Bare-Repository '%s' ...\n"
=20
 #: builtin/clone.c:872
 #, c-format
 msgid "Cloning into '%s'...\n"
-msgstr "Klone nach '%s'...\n"
+msgstr "Klone nach '%s' ...\n"
=20
 #: builtin/clone.c:897
 msgid "--dissociate given, but there is no --reference"
@@ -4600,7 +4600,7 @@ msgstr ""
 #: builtin/commit.c:1199
 msgid "Clever... amending the last one with dirty index."
 msgstr ""
-"Klug... den letzten Commit mit einer ge=E4nderten Staging-Area nachbe=
ssern."
+"Klug ... den letzten Commit mit einer ge=E4nderten Staging-Area nachb=
essern."
=20
 #: builtin/commit.c:1201
 msgid "Explicit paths specified without -i or -o; assuming --only path=
s..."
@@ -7335,7 +7335,7 @@ msgstr "Aktualisiere %s..%s\n"
 #: builtin/merge.c:1388
 #, c-format
 msgid "Trying really trivial in-index merge...\n"
-msgstr "Probiere wirklich trivialen \"in-index\"-Merge...\n"
+msgstr "Probiere wirklich trivialen \"in-index\"-Merge ...\n"
=20
 #: builtin/merge.c:1395
 #, c-format
@@ -7349,12 +7349,12 @@ msgstr "Vorspulen nicht m=F6glich, breche ab."
 #: builtin/merge.c:1450 builtin/merge.c:1529
 #, c-format
 msgid "Rewinding the tree to pristine...\n"
-msgstr "R=FCcklauf des Verzeichnisses bis zum Ursprung...\n"
+msgstr "R=FCcklauf des Verzeichnisses bis zum Ursprung ...\n"
=20
 #: builtin/merge.c:1454
 #, c-format
 msgid "Trying merge strategy %s...\n"
-msgstr "Probiere Merge-Strategie %s...\n"
+msgstr "Probiere Merge-Strategie %s ...\n"
=20
 #: builtin/merge.c:1520
 #, c-format
@@ -7682,7 +7682,7 @@ msgstr "git notes copy [<Optionen>] <von-Objekt> =
<nach-Objekt>"
=20
 #: builtin/notes.c:51
 msgid "git notes copy --stdin [<from-object> <to-object>]..."
-msgstr "git notes copy --stdin [<von-Objekt> <nach-Objekt>]..."
+msgstr "git notes copy --stdin [<von-Objekt> <nach-Objekt>] ..."
=20
 #: builtin/notes.c:56
 msgid "git notes append [<options>] [<object>]"
@@ -8689,7 +8689,7 @@ msgstr "git remote prune [<Optionen>] <Name>"
=20
 #: builtin/remote.c:64
 msgid "git remote update [<options>] [<group> | <remote>]..."
-msgstr "git remote update [<Optionen>] [<Gruppe> | <externesRepository=
>]..."
+msgstr "git remote update [<Optionen>] [<Gruppe> | <externesRepository=
>] ..."
=20
 #: builtin/remote.c:88
 #, c-format
@@ -9865,7 +9865,7 @@ msgstr "fehlerhaftes Objekt bei '%s'"
 #: builtin/tag.c:301
 #, c-format
 msgid "tag name too long: %.*s..."
-msgstr "Tagname zu lang: %.*s..."
+msgstr "Tagname zu lang: %.*s ..."
=20
 #: builtin/tag.c:306
 #, c-format
@@ -10450,7 +10450,7 @@ msgstr ""
=20
 #: git-am.sh:166
 msgid "Falling back to patching base and 3-way merge..."
-msgstr "Falle zur=FCck zum Patchen der Basis und des 3-Wege-Merges..."
+msgstr "Falle zur=FCck zum Patchen der Basis und des 3-Wege-Merges ...=
"
=20
 #: git-am.sh:182
 msgid "Failed to merge in the changes."
@@ -10943,7 +10943,7 @@ msgstr "=C4nderungen von $mb zu $onto:"
 msgid "First, rewinding head to replay your work on top of it..."
 msgstr ""
 "Zun=E4chst wird der Branch zur=FCckgespult, um Ihre =C4nderungen\n"
-"darauf neu anzuwenden..."
+"darauf neu anzuwenden ..."
=20
 #: git-rebase.sh:620
 #, sh-format
--=20
2.3.3.434.g642b19b
