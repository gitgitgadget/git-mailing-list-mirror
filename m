From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] git-imap-send: Allow the program to be run from
	subdirectories of a git tree.
Date: Mon, 2 Jun 2008 15:21:38 +0200
Message-ID: <20080602132138.GG29404@genesis.frugalware.org>
References: <1096648c0806010828yf4f07ebt3f758f41cab5cdfd@mail.gmail.com> <20080601220410.GD29404@genesis.frugalware.org> <1096648c0806020118i1d990affn17af29651e60b13b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G2kvLHdEX2DcGdqq"
Cc: git@vger.kernel.org
To: Rob Shearman <robertshearman@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 02 15:22:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K39zn-0005Bw-Qx
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 15:22:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753465AbYFBNVq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2008 09:21:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753459AbYFBNVq
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 09:21:46 -0400
Received: from virgo.iok.hu ([193.202.89.103]:45660 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752754AbYFBNVp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2008 09:21:45 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 530B81B25A4;
	Mon,  2 Jun 2008 15:21:39 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id E9F81446B9;
	Mon,  2 Jun 2008 15:04:22 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id F1DBC1190A46; Mon,  2 Jun 2008 15:21:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1096648c0806020118i1d990affn17af29651e60b13b@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83518>


--G2kvLHdEX2DcGdqq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 02, 2008 at 09:18:09AM +0100, Rob Shearman <robertshearman@gmai=
l.com> wrote:
> > not
> >
> >        setup_git_directory_gently( NULL );
>=20
> This isn't my normal coding style - I was trying to match the coding
> style to the rest of the file. Only the subsequent line to my added
> line uses the "func(arg)" style instead of the "func( arg )" style and
> that line was changed to the former very recently.

Ah, I see. I haven't looked at imap-send.c specifically, it seems that
this weird "func( arg )" style is used there a lot of times, so sorry
for bothering you with cosmetics.

--G2kvLHdEX2DcGdqq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhD8+IACgkQe81tAgORUJa3tACfTmoYj71Bu2r5NsAvVqyUnt4b
H9IAnjd4rZCu03ecaNrG6TPQkIcSeWze
=z4ci
-----END PGP SIGNATURE-----

--G2kvLHdEX2DcGdqq--
