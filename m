From: Michael Fischer <michael@visv.net>
Subject: Re: [PATCH] git-commit: revamp the git-commit semantics.
Date: Sun, 5 Feb 2006 21:25:54 -0500
Message-ID: <20060206022553.GB25603@blinkenlights.visv.net>
References: <7vpsm2hzng.fsf@assigned-by-dhcp.cox.net> <20060205225116.GC24561@blinkenlights.visv.net> <7vwtg9cq0k.fsf@assigned-by-dhcp.cox.net> <7vzml5b7az.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Feb 06 03:26:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5w4k-00068M-8W
	for gcvg-git@gmane.org; Mon, 06 Feb 2006 03:25:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbWBFCZ4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Feb 2006 21:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750832AbWBFCZz
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Feb 2006 21:25:55 -0500
Received: from www.visv.net ([64.81.194.132]:22508 "EHLO visv.net")
	by vger.kernel.org with ESMTP id S1750786AbWBFCZz (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Feb 2006 21:25:55 -0500
Received: by visv.net (Postfix, from userid 1000)
	id 32D08645B4; Sun,  5 Feb 2006 21:25:54 -0500 (EST)
To: git@vger.kernel.org
Mail-Followup-To: Michael Fischer <michael@visv.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vzml5b7az.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15649>

On Sun, Feb 05, Junio C Hamano wrote:
> Junio C Hamano <junkio@cox.net> writes:
> 
> > To keep yourself up to date:
> >
> > 	$ git clone git://git.kernel.org/pub/scm/git master.git
> 
> Silly me.  This URL is wrong.
> 
> 	$ git clone git://git.kernel.org/pub/scm/git/git master.git

Thanks. Instructions followed, patch tried:

>From within a subdirectory:

$ git commit -m"fix the bounce file" bounce.html 
assuming --include paths...
$

Both my nits are solved. Happy. Thanks.



Michael
-- 
Michael Fischer                         Happiness is a config option.
michael@visv.net                        Recompile and be happy. 
