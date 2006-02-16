From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Fix for rpm creation
Date: Thu, 16 Feb 2006 17:09:54 +0100
Message-ID: <20060216160953.GU31278@pasky.or.cz>
References: <20060216135100.GR31278@pasky.or.cz> <200602161633.44399.Josef.Weidendorfer@gmx.de> <20060216154320.GT31278@pasky.or.cz> <200602161659.39173.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 16 17:09:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9lgu-0006es-0s
	for gcvg-git@gmane.org; Thu, 16 Feb 2006 17:09:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbWBPQI7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Feb 2006 11:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932304AbWBPQI7
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Feb 2006 11:08:59 -0500
Received: from w241.dkm.cz ([62.24.88.241]:25834 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932306AbWBPQI7 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Feb 2006 11:08:59 -0500
Received: (qmail 15818 invoked by uid 2001); 16 Feb 2006 17:09:54 +0100
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Content-Disposition: inline
In-Reply-To: <200602161659.39173.Josef.Weidendorfer@gmx.de>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16309>

Dear diary, on Thu, Feb 16, 2006 at 04:59:39PM CET, I got a letter
where Josef Weidendorfer <Josef.Weidendorfer@gmx.de> said that...
> So perhaps it would be good to hint the user to cg-seek in this
> error message?

That's a good idea. I added a hint there and a paragraph to cg-switch
documentation.

Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
