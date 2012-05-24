From: Nicolas <sanpi@homecomputing.fr>
Subject: [stgit] Play with patch remotely
Date: Thu, 24 May 2012 15:58:07 +0200
Message-ID: <20120524135807.GB1016@homecomputing.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZfOjI3PrQbgiZnxM"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 24 16:04:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXYeK-0000DT-GQ
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 16:04:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756159Ab2EXOEM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 10:04:12 -0400
Received: from homecomputing.fr ([88.185.228.16]:56116 "EHLO homecomputing.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754233Ab2EXOEL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 10:04:11 -0400
X-Greylist: delayed 361 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 May 2012 10:04:11 EDT
Received: by homecomputing.fr (Postfix, from userid 1000)
	id 99006FA8B; Thu, 24 May 2012 15:58:07 +0200 (CEST)
Content-Disposition: inline
X-URL: http://sanpi.homecomputing.fr
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198375>


--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

I discover stgit and I would like export the patchs with the sources.

I try to push the master.stgit branch but clone the remote repository doesn't
works:

    $ git clone git@homecomputing.fr:coding-rules.git
    $ cd coding-rules
    $ git branch
    * master
      master.stgit
    $ stg series
    stg series: master: branch not initialized
    $ stg branch
    master

Have you an idea?

Thank's in advance.

Best regards.
Nicolas.

--ZfOjI3PrQbgiZnxM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQEcBAEBAgAGBQJPvj5vAAoJEAbXGiR4Uy6SiT4H/2qmKjXWC22zpW3YHtTzk9Kf
9Q1cw8Adr/yYHUFGGh7nH+ZMv23MgID4x9A+TXsTUmhpSim4Mcke4LtJYd188bCp
ntKoWy2G/7RSn67hOcO9bNmqKoJAMk0RGNE2nAbyGtXfi1RgTe/YbCIpa0WstDtt
IhtBaUAbx0ywx1fPyPhqVhkEvKLfhZdOdmpAGS1ZfohpS7E98+q0cfC8Y4cFTi7F
QEapGfb4R67sGkx9xgjfdKqkDiz8X23O4XVPWNWAbj9BbdW12Q9Do5TsVWaIgTdE
BnjrQ5QKDJRv+OOZKkdbbcJe3JOtCyZjjbw/n1boovyvMT1bkDL0WAlyN37gq0Q=
=22YB
-----END PGP SIGNATURE-----

--ZfOjI3PrQbgiZnxM--
