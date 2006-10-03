From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH] gitweb: start to generate PATH_INFO URLs
Date: Tue, 3 Oct 2006 19:12:29 +0200
Message-ID: <20061003171229.GN2871@admingilde.org>
References: <20060929221641.GC2871@admingilde.org> <eftk98$2ii$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/0U0QBNx7JIUZLHm"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 03 19:12:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUnoo-0005Gw-67
	for gcvg-git@gmane.org; Tue, 03 Oct 2006 19:12:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030337AbWJCRMb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Oct 2006 13:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030338AbWJCRMb
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Oct 2006 13:12:31 -0400
Received: from agent.admingilde.org ([213.95.21.5]:6596 "EHLO
	mail.admingilde.org") by vger.kernel.org with ESMTP
	id S1030337AbWJCRMa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Oct 2006 13:12:30 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1GUnoj-0003Cr-Ih; Tue, 03 Oct 2006 19:12:29 +0200
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <eftk98$2ii$2@sea.gmane.org>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28279>


--/0U0QBNx7JIUZLHm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Tue, Oct 03, 2006 at 02:16:05PM +0200, Jakub Narebski wrote:
> Martin Waitz wrote:
> > Instead of providing the project as a ?p=3D parameter it is simply appe=
nded
> > to the base URI.
>=20
> I have just modified href() to be able to use it for actions which don't
> need the ?p=3D parameter... and you didn't take into consideration the ca=
se
> when $params{'project'} is set, but undefined.

is this handled correctly in the second patch which got committed to
next?

--=20
Martin Waitz

--/0U0QBNx7JIUZLHm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFIpn9j/Eaxd/oD7IRAvqPAJ0Y+jQj5+J5c6TsNI5EMMqv+ZaBAQCeKMRs
BqowEGy+ueiK6khGahF+GjQ=
=uHH9
-----END PGP SIGNATURE-----

--/0U0QBNx7JIUZLHm--
