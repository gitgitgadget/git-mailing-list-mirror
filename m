From: Max Horn <max@quendi.de>
Subject: Re: [PATCH v5 00/10] transport-helper: updates
Date: Thu, 31 Oct 2013 19:41:15 +0100
Message-ID: <B997286F-D346-464D-9710-BA80BC17A570@quendi.de>
References: <1383212197-14259-1-git-send-email-felipe.contreras@gmail.com> <1383212197-14259-2-git-send-email-felipe.contreras@gmail.com> <BBA75EFD-E68A-4E7F-A886-8878650D58A8@quendi.de> <xmqq4n7x8g6e.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: multipart/signed; boundary="Apple-Mail=_5B6ED8BD-A6CF-4A16-9343-F2C028F5593E"; protocol="application/pgp-signature"; micalg=pgp-sha256
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 31 19:41:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbxBS-00013H-6G
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 19:41:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755341Ab3JaSl0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 14:41:26 -0400
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:59916 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753621Ab3JaSlZ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Oct 2013 14:41:25 -0400
Received: from fb07-alg-gast1.math.uni-giessen.de ([134.176.24.161]); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1VbxBK-0008ML-0q; Thu, 31 Oct 2013 19:41:22 +0100
In-Reply-To: <xmqq4n7x8g6e.fsf@gitster.dls.corp.google.com>
X-Mailer: Apple Mail (2.1510)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1383244885;d8ad6ae9;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237152>


--Apple-Mail=_5B6ED8BD-A6CF-4A16-9343-F2C028F5593E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


On 31.10.2013, at 19:10, Junio C Hamano <gitster@pobox.com> wrote:

> Max Horn <max@quendi.de> writes:
>=20
>> On 31.10.2013, at 10:36, Felipe Contreras =
<felipe.contreras@gmail.com>
>> wrote:
>>=20
>>> Hi,
>>>=20
>>> Here are the patches that allow transport helpers to be completely
>> transparent;
>>> renaming branches, deleting them, custom refspecs, --force,
>> --dry-run,
>>> reporting forced update, everything works.
>>=20
>> I looked through this patch series in detail, and it looks fine to
>> me. Indeed, it fixes several nuisances when using remote-helpers, and
>> as such would be a definite win.
>=20
> Nice.
>=20
>> In other words: Would be really nice to see these applied!
>=20
> The series is sitting on the 'pu' branch, and I think there were
> some "fixup" suggestions during the review, so it may need to be
> rerolled before advancing to 'next'.

You are of course right. Next time I comment, I'll make sure to check =
whether previous review suggestions have been picked up.


--Apple-Mail=_5B6ED8BD-A6CF-4A16-9343-F2C028F5593E
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iF4EAREIAAYFAlJypFEACgkQIpJVslrhe1kM5wEAoravM9rKpGgyrbg3OkmHw79N
yiBiOiS6UEFpDOfsbt8A/1YaoME1cdtULL2gPAtDtvi8KdF4qiVPT9LMgWZI7tzz
=P1UQ
-----END PGP SIGNATURE-----

--Apple-Mail=_5B6ED8BD-A6CF-4A16-9343-F2C028F5593E--
