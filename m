X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC/PATCH] Implement poor-man's submodule support using commit hooks
Date: Wed, 20 Dec 2006 16:44:25 +0100
Message-ID: <20061220154424.GS12411@admingilde.org>
References: <200612201309.02119.andyparkins@gmail.com> <20061220133648.GQ12411@admingilde.org> <200612201435.49685.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s9kDAZ2EyO0AcRYa"
NNTP-Posting-Date: Wed, 20 Dec 2006 15:44:37 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200612201435.49685.andyparkins@gmail.com>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34939>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gx3cL-0001Sz-Ce for gcvg-git@gmane.org; Wed, 20 Dec
 2006 16:44:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752708AbWLTPo0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 10:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754807AbWLTPo0
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 10:44:26 -0500
Received: from mail.admingilde.org ([213.95.32.147]:50627 "EHLO
 mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1752708AbWLTPo0 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec 2006
 10:44:26 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1) id
 1Gx3cH-0005Lk-3Y; Wed, 20 Dec 2006 16:44:25 +0100
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org


--s9kDAZ2EyO0AcRYa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Wed, Dec 20, 2006 at 02:35:48PM +0000, Andy Parkins wrote:
> I had a look at that; and my previous objection still applies: it blends =
two=20
> repositories.  I'd rather they were separate.

yes, but one can see what is needed and where the real problems are.

And I really think we should only start adding submodule code to
mainline git when we are sure that we found an approach where we can see
that it works and that we don't have to change it later.

--=20
Martin Waitz

--s9kDAZ2EyO0AcRYa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFiVpYj/Eaxd/oD7IRAk3nAJ4/d5y3J5N6fGpg+pX9TrhuVd/wEQCggtnm
F6jPtvj8UzO4/EPz5bgr86A=
=z0tI
-----END PGP SIGNATURE-----

