From: phillip <phillip.szelat@gmail.com>
Subject: Re: [PATCH] l10n: de.po: improve some translations
Date: Fri, 30 Oct 2015 23:39:17 -0700
Message-ID: <1C830873-5140-43D3-87CC-6636BB5F3F76@gmail.com>
References: <1446153562-12133-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	matthias.ruester@gmail.com, magnus.goerlitz@googlemail.com
To: Ralf Thielow <ralf.thielow@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 31 07:39:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsPpP-00081K-CO
	for gcvg-git-2@plane.gmane.org; Sat, 31 Oct 2015 07:39:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbbJaGjU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Oct 2015 02:39:20 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35259 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373AbbJaGjT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Oct 2015 02:39:19 -0400
Received: by pasz6 with SMTP id z6so94358481pas.2
        for <git@vger.kernel.org>; Fri, 30 Oct 2015 23:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:content-type:subject:from:date:to:cc
         :message-id;
        bh=SBxWa8ILzxI48y6+UUF51QZDCZEPxuG4uOegENum3ik=;
        b=iVX/TrOiTAJsvAdPxeeRv7jBOQLs+C5bHOKoKxIbamhdtEibih3PKZiGgE3KHCe7M4
         rKxkXTNn1dWnKa+URPL4APl71dIpg6YHAgjp3lGoEFei8Ufo8uFJoUOs8WsBZAKfcKGA
         gC59OAoe/TyXEJIvg0w8UzEnfjEm1vd9Dmd+v5tsV5Dzce5gWFbH4qVmsE2T0AdJTb4d
         mnXR6fe7MVpYBvCXx4n7WPrTwM4anS4r4fLHXc3fh4d98xmTdlYjQ8dmolJBWbI3iutX
         Nt1w9si+eg1DJBF7kpY+VxKE+XVTgLhKcIlqtmDiY/bqEqkSoyTlQUsLulkpMnPwSsm2
         y+UQ==
X-Received: by 10.66.251.72 with SMTP id zi8mr13651160pac.67.1446273558891;
        Fri, 30 Oct 2015 23:39:18 -0700 (PDT)
Received: from [172.20.2.103] (50-203-149-6-static.hfc.comcastbusiness.net. [50.203.149.6])
        by smtp.gmail.com with ESMTPSA id xz5sm11820634pbb.12.2015.10.30.23.39.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 30 Oct 2015 23:39:17 -0700 (PDT)
User-Agent: K-9 Mail for Android
In-Reply-To: <1446153562-12133-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280567>

Hi,=20

all good.

Acked-by: Phillip Sz <phillip.szelat@gmail.com>

>Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
>---
> po/de.po | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/po/de.po b/po/de.po
>index c682aaf..be30642 100644
>--- a/po/de.po
>+++ b/po/de.po
>@@ -592,7 +592,7 @@ msgstr "Fehler beim Schreiben der Signatur nach
>'%s': %s"
> #: grep.c:1718
> #, c-format
> msgid "'%s': unable to read %s"
>-msgstr "'%s': konnte nicht lesen %s"
>+msgstr "'%s': konnte %s nicht lesen"
>=20
> #: grep.c:1735
> #, c-format
>@@ -11749,7 +11749,7 @@ msgstr "unbekannte Option: $opt"
>=20
> #: git-stash.sh:397
> msgid "No stash found."
>-msgstr "Kein \"stash\" gefunden."
>+msgstr "Kein Stash-Eintrag gefunden."
>=20
> #: git-stash.sh:404
> #, sh-format
>@@ -11773,7 +11773,7 @@ msgstr "'$args' ist keine \"stash\"-Referenz"
>=20
> #: git-stash.sh:457
> msgid "unable to refresh index"
>-msgstr "unf=C3=A4hig den Index zu aktualisieren"
>+msgstr "Konnte den Index nicht aktualisieren."
>=20
> #: git-stash.sh:461
> msgid "Cannot apply a stash in the middle of a merge"
