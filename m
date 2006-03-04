From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] AsciiDoc fix for tutorial
Date: Sat, 04 Mar 2006 13:51:47 -0800
Message-ID: <7v4q2dri8c.fsf@assigned-by-dhcp.cox.net>
References: <20060304163527.GA12015@craic.sysops.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 04 22:52:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFefN-0000QQ-DZ
	for gcvg-git@gmane.org; Sat, 04 Mar 2006 22:51:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbWCDVvy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Mar 2006 16:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752008AbWCDVvy
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Mar 2006 16:51:54 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:420 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751355AbWCDVvx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Mar 2006 16:51:53 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060304214803.DODH20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 4 Mar 2006 16:48:03 -0500
To: Francis Daly <francis@daoine.org>
In-Reply-To: <20060304163527.GA12015@craic.sysops.org> (Francis Daly's message
	of "Sat, 4 Mar 2006 16:35:27 +0000")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17192>

Francis Daly <francis@daoine.org> writes:

>  shows the difference between that previous state and the state two
> -commits ago.  Also, HEAD~5 can be used as a shorthand for HEAD^^^^^,
> +commits ago.  Also, HEAD~5 can be used as a shorthand for HEAD{caret}{caret}{caret}^^,

Thanks.  Why not 5 {caret}, not just three {caret} plus ^^?
