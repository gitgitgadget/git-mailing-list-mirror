From: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
Subject: gitweb / kernel.org
Date: Thu, 12 Oct 2006 23:08:21 +0200
Message-ID: <20061012210821.GB4813@schottelius.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s/l3CgOIzMHHjg/5"
X-From: git-owner@vger.kernel.org Thu Oct 12 23:49:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GY7nJ-00063V-DN
	for gcvg-git@gmane.org; Thu, 12 Oct 2006 23:08:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbWJLVI0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Oct 2006 17:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750938AbWJLVIZ
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Oct 2006 17:08:25 -0400
Received: from gw.ptr-62-65-141-133.customer.ch.netstream.com ([62.65.141.133]:31503
	"HELO schottelius.org") by vger.kernel.org with SMTP
	id S1750945AbWJLVIY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Oct 2006 17:08:24 -0400
Received: (qmail 4954 invoked by uid 1000); 12 Oct 2006 21:08:21 -0000
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: echo $message | gpg -e $sender  -s | netcat mailhost 25
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux 2.6.18-1-486
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28800>


--s/l3CgOIzMHHjg/5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hoi!

Just interested, what's the reason that gitweb is extremly slow
on kernel.org?

Just asking because when I see no problem at
http://unix.schottelius.org/cgi-bin/gitweb.cgi on my
dual xeon 2.4ghz / 1 GiB ram / 100Mbit inet / lighttpd 1.4.13.

Yes, I'll have some thousand less hits than kernel.org, but
simulating load with ab does not show any problem either.

Just interested, what the bottleneck is.

Sincerly

Nico

--=20
``...if there's one thing about Linux users, they're do-ers, not whiners.''
(A quotation of Andy Patrizio I completely agree with)

--s/l3CgOIzMHHjg/5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFLq7FuL75KpiFGIwRAhubAJ4/AjbXsloKt7g9Jr9WEE++/+4uVACfbbqB
cEzA8GIR/WkbRkychKqS2Mo=
=8n/h
-----END PGP SIGNATURE-----

--s/l3CgOIzMHHjg/5--
