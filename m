From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] stat() for existence in safe_create_leading_directories()
Date: Thu, 09 Feb 2006 18:30:36 -0800
Message-ID: <7v7j840wtv.fsf@assigned-by-dhcp.cox.net>
References: <15788.1139536573@lotus.CS.Berkeley.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 03:30:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7O3Z-0000iH-Ej
	for gcvg-git@gmane.org; Fri, 10 Feb 2006 03:30:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbWBJCaj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Feb 2006 21:30:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbWBJCaj
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Feb 2006 21:30:39 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:46994 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751011AbWBJCai (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2006 21:30:38 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060210022801.ZPLN26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 9 Feb 2006 21:28:01 -0500
To: Jason Riedy <ejr@EECS.Berkeley.EDU>
In-Reply-To: <15788.1139536573@lotus.CS.Berkeley.EDU> (Jason Riedy's message
	of "Thu, 09 Feb 2006 17:56:13 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15859>

Thanks.

BTW, in an earlier message when I said this:

Jason Riedy <ejr@EECS.Berkeley.EDU> writes:

> And Junio C Hamano writes:
>
>  - Somehow I started to trust your ability to code portably a lot
>  - better than I trust myself, [...]
>
> eep.  ;)  I only have access to three major variations at the
> moment (Linux, semi-old Solaris, recent AIX), so I'm not an
> authority...  Solaris 8 is from before the general Linux/glibc 
> compatability movement, so it's pretty useful for testing.

I was talking more about competence rather than access to
various environments to test on.  I forgot to mention that.
