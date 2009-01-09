From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: 1.5.6.5 fails to clone
	git.kernel.org/[...]/rostedt/linux-2.6-rt
Date: Fri, 9 Jan 2009 15:08:01 +0100
Message-ID: <20090109140801.GO21154@genesis.frugalware.org>
References: <E1LLAn5-0001JM-00@alva.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oQt9EtFvfmoPRfH8"
Cc: git@vger.kernel.org
To: Tim Shepard <shep@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Jan 09 15:09:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLI3H-0003eF-Ou
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 15:09:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753552AbZAIOIH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 09:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753063AbZAIOIF
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 09:08:05 -0500
Received: from virgo.iok.hu ([212.40.97.103]:37575 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752586AbZAIOIE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 09:08:04 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id E2A13580A6;
	Fri,  9 Jan 2009 15:08:02 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 441A94465E;
	Fri,  9 Jan 2009 15:08:01 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 3C7BD11B8630; Fri,  9 Jan 2009 15:08:01 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <E1LLAn5-0001JM-00@alva.home>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105013>


--oQt9EtFvfmoPRfH8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 09, 2009 at 01:24:19AM -0500, Tim Shepard <shep@alum.mit.edu> w=
rote:
>=20
>=20
> I have git 1.5.6.5 installed from the Debian/lenny package.
>=20
> Poking around in http://git.kernel.org/ looking for a git repository
> that might have the latest -rt development happening, I found
>=20
>   http://git.kernel.org/?p=3Dlinux/kernel/git/rostedt/linux-2.6-rt.git
>=20
> which looked promising.
>=20
> But when I tried cloning it using:
>=20
>     git clone rsync://rsync.kernel.org/pub/scm/linux/kernel/git/rostedt/l=
inux-2.6-rt.git linux-2.6-rt

I would use the git:// link from gitweb.

--oQt9EtFvfmoPRfH8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklnWkEACgkQe81tAgORUJbrIACfejlvPTgA5zNzi1PgK+W8ajca
QaAAnimbWmpx51twYq6D9kDhv4htT4Py
=aUsA
-----END PGP SIGNATURE-----

--oQt9EtFvfmoPRfH8--
