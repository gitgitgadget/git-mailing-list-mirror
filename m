From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [PATCH] gitweb: Do not use absolute font sizes
Date: Tue, 15 May 2007 17:09:12 +0200
Message-ID: <20070515150912.GA3653@efreet.light.src>
References: <6efbd9b70705071613p23017509qaf9af12c1d14f9cb@mail.gmail.com> <20070509014150.7477.48489.stgit@rover> <f2a3si$ein$1@sea.gmane.org> <87odkmgaj5.fsf@morpheus.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: David =?utf-8?Q?K=C3=A5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Tue May 15 17:33:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hnz28-0006Go-Am
	for gcvg-git@gmane.org; Tue, 15 May 2007 17:33:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751743AbXEOPdr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 May 2007 11:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753903AbXEOPdr
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 11:33:47 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:36986 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751743AbXEOPdr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 11:33:47 -0400
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id CA05276D54;
	Tue, 15 May 2007 17:33:45 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1HnyeG-000161-5A; Tue, 15 May 2007 17:09:12 +0200
Content-Disposition: inline
In-Reply-To: <87odkmgaj5.fsf@morpheus.local>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47349>


--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 14, 2007 at 18:06:54 -0700, David K=C3=A5gedal wrote:
> Unfortunately, the problem is that too many web sites explicitly
> select extra small font sizes, which means that you have to select a
> "standard" font size in your browser that is a bit larger than you'd
> actually like.

IMHO gitweb should explicitely request being somewhat smaller than normal,
because it has good use for long lines. Normally I want to set font so larg=
e,
that more than ~120 characters won't fit on the screen, since otherwise pag=
es
that don't use margins are simply unreadable. However gitweb presents a tab=
le
with several columns, so having wider line is OK for it. Therefore explicit
'font-size: small' would make sense.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGSc0YRel1vVwhjGURAlC2AJ42+ycPNNVmVJQ9a6JeTHZslWN/FQCfXXtk
SHJc9tdByvl5GlOobuuMzEM=
=Qzdg
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--
