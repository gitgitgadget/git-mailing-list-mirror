From: Phillip Sz <phillip.szelat@gmail.com>
Subject: Re: [PATCH] l10n: de.po: translate 2 messages
Date: Wed, 16 Sep 2015 20:19:57 +0200
Message-ID: <55F9B2CD.8040500@gmail.com>
References: <1442424817-10972-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="I5KPGgqlbJ559v5a3fkmvJTK0SC9AI0fN"
Cc: tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	matthias.ruester@gmail.com, magnus.goerlitz@googlemail.com
To: Ralf Thielow <ralf.thielow@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 16 20:20:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcHJZ-00025Q-NG
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 20:20:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754003AbbIPSUM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 14:20:12 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:33170 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753512AbbIPSUJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 14:20:09 -0400
Received: by wiclk2 with SMTP id lk2so85483440wic.0
        for <git@vger.kernel.org>; Wed, 16 Sep 2015 11:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type;
        bh=0J3Az/HA6J6ieGZAJWJC1Qm6Opx5t9kDz8fVhC6MI+M=;
        b=K/EEdbnp/Qnz+zaA4kMa5GG70qFus8btbhWYTpsc/QQ1i73jFWukv9dTTsRnxnSLMC
         jZoG9ohwXSFsscF9enAXhALBGMe2ZdxxaetVZzTsGPiQJuhG1cooRbKEENMFNloKvNz4
         3MHnc2ZByeoVCnYo8PUnGkRXVlBYa9c+aYZskp07q12RVzH+crAsb4IogItmiv1zdhLO
         RsbX+cGImUh0axy5rZTMa4AC4Mgd/9MCNVw/db/bhAGGxN2a11a3O8iiqMGLNYO5klXM
         mN9oFltGCaANKuXzs5h6C+XEi638IujTdTN/VHGBifM6/enGV1Fawi3lEIvl9xfa0Cpy
         YcZw==
X-Received: by 10.194.221.4 with SMTP id qa4mr25213093wjc.145.1442427608174;
        Wed, 16 Sep 2015 11:20:08 -0700 (PDT)
Received: from [192.168.178.84] (i59F45C99.versanet.de. [89.244.92.153])
        by smtp.googlemail.com with ESMTPSA id t7sm5787353wib.1.2015.09.16.11.20.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 Sep 2015 11:20:07 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
In-Reply-To: <1442424817-10972-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278043>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--I5KPGgqlbJ559v5a3fkmvJTK0SC9AI0fN
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

Acked-by: Phillip Sz <phillip.szelat@gmail.com>

> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---
>  po/de.po | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/po/de.po b/po/de.po
> index e5b523d..c9b4d16 100644
> --- a/po/de.po
> +++ b/po/de.po
> @@ -10530,9 +10530,8 @@ msgstr ""
>  "hash[=3D<n>]] [--abbrev[=3D<n>]] [--tags] [--heads] [--] [<Muster>...=
] "
> =20
>  #: builtin/show-ref.c:11
> -#, fuzzy
>  msgid "git show-ref --exclude-existing[=3D<pattern>] < <ref-list>"
> -msgstr "git show-ref --exclude-existing[=3DMuster] < ref-list"
> +msgstr "git show-ref --exclude-existing[=3D<Muster>] < <Referenzliste>=
"
> =20
>  #: builtin/show-ref.c:170
>  msgid "only show tags (can be combined with heads)"
> @@ -10761,9 +10760,8 @@ msgid "replace the tag if exists"
>  msgstr "das Tag ersetzen, wenn es existiert"
> =20
>  #: builtin/tag.c:609 builtin/update-ref.c:368
> -#, fuzzy
>  msgid "create a reflog"
> -msgstr "create_reflog"
> +msgstr "Reflog erstellen"
> =20
>  #: builtin/tag.c:611
>  msgid "Tag listing options"
>=20



--I5KPGgqlbJ559v5a3fkmvJTK0SC9AI0fN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV+bLWAAoJEJIt6Cqh4sVStDYH/0DQb/m24eEPkYBiHTFEzf0b
nl6SCjqlEIlNKfUi7w8jbPXyT/VwvkBfC8thlzoV/XyDKACeWdzVOZDx5RrVlKLh
kGXSBy9B3ITZlJgAqDSHtDSYMFUJgQJYhQDnm1L5Py1kgqH8GnOM9LDSpyEukzoE
sgIBlPVmPSQrieEGgZ4uw7TVZhZu/dYjBR41bdEWHsUFgEGwXwi8+7rKmNBUT2HR
dG8k57W2Aaw5OEZ0FDmOS7qHWmNsGmm81ThlvufEp+nBJGfhjUO08Hg0Uk3I/MNM
cf2iH+55g7VTy9E2oXQIVf8fIHvvL2OZvgrDu3XeZjguJet6E3ckHbtTLzvcdk4=
=DCSq
-----END PGP SIGNATURE-----

--I5KPGgqlbJ559v5a3fkmvJTK0SC9AI0fN--
