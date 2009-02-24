From: Penny Leach <penny@mjollnir.org>
Subject: Re: git-svn starting with an empty svn repository
Date: Tue, 24 Feb 2009 16:03:58 +0100
Message-ID: <20090224150358.GA18138@mjollnir.org>
References: <20090224134325.GA10719@mjollnir.org> <a2633edd0902240619v633eacq4ff7ffd20f66da04@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rwEMma7ioTxnRzrJ"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 24 16:05:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lbyr0-0008Rv-K9
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 16:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757953AbZBXPEL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 10:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753860AbZBXPEJ
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 10:04:09 -0500
Received: from mjollnir.org ([202.78.240.81]:36040 "EHLO mjollnir.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753528AbZBXPEI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 10:04:08 -0500
Received: from localhost (localhost [127.0.0.1])
	by mjollnir.org (Postfix) with ESMTP id 7A01F28A559
	for <git@vger.kernel.org>; Tue, 24 Feb 2009 16:03:30 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mjollnir.org
Received: from mjollnir.org ([127.0.0.1])
	by localhost (mjollnir.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AUPp+115XG9N for <git@vger.kernel.org>;
	Tue, 24 Feb 2009 16:03:29 +0100 (CET)
Received: from hermia.mjollnir.org (84-73-174-204.dclient.hispeed.ch [84.73.174.204])
	(Authenticated sender: penny)
	by mjollnir.org (Postfix) with ESMTP id CBC1928A557
	for <git@vger.kernel.org>; Tue, 24 Feb 2009 16:03:28 +0100 (CET)
Received: by hermia.mjollnir.org (Postfix, from userid 1000)
	id 3C6EC22104; Tue, 24 Feb 2009 16:03:58 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <a2633edd0902240619v633eacq4ff7ffd20f66da04@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111294>


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thanks for the reply!  I'm glad I'm not the only person crazy enough to
attempt this :)

On Tue, Feb 24, 2009 at 03:19:13PM +0100, Pascal Obry wrote:
> - I have created an empty repository using svnadmin
> - I have imported the svn trunk into Git
> - I'm cherry-picking any new commits from my cvs-imported branch
> (master) into the git-svn one (named svn-trunk)

Right - and you used this method to import the original history into the
svn-trunk branch, as well as any new patches? Or did you do a once off
import of the history using a different method?

Out of interest - how long is the history you're importing?  Mine is about
32,000 commits and it takes forever to import into SVN (only to get to a
broken point and have to start again...)


Penny

--=20
/* ---------------------------------------------------
Penny Leach | http://mjollnir.org | http://she.geek.nz
GPG: 8347 00FC B5BF 6CC0 0FC9 AB90 1875 120A A30E C22B
--------------------------------------------------- */

--rwEMma7ioTxnRzrJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmkDF4ACgkQGHUSCqMOwivHLgCdHs4c213hRMBcxo2nFNmhGdKs
Zi8AnRmFJ21dSMtntA07h6hTEByrITA+
=moye
-----END PGP SIGNATURE-----

--rwEMma7ioTxnRzrJ--
