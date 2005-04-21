From: Fabian Franz <FabianFranz@gmx.de>
Subject: Re: Pasky problem with 'git init URL'
Date: Thu, 21 Apr 2005 23:57:45 +0200
Message-ID: <200504212357.48483.FabianFranz@gmx.de>
References: <1114100518.17551.31.camel@nosferatu.lan> <20050421202928.GH7443@pasky.ji.cz> <17000.6154.748117.967898@smtp.charter.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Schlemmer <azarah@nosferatu.za.org>,
	GIT Mailing Lists <git@vger.kernel.org>,
	Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Thu Apr 21 23:58:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOjfc-0003w5-0L
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 23:57:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbVDUWBk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 18:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbVDUWBk
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 18:01:40 -0400
Received: from mail.gmx.de ([213.165.64.20]:29127 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261313AbVDUWBi convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2005 18:01:38 -0400
Received: (qmail invoked by alias); 21 Apr 2005 22:01:36 -0000
Received: from p54A3C55B.dip.t-dialin.net (EHLO ff.cornils.net) [84.163.197.91]
  by mail.gmx.net (mp004) with SMTP; 22 Apr 2005 00:01:36 +0200
X-Authenticated: #590723
To: "John Stoffel" <john@stoffel.org>
User-Agent: KMail/1.5.4
In-Reply-To: <17000.6154.748117.967898@smtp.charter.net>
Content-Description: clearsigned data
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am Donnerstag, 21. April 2005 23:15 schrieb John Stoffel:
> >>>>> "Petr" == Petr Baudis <pasky@ucw.cz> writes:
>
> Petr> Perhaps it would be useful to have some "command classes" (with at
> least Petr> cg-*-(add|ls|rm)), like:
>
> Petr> 	cg-branch-ls
> Petr> 	cg-remote-rm
> Petr> 	cg-tag-add
>
> Just speaking of consistency, can we make it so that all the commands
> are just variations with out the damm dashes in them?  

I think the dashes are especially useful, because of "tab-completion".

>   git <objecttype> <command> <args> [<obj> ...]
>

I think thats exactly like above:

cg-<objtype>-<command>

cu

Fabian
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFCaCHbI0lSH7CXz7MRAuSXAJ40v4yNgS13BIExfYTwPv8zbj2HcACdG7G6
YiLFD8u8Guh3xppaa14uD+I=
=dkN/
-----END PGP SIGNATURE-----

