From: Max Horn <max@quendi.de>
Subject: Re: [PATCH v3] remote-hg: do not fail on invalid bookmarks
Date: Fri, 21 Mar 2014 22:44:11 +0100
Message-ID: <10F8010F-96E2-45E0-B6D4-C3709AED3C28@quendi.de>
References: <A4F451CA-D1DE-43A9-A4DA-23594C08C4DD@quendi.de> <532CA557.20007@web.de>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: multipart/signed; boundary="Apple-Mail=_727C07CB-A033-4B0F-8BE4-3F3531827168"; protocol="application/pgp-signature"; micalg=pgp-sha256
Cc: git@vger.kernel.org, Antoine Pelisse <apelisse@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: =?iso-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Mar 21 22:44:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WR7Eo-0002SH-4o
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 22:44:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752399AbaCUVoV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 17:44:21 -0400
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:47412 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752428AbaCUVoR (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Mar 2014 17:44:17 -0400
Received: from ip-178-202-253-62.unitymediagroup.de ([178.202.253.62] helo=zanovar.fritz.box); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1WR7Ec-00078u-DX; Fri, 21 Mar 2014 22:44:14 +0100
In-Reply-To: <532CA557.20007@web.de>
X-Mailer: Apple Mail (2.1510)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1395438257;2be8b58b;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244755>


--Apple-Mail=_727C07CB-A033-4B0F-8BE4-3F3531827168
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=iso-8859-1

Hi Torsten,

On 21.03.2014, at 21:47, Torsten B=F6gershausen <tboegi@web.de> wrote:

> On 2014-03-21 12.36, Max Horn wrote:
> All tests passed :-),

Excellent.

> thanks from my side.
> comments inline, some are debatable

Thanks for having a close look and for the constructive feedback!
Unfortunately, I won't have time to look into this for the next 7 days
or so. I wouldn't mind if the patch gets queued with the changes you
suggest; but of course that might be a tad too much to ask for, so I'll
also be happy to do a "proper" re-roll, but then it has to wait a bit.

Cheers,
Max


--Apple-Mail=_727C07CB-A033-4B0F-8BE4-3F3531827168
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iF4EAREIAAYFAlMssq8ACgkQIpJVslrhe1niygD/TRNgAY70zbK4nhn8Aa6BbUsJ
j6WjaqYR3OMeolZ97iwA/j2qPPwE1c/x3XAkOv4QK5Tg2rVP6SY9+2nkRRSgLq5a
=jQem
-----END PGP SIGNATURE-----

--Apple-Mail=_727C07CB-A033-4B0F-8BE4-3F3531827168--
