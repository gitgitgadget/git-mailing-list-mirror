From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH] gitweb: make leftmost column of blame less cluttered.
Date: Tue, 3 Oct 2006 21:20:18 +0200
Message-ID: <20061003192018.GR2871@admingilde.org>
References: <7vwt7k4clr.fsf@assigned-by-dhcp.cox.net> <20061002192930.86293.qmail@web31803.mail.mud.yahoo.com> <7vpsdat4ia.fsf@assigned-by-dhcp.cox.net> <7vmz8dsvwm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7vAdt9JsdkkzRPKN"
Cc: ltuikov@yahoo.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 03 21:20:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUpoY-0001YJ-Sl
	for gcvg-git@gmane.org; Tue, 03 Oct 2006 21:20:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030501AbWJCTUW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Oct 2006 15:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030502AbWJCTUW
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Oct 2006 15:20:22 -0400
Received: from agent.admingilde.org ([213.95.21.5]:13769 "EHLO
	mail.admingilde.org") by vger.kernel.org with ESMTP
	id S1030501AbWJCTUU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Oct 2006 15:20:20 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1GUpoQ-0005KH-T4; Tue, 03 Oct 2006 21:20:18 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vmz8dsvwm.fsf@assigned-by-dhcp.cox.net>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28291>


--7vAdt9JsdkkzRPKN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Tue, Oct 03, 2006 at 12:25:45AM -0700, Junio C Hamano wrote:
> [PATCH] gitweb: make leftmost column of blame less cluttered.
>=20
> Instead of labelling each and every line with clickable commit
> object name, this makes the blame output to show them only on
> the first line of each group of lines from the same revision.
>=20
> Also it makes mouse-over to show the minimum authorship and
> authordate information for extra cuteness ;-).

what about making the line itself clickable and adding the
mouse-over there, too?
Then you don't need to worry about repeating the commit id,
and perhaps it is not even needed any more?

--=20
Martin Waitz

--7vAdt9JsdkkzRPKN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFIrfyj/Eaxd/oD7IRAs6DAKCAZRto0/8cA0fNx96qIgX+ld9wzwCfee20
tt4Jhmw6mgUY7tMbLtrCSeE=
=wBg/
-----END PGP SIGNATURE-----

--7vAdt9JsdkkzRPKN--
