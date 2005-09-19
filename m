From: jepler@unpythonic.net
Subject: Re: Why does git-core 0.99.7 require python 2.4?
Date: Mon, 19 Sep 2005 18:17:07 -0500
Message-ID: <20050919231704.GA19276@unpythonic.net>
References: <432F0C66.7060402@zytor.com> <20050919200222.GA11322@c165.ib.student.liu.se> <7vslw0lqvd.fsf@assigned-by-dhcp.cox.net> <432F26E9.9090707@zytor.com> <7v7jdclpme.fsf@assigned-by-dhcp.cox.net> <432F3253.3070201@zytor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Cc: Junio C Hamano <junkio@cox.net>,
	Fredrik Kuivinen <freku045@student.liu.se>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 20 01:17:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHUst-0003JN-Pe
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 01:17:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932637AbVISXRL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 19:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932654AbVISXRK
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 19:17:10 -0400
Received: from craie.unpythonic.net ([206.222.212.219]:9128 "EHLO
	craie.unpythonic.net") by vger.kernel.org with ESMTP
	id S932648AbVISXRJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2005 19:17:09 -0400
Received: by craie.unpythonic.net (Postfix, from userid 405)
	id 0C98D5DC16E; Mon, 19 Sep 2005 18:17:08 -0500 (CDT)
To: "H. Peter Anvin" <hpa@zytor.com>
Content-Disposition: inline
In-Reply-To: <432F3253.3070201@zytor.com>
User-Agent: Mutt/1.4.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8922>


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

It looks like Python2.4's subprocess module is pure Python, and works
with python2.3.

Could subprocess.py just be included in git?

Jeff

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFDL0bwJd01MZaTXX0RAq+YAJ9QsBQLq3TQrLsqiVuGrVH75hSHNACfTzFt
LYuoo4vmz/xhkNIr+RvGxIc=
=wWL7
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
