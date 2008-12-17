From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: git-format-patch patch
Date: Wed, 17 Dec 2008 22:55:35 +0100
Message-ID: <20081217215535.GI5691@genesis.frugalware.org>
References: <877i5yy149.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="70fLfmUGd5x0AJTB"
Cc: git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Wed Dec 17 22:57:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LD4O0-0007Ov-Qe
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 22:56:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751661AbYLQVzi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 16:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751584AbYLQVzi
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 16:55:38 -0500
Received: from virgo.iok.hu ([212.40.97.103]:55592 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751489AbYLQVzi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 16:55:38 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 35A0C5809C;
	Wed, 17 Dec 2008 22:55:36 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 175354465E;
	Wed, 17 Dec 2008 22:55:35 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id BB0AB11B862F; Wed, 17 Dec 2008 22:55:35 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <877i5yy149.fsf@jidanni.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103398>


--70fLfmUGd5x0AJTB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 18, 2008 at 04:53:42AM +0800, jidanni@jidanni.org wrote:
> I'm still reading the manpage about submitting proper patches, so for now:

It is not a manual page, it lives under Documentation/SubmittingPatches.

Problems with the current patch:

- It is not a unidiff.

- No signoff

- No commit message

Hope this helps. :)

--70fLfmUGd5x0AJTB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklJdVcACgkQe81tAgORUJYL3wCfcuqkQ0EB2kdJ02Qpp0eAMJPs
zsgAnA76xchyB8enjzDQlD+Lit9DGs98
=rqCv
-----END PGP SIGNATURE-----

--70fLfmUGd5x0AJTB--
