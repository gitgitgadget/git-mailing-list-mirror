From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: How to edit commit messages?
Date: Tue, 12 Aug 2008 14:45:57 +0200
Message-ID: <20080812124557.GB18960@genesis.frugalware.org>
References: <g7s088$o1p$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y5yQnZmVlpWlTeDv"
Cc: git@vger.kernel.org
To: dr.chiarello@gmail.com
X-From: git-owner@vger.kernel.org Tue Aug 12 14:47:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KStH8-0000vA-P7
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 14:46:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752273AbYHLMp7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 08:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752237AbYHLMp7
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 08:45:59 -0400
Received: from virgo.iok.hu ([193.202.89.103]:35080 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752175AbYHLMp6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 08:45:58 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 8BA7B1B251D;
	Tue, 12 Aug 2008 14:45:57 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id B86054465E;
	Tue, 12 Aug 2008 13:53:38 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 5BD201190002; Tue, 12 Aug 2008 14:45:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <g7s088$o1p$1@ger.gmane.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92092>


--y5yQnZmVlpWlTeDv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 12, 2008 at 02:38:32PM +0200, dr.chiarello@gmail.com wrote:
> 1) interactively edit commit's messages (some or all)

git rebase -i

> 2) batch edit commit's messages (for example using sed)

git filter-branch

--y5yQnZmVlpWlTeDv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkihhgUACgkQe81tAgORUJY1/wCcCl//ARrTh+trBjSrqs/943nc
wL0AnRZiGR2CmyLZgzKCCUox0yF/PxPi
=IoGr
-----END PGP SIGNATURE-----

--y5yQnZmVlpWlTeDv--
