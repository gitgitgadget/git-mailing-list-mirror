From: Elfyn McBratney <beu@gentoo.org>
Subject: Re: [COGITO] cg-status in an empty repo spits out git-diff-index usage info
Date: Tue, 4 Oct 2005 14:02:54 +0100
Message-ID: <20051004130254.GA13377@gentoo.org>
References: <20050930181809.GB13582@emcb.local> <7vpsqp905i.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Cc: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 04 15:04:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EMmRf-0001cX-SL
	for gcvg-git@gmane.org; Tue, 04 Oct 2005 15:03:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424AbVJDNC5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Oct 2005 09:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932439AbVJDNC5
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Oct 2005 09:02:57 -0400
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:15878 "EHLO
	anchor-post-30.mail.demon.net") by vger.kernel.org with ESMTP
	id S932424AbVJDNC4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2005 09:02:56 -0400
Received: from beu1.demon.co.uk ([83.105.51.149] helo=zippy.emcb.local)
	by anchor-post-30.mail.demon.net with esmtp (Exim 4.42)
	id 1EMmRa-000Bu9-1y; Tue, 04 Oct 2005 13:02:54 +0000
Received: by zippy.emcb.local (Postfix, from userid 1001)
	id 696D6148040; Tue,  4 Oct 2005 14:02:54 +0100 (BST)
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Elfyn McBratney <beu@gentoo.org>,
	Junio C Hamano <junkio@cox.net>,
	git mailing list <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7vpsqp905i.fsf@assigned-by-dhcp.cox.net>
Organisation: Gentoo Foundation, Inc.
User-Agent: mutt-ng/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9676>


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 01, 2005 at 12:17:13 -0700, Junio C Hamano wrote:
 > Elfyn McBratney <beu@gentoo.org> writes:
 >=20
 > > which I'm guessing isn't expected behaviour ;)  `git status` does the
 > > same, FWIW.
 >=20
 > Yes, I noticed 'git status' did it that some time ago, and I
 > thought "gee, that was ugly".  But then I imagined what any
 > other realist maintainer would have said if I reported it as a
 > bug.
 >=20
 >     Lbh xabj lbh'ir whfg perngrq lbhe ercb naq vg vf rzcgl.
 >     Jung qvq lbh rkcrpg sebz 'fgnghf' bhgchg?  Jub pnerf!  Naq
 >     ubj bsgra jbhyq lbh rkcrpg gb eha 'tvg fgnghf' va n arjyl
 >     perngrq ercbfvgbel sebz abj ba, abj lbh xabj jung lbh jbhyq
 >     frr?  Trg hfrq gb vg.
 >=20
 > But I fixed it anyway, exactly a month ago.
 >=20
 >=20
 > -
 > To unsubscribe from this list: send the line "unsubscribe git" in
 > the body of a message to majordomo@vger.kernel.org
 > More majordomo info at  http://vger.kernel.org/majordomo-info.html
 >=20

Hehe - cool, thanks. :)

Best,
Elfyn

--=20
Elfyn McBratney
Gentoo Developer/Perl Team Lead
beu/irc.freenode.net                            http://dev.gentoo.org/~beu/
+------------O.o--------------------- http://dev.gentoo.org/~beu/pubkey.asc

PGP Key ID: 0x69DF17AD
PGP Key Fingerprint:
  DBD3 B756 ED58 B1B4 47B9  B3BD 8D41 E597 69DF 17AD

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDQn1+jUHll2nfF60RAl4sAJ4kWIuhi47ennhu9201HEB73/29XwCgovDK
lz/8NJnw20E7gBAz8nCO8Lo=
=hTIL
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
