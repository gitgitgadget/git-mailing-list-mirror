From: Junio C Hamano <junkio@cox.net>
Subject: Re: Fatal error from git bisect
Date: Thu, 09 Feb 2006 13:32:40 -0800
Message-ID: <7vvevo8bgn.fsf@assigned-by-dhcp.cox.net>
References: <7E000E7F06B05C49BDBB769ADAF44D0773A4BC@NT-SJCA-0750.brcm.ad.broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Linus Torvalds" <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu Feb 09 22:34:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7JQP-00032b-1q
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 22:34:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbWBIVcn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Feb 2006 16:32:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbWBIVcn
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Feb 2006 16:32:43 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:59107 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1750800AbWBIVcn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2006 16:32:43 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060209213106.FYF20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 9 Feb 2006 16:31:06 -0500
To: "Mark E Mason" <mark.e.mason@broadcom.com>
In-Reply-To: <7E000E7F06B05C49BDBB769ADAF44D0773A4BC@NT-SJCA-0750.brcm.ad.broadcom.com>
	(Mark E. Mason's message of "Thu, 9 Feb 2006 13:21:27 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15831>

"Mark E Mason" <mark.e.mason@broadcom.com> writes:

> That did the trick.  Thanks very much for the pointer, it's much
> appreciated.

Thanks, both of you.  This got me worried, especially when I am
at work and cannot pull the whole mips tree to take a look at it
myself.
