From: Junio C Hamano <junkio@cox.net>
Subject: Re: Gitk strangeness..
Date: Thu, 30 Mar 2006 17:50:57 -0800
Message-ID: <7vek0j1iwu.fsf@assigned-by-dhcp.cox.net>
References: <7v64lzo1j7.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0603271802030.15714@g5.osdl.org>
	<17448.40941.256361.866229@cargo.ozlabs.ibm.com>
	<7vr74nmg7e.fsf@assigned-by-dhcp.cox.net>
	<17448.48143.764989.649462@cargo.ozlabs.ibm.com>
	<7vmzfbm8m0.fsf@assigned-by-dhcp.cox.net>
	<17448.54558.865097.519248@cargo.ozlabs.ibm.com>
	<7vzmjbj9a1.fsf@assigned-by-dhcp.cox.net>
	<17449.48630.370867.10251@cargo.ozlabs.ibm.com>
	<20060330205759.GA27131@steel.home>
	<17452.28122.129442.49226@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri Mar 31 03:51:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FP8n0-0004sJ-Q5
	for gcvg-git@gmane.org; Fri, 31 Mar 2006 03:51:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091AbWCaBvA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Mar 2006 20:51:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbWCaBvA
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Mar 2006 20:51:00 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:59323 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751091AbWCaBu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Mar 2006 20:50:59 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060331015059.YRVE25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 30 Mar 2006 20:50:59 -0500
To: Paul Mackerras <paulus@samba.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18215>

Paul Mackerras <paulus@samba.org> writes:

> Alex Riesen writes:
>
>> The old gitk produced a denser graph, which wasn't perfect too, but
>> had a higher count of visible commit titles (and this is two-monitor
>> setup, too).
>
> I just pushed a new version which does better on this.

Thanks.  Pulled, merged and pushed out..
