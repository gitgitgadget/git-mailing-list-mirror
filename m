From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: collapsing commits with rebase
Date: Thu, 8 Jan 2009 03:32:24 +0100
Message-ID: <20090108023224.GU21154@genesis.frugalware.org>
References: <93c3eada0901071608r190a723bma502b68c4ab81a08@mail.gmail.com> <200901072011.37299.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uuwlSTc/3kiP/jew"
Cc: geoffrey.russell@gmail.com, git@vger.kernel.org
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Thu Jan 08 03:33:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKkiX-0000M7-9r
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 03:33:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752350AbZAHCc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 21:32:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752213AbZAHCc0
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 21:32:26 -0500
Received: from virgo.iok.hu ([212.40.97.103]:37846 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751750AbZAHCc0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 21:32:26 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 1E7D0580A6;
	Thu,  8 Jan 2009 03:32:26 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 9E5084465E;
	Thu,  8 Jan 2009 03:32:24 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 60AEA11B8630; Thu,  8 Jan 2009 03:32:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <200901072011.37299.bss@iguanasuicide.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104875>


--uuwlSTc/3kiP/jew
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 07, 2009 at 08:11:32PM -0600, "Boyd Stephen Smith Jr." <bss@iguanasuicide.net> wrote:
> git merge -s sha(D)

You probably mean --squash here, -s stands for --strategy - and I *hope*
you don't have git-sha(D) in your PATH, as a custom merge strategy. ;-)

--uuwlSTc/3kiP/jew
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkllZbgACgkQe81tAgORUJaaXgCfTJKoYSJCwIe9QCBQ7ivfwnUH
zIUAn0lEJ9CiIJkzjBdfAcj3e0aj/VtJ
=oJGZ
-----END PGP SIGNATURE-----

--uuwlSTc/3kiP/jew--
