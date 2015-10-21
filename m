From: =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
Subject: Re: [PATCH] fr.po: Fix "uptream" typo
Date: Wed, 21 Oct 2015 16:50:06 +0200
Message-ID: <2073861.1COpT0d3Y9@cayenne>
References: <1445433959-11240-1-git-send-email-thosch97@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Thomas Schneider <thosch97@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 21 16:50:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zouio-0004tm-9X
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 16:50:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753140AbbJUOu3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Oct 2015 10:50:29 -0400
Received: from smtpfb2-g21.free.fr ([212.27.42.10]:49943 "EHLO
	smtpfb2-g21.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905AbbJUOu3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Oct 2015 10:50:29 -0400
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id EFAC2D37E3C
	for <git@vger.kernel.org>; Wed, 21 Oct 2015 16:50:12 +0200 (CEST)
Received: from cayenne.localnet (unknown [IPv6:2a01:e35:2ef1:f910:86a6:c8ff:fe05:d3e0])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 4BE5A940031;
	Wed, 21 Oct 2015 16:50:07 +0200 (CEST)
User-Agent: KMail/4.14.10 (Linux/4.3.0-rc6jna; KDE/4.14.12; x86_64; ; )
In-Reply-To: <1445433959-11240-1-git-send-email-thosch97@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279984>

Le mercredi 21 octobre 2015, 15:25:59 Thomas Schneider a =E9crit :
> Signed-off-by: Thomas Schneider <thosch97@gmail.com>
> ---
>  po/fr.po | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/po/fr.po b/po/fr.po
> index 581167f..71c4b54 100644
> --- a/po/fr.po
> +++ b/po/fr.po
> @@ -8862,7 +8862,7 @@ msgstr ""
>  "Si vous souhaitez indiquer l'information de suivi distant pour cett=
e "
>  "branche, vous pouvez le faire avec :\n"
>  "\n"
> -"git branch --set-uptream-to=3D%s/<branche> %s\n"
> +"git branch --set-upstream-to=3D%s/<branche> %s\n"
>=20
>  #: builtin/pull.c:476
>  #, c-format

Thanks,

It will be included in the next l10n update.

Jean-No=EBl
