From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCH] .mailmap: Combine more (email, name) to individual persons
Date: Mon, 15 Jul 2013 09:06:59 +0200
Message-ID: <51E39F93.4070700@googlemail.com>
References: <1373796899-23378-1-git-send-email-stefanbeller@googlemail.com> <1373796899-23378-2-git-send-email-stefanbeller@googlemail.com> <20130715061045.GE2962@elie.Belkin>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA21D919ECCE88BE76291E577"
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 15 09:06:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uycs6-0001fq-65
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 09:06:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754119Ab3GOHGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 03:06:51 -0400
Received: from mail-wg0-f54.google.com ([74.125.82.54]:58753 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753Ab3GOHGv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 03:06:51 -0400
Received: by mail-wg0-f54.google.com with SMTP id n11so9778348wgh.33
        for <git@vger.kernel.org>; Mon, 15 Jul 2013 00:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type;
        bh=6uYzmvaPtmqdskpiDm5MCn0JdNbERP4OgV4P3S1TDMA=;
        b=SDumf3FMNIGUTXHLmbctYWRjPYZgf+hO0l/O8N4X/mQ3XvamSm/ar0ZrylirK4Rj9T
         Odq0g1Br+xLkI6Fn0vRMhZHO2aj3urZe/tb3yyL1VK2oJ6AsDvb5IF2zRh0DhFi0G+ds
         Rm5WFs2M5Rj8bvxvl2gf/auQCa3XvSsuJbfXIjCELpUbbl0kCIH5VVNt5cQWyVMy1z3i
         g6fUR++Rkb0u+woiVfB93elmZeqjF0RmjgAjYzxjfkBQyVTnxcTT69Izqu5AZDqqK5Qd
         fSZUPDtCrueeas+28Jqx+0wsoU1+lDR0q2LGoSrCvcmaNbQAcWHFycYSO+cCP/oMwmxI
         DsOw==
X-Received: by 10.180.39.136 with SMTP id p8mr7939257wik.11.1373872008773;
        Mon, 15 Jul 2013 00:06:48 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id d8sm18782852wiz.0.2013.07.15.00.06.46
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 15 Jul 2013 00:06:47 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130623 Thunderbird/17.0.7
In-Reply-To: <20130715061045.GE2962@elie.Belkin>
X-Enigmail-Version: 1.4.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230436>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA21D919ECCE88BE76291E577
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07/15/2013 08:10 AM, Jonathan Nieder wrote:
> Stefan Beller wrote:
>=20
>> Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
>=20
> Markup and methodology look correct.
>=20
> Fwiw,
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>=20
> Is this meant to be squashed with 94b410bb (.mailmap: Map email
> addresses to names, 2013-07-12)?
>=20
> Ciao,
> Jonathan
>=20

As you like, either squash it, or just commit on top of it.
It's the very same kind of changes, so a squash might be better.

Thanks,
Stefan


--------------enigA21D919ECCE88BE76291E577
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJR45+TAAoJEJQCPTzLflhqmR0P/jKV4hbXzAZ3pVJqHi4odceh
KF9wrNfrOwg9pe8Ah6mbGXChb5u+t6RULVQvrTOGYdqH2/D8iHMIB0qxqWkMujg/
8AfqOfVPpJ2LPB3O3PF1r/x6HJJsdhaVzU5mzM9SpsKo4+CUI1v62JA9LUdlC4P6
7d3sNgjmKvKq8Oc97MGbgSRyo+vXmCPbXF2JJS1AgqQJ+fPUsOqDEQGvgfN2rIz3
7EieYD47MqKonkVpAgnFa6OrPfF2SGUTWJ6SBqnJIOuYeMxuZ1jiSrfclqBXrG+x
bulmRH6eKXisYpFCSL6AeC5KQ00sjfPsETdY4OcES7om/bv18dNtPsc/JZ4LqlwY
vP1FuSUPhJ75GTOriCoL0C7LoX88308xzawyrMep5nSjAwCGuM9eupsvCs1rFArS
9PnX6Uk+dRoVfvw0TXWZ8mtxGrVTLFemCIbnC88o/cP3lWTNhnzTwZRoXgblCBpx
rDh3MQ4k+ZFZL17Q6Vw1mI2Viu7jXLvdYiCuIgls52TsaG2llcOt5LrjQ42gDoL5
Em7FozXaR1FvQUCtXzrAsQN8240+goZCP0YZ/+1qifManV+pSMA84JkEEeG4KsPU
Z5frnNrnwgbH/AL2wgu7BzUvjwFXmGsANASeNAFEZcsVbbnv8MuILPlPownb8zsV
ZcaLPYPyNN/Em0MD6wp6
=lCtL
-----END PGP SIGNATURE-----

--------------enigA21D919ECCE88BE76291E577--
