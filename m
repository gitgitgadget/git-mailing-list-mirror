From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] cg-mkpatch: Show diffstat before the patch
Date: Thu, 28 Apr 2005 02:16:42 +0200
Message-ID: <20050428001642.GU22956@pasky.ji.cz>
References: <20050426225855.GA28560@diku.dk> <20050428.090702.23236031.yoshfuji@linux-ipv6.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: fonseca@diku.dk, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 02:11:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQwcw-0006tE-AX
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 02:11:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbVD1AQu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 20:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262118AbVD1AQu
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 20:16:50 -0400
Received: from w241.dkm.cz ([62.24.88.241]:3502 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262123AbVD1AQn (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 20:16:43 -0400
Received: (qmail 31964 invoked by uid 2001); 28 Apr 2005 00:16:42 -0000
To: "YOSHIFUJI Hideaki / ?$B5HF#1QL@" <yoshfuji@linux-ipv6.org>
Content-Disposition: inline
In-Reply-To: <20050428.090702.23236031.yoshfuji@linux-ipv6.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, Apr 28, 2005 at 02:07:02AM CEST, I got a letter
where "YOSHIFUJI Hideaki / ?$B5HF#1QL@" <yoshfuji@linux-ipv6.org> told me that...
> In article <20050426225855.GA28560@diku.dk> (at Wed, 27 Apr 2005 00:58:55 +0200), Jonas Fonseca <fonseca@diku.dk> says:
> 
> > Show diffstat before the patch.
> 
> We do not always need to generate diffstat.
> Please add -s option or something to prepend diffstat.
> Thanks.

Actually, I've been thinking about something like -s, but as in "short",
which would skip this --- part altogether.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
