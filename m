From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] Add testcase for merge.log
Date: Mon, 14 Jul 2008 14:06:30 +0200
Message-ID: <20080714120630.GN10347@genesis.frugalware.org>
References: <7v7ibuqisc.fsf@gitster.siamese.dyndns.org> <1215678742-14042-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qojgPxTeg8qiMNPS"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 14:07:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIMq2-0006ZZ-Pr
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 14:07:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbYGNMGc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 08:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbYGNMGc
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 08:06:32 -0400
Received: from virgo.iok.hu ([193.202.89.103]:59115 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751001AbYGNMGc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 08:06:32 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 20A581B2509;
	Mon, 14 Jul 2008 14:06:31 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id CF8E44465E;
	Mon, 14 Jul 2008 13:30:20 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id E035111901B3; Mon, 14 Jul 2008 14:06:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1215678742-14042-1-git-send-email-vmiklos@frugalware.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88416>


--qojgPxTeg8qiMNPS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2008 at 10:32:22AM +0200, Miklos Vajna <vmiklos@frugalware.=
org> wrote:
> On Thu, Jul 10, 2008 at 12:50:59AM -0700, Junio C Hamano <gitster@pobox.c=
om> wrote:
> > The command forgot the configuration variable when rewritten in C.
>=20
> Thanks. Here is a testcase.

As far as I see this has been forgotten. Should I resend it on top of
current mv/merge-in-c?

Thanks.

--qojgPxTeg8qiMNPS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkh7QUYACgkQe81tAgORUJYVsACfSax/II5Hcm7vIDekBWoPxK7x
Ej8AmgOBJe2Qi/VkDFyRWvhMIYFuAVru
=inJ3
-----END PGP SIGNATURE-----

--qojgPxTeg8qiMNPS--
