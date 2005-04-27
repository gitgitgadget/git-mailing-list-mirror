From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] cg-mkpatch: Show diffstat before the patch
Date: Thu, 28 Apr 2005 01:55:39 +0200
Message-ID: <20050427235539.GO22956@pasky.ji.cz>
References: <20050426225855.GA28560@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Apr 28 01:50:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQwIS-0004wq-3X
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 01:50:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbVD0Xzn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 19:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262107AbVD0Xzn
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 19:55:43 -0400
Received: from w241.dkm.cz ([62.24.88.241]:40877 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262106AbVD0Xzk (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 19:55:40 -0400
Received: (qmail 27107 invoked by uid 2001); 27 Apr 2005 23:55:39 -0000
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050426225855.GA28560@diku.dk>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Wed, Apr 27, 2005 at 12:58:55AM CEST, I got a letter
where Jonas Fonseca <fonseca@diku.dk> told me that...
> Show diffstat before the patch.
> 
> Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

I think you should first check by which(1) or something whether you have
diffstat. Piling up dependencies like this is pretty annoying.

Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
