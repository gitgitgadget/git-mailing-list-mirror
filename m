From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Joining cg-*-id
Date: Wed, 21 Sep 2005 07:51:33 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509210750060.2553@g5.osdl.org>
References: <1127166049.26772.26.camel@dv> <20050919215608.GA13845@pasky.or.cz>
 <Pine.LNX.4.58.0509191505470.2553@g5.osdl.org> <20050919225422.GG18320@pasky.or.cz>
 <Pine.LNX.4.58.0509191746130.2553@g5.osdl.org> <20050920135735.GC1884@pasky.or.cz>
 <Pine.LNX.4.58.0509200734440.2553@g5.osdl.org> <20050920150719.GB1836@pasky.or.cz>
 <Pine.LNX.4.58.0509200906120.2553@g5.osdl.org> <Pine.LNX.4.58.0509201224360.2553@g5.osdl.org>
 <17201.14169.150101.991868@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>,
	Pavel Roskin <proski@gnu.org>, fonseca@diku.dk,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 21 16:57:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EI5xA-00035v-Of
	for gcvg-git@gmane.org; Wed, 21 Sep 2005 16:52:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751036AbVIUOwF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Sep 2005 10:52:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751042AbVIUOwF
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Sep 2005 10:52:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60607 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751036AbVIUOwD (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Sep 2005 10:52:03 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8LEpbBo027327
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 21 Sep 2005 07:51:37 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8LEpXxW009628;
	Wed, 21 Sep 2005 07:51:35 -0700
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17201.14169.150101.991868@cargo.ozlabs.ibm.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.117 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9048>



On Wed, 21 Sep 2005, Paul Mackerras wrote:
> 
> Can you still replicate the problem with an unmodified gitk?

Oooh. I can't. Very strange. I definitely could yesterday:  
"--since=yesterday" worked, but "--since='1 week ago'" didn't.

Magic. Maybe I mistyped something.

		Linus
