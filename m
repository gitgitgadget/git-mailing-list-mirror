From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: sending changesets from the middle of a git tree
Date: Mon, 15 Aug 2005 09:55:08 +0100
Message-ID: <tnxmznj7f6b.fsf@arm.com>
References: <42FEBC16.9050309@austin.rr.com>
	<Pine.LNX.4.58.0508132155100.3553@g5.osdl.org>
	<7vhddtdk86.fsf@assigned-by-dhcp.cox.net>
	<20050814092757.GP5608@pasky.ji.cz>
	<7vfytc9dzw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Mon Aug 15 10:58:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4anC-0005ww-Av
	for gcvg-git@gmane.org; Mon, 15 Aug 2005 10:58:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbVHOI56 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Aug 2005 04:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbVHOI56
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Aug 2005 04:57:58 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:57828 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S932276AbVHOI55 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2005 04:57:57 -0400
Received: from cam-mail2.cambridge.arm.com (cam-mail2.cambridge.arm.com [10.1.127.39])
	by cam-admin0.cambridge.arm.com (8.12.10/8.12.10) with ESMTP id j7F8spOU018258;
	Mon, 15 Aug 2005 09:54:51 +0100 (BST)
Received: from ZIPPY.Emea.Arm.com (cam-exch2.emea.arm.com [10.1.255.58])
	by cam-mail2.cambridge.arm.com (8.9.3/8.9.3) with ESMTP id JAA17586;
	Mon, 15 Aug 2005 09:55:42 +0100 (BST)
Received: from localhost.localdomain ([10.1.69.144]) by ZIPPY.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.211);
	 Mon, 15 Aug 2005 09:55:41 +0100
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfytc9dzw.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sun, 14 Aug 2005 18:37:39 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 15 Aug 2005 08:55:41.0733 (UTC) FILETIME=[1D753D50:01C5A177]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:
> Petr Baudis <pasky@suse.cz> writes:
>
>> Dear diary, on Sun, Aug 14, 2005 at 09:57:13AM CEST, I got a letter
>> where Junio C Hamano <junkio@cox.net> told me that...
>>> Linus Torvalds <torvalds@osdl.org> writes:
>>> 
>>> > Junio, maybe you want to talk about how you move patches from your "pu" 
>>> > branch to the real branches.
>>> 
>> Actually, wouldn't this be also precisely for what StGIT is intended to?
>
> Exactly my feeling.  I was sort of waiting for Catalin to speak
> up.  With its basing philosophical ancestry on quilt, this is
> the kind of task StGIT is designed to do.

Have been on holiday and couldn't reply. I will follow up.

-- 
Catalin
