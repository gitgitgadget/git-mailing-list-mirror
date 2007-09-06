From: martin f krafft <madduck@madduck.net>
Subject: Re: inconsistent use of worktree?
Date: Thu, 6 Sep 2007 15:41:38 +0200
Message-ID: <20070906134138.GA8548@piper.oerlikon.madduck.net>
References: <20070906132906.GA7791@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 06 15:41:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITHcD-0003DZ-Fu
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 15:41:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755682AbXIFNln (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 09:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755111AbXIFNln
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 09:41:43 -0400
Received: from clegg.madduck.net ([82.197.162.59]:50892 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064AbXIFNlm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 09:41:42 -0400
Received: from wall.oerlikon.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTP id D55C2BEBC
	for <git@vger.kernel.org>; Thu,  6 Sep 2007 15:41:38 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 584309F161
	for <git@vger.kernel.org>; Thu,  6 Sep 2007 15:41:38 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 1ABEA43F4; Thu,  6 Sep 2007 15:41:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070906132906.GA7791@piper.oerlikon.madduck.net>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.22-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: ClamAV 0.91.2/4170/Thu Sep  6 06:30:09 2007 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57878>


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach martin f krafft <madduck@madduck.net> [2007.09.06.1529 +0200]:
> What is git doing? Could it be that it's getting utterly confused
> and inconsistently uses the worktree? I'd be happy to investigate
> this, but want to make sure I am not doing anything wrong!

git-commit -a also does not work:

  piper:~/.bin/colgit.git> git commit -m'add list action to enumerate all k=
nown repos' -a
  error: .bin/colgit: cannot add to the index - missing --add option?
  fatal: Unable to process path .bin/colgit

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
redistribution of this email via the
microsoft network is prohibited.
=20
spamtraps: madduck.bogus@madduck.net

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG4AOSIgvIgzMMSnURAmhWAJ0Ss2HuicRTusGxtw5egFjwpM/o6wCfSQu9
E0LTgh4ssLPqf+Mi2BkmRGo=
=J+ui
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
