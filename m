From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Teach parse_commit_buffer about grafting.
Date: Thu, 18 Aug 2005 13:02:30 +1000
Message-ID: <17155.64070.264664.926461@cargo.ozlabs.ibm.com>
References: <7vslxw4tb1.fsf_-_@assigned-by-dhcp.cox.net>
	<20050818003036.C53FD353BF9@atlas.denx.de>
	<7vd5ocouus.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Wolfgang Denk <wd@denx.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 18 05:05:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5ahQ-00051X-G4
	for gcvg-git@gmane.org; Thu, 18 Aug 2005 05:04:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbVHRDEJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Aug 2005 23:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbVHRDEJ
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Aug 2005 23:04:09 -0400
Received: from ozlabs.org ([203.10.76.45]:15770 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932116AbVHRDEI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Aug 2005 23:04:08 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id 87C3667FC9; Thu, 18 Aug 2005 13:04:07 +1000 (EST)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vd5ocouus.fsf@assigned-by-dhcp.cox.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano writes:

> My Tcl/Tk is really rusty, and I do not like this patch, but
> here is my stab at teaching the code that reads commit objects
> how to use grafts as well.

I added support for grafts to gitk just yesterday, and it should be on
kernel.org by now.  I also committed the changes to send lines into
hyperspace.

Regards,
Paul.
