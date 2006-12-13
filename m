X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Martin Waitz <tali@admingilde.org>
Subject: Re: git-pull: "Cannot obtain needed none"?
Date: Wed, 13 Dec 2006 09:22:07 +0100
Message-ID: <20061213082207.GB7413@admingilde.org>
References: <81b0412b0612120943i48c8597u32d0300cbbd7b3e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l76fUT7nc3MelDdI"
NNTP-Posting-Date: Wed, 13 Dec 2006 08:57:04 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Greylist: delayed 2082 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 03:56:51 EST
Content-Disposition: inline
In-Reply-To: <81b0412b0612120943i48c8597u32d0300cbbd7b3e8@mail.gmail.com>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34187>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuPv8-0001hF-Fi for gcvg-git@gmane.org; Wed, 13 Dec
 2006 09:56:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932621AbWLMI4v (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 03:56:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932623AbWLMI4v
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 03:56:51 -0500
Received: from mail.admingilde.org ([213.95.32.147]:33214 "EHLO
 mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932621AbWLMI4v (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006
 03:56:51 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1) id
 1GuPNP-0007qz-6m; Wed, 13 Dec 2006 09:22:07 +0100
To: Alex Riesen <raa.lkml@gmail.com>
Sender: git-owner@vger.kernel.org


--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Tue, Dec 12, 2006 at 06:43:48PM +0100, Alex Riesen wrote:
> error: Unable to find 9a6e87b60dbd2305c95cecce7d9d60f849a0658d under
> http://www.kernel.org/pub/scm/git/git.git/
> Cannot obtain needed none 9a6e87b60dbd2305c95cecce7d9d60f849a0658d
> while processing commit 0000000000000000000000000000000000000000.

Yesterday I noticed the exact same message, but with a different sha1, in
the logs of my script which updated the linux kernel repository at work.
I did not have the time to track it down and today everything worked as
normal again.

--=20
Martin Waitz

--l76fUT7nc3MelDdI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFf7gvj/Eaxd/oD7IRAmAvAJ9EXPCOnnEXJL9IBefXA9acrk7drgCdH17n
wrm07SFL61HDtSVjN28v+xk=
=jCMy
-----END PGP SIGNATURE-----

