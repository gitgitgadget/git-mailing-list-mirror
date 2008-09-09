From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] t7501: always use test_cmp instead of diff
Date: Wed, 10 Sep 2008 01:49:24 +0200
Message-ID: <20080909234924.GN4829@genesis.frugalware.org>
References: <1221003666-17115-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ucgz5Oc/kKURWzXs"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 10 01:50:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdCyM-00005O-Ey
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 01:50:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbYIIXtF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 19:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751537AbYIIXtE
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 19:49:04 -0400
Received: from virgo.iok.hu ([193.202.89.103]:47388 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751013AbYIIXtE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 19:49:04 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 66BEB1B2508;
	Wed, 10 Sep 2008 01:49:01 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 4289E4465E;
	Wed, 10 Sep 2008 01:49:00 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 3DDDE119019E; Wed, 10 Sep 2008 01:49:24 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1221003666-17115-1-git-send-email-vmiklos@frugalware.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95466>


--Ucgz5Oc/kKURWzXs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 10, 2008 at 01:41:06AM +0200, Miklos Vajna <vmiklos@frugalware.org> wrote:
> This should make the output more readable (by default using diff -u)
> when some tests fail.

Sorry for the duplication, I didn't want to send it twice. I also just
realised after sending that I forgot to rebase it again current master,
where git-rev-list is replaced by git rev-list, but I guess git am -3
handles it. ;-)

--Ucgz5Oc/kKURWzXs
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkjHC4QACgkQe81tAgORUJZBygCgiIl1C2QbmOyZJphdZFrBHARs
FlwAnjCiYhnfqlZY8wg2vhZ7PStjJOuy
=2n5c
-----END PGP SIGNATURE-----

--Ucgz5Oc/kKURWzXs--
