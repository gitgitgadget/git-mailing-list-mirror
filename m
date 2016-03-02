From: =?UTF-8?Q?Matthias_R=c3=bcster?= <matthias.ruester@gmail.com>
Subject: Re: [PATCH v2] l10n: de.po: add space to abbreviation "z. B."
Date: Wed, 2 Mar 2016 18:59:04 +0100
Message-ID: <56D729E8.5070506@gmail.com>
References: <1456939802-6171-1-git-send-email-ralf.thielow@gmail.com>
 <1456940928-8233-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	phillip.szelat@gmail.com, magnus.goerlitz@googlemail.com
To: Ralf Thielow <ralf.thielow@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 02 19:59:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abBzO-0002at-7W
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 19:59:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756195AbcCBS7J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Mar 2016 13:59:09 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33949 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756089AbcCBS7I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2016 13:59:08 -0500
Received: by mail-wm0-f65.google.com with SMTP id p65so282946wmp.1
        for <git@vger.kernel.org>; Wed, 02 Mar 2016 10:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=iQqdt6EznMk0cW2AGAU3qui/obhNeJVH8K+GBwJynkA=;
        b=IJLG7ZFSLU3Ph4MdgT5IuKkzNxoFWJBRx+X4n3YM5ZeAcxoQfAbvwIoqhxGH8gkQSM
         xadM863PlUva30iIMFg83H2QklOgEGz7aK2gHBeuOgGoQUvZMsQikWuiXqny1ibNWZro
         xdko6hG9T/GGK5AXhfgqbbS2B8nXi7byFrKt1VId4JAmIVILOz1gQ/WzHwRQx1GyMMmw
         rz56KTQIWbb2CqZuI7eUiPqWVEFLbpnddaLcwPQbYVaaINpUbyXR1i115ZoZ6leduBYK
         u+LiI/TOq+i78yZk1fmNReoVtRG7rka9dQqaIojYgBbctY7Hb7/PLUIBhAARbvKljrAr
         EKRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=iQqdt6EznMk0cW2AGAU3qui/obhNeJVH8K+GBwJynkA=;
        b=fwpEJ40bgXxBXSSl4YmcS4W+/UrRwIW596Xf1WN3Yib1Ika6dCk0GJTH1fvtb6GIBq
         I+yhCYYjFAFhgMmm5UGO2vpYTYWNCLTQ1CPIiPm/xkWEA7oFwfNel2VNNKWBIZDtzHeG
         SUkOFEIngZgCVM1kA39uGBm6uNxfwoKJ2MxKkCqfTkACXQl9+RWpZMkjtsIGAzX9kZkw
         dtvqGpkmdupTs7M4Jw+FXWHN+1bpc0Ch9DFQJN74b+S11QrSEpiY5S+PH2URiV08Sc8w
         aMmjJs+DApLZyIv+m1GJj8nM3DrJqVg6jXhnF8471XaovF9NJKTZI0mUkb21BnaMBUuP
         HoTA==
X-Gm-Message-State: AD7BkJLxAelbSjoXUs1Ji9Z5vc0qYAV/gtxDe5/gMvbc6THXjcpIAlvxOrC7FYI8PZSeGA==
X-Received: by 10.28.135.4 with SMTP id j4mr1561229wmd.80.1456945146696;
        Wed, 02 Mar 2016 10:59:06 -0800 (PST)
Received: from ?IPv6:2a02:8108:2bbf:ecb0:5511:d304:47a3:98b3? ([2a02:8108:2bbf:ecb0:5511:d304:47a3:98b3])
        by smtp.googlemail.com with ESMTPSA id bg1sm37201051wjc.27.2016.03.02.10.59.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 Mar 2016 10:59:05 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <1456940928-8233-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288144>

In my opinion I would like to see "z.B." in a monospaced environment
rather than "z. B.".
The correct way of separating those two is to use a thin space, which i=
s
not possible in ASCII.

Look here for further information:
https://de.wikipedia.org/wiki/Schmales_Leerzeichen

Kind regards,
Matthias


Am 02.03.2016 um 18:48 schrieb Ralf Thielow:
> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---
>  po/de.po | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/po/de.po b/po/de.po
> index a6b7bf3..9344a53 100644
> --- a/po/de.po
> +++ b/po/de.po
> @@ -9145,7 +9145,7 @@ msgid ""
>  msgstr ""
>  "Aktualisierungen wurden zur=C3=BCckgewiesen, weil die Spitze Ihres =
aktuellen\n"
>  "Branches hinter seinem externen Gegenst=C3=BCck zur=C3=BCckgefallen=
 ist. F=C3=BChren Sie\n"
> -"die externen =C3=84nderungen zusammen (z.B. 'git pull ...') bevor S=
ie \"push\"\n"
> +"die externen =C3=84nderungen zusammen (z. B. 'git pull ...') bevor =
Sie \"push\"\n"
>  "erneut ausf=C3=BChren.\n"
>  "Siehe auch die Sektion 'Note about fast-forwards' in 'git push --he=
lp'\n"
>  "f=C3=BCr weitere Details."
> @@ -9160,7 +9160,7 @@ msgstr ""
>  "Aktualisierungen wurden zur=C3=BCckgewiesen, weil die Spitze eines =
versendeten\n"
>  "Branches hinter seinem externen Gegenst=C3=BCck zur=C3=BCckgefallen=
 ist. Checken Sie\n"
>  "diesen Branch aus und f=C3=BChren Sie die externen =C3=84nderungen =
zusammen\n"
> -"(z.B. 'git pull ...') bevor Sie erneut \"push\" ausf=C3=BChren.\n"
> +"(z. B. 'git pull ...') bevor Sie erneut \"push\" ausf=C3=BChren.\n"
>  "Siehe auch die Sektion 'Note about fast-forwards' in 'git push --he=
lp'\n"
>  "f=C3=BCr weitere Details."
> =20
> @@ -9177,7 +9177,7 @@ msgstr ""
>  "die lokal nicht vorhanden sind. Das wird =C3=BCblicherweise durch e=
inen \"push\" "
>  "von\n"
>  "Commits auf dieselbe Referenz von einem anderen Repository aus veru=
rsacht.\n"
> -"Vielleicht m=C3=BCssen Sie die externen =C3=84nderungen zusammenzuf=
=C3=BChren (z.B. 'git "
> +"Vielleicht m=C3=BCssen Sie die externen =C3=84nderungen zusammenf=C3=
=BChren (z. B. 'git "
>  "pull ...')\n"
>  "bevor Sie erneut \"push\" ausf=C3=BChren.\n"
>  "Siehe auch die Sektion 'Note about fast-forwards' in 'git push --he=
lp'\n"
>=20
