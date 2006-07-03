From: Junio C Hamano <junkio@cox.net>
Subject: Re: [POLL] Who likes running Git without make install?
Date: Mon, 03 Jul 2006 01:08:31 -0700
Message-ID: <7vmzbrrtz4.fsf@assigned-by-dhcp.cox.net>
References: <7vhd2atid1.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0606241338370.6483@g5.osdl.org>
	<7vd5cyt8a3.fsf@assigned-by-dhcp.cox.net>
	<20060625010202.GX21864@pasky.or.cz>
	<20060625014009.GA21864@pasky.or.cz>
	<7vac82q6mb.fsf@assigned-by-dhcp.cox.net>
	<20060625152157.GG21864@pasky.or.cz>
	<7vk674mmyo.fsf@assigned-by-dhcp.cox.net>
	<20060701235906.GE29115@pasky.or.cz>
	<7vslljrxe0.fsf_-_@assigned-by-dhcp.cox.net>
	<20060703075850.GL29115@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 03 10:08:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxJU2-0005Mc-AX
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 10:08:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbWGCIIe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 04:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbWGCIIe
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 04:08:34 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:57842 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750802AbWGCIIc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jul 2006 04:08:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060703080832.YQWL22974.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 3 Jul 2006 04:08:32 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060703075850.GL29115@pasky.or.cz> (Petr Baudis's message of
	"Mon, 3 Jul 2006 09:58:50 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23162>

Petr Baudis <pasky@suse.cz> writes:

> Dear diary, on Mon, Jul 03, 2006 at 08:54:47AM CEST, I got a letter
> where Junio C Hamano <junkio@cox.net> said that...
>> -- >8 --
>> INSTALL: a tip for running after building but without installing.
>> 
>> Signed-off-by: Junio C Hamano <junkio@cox.net>
>
> Acked-by: Petr Baudis <pasky@suse.cz>
>
> I can live with this "weak (D3)". 99% of Git users probably use
> installed Git instance anyway and most of the rest are likely to be Git
> developers testing new code who can do this extra environment setup.

You earlier had to set two environment variables anyway but you
have added another.  I do not see what's weak about it.
