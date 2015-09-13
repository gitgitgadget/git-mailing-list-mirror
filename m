From: Phillip Sz <phillip.szelat@gmail.com>
Subject: Re: [PATCH] l10n: de.po: translate 123 new messages
Date: Sun, 13 Sep 2015 20:35:34 +0200
Message-ID: <55F5C1F6.8000808@gmail.com>
References: <1441985744-882-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="HfAtuXaeuRFuNL7FoUGmHf9oTBSwIN4Sg"
Cc: tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	matthias.ruester@gmail.com, magnus.goerlitz@googlemail.com
To: Ralf Thielow <ralf.thielow@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 13 20:35:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbC7y-00051W-9H
	for gcvg-git-2@plane.gmane.org; Sun, 13 Sep 2015 20:35:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753985AbbIMSfp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2015 14:35:45 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:33885 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753550AbbIMSfo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2015 14:35:44 -0400
Received: by wicfx3 with SMTP id fx3so115076279wic.1
        for <git@vger.kernel.org>; Sun, 13 Sep 2015 11:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type;
        bh=iHnjtQqqw1u/ehL+vRMTEucCpoyTzvoHE0GpGgK+jIA=;
        b=C4EA8SDzpVzgN23AfoiQIcXgQaMC+bFtvqEds9tM+aHD3zfVJLlcJ3djPhDI7CfjlC
         4PzfIwrpyPvom4C2EIE+lY9TiloMoDL9hdfkb8xjEgSgwedK0LZVq//xVPOvs0tO/NDw
         xW7uwIOHSIrj4F68mhcTKwYM/PqQCjq0CxImSNKovYE1m+6Q4Mo5lEVTWN5Et4s4rE8C
         y4abdcz8La1lholfaYOpux1XF7gwY69Tl0mwmngqa1SEQHejJACJCoUiQSoNfBujORbu
         pqJulsRK82HBIO3JpN6Hu6SYd71fisTsHv5sURDlBDHziOMm3kFneRP/8leUxDJQmyUB
         mLPA==
X-Received: by 10.180.91.6 with SMTP id ca6mr17761408wib.47.1442169343354;
        Sun, 13 Sep 2015 11:35:43 -0700 (PDT)
Received: from [192.168.178.84] (i59F45008.versanet.de. [89.244.80.8])
        by smtp.googlemail.com with ESMTPSA id xw2sm11470233wjc.12.2015.09.13.11.35.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 13 Sep 2015 11:35:42 -0700 (PDT)
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
In-Reply-To: <1441985744-882-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277790>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HfAtuXaeuRFuNL7FoUGmHf9oTBSwIN4Sg
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

Just some comments:

>  #: advice.c:103
> -#, fuzzy
>  msgid "Please, commit your changes before you can merge."
> -msgstr "Bitte gebe die Versionsbeschreibung f=C3=BCr deine =C3=84nderu=
ngen ein."
> +msgstr "Bitte committen Sie Ihre =C3=84nderungen, bevor Sie \"merge\" =
ausf=C3=BChren."

I think this translation slightly changes the content, have you done
this intentionally?

What about "Bitte committen Sie Ihre =C3=84nderungen, bevor Sie den Merge=

ausf=C3=BChren."?

>  #: wt-status.c:1105
> -#, fuzzy
>  msgid "No commands done."
> -msgstr "Keine Commits geparst."
> +msgstr "Keine Kommandos ausgef=C3=BChrt."
>=20

Are you sure about this? "done" could also mean something like "erledigt"=
=2E

>  #: builtin/am.c:923
> -#, fuzzy
>  msgid "invalid timezone offset"
> -msgstr "Ung=C3=BCltige Option: %s"
> +msgstr "Ung=C3=BCltiger Offset in Zeitzone"
> =20

"Ung=C3=BCltiger Offset in der Zeitzone" reads better.

>  #: common-cmds.h:18
> -#, fuzzy
>  msgid "Use binary search to find the commit that introduced a bug"
> -msgstr ""
> -"=C3=BCber eine Bin=C3=A4rsuche die =C3=84nderungen finden, die einen =
Fehler verursacht haben"
> +msgstr "Bin=C3=A4rsuche verwenden, um den Commit finden, der einen Feh=
ler "
> +"verursacht hat"
>=20

"Bin=C3=A4rsuche verwenden, um den Commit zu finden, der einen Fehler
verursacht hat"

The rest is fine. Thanks.

Phillip


--HfAtuXaeuRFuNL7FoUGmHf9oTBSwIN4Sg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV9cH9AAoJEJIt6Cqh4sVSd2sH/jg9EReBxQXIukMYxyoDOP6o
TRbIpiSUy7ZkHIFHCV7zujgjNiTU7326YcxPyoH1NmCKjvE4EQenLzPHD1jh6vLE
XPWqrkc+uKm9qihLrPC1dEWIgzsnmbOzkjXLHqSlxjix6jELBVhRkmlhtuJ3+y3C
SBZqjCgjnH4PDv+DrIudPJHynKC8IIsxOZoOaQ8QyOfW8iok+qsWL63jG7YnzU6n
UvCtullhtvoP1TZwyLnGcDRUZnK604HGo90RKve4YpcwedBS1zxBK3ctjMjpH44f
64JP3OMexJ1FWvkUUgjnMKPBKU4l3zj+tZQA01wFkbfop5GARu2Y6i1No0NXLuc=
=0XFd
-----END PGP SIGNATURE-----

--HfAtuXaeuRFuNL7FoUGmHf9oTBSwIN4Sg--
