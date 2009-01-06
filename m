From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: how to track the history of a line in a file
Date: Tue, 6 Jan 2009 17:08:14 +0100
Message-ID: <20090106160814.GI21154@genesis.frugalware.org>
References: <alpine.DEB.1.10.0901021405460.21567@asgard.lang.hm> <87d4f01lmt.fsf@gollum.intra.norang.ca>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8JMtXNYTIIy8Rvxv"
Cc: david@lang.hm, git@vger.kernel.org
To: Bernt Hansen <bernt@norang.ca>
X-From: git-owner@vger.kernel.org Tue Jan 06 17:09:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKEUy-0008E9-Sk
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 17:09:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbZAFQIV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 11:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750928AbZAFQIV
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 11:08:21 -0500
Received: from virgo.iok.hu ([212.40.97.103]:60978 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750906AbZAFQIU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 11:08:20 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 421F8580AC;
	Tue,  6 Jan 2009 17:08:20 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 979C14465E;
	Tue,  6 Jan 2009 17:08:14 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 32B6811B8630; Tue,  6 Jan 2009 17:08:14 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <87d4f01lmt.fsf@gollum.intra.norang.ca>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104696>


--8JMtXNYTIIy8Rvxv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 06, 2009 at 10:48:10AM -0500, Bernt Hansen <bernt@norang.ca> wr=
ote:
> Save the following script in ~/bin/git-rblame.sh, make it executable,
> and then create a global git alias for it as follows:
>=20
> $ git config --global alias.rblame '!~/bin/git-rblame.sh $*'

Given that you have ~/bin in PATH, just name the script ~/bin/git-rblame
and you won't even have to define an alias on each machine. ;-)

--8JMtXNYTIIy8Rvxv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkljge4ACgkQe81tAgORUJYTbACfXj3fW2xUEDKI18CGJxBUGrdB
Cb4An17f32FydNBPGH3XQCMFl5R71xY1
=bTaX
-----END PGP SIGNATURE-----

--8JMtXNYTIIy8Rvxv--
