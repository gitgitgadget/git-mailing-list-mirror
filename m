From: martin f krafft <madduck@madduck.net>
Subject: Re: confused about preserved permissions
Date: Mon, 20 Aug 2007 19:38:40 +0200
Message-ID: <20070820173840.GA19868@piper.oerlikon.madduck.net>
References: <20070820164411.GA15637@piper.oerlikon.madduck.net> <20070820165426.GA7206@artemis.corp>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 20 19:39:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INBE1-0000n3-O5
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 19:39:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751606AbXHTRjW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 13:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751471AbXHTRjW
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 13:39:22 -0400
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:34822 "EHLO
	albatross.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751218AbXHTRjV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 13:39:21 -0400
Received: from localhost (albatross.madduck.net [127.0.0.1])
	by albatross.madduck.net (postfix) with ESMTP id 00B308966C2
	for <git@vger.kernel.org>; Mon, 20 Aug 2007 19:39:20 +0200 (CEST)
Received: from albatross.madduck.net ([127.0.0.1])
	by localhost (albatross.madduck.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 07682-09 for <git@vger.kernel.org>;
	Mon, 20 Aug 2007 19:39:19 +0200 (CEST)
Received: from wall.oerlikon.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by albatross.madduck.net (postfix) with ESMTP id C7824895F7F
	for <git@vger.kernel.org>; Mon, 20 Aug 2007 19:39:19 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 02D919F16A
	for <git@vger.kernel.org>; Mon, 20 Aug 2007 19:39:18 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id DC81043F9; Mon, 20 Aug 2007 19:38:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070820165426.GA7206@artemis.corp>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.22-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at madduck.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56226>


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Pierre Habouzit <madcoder@debian.org> [2007.08.20.1854 +0200]:
> > I'd be grateful for any documentation to read in addition to the
> > code. I saw core.filemode, but that's only about the x bit, it
> > seems.
>=20
>   You may want to read git-config around core.sharedRepository.

Hello Pierre, thanks for taking the time to respond.

core.sharedRepository (or init --shared for that matter) seems to
only deal with permissions of $GIT_DIR. I am worrying about the
permissions of the worktree. I also stated in the OP that I had used
--shared but none of the settings made any difference...

Cheers,

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
normaliser unix c'est comme pasteuriser le camembert.
=20
spamtraps: madduck.bogus@madduck.net

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGydGgIgvIgzMMSnURAkAHAJ4vSy9JYlNIX5qbzLaGga47HH+ZcgCcCSmH
nJVj3sqrFjjICHMAvo+vXY0=
=gfV6
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
