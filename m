From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] Make rsh protocol extensible
Date: Thu, 2 Jun 2005 22:59:12 +0200
Message-ID: <20050602205912.GD32189@pasky.ji.cz>
References: <Pine.LNX.4.21.0505190108490.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 02 23:00:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ddwm6-00072Y-Hy
	for gcvg-git@gmane.org; Thu, 02 Jun 2005 22:58:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbVFBVBA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Jun 2005 17:01:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbVFBVAR
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jun 2005 17:00:17 -0400
Received: from w241.dkm.cz ([62.24.88.241]:2007 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261346AbVFBU7P (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jun 2005 16:59:15 -0400
Received: (qmail 9904 invoked by uid 2001); 2 Jun 2005 20:59:12 -0000
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0505190108490.30848-100000@iabervon.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, May 19, 2005 at 07:11:46AM CEST, I got a letter
where Daniel Barkalow <barkalow@iabervon.org> told me that...
> This changes the rsh protocol to allow reporting failure in getting an
> object without breaking the connection, and to allow other types of
> request than for objects to be made. It is a preliminary to any more
> extensive pull operation.
> 
> Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>

I wanted to apply it but then I figured out that I will better hold it
and ask you what do you think about it now after few weeks. ;-) Should I
still go on and apply it to Cogito?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
