From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFC PATCH] Documentation: new upstream rebase recovery section in git-rebase
Date: Wed, 3 Sep 2008 07:38:07 +0200
Message-ID: <200809030738.09589.trast@student.ethz.ch>
References: <1220386721-10215-1-git-send-email-trast@student.ethz.ch> <7vvdxei5wv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart53065106.QjDDQOm4B2";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 03 10:26:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kango-0006MR-Go
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 10:26:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbYICIZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 04:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751435AbYICIZD
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 04:25:03 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:23499 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751239AbYICIZB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 04:25:01 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 3 Sep 2008 10:25:00 +0200
Received: from cx-public-docking-1-043.ethz.ch ([129.132.149.43]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 3 Sep 2008 10:24:59 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <7vvdxei5wv.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 03 Sep 2008 08:24:59.0571 (UTC) FILETIME=[8E08E030:01C90D9E]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94761>

--nextPart53065106.QjDDQOm4B2
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Junio C Hamano wrote:
> Thomas Rast <trast@student.ethz.ch> writes:
> > +HELP, MY UPSTREAM HAS REBASED!
> > +------------------------------
>=20
> I read this section only once, but it looked reasonable as a recovery
> procedure to me.

Thanks a lot for your comments, I will look into the links you gave
me.

It occured to me that rebase's ability to skip existing commits can
effectively replace the entire manual component of finding out when
the topic branch started.  Which makes it far less scary. :-(

Maybe I'll write something about editing with 'rebase -i' instead,
which breaks the automatic skips again.

=2D Thomas

=2D-=20
Thomas Rast
trast@student.ethz.ch


--nextPart53065106.QjDDQOm4B2
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAki+IsEACgkQqUud07tmzP3YOACfSiN/EHA4ZXbV66qJK71MQw7L
3d4AnRDwS0sEFVJ6+PP+dGuEX0pc2mz2
=GIVz
-----END PGP SIGNATURE-----

--nextPart53065106.QjDDQOm4B2--
