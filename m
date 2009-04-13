From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] builtin-merge: fix a typo in an error message
Date: Tue, 14 Apr 2009 01:12:50 +0200
Message-ID: <20090413231250.GA16990@genesis.frugalware.org>
References: <20090413181008.GA8273@linux.vnet>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v15hXiddb3kq3Bam"
Cc: git@vger.kernel.org
To: Allan Caffee <allan.caffee@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 14 01:14:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtVMF-0000Gw-Js
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 01:14:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753126AbZDMXMy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 19:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752836AbZDMXMx
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 19:12:53 -0400
Received: from virgo.iok.hu ([212.40.97.103]:35391 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751084AbZDMXMx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 19:12:53 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id A0ADA580B5;
	Tue, 14 Apr 2009 01:12:50 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 3FAEB5422F;
	Tue, 14 Apr 2009 01:12:50 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 1EA2311F0829; Tue, 14 Apr 2009 01:12:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20090413181008.GA8273@linux.vnet>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116501>


--v15hXiddb3kq3Bam
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 13, 2009 at 02:10:08PM -0400, Allan Caffee <allan.caffee@gmail.com> wrote:
> -		die("Could open %s for writing", git_path("MERGE_MSG"));
> +		die("Could not open %s for writing", git_path("MERGE_MSG"));

Acked-by: Miklos Vajna <vmiklos@frugalware.org>

Thanks.

PS: Please use 'unset followup_to' when sending messages to the git
list, see
http://thread.gmane.org/gmane.comp.version-control.git/83140/focus=83234.

--v15hXiddb3kq3Bam
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAknjxvIACgkQe81tAgORUJbYZACdGc8gBgoepdMb2aV0kIlcogwS
UOEAniYqJZ1QOkXUk26U9DVcGBTFFOcM
=yFdW
-----END PGP SIGNATURE-----

--v15hXiddb3kq3Bam--
