From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] log: properly handle decorations with chained tags
Date: Thu, 19 Dec 2013 23:44:42 +0000
Message-ID: <20131219234442.GI259467@vauxhall.crustytoothpaste.net>
References: <20131217004044.GB259467@vauxhall.crustytoothpaste.net>
 <1387254501-319329-1-git-send-email-sandals@crustytoothpaste.net>
 <xmqq38lrknbd.fsf@gitster.dls.corp.google.com>
 <20131219031809.GG259467@vauxhall.crustytoothpaste.net>
 <xmqqfvpofzp5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NgG1H2o5aFKkgPy/"
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Kirill Likhodedov <kirill.likhodedov@jetbrains.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 20 00:44:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtnGu-0001yC-IV
	for gcvg-git-2@plane.gmane.org; Fri, 20 Dec 2013 00:44:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756461Ab3LSXot (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Dec 2013 18:44:49 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:34938 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755822Ab3LSXos (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Dec 2013 18:44:48 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:25f2:d8a1:a1:c2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id C7B332806B;
	Thu, 19 Dec 2013 23:44:45 +0000 (UTC)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Kirill Likhodedov <kirill.likhodedov@jetbrains.com>
Content-Disposition: inline
In-Reply-To: <xmqqfvpofzp5.fsf@gitster.dls.corp.google.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.11-1-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239557>


--NgG1H2o5aFKkgPy/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2013 at 10:44:22AM -0800, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> > Yeah, that's the clean fix I was looking for, but couldn't quite come up
> > with.  I'm going to re-roll with your fix instead of mine and my tests.
> > Any objections to adding your sign-off?
>=20
> I was actually planning to just squash 35a34ce281 as a fixup! to
> your 5e65a201 and call it a day.  I think your proposed log message
> in the latter clearly describes why the fix is correct.

Okay, sounds good.  Thanks.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--NgG1H2o5aFKkgPy/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCgAGBQJSs4TpAAoJEL9TXYEfUvaLB2sQAJyvcJr2Di+2w66MQDuRYJeE
IOerAJK/yfVI4/AESmaOym4HyO5i7udlFmr3hvSdNIqUSsc2MJF26A/Tk7PBJrlc
UzZPTI3jALpTqXXjG6aRRmtsSVorlOUCApR9yh/BvoWyva6+G0cH39p47W0nkVdv
nK6Ir/TSnmQbVsI4DhMkBAUq+VPjQvI3qiKHmtj6tTkMeAzk3CfbuVZbtT78vm15
Xs12DvlSr+eEpfVvmphG/XmMGSJsNHdKB80MxaEnhXzjoEK/mnqn1GxFe4YaXBuJ
gsALxaVjqag/jUJfMpVcKVnZsnZ4pvNXw+njv7+CoDpkqpDFrwtkN+IvRo80cLAD
O50BqwMPXOQmeJOItliVJ4nnE/PRGq8ZT1cEen3FxXZ14j9lPrSaFBPjixlhdvt/
eqSm1ySJfC/U3vYM4yf5Vmn6PkDyvLBftx8gyiypOKMQrQFw0/ei4BVg6V1sqHHe
jPJ7p5OH6sl3MzCkrPRrfcylrxhn3IfboRS8XJVe0LhIDeRghXJCDnULDvsYwUFc
ocH9euoultXJmO5Y3VAPjJ0r8h0xIJjDy4yB5T9g5nqzgaoFzPUcZEo/lHdEHNU2
ckLRzsLtkc+ABzDKzSZBGwQi6AaE69lfbVKypldyBXY6Sp+ooB8jlo8IPziadrWv
gph8cyn1uFS5XJdZfyOk
=Sn6U
-----END PGP SIGNATURE-----

--NgG1H2o5aFKkgPy/--
