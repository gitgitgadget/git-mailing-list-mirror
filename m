From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [ANNOUNCE] GIT 1.4.3
Date: Sun, 22 Oct 2006 22:36:35 -0400
Message-ID: <20061023023635.GA20256@fieldses.org>
References: <20061022035919.GA4420@fieldses.org> <7vy7r954k7.fsf@assigned-by-dhcp.cox.net> <20061022231422.GA9375@fieldses.org> <20061023005336.GA12932@fieldses.org> <453C1A35.70504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 23 04:36:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbpgA-0006Ry-4s
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 04:36:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbWJWCgj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 22:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbWJWCgj
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 22:36:39 -0400
Received: from mail.fieldses.org ([66.93.2.214]:1676 "EHLO pickle.fieldses.org")
	by vger.kernel.org with ESMTP id S1751219AbWJWCgi (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Oct 2006 22:36:38 -0400
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1Gbpg3-0005Qm-Vf; Sun, 22 Oct 2006 22:36:35 -0400
To: A Large Angry SCM <gitzilla@gmail.com>
Content-Disposition: inline
In-Reply-To: <453C1A35.70504@gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29812>

On Sun, Oct 22, 2006 at 06:26:13PM -0700, A Large Angry SCM wrote:
> J. Bruce Fields wrote:
> >So for me, if I run
> >
> >	less -FRS file
> >
> >where "file" is less than a page, I see nothing happen whatsoever.
> >
> >At a guess, maybe it's clearing the screen, displaying the file, the
> >restoring, all before I see anything happen?
...
> 
> How about reverting this change? From the reports here, is causing 
> problems on a number of different distributions.

I'm using gnome-terminal on Debian/Sid, by the way.

> These settings are probably something that is better set by the user in 
> an environment variable. Or, make the default something that does work 
> everywhere and have a config item for those that wish to customize their UI.

(Um, sorry for my mail screwups, by the way....)

--b.
