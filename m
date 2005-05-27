From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: More gitweb queries..
Date: Fri, 27 May 2005 21:29:41 +0200
Message-ID: <20050527192941.GE7068@cip.informatik.uni-erlangen.de>
References: <Pine.LNX.4.58.0505271145570.17402@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kay Sievers <kay.sievers@vrfy.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 27 21:34:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbkZ1-00050k-W7
	for gcvg-git@gmane.org; Fri, 27 May 2005 21:32:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262556AbVE0Tdx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 15:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261969AbVE0Tbj
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 15:31:39 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:49843 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262557AbVE0T3s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2005 15:29:48 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j4RJTgS8004565
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 27 May 2005 19:29:42 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j4RJTfoD004564;
	Fri, 27 May 2005 21:29:41 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Kay Sievers <kay.sievers@vrfy.org>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505271145570.17402@ppc970.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

> I get the urge to do octopus-merges in the kernel just because of how
> good they look in gitk ;) ]

talking about octopus-merges ... I don't understand how they work. What
happens if one file is touched in every of the 8 trees. How can that be
handled?

	Thomas
