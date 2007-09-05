From: Johan Herland <johan@herland.net>
Subject: Re: People unaware of the importance of "git gc"?
Date: Wed, 5 Sep 2007 10:41:57 +0200
Message-ID: <200709051042.04345.johan@herland.net>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org> <200709051013.39910.johan@herland.net> <vpqtzq91p5z.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1633438.A8FMzmKyzX";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Sep 05 10:42:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISqTQ-0003jF-7I
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 10:42:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755865AbXIEImv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 04:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755872AbXIEImv
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 04:42:51 -0400
Received: from sam.opera.com ([213.236.208.81]:35078 "EHLO sam.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753618AbXIEImu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 04:42:50 -0400
Received: from pc085.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	by sam.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id l858g4Jc008808
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 5 Sep 2007 08:42:09 GMT
User-Agent: KMail/1.9.7
In-Reply-To: <vpqtzq91p5z.fsf@bauges.imag.fr>
X-Virus-Scanned: ClamAV 0.91.1/4159/Wed Sep  5 06:09:35 2007 on sam.opera.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57688>

--nextPart1633438.A8FMzmKyzX
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 05 September 2007, Matthieu Moy wrote:
> Johan Herland <johan@herland.net> writes:
>=20
> > When git-fetch and git-commit has done its job and is about to exit, it=
 checks=20
> > the number of loose object, and if too high tells the user something=20
> > like "There are too many loose objects in the repo, do you want me to r=
epack?=20
> > (y/N)". If the user answers "n" or simply <Enter>,
>=20
> I don't like commands to be interactive if they don't _need_ to be so.
> It kills scripting, it makes it hard for a front-end (git gui or so)
> to use the command, ...

Ok, so add an option or config variable to turn on/off this behaviour.

=2E..Johan

=2D-=20
Johan Herland, <johan@herland.net>
www.herland.net

--nextPart1633438.A8FMzmKyzX
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7-ecc0.1.6 (GNU/Linux)

iD8DBQBG3mvWBHj4kl4fT1wRAsEuAJ98NDxY0CL98l8QCj5n70q46d63WQCfWKq8
l/lvkhVhDMPCmreZ0JU8O2U=
=VfRG
-----END PGP SIGNATURE-----

--nextPart1633438.A8FMzmKyzX--
