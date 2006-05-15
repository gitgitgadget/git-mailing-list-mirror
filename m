From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: [PATCH] gitk: Display commit messages with word wrap
Date: Mon, 15 May 2006 19:07:31 +0400
Message-ID: <20060515150731.GD19254@master.mivlgu.local>
References: <20060514151456.GA18012@procyon.home> <7v4pzs18wl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jL2BoiuKMElzg3CS"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 17:08:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfefY-0001Oy-91
	for gcvg-git@gmane.org; Mon, 15 May 2006 17:07:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964943AbWEOPHd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 11:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964952AbWEOPHd
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 11:07:33 -0400
Received: from mivlgu.ru ([81.18.140.87]:58546 "EHLO master.mivlgu.local")
	by vger.kernel.org with ESMTP id S964943AbWEOPHc (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 May 2006 11:07:32 -0400
Received: by master.mivlgu.local (Postfix, from userid 1000)
	id B4B7C180086; Mon, 15 May 2006 19:07:31 +0400 (MSD)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v4pzs18wl.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20052>


--jL2BoiuKMElzg3CS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 14, 2006 at 04:30:50PM -0700, Junio C Hamano wrote:
> Sergey Vlasov <vsu@altlinux.ru> writes:
>=20
> > Some people put very long strings into commit messages, which then
> > become invisible in gitk (word wrapping in the commit details window is
> > turned off, and there is no horizontal scroll bar).  Enabling word wrap
> > for just the commit message looks much better.
>=20
> I do not mind it myself but IIRC gitk's "no wrapping" was made
> because people found wrapping annoying; maybe a runtime
> configuration option?

OK, added a hidden option in ~/.gitk which defaults to "no wrapping", so
most users will not notice anything...

--jL2BoiuKMElzg3CS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFEaJkzW82GfkQfsqIRAqs1AJ9HZwRzdiGnikTt6SBkBIjzdJib6gCeIJhv
rFYTf1fMDLSPQD5et/EI7V8=
=WHYS
-----END PGP SIGNATURE-----

--jL2BoiuKMElzg3CS--
