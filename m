From: martin f krafft <madduck@madduck.net>
Subject: Re: Exporting a tree from a repository
Date: Sun, 15 Jul 2007 09:17:16 +0200
Message-ID: <20070715071716.GA22798@piper.oerlikon.madduck.net>
References: <8e04b5820707141325o400e170bu9eb80b304cae506b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Cc: git@vger.kernel.org
To: Ciprian Dorin Craciun <ciprian.craciun@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 15 09:17:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9yM6-0008D0-Qq
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 09:17:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753048AbXGOHRT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 03:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753124AbXGOHRT
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 03:17:19 -0400
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:45577 "EHLO
	albatross.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753048AbXGOHRS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 03:17:18 -0400
Received: from localhost (albatross.madduck.net [127.0.0.1])
	by albatross.madduck.net (postfix) with ESMTP id 7729A895D73;
	Sun, 15 Jul 2007 09:17:17 +0200 (CEST)
Received: from albatross.madduck.net ([127.0.0.1])
	by localhost (albatross.madduck.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 31105-02; Sun, 15 Jul 2007 09:17:17 +0200 (CEST)
Received: from wall.oerlikon.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by albatross.madduck.net (postfix) with ESMTP id 42D0B895D72;
	Sun, 15 Jul 2007 09:17:17 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 80CE99F121;
	Sun, 15 Jul 2007 09:17:16 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 54B7043FC; Sun, 15 Jul 2007 09:17:16 +0200 (CEST)
Mail-Followup-To: Ciprian Dorin Craciun <ciprian.craciun@gmail.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <8e04b5820707141325o400e170bu9eb80b304cae506b@mail.gmail.com>
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.21-2-amd64 x86_64
X-Motto: Keep the good times rollin'
X-Subliminal-Message: debian/rules!
X-Spamtrap: madduck.bogus@madduck.net
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at madduck.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52531>


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Ciprian Dorin Craciun <ciprian.craciun@gmail.com> [2007.07.14.2=
225 +0200]:
>    Now I know that I can use "git archive | tar -x"... I am looking
> for the same functionality but without the intermediary file... Maybe
> something like "git archive --format=3Dtree <branch>"...

There is no intermediary file.

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
spamtraps: madduck.bogus@madduck.net
=20
"when I was a boy I was told
 that anybody could become president.
 now i'm beginning to believe it."
                                                    -- clarence darrow

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature (GPG/PGP)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGmcn8IgvIgzMMSnURAlakAJ0YYqB0x/cwLq5p2FVqR3mSfYmz/ACgr95r
uOdu3u0zjuj3cbffuVM38Xs=
=mvRj
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
