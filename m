From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH] l10n: de.po: change Email to E-Mail
Date: Sun, 21 Sep 2014 09:45:15 +0200
Message-ID: <CAN0XMOLP+rYJs88h=csdPrD1F+EHaOE-u=byj6vF6Ey0xoK+2g@mail.gmail.com>
References: <1411228313-1941-1-git-send-email-phillip.szelat@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Phillip Sz <phillip.szelat@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 21 09:45:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XVbps-0000Cs-RA
	for gcvg-git-2@plane.gmane.org; Sun, 21 Sep 2014 09:45:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751895AbaIUHpS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 21 Sep 2014 03:45:18 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:41847 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751792AbaIUHpR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Sep 2014 03:45:17 -0400
Received: by mail-wi0-f169.google.com with SMTP id fb4so1349858wid.0
        for <git@vger.kernel.org>; Sun, 21 Sep 2014 00:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=xsvECkojGAXzBnsyLLg6NnyZdL3ff/Xk5R+UfP2+SLY=;
        b=nz86wGfAomqWyK7UO+S5Bp7HSufbrM9F4DrNLNbXrh9xKZeBY+/vzkESz26IhbsVBC
         faM/cPVq9muECYgvzO7YOjiizZ+pAw83/fwVQ2d0behJ9Hr2vi2oFfEYLebjj/MXz084
         kFeVwkj7VX9LQB0na6bVf6n3hMWXNIe7ZN+xbMx5o0TaQn962SsU61t33w0AIsYjCjWX
         n16fRZFynUc0ugbdZLP8+yTm1dw4hnVWA07rQ167d3OiwVB516VpN0cVejAFjUKXmfi2
         aj2KF9HozkoBTjohVpHJYVG/JJRArtMZZ3A7V7PyctWBPKQhwa3cy1BLmWo1u4ZccS30
         Ofgg==
X-Received: by 10.194.84.42 with SMTP id v10mr12538448wjy.63.1411285515933;
 Sun, 21 Sep 2014 00:45:15 -0700 (PDT)
Received: by 10.194.173.167 with HTTP; Sun, 21 Sep 2014 00:45:15 -0700 (PDT)
In-Reply-To: <1411228313-1941-1-git-send-email-phillip.szelat@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257342>

2014-09-20 17:51 GMT+02:00 Phillip Sz <phillip.szelat@gmail.com>:
> Changes all Email to E-Mail, as this is the correct form in german.
>

Thanks!

> Phillip
>
> Signed-off-by: Phillip Sz <phillip.szelat@gmail.com>
> ---
>  po/de.po | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/po/de.po b/po/de.po
> index e5d2b25..c6aa69f 100644
> --- a/po/de.po
> +++ b/po/de.po
> @@ -2691,7 +2691,7 @@ msgstr "Unterdr=C3=BCckt den Namen des Autors u=
nd den Zeitstempel (Standard: aus)"
>
>  #: builtin/blame.c:2514
>  msgid "Show author email instead of name (Default: off)"
> -msgstr "Zeigt anstatt des Namens die Email-Adresse des Autors (Stand=
ard: aus)"
> +msgstr "Zeigt anstatt des Namens die E-Mail-Adresse des Autors (Stan=
dard: aus)"
>
>  #: builtin/blame.c:2515
>  msgid "Ignore whitespace differences"
> @@ -6535,7 +6535,7 @@ msgstr "zeigt Patchformat anstatt des Standards=
 (Patch + Zusammenfassung)"
>
>  #: builtin/log.c:1217
>  msgid "Messaging"
> -msgstr "Email-Einstellungen"
> +msgstr "E-Mail-Einstellungen"
>
>  #: builtin/log.c:1218
>  msgid "header"
> @@ -6543,11 +6543,11 @@ msgstr "Header"
>
>  #: builtin/log.c:1219
>  msgid "add email header"
> -msgstr "f=C3=BCgt Email-Header hinzu"
> +msgstr "f=C3=BCgt E-Mail-Header hinzu"
>
>  #: builtin/log.c:1220 builtin/log.c:1222
>  msgid "email"
> -msgstr "Email"
> +msgstr "E-Mail"
>
>  #: builtin/log.c:1220
>  msgid "add To: header"
> @@ -6573,7 +6573,7 @@ msgstr "message-id"
>
>  #: builtin/log.c:1228
>  msgid "make first mail a reply to <message-id>"
> -msgstr "macht aus erster Email eine Antwort zu <message-id>"
> +msgstr "macht aus erster E-Mail eine Antwort zu <message-id>"
>
>  #: builtin/log.c:1229 builtin/log.c:1232
>  msgid "boundary"
> @@ -9431,7 +9431,7 @@ msgstr "Unterdr=C3=BCckt Commit-Beschreibungen,=
 liefert nur Anzahl der Commits"
>
>  #: builtin/shortlog.c:234
>  msgid "Show the email address of each author"
> -msgstr "Zeigt die Email-Adresse von jedem Autor"
> +msgstr "Zeigt die E-Mail-Adresse von jedem Autor"
>
>  #: builtin/shortlog.c:235
>  msgid "w[,i1[,i2]]"
> @@ -10284,7 +10284,7 @@ msgstr ""
>
>  #: git-am.sh:732
>  msgid "Patch does not have a valid e-mail address."
> -msgstr "Patch enth=C3=A4lt keine g=C3=BCltige Email-Adresse."
> +msgstr "Patch enth=C3=A4lt keine g=C3=BCltige E-Mail-Adresse."
>
>  #: git-am.sh:779
>  msgid "cannot be interactive without stdin connected to a terminal."
> --
> 2.1.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
