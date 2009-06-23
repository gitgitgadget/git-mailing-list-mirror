From: Sascha Silbe <sascha-ml-devel-vcs-git@silbe.org>
Subject: crash proof / recovery from power loss
Date: Tue, 23 Jun 2009 23:05:56 +0200
Message-ID: <20090623210556.GB31015@twin.sascha.silbe.org>
Reply-To: Sascha Silbe <sascha-ml-reply-to-2009-2@silbe.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 23 23:12:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJDIO-00074Y-0M
	for gcvg-git-2@gmane.org; Tue, 23 Jun 2009 23:12:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755566AbZFWVMi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2009 17:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754986AbZFWVMh
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jun 2009 17:12:37 -0400
Received: from setoy.chost.de ([217.160.209.225]:48129 "EHLO smtp.chost.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754613AbZFWVMh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2009 17:12:37 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Jun 2009 17:12:36 EDT
Received: (qmail 4702 invoked by uid 5015); 23 Jun 2009 21:08:49 -0000
Received: (nullmailer pid 32602 invoked by uid 8193);
	Tue, 23 Jun 2009 21:05:56 -0000
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122110>


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!


I'm going to use git as a back end for the Sugar data store / Journal.=20
[1]
One thing I'm worried about is how it's going to behave if a crash (e.g.=20
power loss - no corruption) occurs.
What can happen in such a case? Is it always recoverable and if so, how?


[1] http://wiki.sugarlabs.org/go/Version_support_for_datastore

CU Sascha

--=20
http://sascha.silbe.org/
http://www.infra-silbe.de/
--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQEcBAEBAgAGBQJKQUOvAAoJELpz82VMF3Da+9sH/0MgbhbeqN9oJKIftBlXCN8K
bsqIbv3qZiMbCkMdOnT+Odca0fRLqR0tjkANeuPVIGUQR0uPV3451ss3uPU2k/Il
mbyvkuDYPa9mFE0eAkfodattvtiXhXx9WWedmtTnhKc8w4LKfPdIQfhowAwTXn+U
IWq13r8tkJ6b7LfnUe/Jup9fOHM7euUIxwNqRQ1Ufmw7Gf2Q+51O5m5b8MAnsN5v
BfXL8t36a3ktQMhc0bxSS1l9fBxblOr2VgGcDYpq3B1cGoENGyQbS56Tf8pxLfDh
7BC9M/4yasKLf8ArVKHgxIukP9fXHPxb8b4o6eISODb7+BzO/gEPgSNRifzSDTk=
=T1+k
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
