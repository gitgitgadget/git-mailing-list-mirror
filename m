From: Phillip Sz <phillip.szelat@gmail.com>
Subject: Re: [PATCH] l10n: de.po: translate 65 new messages
Date: Sun, 5 Jul 2015 15:21:47 +0200
Message-ID: <55992F6B.7040000@gmail.com>
References: <1435938622-6199-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="VJJBXw7FOX5q61p83oBpFiHw4CVQWweJP"
Cc: tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	matthias.ruester@gmail.com, magnus.goerlitz@googlemail.com
To: Ralf Thielow <ralf.thielow@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 05 15:22:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZBjrw-0001ki-Mv
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jul 2015 15:22:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842AbbGENV7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jul 2015 09:21:59 -0400
Received: from mail-wg0-f48.google.com ([74.125.82.48]:33987 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789AbbGENV5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jul 2015 09:21:57 -0400
Received: by wgqq4 with SMTP id q4so120001620wgq.1
        for <git@vger.kernel.org>; Sun, 05 Jul 2015 06:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:subject:to:references:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-type;
        bh=hPS7dKPrTmCubzIvM3r8Lq8uwvYe1Lr2g3ks9mxpBbU=;
        b=Np+KkdQhjci0GpC5uN4Za15noMN1hgmKPiUbObAdDV6xUlJ/MwmFzhIWRxayulrpWQ
         AvzdfIqUXyvP5KV3W43egbOwOn10QZuLETN2ENahSvDDBUjSO3U6hlcqsG9fam81RB1K
         tDAQhB0/hOM1z6IGkSNRrVkrXbwMYreKlpF9kvobYn12IuO4+e3yoaGX/DAjEX/4TZRG
         BwT9f5e10ZhAAAC1+MM/q9TrOIiDp+UW/Xhvd+A+ySpoGhyfnNxxd6GHcASIfyIl5Osz
         BjQOAL8s5DMVZDKI2p3nfTy13BmwjktdopbanmdmDBMz2Gala8Zvi7co+f9B+aRcyHP6
         xR3w==
X-Received: by 10.195.11.3 with SMTP id ee3mr87039373wjd.89.1436102516569;
        Sun, 05 Jul 2015 06:21:56 -0700 (PDT)
Received: from [192.168.178.21] (i59F45F4E.versanet.de. [89.244.95.78])
        by mx.google.com with ESMTPSA id lq9sm14037106wjb.35.2015.07.05.06.21.53
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Jul 2015 06:21:54 -0700 (PDT)
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.0.1
In-Reply-To: <1435938622-6199-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273364>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VJJBXw7FOX5q61p83oBpFiHw4CVQWweJP
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

>  #: dir.c:1945
>  msgid "Untracked cache is disabled on this system."
> -msgstr ""
> +msgstr "Cache f=C3=BCr unversionierten Dateien ist auf diesem System d=
eaktiviert."

I think it should be "Cache f=C3=BCr unversionierte Dateien ist auf diese=
m
System deaktiviert."

>  #: help.c:214
>  msgid "git commands available from elsewhere on your $PATH"
>  msgstr "Vorhandene Git-Kommandos irgendwo in Ihrem $PATH"
> =20

What do you think about "Git-Kommandos sind anderwo verf=C3=BCgbar in Ihr=
em
$PATH"?

>  #: remote.c:2124
>  #, c-format
>  msgid "Your branch is based on '%s', but the upstream is gone.\n"
>  msgstr "Ihr Branch basiert auf '%s', aber Upstream-Branch wurde entfer=
nt.\n"
>=20

Maybe "Ihr Branch basiert auf '%s', aber der Upstream-Branch wurde
entfernt.\n" ? I think we should use a full sentence, because it has a
dot at the end.

Phillip


--VJJBXw7FOX5q61p83oBpFiHw4CVQWweJP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVmS9rAAoJEJIt6Cqh4sVSj/kIAIAd4vvo8z6ipf1gk8Gt4QgA
sJ1zyLf5BmuVzfSPGaaCD1JjYwxX7SU9NXTw8uGF8FYG1aEqEvmXlPmKNogsbTv8
0RMHqPo4qBNIkW6IxaaI6TqXl0uZanLcPnuINT+ouD6gPwSJfolh1eJrQDAieoL4
y8lipPLlalwFqDPoMEStNYgnPPJYGYIGBWf+1u32MFb7ecaVCNmlr/a60buDaubQ
JnQvOpnLGBvymkPwOLhxgPSVp5qMa7kL3/xRRbMx39SC2APwrkjHmiE3a/A7IJFy
rlQbAv11W9zvHLKldrSYBBJQTb2kCgVsoITshlVRBvN73wIJq912gXZopNmB4Fc=
=DUjx
-----END PGP SIGNATURE-----

--VJJBXw7FOX5q61p83oBpFiHw4CVQWweJP--
