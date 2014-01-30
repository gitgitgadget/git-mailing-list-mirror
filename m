From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Re* [RFC PATCH 2/1] Make request-pull able to take a refspec of
 form local:remote
Date: Thu, 30 Jan 2014 00:16:30 +0000
Message-ID: <20140130001630.GD91854@vauxhall.crustytoothpaste.net>
References: <alpine.LFD.2.11.1401221535140.18207@i7.linux-foundation.org>
 <xmqqlhy6trfp.fsf@gitster.dls.corp.google.com>
 <CA+55aFyGaaMOL5pBhZ1BHMr07oDi2MuS-fPu4nnxhjoy+F0AQw@mail.gmail.com>
 <xmqqsises3u0.fsf@gitster.dls.corp.google.com>
 <CA+55aFyN7WWAF6pGfP+0j29nf6ETao0J5sUu+5UDaXUYC9_Geg@mail.gmail.com>
 <xmqqvbx9qgo7.fsf@gitster.dls.corp.google.com>
 <xmqqfvo6icqf.fsf_-_@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oj4kGyHlBMXGt3Le"
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Tejun Heo <tj@kernel.org>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 30 01:16:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8fJB-0000VJ-FF
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jan 2014 01:16:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752553AbaA3AQh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jan 2014 19:16:37 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:51468 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750879AbaA3AQg (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jan 2014 19:16:36 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:f5a9:eaf8:ef0c:ad71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 4329328071;
	Thu, 30 Jan 2014 00:16:34 +0000 (UTC)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Tejun Heo <tj@kernel.org>, Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
Content-Disposition: inline
In-Reply-To: <xmqqfvo6icqf.fsf_-_@gitster.dls.corp.google.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.12-1-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241234>


--oj4kGyHlBMXGt3Le
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2014 at 03:34:32PM -0800, Junio C Hamano wrote:
> The previous two steps were meant to stop promoting the explicit
> refname the user gave to the command to a different ref that points
> at it.  Most notably, we no longer substitute a branch name the user
> used with a name of the tqag that points at the commit at the tip of

s/tqag/tag/


--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--oj4kGyHlBMXGt3Le
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJS6ZneAAoJEL9TXYEfUvaLd7QQAKGff/+K3OzhfPW//s5wExVh
ezFtW4jNNalTMcYR305ztbnC6pt8pdAQcrWEzPPbSpQq74tY0d2onw4M/e6Pi4l+
EjG8+zz3HHQVtYutVs8fwZPdLY3NjqJSRdG1pxipQKBK9SmI3kSpboQ65e6dua1S
gO3Kq8UoNe2fMWqwrj4YY2lF+zpTmGfIdNzrgOeZXVtfBHV5Yg0mHzg+jO/ai9D8
2oH3sLs78cTh4SeMsPN7ZUD96MAzqam38pING+fFhRA9xrAW8FiwF+OuO0/FgqD/
If9mbycRPoIz2WrMPlinQwNZye8s9HOQWne6aISy3Sf/0s8fOc/Xzfo3vxQFAAkL
z18pMRd9m1UfJpegWHdk2rhDbqH8pEVRjSe3+x5Un+YvfS1L3Vk+Ect5/5He4cP1
XFzQ4nokhOiFHp1avb41TXtCPRdVWGyN74XmDRzo9wX7kjoatAUKV4h00OD/LfT3
bdNoEPdQzBugW1FyICe2pOrZEXHyDVGO6u3yfrjL8KAnjRMT9v/glX2Cynk2hgh0
LU9ddh29Q6/AKauGcFKQbhGCQWyrJ86xaTRXgMnbuAY0SYltRGpscWW2V7lSlnRQ
TLm6m9XAKpRoOuwZjGM/2TJQ9Bt8Fi04wK2cCR9sFAr7SLE3ceDPPlYmQsloA6o7
WpIC86MQm+6ZsRfB6QuC
=sShd
-----END PGP SIGNATURE-----

--oj4kGyHlBMXGt3Le--
