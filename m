From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH] Use git-tag in git-cvsimport
Date: Mon, 4 Jun 2007 09:18:11 +0200
Message-ID: <20070604071810.GD16637@admingilde.org>
References: <11808537962798-git-send-email-el@prans.net> <20070603225354.GB16637@admingilde.org> <7vabvgmvuo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="osDK9TLjxFScVI/L"
Cc: Elvis Pranskevichus <el@prans.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 04 09:18:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hv6pa-00037O-1b
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 09:18:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751871AbXFDHSP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 03:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751940AbXFDHSP
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 03:18:15 -0400
Received: from mail.admingilde.org ([213.95.32.147]:57675 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751871AbXFDHSP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 03:18:15 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1Hv6pP-0006AW-70; Mon, 04 Jun 2007 09:18:11 +0200
Content-Disposition: inline
In-Reply-To: <7vabvgmvuo.fsf@assigned-by-dhcp.cox.net>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49072>


--osDK9TLjxFScVI/L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Sun, Jun 03, 2007 at 05:01:03PM -0700, Junio C Hamano wrote:
> Martin Waitz <tali@admingilde.org> writes:
> > but lightweight tags are not fetched by default.
>=20
> Are you sure about that?

not any more now that you questioned it ;-)

But at least there is a hook script which refuses to receive
un-annotated tags and I always considered those tags to be temporary
tags in the local repository.

--=20
Martin Waitz

--osDK9TLjxFScVI/L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGY7yyj/Eaxd/oD7IRAp6NAJ91J5OJ4SMtDPV9aGYfL6mwOdEWdACeLa1B
HHSlv5G6zmoewtbJcRUaWJY=
=t7Gi
-----END PGP SIGNATURE-----

--osDK9TLjxFScVI/L--
