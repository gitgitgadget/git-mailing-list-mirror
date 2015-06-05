From: Phillip Sz <phillip.szelat@gmail.com>
Subject: Re: [PATCH] l10n: de.po: fix translation of "head nodes"
Date: Fri, 05 Jun 2015 21:17:47 +0200
Message-ID: <5571F5DB.30905@gmail.com>
References: <1433526300-10936-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="gP2Uqf0KvoKx8AcTofjFHdotK3kA4AvO3"
Cc: git@drmicha.warpmail.net, tr@thomasrast.ch, jk@jk.gs,
	stimming@tuhh.de, matthias.ruester@gmail.com,
	magnus.goerlitz@googlemail.com
To: Ralf Thielow <ralf.thielow@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 05 21:18:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0x81-0003d4-8k
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 21:18:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752614AbbFETSA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 15:18:00 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:38688 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752387AbbFETR7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2015 15:17:59 -0400
Received: by wibdq8 with SMTP id dq8so28539054wib.1
        for <git@vger.kernel.org>; Fri, 05 Jun 2015 12:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type;
        bh=U58naOZkMlo+4/qsAb5GepXgpkfYRRYZ7hVsa3LoiNY=;
        b=QE2f4WJZXFSPs35RmI2KbN6CJ5BjDSZUmo+L5WZ2348/G3RLJ6Zz0jEywQpBNW/22t
         TZ7zC4/yluNqQZ8HKkg03O0s330yGS2em5gU8cdcnzClNuKe9Lv6MKw1oNYKVBEYD9R4
         twUlt9hpudxnpB4b9bJlo+moPnxWsuoFYkBPt3HzNJB7/gNiMEnDMpkH8A6tBnxQhb3n
         EWJ1Ac7UctPW8absKMeTzT4qHJlrLakCMMj36naiH2gY5iQbdN873mCrFYWquGrmcstQ
         34QSTLf+y0Z0DYlbBILqO3zTdgNRY9jyFsKttqjxU6GW/nlDOZSofd7MIawMJ3vVGxnq
         PO5g==
X-Received: by 10.180.90.202 with SMTP id by10mr20535746wib.62.1433531878186;
        Fri, 05 Jun 2015 12:17:58 -0700 (PDT)
Received: from [192.168.178.21] (i59F45004.versanet.de. [89.244.80.4])
        by mx.google.com with ESMTPSA id gs7sm4726479wib.10.2015.06.05.12.17.54
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jun 2015 12:17:56 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <1433526300-10936-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270873>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gP2Uqf0KvoKx8AcTofjFHdotK3kA4AvO3
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Acked-by: Phillip Sz <phillip.szelat@gmail.com>

> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---
>  po/de.po | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/po/de.po b/po/de.po
> index 7d603c2..945bd13 100644
> --- a/po/de.po
> +++ b/po/de.po
> @@ -5679,11 +5679,11 @@ msgstr "Hauptwurzeln melden"
> =20
>  #: builtin/fsck.c:613
>  msgid "make index objects head nodes"
> -msgstr "Objekte in der Staging-Area pr=C3=BCfen"
> +msgstr "Index-Objekte in Erreichbarkeitspr=C3=BCfung einbeziehen"
> =20
>  #: builtin/fsck.c:614
>  msgid "make reflogs head nodes (default)"
> -msgstr "die Reflogs pr=C3=BCfen (Standard)"
> +msgstr "Reflogs in Erreichbarkeitspr=C3=BCfung einbeziehen (Standard)"=

> =20
>  #: builtin/fsck.c:615
>  msgid "also consider packs and alternate objects"
>=20



--gP2Uqf0KvoKx8AcTofjFHdotK3kA4AvO3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVcfXbAAoJEJIt6Cqh4sVSvUEIAKBepv6S654oXfQdDjgu95BM
yHMGo4X1U9Q+vVaaqyBE5BXB+vzxvZ8bmPzfcp2Law/noSge0ZMABvZAq1jNEoyk
4Qa5SrS1Usra8ak0pCTUXPGmkVJHwjtmHtYdzdNn6quLv2QI2XJJRh1ybDBuz8pV
ecZ7muYn1wR4B//TerXUrHsfc10ok08tsl07O8yiaMHUQlThTxzWtBsKuCDEbAhy
+b7VTn8rtp/NPUQxLO7+3qQwAmMZiDeHd8s0hg0xQMarvwNVnOzk+55VFTJ1cbQS
VFnhRkQyddbRjam29frnMBxFqfb/yytz7j/C7SBW35e1eAPmAOXfN42d40qdBY0=
=2B4C
-----END PGP SIGNATURE-----

--gP2Uqf0KvoKx8AcTofjFHdotK3kA4AvO3--
