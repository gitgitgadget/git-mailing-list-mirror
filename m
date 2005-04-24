From: Fabian Franz <FabianFranz@gmx.de>
Subject: Re: [RFC] Design of name-addressed data portion
Date: Mon, 25 Apr 2005 00:58:13 +0200
Message-ID: <200504250058.15901.FabianFranz@gmx.de>
References: <Pine.LNX.4.21.0504241336250.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Mon Apr 25 00:57:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPq2Q-000191-2y
	for gcvg-git@gmane.org; Mon, 25 Apr 2005 00:57:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262473AbVDXXCL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 19:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262474AbVDXXCL
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 19:02:11 -0400
Received: from imap.gmx.net ([213.165.64.20]:26314 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262473AbVDXXCI (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Apr 2005 19:02:08 -0400
Received: (qmail invoked by alias); 24 Apr 2005 23:02:05 -0000
Received: from p54A3E391.dip.t-dialin.net (EHLO ff.cornils.net) [84.163.227.145]
  by mail.gmx.net (mp017) with SMTP; 25 Apr 2005 01:02:05 +0200
X-Authenticated: #590723
To: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
User-Agent: KMail/1.5.4
In-Reply-To: <Pine.LNX.4.21.0504241336250.30848-100000@iabervon.org>
Content-Description: clearsigned data
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am Sonntag, 24. April 2005 20:17 schrieb Daniel Barkalow:
> I'd propose the following structure:
>
> [...]
>    tags/     the tags
>      ...     files with the symbolic name of the tags, containing the hash

Couldn't you use symbolic or hard links here and in references/?

cu

Fabian
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFCbCSHI0lSH7CXz7MRAmPDAJ95YVHaGWH3KIMhOrw035cAUZd+QgCfZqFa
8IAfnNgc8P6cx+W2+xNJ0P0=
=WGC/
-----END PGP SIGNATURE-----

