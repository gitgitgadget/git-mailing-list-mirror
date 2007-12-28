From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: Committing, pushing and pulling for Multi-GIT-Module project
Date: Fri, 28 Dec 2007 15:49:03 +0100
Message-ID: <20071228144903.GU23659@genesis.frugalware.org>
References: <7bfdc29a0712272343j6c9b460eq97f17cea9f3a9c3b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7kD9y3RnPUgTZee0"
Cc: git@vger.kernel.org
To: Imran M Yousuf <imyousuf@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 28 15:49:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8GWr-0003X8-U6
	for gcvg-git-2@gmane.org; Fri, 28 Dec 2007 15:49:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753615AbXL1OtI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Dec 2007 09:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753159AbXL1OtH
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Dec 2007 09:49:07 -0500
Received: from virgo.iok.hu ([193.202.89.103]:29881 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752841AbXL1OtG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Dec 2007 09:49:06 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id A5D051B24FE;
	Fri, 28 Dec 2007 15:49:03 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 31EBE4466E;
	Fri, 28 Dec 2007 15:47:36 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 377D2176C03D; Fri, 28 Dec 2007 15:49:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7bfdc29a0712272343j6c9b460eq97f17cea9f3a9c3b@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69283>


--7kD9y3RnPUgTZee0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 28, 2007 at 01:43:37PM +0600, Imran M Yousuf <imyousuf@gmail.com> wrote:
> I am working with a multi-git-module project, I was wondering is it
> possible to commit, push and pull all the modules at once?

if you use the term 'module' as 'repo', then yes, you have to do so
individually. (of course you can write a wrapper if you want)

- VMiklos

--7kD9y3RnPUgTZee0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHdQzfe81tAgORUJYRAgZ4AJ90rEBb/5c/9Doy9I7oJLsJA/huBwCghdMS
uy5EO2IACzMHjDOEeK5dP0c=
=skSs
-----END PGP SIGNATURE-----

--7kD9y3RnPUgTZee0--
