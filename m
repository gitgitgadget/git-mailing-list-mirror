From: Petr Baudis <pasky@suse.cz>
Subject: Re: [ANNOUNCE] GIT 1.2.0
Date: Sun, 12 Feb 2006 23:33:47 +0100
Message-ID: <20060212223347.GZ31278@pasky.or.cz>
References: <7vzmkw8d5b.fsf@assigned-by-dhcp.cox.net> <7vaccw8bsc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 12 23:33:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8PmM-0007cS-Go
	for gcvg-git@gmane.org; Sun, 12 Feb 2006 23:33:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041AbWBLWdL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Feb 2006 17:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbWBLWdL
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Feb 2006 17:33:11 -0500
Received: from w241.dkm.cz ([62.24.88.241]:37579 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751041AbWBLWdK (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Feb 2006 17:33:10 -0500
Received: (qmail 8883 invoked by uid 2001); 12 Feb 2006 23:33:47 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vaccw8bsc.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16026>

Dear diary, on Sun, Feb 12, 2006 at 11:14:43PM CET, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> For the full list of changes above, see:
> 
> 	$ git log ^v1.1.6 v1.1.0..v1.2.0

Actually, you can do just

 	$ git log v1.1.6..v1.2.0

since v1.1.6 is a superset of v1.1.0. It is like "list all new patches I
will get when I update from v1.1.6 to v1.2.0".

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
