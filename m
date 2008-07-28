From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH 6/6] Add a new test for using a custom merge strategy
Date: Tue, 29 Jul 2008 01:58:47 +0200
Message-ID: <20080728235847.GR32057@genesis.frugalware.org>
References: <cover.1217288180.git.vmiklos@frugalware.org> <f3af7df2dda2dcb7801314cc993470264259f970.1217288180.git.vmiklos@frugalware.org> <alpine.DEB.1.00.0807290153300.2725@eeepc-johanness>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a44Z7v/T0/yhdW//"
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 29 01:59:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNcd8-0000pP-PH
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 01:59:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752073AbYG1X6t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 19:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752069AbYG1X6t
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 19:58:49 -0400
Received: from virgo.iok.hu ([193.202.89.103]:58857 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751847AbYG1X6s (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 19:58:48 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 950DD1B2526;
	Tue, 29 Jul 2008 01:58:47 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 24D954465E;
	Tue, 29 Jul 2008 01:14:25 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 75F461190A0A; Tue, 29 Jul 2008 01:58:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807290153300.2725@eeepc-johanness>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90530>


--a44Z7v/T0/yhdW//
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2008 at 01:54:17AM +0200, Johannes Schindelin <Johannes.Sch=
indelin@gmx.de> wrote:
> Actually, this _is_ the opposite of -s ours, no?  -s ours just takes our=
=20
> tree, your -s theirs just takes their tree.
>=20
> Sorry for the confusion I caused,

Aah. :-)

I did not read the source of git-merge-ours and based on your
description I thought my knowledge / the doc about -s ours was not
correct.

So I guess my original patch was right, then.

Note to self: "take 2" gets messy, time to send a "take 3" soon. ;-)

--a44Z7v/T0/yhdW//
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiOXTcACgkQe81tAgORUJYqKwCdE+rPTFUqgS3US3yk0JmntsLx
R3EAn2c9+9GBKA3I6oYVxoXSlRrFDUhM
=0D47
-----END PGP SIGNATURE-----

--a44Z7v/T0/yhdW//--
