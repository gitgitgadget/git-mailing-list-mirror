From: Martin Waitz <tali@admingilde.org>
Subject: Re: Submodule object store
Date: Tue, 27 Mar 2007 16:28:40 +0200
Message-ID: <20070327142840.GN22773@admingilde.org>
References: <20070326183523.GG22773@admingilde.org> <200703262133.44520.Josef.Weidendorfer@gmx.de> <20070326220302.GH22773@admingilde.org> <7vfy7rvct2.fsf@assigned-by-dhcp.cox.net> <20070326231637.GJ22773@admingilde.org> <7vy7ljtwir.fsf@assigned-by-dhcp.cox.net> <20070326233603.GL22773@admingilde.org> <Pine.LNX.4.63.0703261515330.14387@qynat.qvtvafvgr.pbz> <20070326235527.GM22773@admingilde.org> <7vps6vttpq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fDP66DSfTvWAYVew"
Cc: David Lang <david.lang@digitalinsight.com>,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Eric Lesh <eclesh@ucla.edu>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 27 16:28:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWCfJ-00049b-5d
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 16:28:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753883AbXC0O2n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 10:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753888AbXC0O2n
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 10:28:43 -0400
Received: from mail.admingilde.org ([213.95.32.147]:56710 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753883AbXC0O2m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 10:28:42 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1HWCfA-0001rG-Bo; Tue, 27 Mar 2007 16:28:40 +0200
Content-Disposition: inline
In-Reply-To: <7vps6vttpq.fsf@assigned-by-dhcp.cox.net>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43273>


--fDP66DSfTvWAYVew
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Mon, Mar 26, 2007 at 05:29:05PM -0700, Junio C Hamano wrote:
> Martin Waitz <tali@admingilde.org> writes:
> > The separated object store also helps reduce the memory requirement for
> > large pushs/pulls.
>=20
> That's a total bull.  The size of push/pull only depends on how
> you separate set of refs (which affects the traversal hence
> affects the set of objects to be exchanged).

of course you are right.

--=20
Martin Waitz

--fDP66DSfTvWAYVew
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGCSoYj/Eaxd/oD7IRAoPIAJwMWIrce6CKEcJmcgfT98ySjkUosgCfdxwq
jpM2C7DP6q6Y1GLF9bOU6D0=
=ZKzn
-----END PGP SIGNATURE-----

--fDP66DSfTvWAYVew--
