From: martin f krafft <madduck@madduck.net>
Subject: Re: [PATCH] gitk: don't save the geometry to rc file on exit
Date: Mon, 25 Feb 2008 13:24:43 +0100
Message-ID: <20080225122443.GA1543@piper.oerlikon.madduck.net>
References: <47AAA254.2020008@thorn.ws> <20080207063020.GP24004@spearce.org> <200802071056.19370.robin.rosenberg.lists@dewire.com> <20080207101051.19459.qmail@fcb20609bc7c07.315fe32.mid.smarden.org> <20080223113759.12854.qmail@6a8737aa4695b2.315fe32.mid.smarden.org> <18368.41742.689290.877767@cargo.ozlabs.ibm.com> <20080225080739.GA13610@piper.oerlikon.madduck.net> <18370.45020.940192.10482@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
To: Paul Mackerras <paulus@samba.org>, Gerrit Pape <pape@smarden.org>,
	git@vger.kernel.org, Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 13:26:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTcPH-0006i1-IX
	for gcvg-git-2@gmane.org; Mon, 25 Feb 2008 13:26:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754507AbYBYMZb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2008 07:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754495AbYBYMZb
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Feb 2008 07:25:31 -0500
Received: from seamus.madduck.net ([213.203.238.82]:45053 "EHLO
	seamus.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754483AbYBYMZa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2008 07:25:30 -0500
Received: from wall.oerlikon.madduck.net (84-75-158-163.dclient.hispeed.ch [84.75.158.163])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by seamus.madduck.net (postfix) with ESMTP id 33D574064C3;
	Mon, 25 Feb 2008 13:25:42 +0100 (CET)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id C42059F13A;
	Mon, 25 Feb 2008 13:24:44 +0100 (CET)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 7EFC74400; Mon, 25 Feb 2008 13:24:43 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <18370.45020.940192.10482@cargo.ozlabs.ibm.com>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.24-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Virus-Scanned: ClamAV 0.92.1/5981/Mon Feb 25 10:19:15 2008 on seamus.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75024>


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Paul Mackerras <paulus@samba.org> [2008.02.25.1309 +0100]:
> Then various other bits of config won't be persistent, such as font
> settings.  So I don't think that's a good idea.

Huh? I use the same font on all machines, but the screen resolutions
differ...

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
time wounds all heels.
                                                       -- groucho marx
=20
spamtraps: madduck.bogus@madduck.net

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHwrOLIgvIgzMMSnURAqHmAKDduDKaXsFE9epZkHBpWgeysrzBvgCfal1e
/tqpPvScqzOnyM+xqjkkH2I=
=izf0
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
