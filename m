From: Jan Hudec <bulb@ucw.cz>
Subject: Re: Anyone running GIT on native Windows
Date: Wed, 9 May 2007 20:31:52 +0200
Message-ID: <20070509183152.GB2982@efreet.light.src>
References: <2b6901c78faa$cf9aa7e0$0200a8c0@AMD2500> <7vejlufmhd.fsf@assigned-by-dhcp.cox.net> <2b7f01c78fb1$be4dc6a0$0200a8c0@AMD2500> <463ECEF4.625F3633@eudaptics.com> <e5bfff550705070448t7813d064mbac82abb45591888@mail.gmail.com> <463F14FF.F8DF11EB@eudaptics.com> <46415106.5040401@xs4all.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/NkBOFFp2J2Af1nK"
Cc: git@vger.kernel.org, Marco Costalba <mcostalba@gmail.com>
To: Han-Wen Nienhuys <hanwen@xs4all.nl>
X-From: git-owner@vger.kernel.org Wed May 09 20:32:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hlqxh-0005qh-Q8
	for gcvg-git@gmane.org; Wed, 09 May 2007 20:32:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756787AbXEIScQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 14:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756830AbXEIScQ
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 14:32:16 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:4883 "EHLO mail.bluetone.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756787AbXEIScP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 14:32:15 -0400
Received: from ([85.207.119.145])
	by mail.bluetone.cz with ESMTP with TLS id 5203017.116325;
	Wed, 09 May 2007 20:31:57 +0200
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1Hlqx6-0001tU-I5; Wed, 09 May 2007 20:31:52 +0200
Content-Disposition: inline
In-Reply-To: <46415106.5040401@xs4all.nl>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-esp: ESP<0>=
	RBL:<0> 
	SHA:<0> 
	UHA:<0> 
	BAYES:<0> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46764>


--/NkBOFFp2J2Af1nK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 09, 2007 at 01:41:42 -0300, Han-Wen Nienhuys wrote:
> Johannes Sixt escreveu:
> > The next big thing to think about is an installer. Does anyone have a
> > suggestion for a free installer tool? I only know about Microsoft's WiX
> > (wix.sf.net), but it requires .NET (for the developer, not the user).
>=20
> I packaged Mingw GIT using NSIS some time ago; see=20
>=20
>   http://lilypond.org/git/binaries/mingw/
>=20
> Due various personal reasons, I haven't been able to update this, but I=
=20
> will package a new version soon. Please try it to see whether there are=
=20
> any rough edges.=20

Would you care to share the installer scripts? Maybe you can find someone to
help.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--/NkBOFFp2J2Af1nK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGQhOYRel1vVwhjGURArLXAKDavcx9UNFjWAWxTrpUcWN8eOgm7gCg4IAE
HDqOKpdi3Vo0VycmXeLU1ts=
=XT/h
-----END PGP SIGNATURE-----

--/NkBOFFp2J2Af1nK--
