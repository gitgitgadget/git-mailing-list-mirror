From: Petr Baudis <pasky@suse.cz>
Subject: Re: type in cg-merge?
Date: Fri, 11 Nov 2005 11:17:36 +0100
Message-ID: <20051111101736.GK30496@pasky.or.cz>
References: <200511110752.53249.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 11 11:19:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaVya-0008R6-Ra
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 11:17:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbVKKKRj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 05:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbVKKKRj
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 05:17:39 -0500
Received: from w241.dkm.cz ([62.24.88.241]:2518 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751264AbVKKKRi (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Nov 2005 05:17:38 -0500
Received: (qmail 22030 invoked by uid 2001); 11 Nov 2005 11:17:36 +0100
To: Alan Chandler <alan@chandlerfamily.org.uk>
Content-Disposition: inline
In-Reply-To: <200511110752.53249.alan@chandlerfamily.org.uk>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11578>

Dear diary, on Fri, Nov 11, 2005 at 08:52:53AM CET, I got a letter
where Alan Chandler <alan@chandlerfamily.org.uk> said that...
> I am just reading the code in cg-merge to see how it works (taking your advice 
> to see how to re-write my history properly - see early threads about this 
> subject)
> 
> At line there is an echo 0 that looks suspiciously like it should be an exit 
> 0.

You are obviously right. Thanks, fixed.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
