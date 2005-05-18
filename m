From: Petr Baudis <pasky@ucw.cz>
Subject: Re: README rewrite
Date: Thu, 19 May 2005 00:27:26 +0200
Message-ID: <20050518222725.GG10358@pasky.ji.cz>
References: <20050515044244.GA7391@tumblerings.org> <20050515044941.GB7391@tumblerings.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 00:32:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYX3m-0001cu-5V
	for gcvg-git@gmane.org; Thu, 19 May 2005 00:30:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262347AbVERWa2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 May 2005 18:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262404AbVERW16
	(ORCPT <rfc822;git-outgoing>); Wed, 18 May 2005 18:27:58 -0400
Received: from w241.dkm.cz ([62.24.88.241]:36237 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262403AbVERW1c (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 May 2005 18:27:32 -0400
Received: (qmail 14697 invoked by uid 2001); 18 May 2005 22:27:26 -0000
To: Zack Brown <zbrown@tumblerings.org>
Content-Disposition: inline
In-Reply-To: <20050515044941.GB7391@tumblerings.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, May 15, 2005 at 06:49:41AM CEST, I got a letter
where Zack Brown <zbrown@tumblerings.org> told me that...
> Here's an updated patch with fixes, apply instead of the one I just sent:
> 
> Signed-off-by: Zack Brown <zbrown@tumblerings.org>

Thanks. I've used the first part of the rewrite, tweaked it
substantially (I have some reservations about the style and suspicions
regarding the grammar), and somewhat awkwardly merged in the current
stuff missing in the rewrite (cg-diff and such).

I'd prefer the reference documentation in separate Documentation/ files,
much in the style of the GIT documentation.

Thanks again,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
