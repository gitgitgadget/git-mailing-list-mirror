From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH] Kill the useless progress meter in merge-recursive
Date: Fri, 20 Apr 2007 11:00:10 +0200
Message-ID: <20070420090010.GD27208@admingilde.org>
References: <20070420063718.GA8424@spearce.org> <7vd51z317c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IpbVkmxF4tDyP/Kb"
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Apr 20 11:00:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Heoz3-0003Zl-Sk
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 11:00:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1766684AbXDTJAO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 05:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1766807AbXDTJAO
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 05:00:14 -0400
Received: from mail.admingilde.org ([213.95.32.147]:36241 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1766684AbXDTJAM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2007 05:00:12 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1HeoyQ-0004Nt-CW; Fri, 20 Apr 2007 11:00:10 +0200
Content-Disposition: inline
In-Reply-To: <7vd51z317c.fsf@assigned-by-dhcp.cox.net>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45076>


--IpbVkmxF4tDyP/Kb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Fri, Apr 20, 2007 at 01:21:59AM -0700, Junio C Hamano wrote:
> I would propose removing the progress meter for "Checking out
> files" in unpack-trees, for the same reason.

well, for large trees it is indeed useful, so I'd like to leave it in.

--=20
Martin Waitz

--IpbVkmxF4tDyP/Kb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGKIEaj/Eaxd/oD7IRApIUAJ9X+pLwXK3BgzbJY2tzaTh5WEl7iQCdHp5k
ICZkWjyPxKsS9F/HP8odrWM=
=ZP+E
-----END PGP SIGNATURE-----

--IpbVkmxF4tDyP/Kb--
