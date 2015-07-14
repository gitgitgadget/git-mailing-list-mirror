From: phillip <phillip.szelat@gmail.com>
Subject: Re: [PATCH] l10n: de.po: translate 9 new messages
Date: Tue, 14 Jul 2015 23:06:52 +0200
Message-ID: <48E68E08-9873-4F2F-B96F-F35465F4A33E@gmail.com>
References: <1436896778-8159-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	matthias.ruester@gmail.com, magnus.goerlitz@googlemail.com
To: Ralf Thielow <ralf.thielow@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 14 23:07:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZF7Pq-0000DT-IK
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jul 2015 23:07:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752989AbbGNVG6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Jul 2015 17:06:58 -0400
Received: from mail-wg0-f66.google.com ([74.125.82.66]:36140 "EHLO
	mail-wg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752683AbbGNVG6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2015 17:06:58 -0400
Received: by wgbbj7 with SMTP id bj7so1740791wgb.3
        for <git@vger.kernel.org>; Tue, 14 Jul 2015 14:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:content-type:subject:from:date:to:cc
         :message-id;
        bh=FE+EAFSPwDTxCMj8UlyAUNzYrB9YhZewvtO6zcE5DXc=;
        b=e/Q+2cXH0bBga1ZfXHx1itQwcKJ5OVcKuuyiJ92ObaD7sDZ3HM48VqGkBzAhB+yIs5
         dEikEphdsm8uJj8UAjiK/8syuzdEGj/H0OucWJVWpkDTjK/l5iomMPsyTBHJTEljjAHo
         G17nHMd2+saGzdMS+ZGVltd+S+VIZyRkTLmBg4bT5Yf553402kJQo029g7eoWtFxHTLF
         P6QoHHggP10GHDYlDe/D+6gNhtZYK46fqZexamEFFc5zjI/HWc8/88r2MRRfylft+iIw
         oyzwFNQEcHg0MvNquaTefXaxkWIxbBjc//bVL9Ep+NXd4gKQj1av7Px2gMWRgaDueDDk
         fWbg==
X-Received: by 10.180.78.136 with SMTP id b8mr8745553wix.89.1436908016978;
        Tue, 14 Jul 2015 14:06:56 -0700 (PDT)
Received: from android-b7bb6bce7d91de53.fritz.box (i59F45643.versanet.de. [89.244.86.67])
        by smtp.gmail.com with ESMTPSA id se11sm22939353wic.2.2015.07.14.14.06.55
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jul 2015 14:06:56 -0700 (PDT)
User-Agent: K-9 Mail for Android
In-Reply-To: <1436896778-8159-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273977>



Acked-by: Phillip Sz <phillip.szelat@gmail.com>

>Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
>---
> po/de.po | 28 ++++++++++------------------
> 1 file changed, 10 insertions(+), 18 deletions(-)
>
>diff --git a/po/de.po b/po/de.po
>index 64070cd..6ed3509 100644
>--- a/po/de.po
>+++ b/po/de.po
>@@ -10463,14 +10463,12 @@ msgid "print tag contents"
> msgstr "Tag-Inhalte ausgeben"
>=20
> #: builtin/worktree.c:11
>-#, fuzzy
> msgid "git worktree add [<options>] <path> <branch>"
>-msgstr "git remote add [<Optionen>] <Name> <URL>"
>+msgstr "git worktree add [<Optionen>] <Pfad> <Branch>"
>=20
> #: builtin/worktree.c:12
>-#, fuzzy
> msgid "git worktree prune [<options>]"
>-msgstr "git notes prune [<Optionen>]"
>+msgstr "git worktree prune [<Optionen>]"
>=20
> #: builtin/worktree.c:27
> #, c-format
>@@ -10513,9 +10511,8 @@ msgid "could not create directory of '%s'"
> msgstr "Konnte Verzeichnis '%s' nicht erstellen."
>=20
> #: builtin/worktree.c:241
>-#, fuzzy
> msgid "unable to resolve HEAD"
>-msgstr "kann HEAD nicht aufl=C3=B6sen"
>+msgstr "Konnte HEAD nicht aufl=C3=B6sen."
>=20
> #: builtin/worktree.c:249
> #, c-format
>@@ -10523,29 +10520,25 @@ msgid "Enter %s (identifier %s)"
> msgstr "Betrete %s (Identifikation %s)"
>=20
> #: builtin/worktree.c:281
>-#, fuzzy
>msgid "checkout <branch> even if already checked out in other worktree=
"
>-msgstr "Branches oder Pfade im Arbeitsverzeichnis auschecken"
>+msgstr "<Branch> auschecken, auch wenn dieser bereits in einem andere=
n
>"
>+"Arbeitsverzeichnis ausgecheckt ist"
>=20
> #: builtin/worktree.c:283
>-#, fuzzy
> msgid "create a new branch"
>-msgstr "das Reflog f=C3=BCr den neuen Branch erzeugen"
>+msgstr "neuen Branch erstellen"
>=20
> #: builtin/worktree.c:285
>-#, fuzzy
> msgid "create or reset a branch"
>-msgstr "Branches anzeigen, erstellen oder entfernen"
>+msgstr "Branch erstellen oder umsetzen"
>=20
> #: builtin/worktree.c:286
>-#, fuzzy
> msgid "detach HEAD at named commit"
>-msgstr "HEAD zu benanntem Commit setzen"
>+msgstr "HEAD bei benanntem Commit losl=C3=B6sen"
>=20
> #: builtin/worktree.c:292
>-#, fuzzy
> msgid "-b and -B are mutually exclusive"
>-msgstr "Die Optionen -n und -k schlie=C3=9Fen sich gegenseitig aus."
>+msgstr "-b und -B schlie=C3=9Fen sich gegenseitig aus"
>=20
> #: builtin/write-tree.c:13
> msgid "git write-tree [--missing-ok] [--prefix=3D<prefix>/]"
>@@ -10612,9 +10605,8 @@ msgid "List, create, or delete branches"
> msgstr "Branches anzeigen, erstellen oder entfernen"
>=20
> #: common-cmds.h:21
>-#, fuzzy
> msgid "Switch branches or restore working tree files"
>-msgstr "Branches oder Pfade im Arbeitsverzeichnis auschecken"
>+msgstr "Branches wechseln oder Dateien im Arbeitsverzeichnis
>wiederherstellen"
>=20
> #: common-cmds.h:22
> msgid "Clone a repository into a new directory"
