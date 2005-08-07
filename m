From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-local-pull?
Date: Sat, 06 Aug 2005 22:31:50 -0700
Message-ID: <7vbr4a2tyx.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.62.0508031259430.23721@iabervon.org>
	<20050804201230.GC24479@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 07 07:32:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E1dlk-0005du-P1
	for gcvg-git@gmane.org; Sun, 07 Aug 2005 07:32:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751067AbVHGFbx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Aug 2005 01:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751068AbVHGFbx
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Aug 2005 01:31:53 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:64669 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751056AbVHGFbw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Aug 2005 01:31:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050807053151.NLLT7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 7 Aug 2005 01:31:51 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050804201230.GC24479@pasky.ji.cz> (Petr Baudis's message of
	"Thu, 4 Aug 2005 22:12:30 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis <pasky@suse.cz> writes:

>> I can probably fix it if anyone cares, but it's not something I use 
>> personally, so I don't know if it's worthwhile. It should probably be 
>> removed if we don't fix it, since it will fail on any popular repository 
>> at this point.
>
> I want to use it in Cogito again, since copying everything obviously
> sucks and I want to hardlink, so repacking is not a solution either.

Me too.
