From: Paul Mackerras <paulus@samba.org>
Subject: Re: Gitk strangeness..
Date: Fri, 31 Mar 2006 10:46:34 +1100
Message-ID: <17452.28122.129442.49226@cargo.ozlabs.ibm.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri Mar 31 01:46:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FP6qi-00019m-NE
	for gcvg-git@gmane.org; Fri, 31 Mar 2006 01:46:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbWC3Xql (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Mar 2006 18:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbWC3Xql
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Mar 2006 18:46:41 -0500
Received: from ozlabs.org ([203.10.76.45]:26277 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751156AbWC3Xql (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Mar 2006 18:46:41 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id 064A3679EA; Fri, 31 Mar 2006 10:46:40 +1100 (EST)
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <20060330205759.GA27131@steel.home>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18210>

Alex Riesen writes:

> The old gitk produced a denser graph, which wasn't perfect too, but
> had a higher count of visible commit titles (and this is two-monitor
> setup, too).

I just pushed a new version which does better on this.

Paul.
