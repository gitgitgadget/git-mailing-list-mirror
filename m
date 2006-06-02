From: Keith Packard <keithp@keithp.com>
Subject: Re: Importing Mozilla CVS into git
Date: Thu, 01 Jun 2006 20:55:18 -0700
Message-ID: <1149220518.5521.43.camel@neko.keithp.com>
References: <9e4733910606011521n106f8f24s6c7053ce51e3791e@mail.gmail.com>
	 <1149204044.27695.38.camel@neko.keithp.com>
	 <9e4733910606011755n29a149f2m1409c5a23888f1c5@mail.gmail.com>
	 <1149214075.5521.31.camel@neko.keithp.com>
	 <9e4733910606011936i725e8eb2h8c2357f3688da43e@mail.gmail.com>
	 <1149219593.5521.34.camel@neko.keithp.com>
	 <9e4733910606012047h727a25f1vb367c880f8933c4e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-9od4ZHctCoRzCG7d07rc"
Cc: keithp@keithp.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 02 05:55:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fm0l8-0000bP-JD
	for gcvg-git@gmane.org; Fri, 02 Jun 2006 05:55:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbWFBDzc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Jun 2006 23:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751261AbWFBDzc
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jun 2006 23:55:32 -0400
Received: from home.keithp.com ([63.227.221.253]:16658 "EHLO keithp.com")
	by vger.kernel.org with ESMTP id S1751198AbWFBDzc (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Jun 2006 23:55:32 -0400
Received: from localhost (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 597FA130023;
	Thu,  1 Jun 2006 20:55:31 -0700 (PDT)
Received: from keithp.com ([127.0.0.1])
	by localhost (keithp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 25094-02; Thu, 1 Jun 2006 20:55:30 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1033)
	id D8F0213001E; Thu,  1 Jun 2006 20:55:30 -0700 (PDT)
Received: from neko.keithp.com (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id CF62214001;
	Thu,  1 Jun 2006 20:55:30 -0700 (PDT)
Received: by neko.keithp.com (Postfix, from userid 1488)
	id A95C7542C0; Thu,  1 Jun 2006 20:55:18 -0700 (PDT)
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910606012047h727a25f1vb367c880f8933c4e@mail.gmail.com>
X-Mailer: Evolution 2.6.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21140>


--=-9od4ZHctCoRzCG7d07rc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-06-01 at 23:47 -0400, Jon Smirl wrote:
> On 6/1/06, Keith Packard <keithp@keithp.com> wrote:
> > Git runs fine on Windows these days; asking people to use reasonable
> > tools to contribute to the project doesn't seem crazy to me.
>=20
> WIndows, Mac, Solaris and Linux will cover most Firefox developers.
> Is git to go on those platforms? Is WIndows native or cygwin?

I think the windows stuff may still be cygwin, but Mac and Solaris work
fine with the git, of course. It's just simple posix code, after all

> There are a few more people on weird platforms that will need a solution.
> Are perl and shell script still a requirement?

Yeah, quite a bit of both of those still. Less over time as people
figure out that C code is generally easier to fix than a nasty
combination of C code, shell scripts and perl line noise.

--=20
keith.packard@intel.com

--=-9od4ZHctCoRzCG7d07rc
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBEf7amQp8BWwlsTdMRAm0JAKCfk1WCW3vi8a7bmzccPvUAzPFxvQCguNu1
tLebuXRQ4cu/Ka59UMW37ps=
=fdVB
-----END PGP SIGNATURE-----

--=-9od4ZHctCoRzCG7d07rc--
