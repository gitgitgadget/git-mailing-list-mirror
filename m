From: Keith Packard <keithp@keithp.com>
Subject: Re: parsecvs tool now creates git repositories
Date: Fri, 07 Apr 2006 00:24:57 -0700
Message-ID: <1144394697.2303.307.camel@neko.keithp.com>
References: <20060405174247.GA29758@blackbean.org>
	 <1144262498.2303.231.camel@neko.keithp.com>
	 <20060406181502.GA15741@blackbean.org>
	 <1144354356.2303.270.camel@neko.keithp.com>
	 <46a038f90604061451m4522e3f3qceae2331751a307c@mail.gmail.com>
	 <1144361968.2303.288.camel@neko.keithp.com>
	 <46a038f90604061622s5a7bee4eq6666d9b3796f70f6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-KXtM7q+9E5R+0UFIB+VE"
Cc: keithp@keithp.com, Jim Radford <radford@blackbean.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 07 09:25:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FRlLd-0006SO-Ga
	for gcvg-git@gmane.org; Fri, 07 Apr 2006 09:25:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325AbWDGHZe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Apr 2006 03:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932326AbWDGHZe
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Apr 2006 03:25:34 -0400
Received: from home.keithp.com ([63.227.221.253]:14599 "EHLO keithp.com")
	by vger.kernel.org with ESMTP id S932325AbWDGHZe (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Apr 2006 03:25:34 -0400
Received: from localhost (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id A6D66130020;
	Fri,  7 Apr 2006 00:25:23 -0700 (PDT)
Received: from keithp.com ([127.0.0.1])
	by localhost (keithp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 26568-01-7; Fri, 7 Apr 2006 00:25:23 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1033)
	id 6E93413001F; Fri,  7 Apr 2006 00:25:23 -0700 (PDT)
Received: from neko.keithp.com (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 6BFC814001;
	Fri,  7 Apr 2006 00:25:23 -0700 (PDT)
Received: by neko.keithp.com (Postfix, from userid 1488)
	id 9B9FC6B42B7; Fri,  7 Apr 2006 00:24:57 -0700 (PDT)
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90604061622s5a7bee4eq6666d9b3796f70f6@mail.gmail.com>
X-Mailer: Evolution 2.4.2.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18493>


--=-KXtM7q+9E5R+0UFIB+VE
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-04-07 at 11:22 +1200, Martin Langhoff wrote:

> parsecvs is committing them with the "added file foo.x" message, not
> the actual commit message.

heh. my cvs repositories are all so kludged that no files have ever been
added, it appears. I'll fix this when I've got a copy of the moodle
repository. sf.net is as useful as always.

I suspect the change is as simple as checking the format of the log
message and time time stamps of the commits and then just dropping the
1.1 revision from the tree entirely.

--=20
keith.packard@intel.com

--=-KXtM7q+9E5R+0UFIB+VE
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBENhPJQp8BWwlsTdMRAq90AJ9CO48n4Q9oCkuLlzxUVbNIp077EACgjgKN
HjIozks2nW2PI4Wbg5zlPh0=
=QgDY
-----END PGP SIGNATURE-----

--=-KXtM7q+9E5R+0UFIB+VE--
