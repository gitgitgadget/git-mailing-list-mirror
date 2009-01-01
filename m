From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: Extracting a single commit or object
Date: Thu, 1 Jan 2009 19:08:34 +0100
Message-ID: <20090101180834.GJ21154@genesis.frugalware.org>
References: <21223948.post@talk.nabble.com> <alpine.DEB.1.00.0901011747580.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W/k2pzXB1sdSS/P9"
Cc: yitzhakbg <yitzhakbg@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 01 19:10:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIRzb-0005Cs-FS
	for gcvg-git-2@gmane.org; Thu, 01 Jan 2009 19:09:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751536AbZAASIi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Jan 2009 13:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750911AbZAASIh
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jan 2009 13:08:37 -0500
Received: from virgo.iok.hu ([212.40.97.103]:55301 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750724AbZAASIg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jan 2009 13:08:36 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 92945580FD;
	Thu,  1 Jan 2009 19:08:35 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 5DAEE4465E;
	Thu,  1 Jan 2009 19:08:34 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 923C211B8630; Thu,  1 Jan 2009 19:08:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0901011747580.30769@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104306>


--W/k2pzXB1sdSS/P9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 01, 2009 at 05:52:49PM +0100, Johannes Schindelin <Johannes.Sch=
indelin@gmx.de> wrote:
> If you activated bash completion, you can even complete monsters like=20
> this:
>=20
> 	git show \
> v1.5.3:v1.5.3:t/t4013/diff.diff-tree_--cc_--patch-with-stat_--summary_mas=
ter

Wow, that's really a monster. After removing the first leading v1.5.3:,
it works. (If this is a bash completion bug, I can't reproduce.)

--W/k2pzXB1sdSS/P9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkldBqIACgkQe81tAgORUJboXwCfcJqKALNJp/yM9L0zi5dI8ZPl
scUAn3Or3Sc/tSoIFNjeJL/IkGw0WyUP
=7ISa
-----END PGP SIGNATURE-----

--W/k2pzXB1sdSS/P9--
