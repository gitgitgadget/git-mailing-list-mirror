From: Robert Collins <robertc@robertcollins.net>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 19:40:34 +1000
Message-ID: <1161078035.9020.73.camel@localhost.localdomain>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
	 <200610170119.09066.jnareb@gmail.com> <45346290.6050300@utoronto.ca>
	 <200610171120.09747.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Bg0qoOg1UVzvpbt6HNLG"
Cc: Aaron Bentley <aaron.bentley@utoronto.ca>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 11:40:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZlRL-0000Zr-Es
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 11:40:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422665AbWJQJks (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 05:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161047AbWJQJks
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 05:40:48 -0400
Received: from ash25e.internode.on.net ([203.16.214.182]:2066 "EHLO
	ash25e.internode.on.net") by vger.kernel.org with ESMTP
	id S1161041AbWJQJks (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 05:40:48 -0400
Received: from lifelesswks.robertcollins.net (ppp245-86.static.internode.on.net [59.167.245.86])
	by ash25e.internode.on.net (8.13.6/8.13.5) with ESMTP id k9H9eYrV017825;
	Tue, 17 Oct 2006 19:10:34 +0930 (CST)
	(envelope-from robertc@robertcollins.net)
Received: from [192.168.1.5] (helo=lifelesslap.robertcollins.net)
	by lifelesswks.robertcollins.net with esmtpa (Exim 4.60)
	(envelope-from <robertc@robertcollins.net>)
	id 1GZlR3-0000JT-RL; Tue, 17 Oct 2006 19:40:33 +1000
Received: from localhost ([127.0.0.1] helo=localhost.localdomain)
	by lifelesslap.robertcollins.net with esmtp (Exim 4.60)
	(envelope-from <robertc@robertcollins.net>)
	id 1GZlR5-0004SH-MU; Tue, 17 Oct 2006 19:40:35 +1000
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200610171120.09747.jnareb@gmail.com>
X-Mailer: Evolution 2.6.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29043>


--=-Bg0qoOg1UVzvpbt6HNLG
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-10-17 at 11:20 +0200, Jakub Narebski wrote:
>=20
>           ---- time --->
>=20
>     --*--*--*--*--*--*--*--*--*-- <branch>
>           \            /
>            \-*--X--*--/
>=20
> The branch it used to be on is gone...

In bzr 0.12 this is :
2.1.2

(assuming the first * is numbered '1'.)

These numbers are fairly stable, in particular everything's number in
the mainline will be the same number in all the branches created from it
at that point in time, but a branch that initially creates a revision or
obtains it before the mainline will have a different number until they
syncronise with the mainline via pull.

-Rob
--=20
GPG key available at: <http://www.robertcollins.net/keys.txt>.

--=-Bg0qoOg1UVzvpbt6HNLG
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBFNKUSM4BfeEKYx2ERArp3AJ9Q7GgCumcWe5O5qrY6JPKCINSx4wCePfGB
5t88Qc43szCsk2OBaBXb2JE=
=Ggix
-----END PGP SIGNATURE-----

--=-Bg0qoOg1UVzvpbt6HNLG--
