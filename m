From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [ANNOUNCE] Cogito-0.12
Date: Sun, 10 Jul 2005 21:32:09 +0100
Message-ID: <20050710213209.B22477@flint.arm.linux.org.uk>
References: <20050709232955.B31045@flint.arm.linux.org.uk> <7vpstrv8z6.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0507092158290.17536@g5.osdl.org> <Pine.LNX.4.58.0507092211470.17536@g5.osdl.org> <20050710075548.A11765@flint.arm.linux.org.uk> <7v4qb3uo63.fsf@assigned-by-dhcp.cox.net> <20050710134624.B3279@flint.arm.linux.org.uk> <Pine.LNX.4.58.0507100942020.17536@g5.osdl.org> <20050710201504.A22477@flint.arm.linux.org.uk> <Pine.LNX.4.58.0507101228300.17536@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, Petr Baudis <pasky@suse.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 10 22:37:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DriY3-0003NN-71
	for gcvg-git@gmane.org; Sun, 10 Jul 2005 22:37:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261219AbVGJUgb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jul 2005 16:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbVGJUe1
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jul 2005 16:34:27 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:15890 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261919AbVGJUcP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jul 2005 16:32:15 -0400
Received: from [192.168.0.4] (helo=flint.arm.linux.org.uk)
	by caramon.arm.linux.org.uk with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DriTC-0001Rc-M7; Sun, 10 Jul 2005 21:32:11 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.41)
	id 1DriTB-000793-F1; Sun, 10 Jul 2005 21:32:09 +0100
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0507101228300.17536@g5.osdl.org>; from torvalds@osdl.org on Sun, Jul 10, 2005 at 01:03:30PM -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 10, 2005 at 01:03:30PM -0700, Linus Torvalds wrote:
> Anyway, I pushed out the merge, so don't worry about your tree. But let's 
> hold off on this partial thing for a while, ok?

Thanks, that's good news.  I was fearing having to reconstruct stuff.

Do you want me to re-populate linux-2.6-arm.git to be fully populated
or are you happy for it to just grow the new objects as they become
available?

-- 
Russell King
