From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: how do I merge completely unrelated repositories ?
Date: Thu, 26 Jun 2008 11:45:22 +0200
Message-ID: <20080626094522.GA29404@genesis.frugalware.org>
References: <46d6db660806260239xc57ffaag6469967ae2257cb1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vPBVJJIgwluSVH2g"
Cc: Git Mailing List <git@vger.kernel.org>
To: Christian MICHON <christian.michon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 11:46:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBo3Z-00078I-Av
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 11:46:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752800AbYFZJpZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 05:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754210AbYFZJpZ
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 05:45:25 -0400
Received: from virgo.iok.hu ([193.202.89.103]:33022 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751661AbYFZJpY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 05:45:24 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 454391B2518;
	Thu, 26 Jun 2008 11:45:23 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 50D9144697;
	Thu, 26 Jun 2008 11:19:27 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 0C919177001C; Thu, 26 Jun 2008 11:45:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <46d6db660806260239xc57ffaag6469967ae2257cb1@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86424>


--vPBVJJIgwluSVH2g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 26, 2008 at 11:39:37AM +0200, Christian MICHON <christian.michon@gmail.com> wrote:
> How would you do it, since merge will not merge if it cannot find a
> common ancestor ?

Did you try so?

If there are no conflicting paths then a simple

git pull /path/to/other/repo.git master

or similar should work.

--vPBVJJIgwluSVH2g
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhjZTIACgkQe81tAgORUJbQ8gCfVmn+KP6pevYZHgiZpYPRwa9V
Di4AniUpnTFEYilm22BDalTlIPUQN8ag
=3S+D
-----END PGP SIGNATURE-----

--vPBVJJIgwluSVH2g--
