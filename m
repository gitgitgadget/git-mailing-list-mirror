From: Erik Mouw <mouw@nl.linux.org>
Subject: Re: git installation (as private user) should NEVER write site_perl
Date: Tue, 20 Feb 2007 18:55:37 +0100
Organization: Eric Conspiracy Secret Labs
Message-ID: <20070220175536.GC26444@gateway.home>
References: <86sld0sq7c.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bAmEntskrkuBymla"
Cc: git@vger.kernel.org
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Tue Feb 20 19:02:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJZJc-0000a5-1O
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 19:02:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030327AbXBTSCH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Feb 2007 13:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932975AbXBTSCG
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 13:02:06 -0500
Received: from smtp-vbr14.xs4all.nl ([194.109.24.34]:1818 "EHLO
	smtp-vbr14.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933001AbXBTSCF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Feb 2007 13:02:05 -0500
X-Greylist: delayed 372 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Feb 2007 13:02:05 EST
Received: from gateway.home (a82-92-155-199.adsl.xs4all.nl [82.92.155.199])
	by smtp-vbr14.xs4all.nl (8.13.8/8.13.8) with ESMTP id l1KHtbAN086118;
	Tue, 20 Feb 2007 18:55:46 +0100 (CET)
	(envelope-from mouw@nl.linux.org)
Received: from erik by gateway.home with local (Exim 3.36 #1 (Debian))
	id 1HJZDF-0000RC-00; Tue, 20 Feb 2007 18:55:37 +0100
Content-Disposition: inline
In-Reply-To: <86sld0sq7c.fsf@blue.stonehenge.com>
X-Eric-Conspiracy: There is no conspiracy!
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40247>


--bAmEntskrkuBymla
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2007 at 09:18:15AM -0800, Randal L. Schwartz wrote:
> I tried to install git on a system where I was a normal user.  Of course,
> this step fails:
>=20
>      Installing /usr/perl5/site_perl/5.6.1/Error.pm
>      Installing /usr/perl5/site_perl/5.6.1/Git.pm

It gets installed in ~/share/perl/5.8.4/ when I compile as a normal
user (git-1.5.0.1):

Installing /home/erik/share/perl/5.8.4/Error.pm
Installing /home/erik/share/perl/5.8.4/Git.pm
Installing /home/erik/man/man3/private-Error.3pm
Installing /home/erik/man/man3/Git.3pm


Erik

--=20
They're all fools. Don't worry. Darwin may be slow, but he'll
eventually get them. -- Matthew Lammers in alt.sysadmin.recovery

--bAmEntskrkuBymla
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFF2zYY/PlVHJtIto0RAvaoAJ9WV0sgA6NK5/VZDWzUPp2KJSKJJACffi+G
Ov3eUz6n7lqzG0rIlygnvz8=
=66xI
-----END PGP SIGNATURE-----

--bAmEntskrkuBymla--
