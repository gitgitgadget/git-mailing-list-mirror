From: Charles McGarvey <chazmcgarvey@brokenzipper.com>
Subject: Re: [Administrivia] On ruby and contrib/
Date: Thu, 06 Jun 2013 14:41:26 -0600
Organization: Sevenology
Message-ID: <51B0F3F6.5040507@brokenzipper.com>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org> <7va9n52zjc.fsf@alter.siamese.dyndns.org> <CAMP44s012ccmaArrTbfy_xNrqbnOjVGTnY+po9cE8JGh_U72Gg@mail.gmail.com> <CANgJU+W1BLOB_TuMa_zRHtCW-8Ge8nu_kK=5qu2xDY=Km_kk4A@mail.gmail.com> <CAMP44s3zuDPTApPvnaC0bzqmAUkRRwePZDRL4syB=tM3d6eiBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2ITAALWNCIMTMVFLKCKDV"
Cc: demerphq <demerphq@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	=?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoQ==?= =?UTF-8?B?aSBOZ+G7jWM=?= 
	<pclouds@gmail.com>, Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 06 22:41:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ukh07-00074C-W8
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 22:41:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752906Ab3FFUlf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jun 2013 16:41:35 -0400
Received: from romulus.brokenzipper.com ([71.19.157.142]:65374 "EHLO
	romulus.brokenzipper.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989Ab3FFUle (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 16:41:34 -0400
Received: from vulcan.local (unknown [IPv6:2602:61:7edf:e300:0:ff:fe00:7701])
	by romulus.brokenzipper.com (Postfix) with ESMTP id F3D0852D66;
	Thu,  6 Jun 2013 14:41:28 -0600 (MDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=brokenzipper.com;
	s=romulus; t=1370551289;
	bh=SWR7Up2NMuk98osZ7l9LOcWKUVhfnI3d4MQJqMvBOmE=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=Luxl4+6Vg4qdoRLx7n5bjpZs3TnG7QQ4i6YrvNINBOwaoZ/w2iP/lhfxmjgxFY3XJ
	 tMwnJw8cKDEyG1euvW4L8L17Lxh9C57c8g4pG+iVA4hiQTLz9ZGZluEgQtxPyudsaT
	 irZPyIABMGUcojQprxJOcUmfYDDS7ebrb21rzZ6c=
Received: from [2602:61:7edf:e300:0:ff:fe00:7700]
	by vulcan.local with esmtpsa (TLS1.0:DHE_RSA_CAMELLIA_256_CBC_SHA1:256)
	(Exim 4.80)
	(envelope-from <chazmcgarvey@brokenzipper.com>)
	id 1Ukh0M-0005Xk-Va; Thu, 06 Jun 2013 14:41:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130523 Thunderbird/17.0.6
In-Reply-To: <CAMP44s3zuDPTApPvnaC0bzqmAUkRRwePZDRL4syB=tM3d6eiBA@mail.gmail.com>
X-Enigmail-Version: 1.6a1pre
OpenPGP: url=https://www.brokenzipper.com/chaz.asc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226556>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2ITAALWNCIMTMVFLKCKDV
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 06/06/2013 01:46 AM, Felipe Contreras wrote:
> On Thu, Jun 6, 2013 at 2:26 AM, demerphq <demerphq@gmail.com> wrote:
>>
>> Good thing you are being objective and leaving out the Python 3.0
>> mess, the long legacy of backwards compatibility in the Perl
>> community, the active community behind it, its extensive portability
>> support, and fail to mention the lack of an equivalent to CPAN. We
>> wouldn't want facts to get in the way of a personal bias would we?
>=20
> None of that has anything to do with Perl's popularity.
>=20
>> Just thought I'd push back on the FUD. People have been saying Perl is=

>> going away for decades...
>=20
> Perl has been going away for the last decade [1], and will continue to
> go away. Perl is going away, and that an undeniable fact, and if you
> are not interested in discussing on the basis of reality, I'm not
> interested in discussing with you.
>=20
> [1] http://www.tiobe.com/content/paperinfo/tpci/images/tpci_trends.png

The linchpin of your argument is that Perl is dying.  Let's assume that t=
he
TIOBE index is a reliable basis for making business decisions--it's not, =
but
let's pretend--the graph you linked to doesn't even seem to support your
conclusion (or am I missing something?).  It looks like Perl's popularity=
 has
pretty much been constant for at least two years.  It's apparently not
increasing in popularity, but this isn't an electrocardiogram (i.e.
flat-lining is not dead or even dying).  The same graph shows that Ruby's=

popularity also hasn't changed very much since 2007 after its initial sur=
ge.

Now, it's probably too off-topic to pick apart TIOBE's methodology here, =
but
suffice it to say that, like any trend indicator, it's only as useful as =
your
knowledge of its limitations, and this has been discussed enough elsewher=
e.

It's true that Perl isn't soon going to win any trendiness awards, but th=
e
same reasons that made Perl a good choice for git so many years ago are s=
till
there and then some.  You would probably also be surprised at the number =
of
new kids learning Perl.

I guess I just denied the "undeniable fact" that Perl is going away, so m=
aybe
I'm one of those with whom you do not want to discuss this, but, for my p=
art,
I am willing to consider other evidence for the claim.  As I pointed out,=
 the
evidence shown so far (one reference to the TIOBE index) isn't nearly eno=
ugh
to settle the matter.  I also apologize for dragging this out if this thr=
ead
is judged to not be worth a whole lot.

--=20
Charles McGarvey


------enig2ITAALWNCIMTMVFLKCKDV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlGw8/YACgkQNi05PrCndfsXugCcCyE/gDNKQeqKL44YVJpDhkqg
9toAnip76yzXWRsLCzVy5LYW1OLnL9KT
=8v4m
-----END PGP SIGNATURE-----

------enig2ITAALWNCIMTMVFLKCKDV--
