From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: git-svn-import or CVS import from local HD rather than remote.
Date: Thu, 12 Jun 2008 22:41:54 +0200
Message-ID: <20080612204154.GP29404@genesis.frugalware.org>
References: <Pine.LNX.4.64.0806121214210.18454@xenau.zenez.com> <20080612185545.GN29404@genesis.frugalware.org> <Pine.LNX.4.64.0806121315540.18454@xenau.zenez.com> <alpine.LNX.1.00.0806121523370.19665@iabervon.org> <Pine.LNX.4.64.0806121348340.18454@xenau.zenez.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0ACeQ+v8/z7rTqFh"
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Git List <git@vger.kernel.org>
To: Boyd Lynn Gerber <gerberb@zenez.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 22:42:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6tdF-00009I-49
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 22:42:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758715AbYFLUl6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 16:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758658AbYFLUl5
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 16:41:57 -0400
Received: from virgo.iok.hu ([193.202.89.103]:40767 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758332AbYFLUl4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 16:41:56 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 9CE271B2517;
	Thu, 12 Jun 2008 22:41:55 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id D524F4469A;
	Thu, 12 Jun 2008 22:23:18 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id C0B8A1770022; Thu, 12 Jun 2008 22:41:54 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0806121348340.18454@xenau.zenez.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84790>


--0ACeQ+v8/z7rTqFh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2008 at 01:57:28PM -0600, Boyd Lynn Gerber <gerberb@zenez.c=
om> wrote:
> This is really frustrating.
>=20
> I have tried every combination of file://localhost/ file:///
>=20
> This is what I get
>=20
> git-svn clone file:///working/svn/network/wireshark/ -T trunk -b branches=
=20
> -t tags wireshark
> Initialized empty Git repository in .git/
> Couldn't open a repository: Unable to open an ra_local session to URL:=20
> Unable to open repository 'file:///working/svn/network/wireshark' at=20
> /usr/bin/git-svn line 1048

Did you do just a simple checkout or do you have the full repository at
/working/svn/network/wireshark?

You need the later if you want to do the conversion offline.

--0ACeQ+v8/z7rTqFh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhRihIACgkQe81tAgORUJYTJgCfdguogVoMPHAeCkxttdnsQqsW
JssAoI0HzLMh6afmF3a8isX2KJg2gLXA
=gmSr
-----END PGP SIGNATURE-----

--0ACeQ+v8/z7rTqFh--
