From: martin f krafft <madduck@madduck.net>
Subject: Re: [announce] colgit: manage git repository collections
Date: Thu, 6 Sep 2007 15:15:25 +0200
Message-ID: <20070906131525.GA7261@piper.oerlikon.madduck.net>
References: <20070906101115.GA29360@piper.oerlikon.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Cc: home in vcs discussion list <vcs-home@lists.madduck.net>
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 06 15:15:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITHCt-0002VI-0I
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 15:15:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754153AbXIFNPe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 09:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752256AbXIFNPd
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 09:15:33 -0400
Received: from clegg.madduck.net ([82.197.162.59]:42540 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751974AbXIFNPd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 09:15:33 -0400
Received: from wall.oerlikon.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTP id E66D4BEBC;
	Thu,  6 Sep 2007 15:15:25 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 65D739F161;
	Thu,  6 Sep 2007 15:15:25 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 0C08E43F4; Thu,  6 Sep 2007 15:15:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070906101115.GA29360@piper.oerlikon.madduck.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57876>


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach martin f krafft <madduck@madduck.net> [2007.09.06.1211 +0200]:
> With SVN, I'd have a repository for each machine, which existed only
> of svn:externals references pulling in other repos and thus
> assembling my home directory. git-submodule isn't quite designed for
> this sort of stuff, and thus I came up with colgit.

You might want to read over this short discussion between Peter and
I on why git-submodules aren't up for the task:

  http://colabti.de/irclogger/irclogger_log/git?date=3D2007-09-06,Thu&sel=
=3D578#l979

Cheers,

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
"'the answer to the great question...'
 'of life, the universe and everything...' said deep thought.
 'is...' said deep thought, and paused.
 'is...'
 'forty-two,' said deep thought, with infinite majesty and calm."
                                 -- hitchhiker's guide to the galaxy
=20
spamtraps: madduck.bogus@madduck.net

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG3/1sIgvIgzMMSnURAovuAKCk7eFjoH8NmRtaosDgExBl23XttgCcC5P7
dkrdYDZswVGUEsWPECnFQto=
=2oIZ
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
