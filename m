From: Max Horn <max@quendi.de>
Subject: Re: [PATCH v5 09/10] fast-export: add support to delete refs
Date: Thu, 31 Oct 2013 23:38:03 +0100
Message-ID: <DB0125AA-9F4D-497A-B0F6-9933231BCEA6@quendi.de>
References: <1383212197-14259-1-git-send-email-felipe.contreras@gmail.com> <1383212197-14259-8-git-send-email-felipe.contreras@gmail.com> <6F276334-DFDB-40B8-8B24-38FFB6DBED9B@quendi.de> <CAMP44s3vxfN5Wc+S+VjimisUgZGQMzR7Z2YkO8J4UEk7+cPy_Q@mail.gmail.com> <78D9AAB6-09EC-4E81-A7BE-D36B9A9869D1@quendi.de> <CAMP44s2n-dDEcY8Ds+0z0sys1q_Y60s7KOCs5VvO0tAWG3iLpQ@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: multipart/signed; boundary="Apple-Mail=_9DF8DD23-66A7-4F55-ACFE-677863335DD2"; protocol="application/pgp-signature"; micalg=pgp-sha256
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 31 23:38:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vc0si-0007kt-UJ
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 23:38:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752282Ab3JaWiM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 18:38:12 -0400
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:34594 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751766Ab3JaWiL (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Oct 2013 18:38:11 -0400
Received: from ip-178-202-253-6.unitymediagroup.de ([178.202.253.6] helo=zanovar.fritz.box); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1Vc0sQ-0000TY-Pd; Thu, 31 Oct 2013 23:38:06 +0100
In-Reply-To: <CAMP44s2n-dDEcY8Ds+0z0sys1q_Y60s7KOCs5VvO0tAWG3iLpQ@mail.gmail.com>
X-Mailer: Apple Mail (2.1510)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1383259091;fa5eff6d;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237189>


--Apple-Mail=_9DF8DD23-66A7-4F55-ACFE-677863335DD2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


On 31.10.2013, at 20:53, Felipe Contreras <felipe.contreras@gmail.com> =
wrote:

> On Thu, Oct 31, 2013 at 1:47 PM, Max Horn <max@quendi.de> wrote:
>>=20
>> On 31.10.2013, at 20:41, Felipe Contreras =
<felipe.contreras@gmail.com> wrote:
>>=20
>>> On Thu, Oct 31, 2013 at 1:29 PM, Max Horn <max@quendi.de> wrote:
[...]
>>>=20
>>> That's what the previous patch does.
>>=20
>> Right *facepalm*.
>>=20
>> But then this should be documented in git-fast-import.txt, shouldn't =
it?
>=20
> It is... in the previous patch.

Indeed, there it is. So that answer to my initial question is: Yes, I am =
being dense :-).

So, I am (still) happy with the patch series :-)


--Apple-Mail=_9DF8DD23-66A7-4F55-ACFE-677863335DD2
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iF4EAREIAAYFAlJy284ACgkQIpJVslrhe1kwVQD/dvRbhR9C8/WZ/CWpvqbAPpe3
pUG5cS7dfxIjOIw4OUgA/i3U4C9J69qcQc9Ari1Ao3nXeDqZxdF1d4fXzvuO6rXR
=OqiQ
-----END PGP SIGNATURE-----

--Apple-Mail=_9DF8DD23-66A7-4F55-ACFE-677863335DD2--
