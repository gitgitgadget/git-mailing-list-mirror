From: Junio C Hamano <junkio@cox.net>
Subject: Re: Tracking and committing back to Subversion?
Date: Thu, 09 Feb 2006 16:54:58 -0800
Message-ID: <7vk6c43ue5.fsf@assigned-by-dhcp.cox.net>
References: <1138834301.21899.40.camel@wilber.wgtn.cat-it.co.nz>
	<200602040727.30965.linuxfood@linuxfood.net>
	<43E7DA7F.6060503@vilain.net>
	<200602091650.55370.linuxfood@linuxfood.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 01:55:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7MYy-0005Ue-8W
	for gcvg-git@gmane.org; Fri, 10 Feb 2006 01:55:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750917AbWBJAzA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Feb 2006 19:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750919AbWBJAzA
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Feb 2006 19:55:00 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:2206 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1750917AbWBJAzA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2006 19:55:00 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060210005323.EAKA20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 9 Feb 2006 19:53:23 -0500
To: Brian Smith <linuxfood@linuxfood.net>
In-Reply-To: <200602091650.55370.linuxfood@linuxfood.net> (Brian Smith's
	message of "Thu, 9 Feb 2006 16:50:54 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15852>

Brian Smith <linuxfood@linuxfood.net> writes:

> While that is an admirable goal, unless you can point me to something that
> will allow you to actually commit back to SVN without a working copy, it 
> defeats the purpose of my tools which is basically to use to git for the 
> purpose of holding intermediate development before sending it into SVN as a 
> final commit. 

Wouldn't svk (or svl or whatever it is called these days) be a
better match for that kind of "keep my work while disconnected
from master svn repository" purpose?
