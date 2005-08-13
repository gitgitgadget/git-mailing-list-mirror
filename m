From: Ryan Anderson <ryan@michonline.com>
Subject: Re: [PATCH] Use "-script" postfix for scripts
Date: Sat, 13 Aug 2005 18:25:12 -0400
Message-ID: <20050813222512.GA6844@mythryan2.michonline.com>
References: <Pine.LNX.4.63.0508121526050.25606@wgmdd8.biozentrum.uni-wuerzburg.de> <7vwtmrxjbb.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0508121451590.3295@g5.osdl.org> <20050812222716.GD22778@mythryan2.michonline.com> <7v64uaqknh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 14 00:25:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E44RX-00032a-3P
	for gcvg-git@gmane.org; Sun, 14 Aug 2005 00:25:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbVHMWZ3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Aug 2005 18:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbVHMWZ2
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Aug 2005 18:25:28 -0400
Received: from mail.autoweb.net ([198.172.237.26]:48576 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S932377AbVHMWZ2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Aug 2005 18:25:28 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1E44RE-0002gX-UV; Sat, 13 Aug 2005 18:25:12 -0400
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1E44RE-0002yJ-00; Sat, 13 Aug 2005 18:25:12 -0400
Received: from ryan by mythical with local (Exim 4.52)
	id 1E44RE-0002T9-3h; Sat, 13 Aug 2005 18:25:12 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v64uaqknh.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 13, 2005 at 01:57:22AM -0700, Junio C Hamano wrote:
> Ryan Anderson <ryan@michonline.com> writes:
> 
> > See, for example, the history on git-rename-script for why this is good.
> 
> Why do you think it is a good example?  What happens when next
> time somebody rewrites it in C?

Well, I was really responding to the comment about "-script" being
better than ".sh", as trying ".sh", ".pl", ".php", etc, would rapidly
be annoying.

Honestly, I think the biggest argument against the "-script" suffix is
related to man-page usage:  It requires significant knowledge of the Git
project to figure out what name variant to use to find the man page.

(There are other problems with man pages, but I'll address those
seperately now that they have occurred to me.)

-- 

Ryan Anderson
  sometimes Pug Majere
