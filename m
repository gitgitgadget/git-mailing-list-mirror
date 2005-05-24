From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: gitweb wishlist
Date: Tue, 24 May 2005 23:52:38 +0200
Message-ID: <20050524215238.GG25606@cip.informatik.uni-erlangen.de>
References: <Pine.LNX.4.58.0505240110580.2307@ppc970.osdl.org> <20050524161745.GA9537@cip.informatik.uni-erlangen.de> <Pine.LNX.4.58.0505240929051.2307@ppc970.osdl.org> <Pine.LNX.4.58.0505240943080.2307@ppc970.osdl.org> <Pine.LNX.4.58.0505241017510.2307@ppc970.osdl.org> <20050524184612.GA23637@cip.informatik.uni-erlangen.de> <Pine.LNX.4.58.0505241236020.2307@ppc970.osdl.org> <Pine.LNX.4.58.0505241259250.2307@ppc970.osdl.org> <20050524202846.GC25606@cip.informatik.uni-erlangen.de> <Pine.LNX.4.58.0505241345280.2307@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Mansfield <david@cobite.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kay Sievers <kay.sievers@vrfy.org>, Petr Baudis <pasky@ucw.cz>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 24 23:53:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DahJO-0003tK-LZ
	for gcvg-git@gmane.org; Tue, 24 May 2005 23:51:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262206AbVEXVw4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 May 2005 17:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262202AbVEXVw4
	(ORCPT <rfc822;git-outgoing>); Tue, 24 May 2005 17:52:56 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:42926 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262206AbVEXVwr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 May 2005 17:52:47 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j4OLqdS8006808
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 24 May 2005 21:52:39 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j4OLqcui006807;
	Tue, 24 May 2005 23:52:39 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	David Mansfield <david@cobite.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kay Sievers <kay.sievers@vrfy.org>, Petr Baudis <pasky@ucw.cz>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505241345280.2307@ppc970.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

> Ahh, the mutt people really use something else for development, and this 
> is just an export into CVS (like the Linux bkcvs tree)? Or do they just 
> have fast machines and no networking? Or are there good versions of CVS 
> around that re-use the same time across one whole commit?

I did one sampling and though it would be representative which it isn't.
What I don't understand why noone ever fixed this? cvs has its own rcs
implementation anyway to speed things up, hasn't it?

	Thomas
