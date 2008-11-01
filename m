From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: Git remote status
Date: Sat, 1 Nov 2008 21:11:24 +0100
Message-ID: <20081101201124.GX24201@genesis.frugalware.org>
References: <490CB390.9000206@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NqXz6hVRMdSFrLFa"
Cc: git@vger.kernel.org
To: Gonsolo <gonsolo@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 01 21:12:47 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwMps-0001qu-Tr
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 21:12:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752404AbYKAUL1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 16:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752397AbYKAUL1
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 16:11:27 -0400
Received: from virgo.iok.hu ([193.202.89.103]:49647 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752221AbYKAUL0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 16:11:26 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id D22F9580A4;
	Sat,  1 Nov 2008 21:11:24 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id B38A04465E;
	Sat,  1 Nov 2008 21:11:24 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 90B54119019E; Sat,  1 Nov 2008 21:11:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <490CB390.9000206@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99769>


--NqXz6hVRMdSFrLFa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 01, 2008 at 08:52:48PM +0100, Gonsolo <gonsolo@gmail.com> wrote:
> Is there a "git remote status" or git-status switch to get the same=20
> information without switching branches?

Just 'git checkout' should print the info for the current branch.

--NqXz6hVRMdSFrLFa
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkMt+wACgkQe81tAgORUJaCpwCglgey9BcIilMlGxZN3b/dptwf
+ZUAoKp2lXsuZ1yFDILk9uwoq4bSIFja
=VVRc
-----END PGP SIGNATURE-----

--NqXz6hVRMdSFrLFa--
