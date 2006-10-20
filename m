From: Robert Collins <robertc@robertcollins.net>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Sat, 21 Oct 2006 09:15:29 +1000
Message-ID: <1161386129.13697.63.camel@localhost.localdomain>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	 <ehao3e$2qv$1@sea.gmane.org> <4538EC8F.7020502@utoronto.ca>
	 <200610201821.34712.jnareb@gmail.com>
	 <20061020181210.GA29843@artax.karlin.mff.cuni.cz>
	 <Pine.LNX.4.64.0610201133260.3962@g5.osdl.org>
	 <1161382416.9241.19.camel@localhost.localdomain>
	 <1161385512.13697.61.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ssxvPA+xa6qfk6uNNV4S"
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 21 01:15:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gb3af-0006xj-DF
	for gcvg-git@gmane.org; Sat, 21 Oct 2006 01:15:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422947AbWJTXPe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Oct 2006 19:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030264AbWJTXPe
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Oct 2006 19:15:34 -0400
Received: from smtp1.adl2.internode.on.net ([203.16.214.181]:39431 "EHLO
	smtp1.adl2.internode.on.net") by vger.kernel.org with ESMTP
	id S1030205AbWJTXPd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Oct 2006 19:15:33 -0400
Received: from lifelesswks.robertcollins.net (ppp245-86.static.internode.on.net [59.167.245.86])
	by smtp1.adl2.internode.on.net (8.13.6/8.13.5) with ESMTP id k9KNFKAl056616;
	Sat, 21 Oct 2006 08:45:21 +0930 (CST)
	(envelope-from robertc@robertcollins.net)
Received: from [192.168.1.5] (helo=lifelesslap.robertcollins.net)
	by lifelesswks.robertcollins.net with esmtpa (Exim 4.60)
	(envelope-from <robertc@robertcollins.net>)
	id 1Gb3aC-00040Q-GY; Sat, 21 Oct 2006 09:15:20 +1000
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
	by lifelesslap.robertcollins.net with esmtp (Exim 4.60)
	(envelope-from <robertc@robertcollins.net>)
	id 1Gb3aM-00042p-2l; Sat, 21 Oct 2006 09:15:30 +1000
To: Jeff Licquia <jeff@licquia.org>
In-Reply-To: <1161385512.13697.61.camel@localhost.localdomain>
X-Mailer: Evolution 2.6.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29553>


--=-ssxvPA+xa6qfk6uNNV4S
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2006-10-21 at 09:05 +1000, Robert Collins wrote:
> On Fri, 2006-10-20 at 18:13 -0400, Jeff Licquia wrote:
> >=20
> > All in all, not ideal, but it seems bzr handles this better than bk.
> > Certainly, bzr doesn't silently drop anyone's changes, at least.  I
> > suspect that bzr could improve its handling of this use case, but not,
> > I'm sure, to Linus's specifications; some of the fun and games does
> > seem to come from the use of file IDs.=20
...
> However, I'm still convinced that tracking the user intention of renames
> leads to a slicker system than renames via inference. My off the cuff
> list of corner cases is:

I meant to add, that I think inference is a great tool to use as an
adjunct to whatever explicit data one can capture.

-Rob
--=20
GPG key available at: <http://www.robertcollins.net/keys.txt>.

--=-ssxvPA+xa6qfk6uNNV4S
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBFOViRM4BfeEKYx2ERAtKMAKCKxkmnC7Li8gFsn1hb1sDljNVuFACeKBGl
707qbvl6mXS0B/HZtQKkj5k=
=7yiU
-----END PGP SIGNATURE-----

--=-ssxvPA+xa6qfk6uNNV4S--
