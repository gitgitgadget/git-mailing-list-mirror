From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] move --show-cdup, --show-prefix, and --show-git-dir out of git-rev-parse.
Date: Sat, 7 Oct 2006 23:36:03 +0200
Message-ID: <20061007213603.GB2871@admingilde.org>
References: <20061007210429.GA2871@admingilde.org> <eg95a6$2v7$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CPn8Wy5ME997YUMW"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 07 23:36:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWJq5-0000lj-ML
	for gcvg-git@gmane.org; Sat, 07 Oct 2006 23:36:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932869AbWJGVgG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Oct 2006 17:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932868AbWJGVgG
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Oct 2006 17:36:06 -0400
Received: from agent.admingilde.org ([213.95.21.5]:39586 "EHLO
	mail.admingilde.org") by vger.kernel.org with ESMTP id S932869AbWJGVgE
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 7 Oct 2006 17:36:04 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1GWJpz-0007Ry-CM; Sat, 07 Oct 2006 23:36:03 +0200
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <eg95a6$2v7$1@sea.gmane.org>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28511>


--CPn8Wy5ME997YUMW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 07, 2006 at 11:14:34PM +0200, Jakub Narebski wrote:
> Martin Waitz wrote:
> > They don't really have anything to do with refs.
>=20
> But is it a good idea to add yet another command? We have too many of them
> already...

true

> I'd rather add one command, git-admin/git-config, or just move the options
> to the "git" command. So we would have "git --show-git-dir" in addition to
> "git --git-dir=3D<directory>".

I thought doing the same for these commands as for --help and --version
but wanted to hear some opinions first...

After all, the comment in front of --version talked about legacy,
so I was afraid to add more legacy ;-)

--=20
Martin Waitz

--CPn8Wy5ME997YUMW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFKB3Dj/Eaxd/oD7IRAloYAJ4r+f89deDb+chwgFpeeGuEaUmeSgCdGqFO
JWWTfbrNtsS/Smh0uMfMK4k=
=pDHz
-----END PGP SIGNATURE-----

--CPn8Wy5ME997YUMW--
