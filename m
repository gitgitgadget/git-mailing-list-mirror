From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: [PATCH] Add -O<orderfile> option to diff-* brothers.
Date: Sat, 28 May 2005 13:19:59 +0200
Message-ID: <20050528111959.GA28780@cip.informatik.uni-erlangen.de>
References: <7vzmufwu8w.fsf@assigned-by-dhcp.cox.net> <20050528111238.GA1036@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 28 13:19:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbzL3-0007px-Ey
	for gcvg-git@gmane.org; Sat, 28 May 2005 13:18:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262704AbVE1LUm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 28 May 2005 07:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262703AbVE1LUm
	(ORCPT <rfc822;git-outgoing>); Sat, 28 May 2005 07:20:42 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:42406 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262705AbVE1LUF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2005 07:20:05 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j4SBJxS8001425
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 28 May 2005 11:20:00 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j4SBJxeH001424;
	Sat, 28 May 2005 13:19:59 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20050528111238.GA1036@pasky.ji.cz>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

> Hmm, is this really useful in practice? diff itself doesn't appear to
> have it either, and I haven't seen something like this before. So is it
> worth the code?

I think it is. For example on git development it is nice to see the
Documentation first. So you know what it is supposed to do and later you
see the actual implementation. I think Junio requested this exactly
before.

	Thoms
