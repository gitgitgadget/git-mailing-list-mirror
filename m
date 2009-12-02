From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [BUG?] git-merge appends extra string to user's message?
Date: Wed, 2 Dec 2009 18:13:02 +0100
Message-ID: <20091202171302.GZ31763@genesis.frugalware.org>
References: <20091202192030.6117@nanako3.lavabit.com>
 <7veindi9pe.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xwxKudPUn/iIKJJG"
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 18:13:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFslJ-0000Co-HM
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 18:13:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755227AbZLBRM6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 12:12:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755188AbZLBRM5
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 12:12:57 -0500
Received: from virgo.iok.hu ([212.40.97.103]:48592 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755187AbZLBRM5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 12:12:57 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 7BE805809B;
	Wed,  2 Dec 2009 18:13:03 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 7B1CE42F0A;
	Wed,  2 Dec 2009 18:13:02 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 51CAF1240011; Wed,  2 Dec 2009 18:13:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7veindi9pe.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134355>


--xwxKudPUn/iIKJJG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 02, 2009 at 09:09:49AM -0800, Junio C Hamano <gitster@pobox.com> wrote:
> I am still in favor, and I think we should do this change.  I know Miklos
> said it is intentional, but I think he merely means "The version rewritten
> in C does so intentionally because the version before rewrite did so", not
> necessarily because "the version before rewrite did so intentionally with
> good reasons."

Exactly.

> How does this look?

Looks fine.

--xwxKudPUn/iIKJJG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAksWoB4ACgkQe81tAgORUJbuHwCfeAQEfD276JdsaVetqqadGtHb
7Q4An2sUCLGYwdS27Pa6iFFFtDTcdGYa
=Hl2n
-----END PGP SIGNATURE-----

--xwxKudPUn/iIKJJG--
