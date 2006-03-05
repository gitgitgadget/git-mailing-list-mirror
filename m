From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git
Date: Sat, 04 Mar 2006 20:51:42 -0800
Message-ID: <7v4q2djxy9.fsf@assigned-by-dhcp.cox.net>
References: <7vacc5jza6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Mar 05 05:51:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FFlDi-0001Y3-LA
	for gcvg-git@gmane.org; Sun, 05 Mar 2006 05:51:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567AbWCEEvr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Mar 2006 23:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751532AbWCEEvr
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Mar 2006 23:51:47 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:6107 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751497AbWCEEvq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Mar 2006 23:51:46 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060305045027.KHIU3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 4 Mar 2006 23:50:27 -0500
To: git@vger.kernel.org
In-Reply-To: <7vacc5jza6.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 04 Mar 2006 20:22:57 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17202>

Junio C Hamano <junkio@cox.net> writes:

> Fredrik's git-blame still has -Wdeclaration-after-statement
> issues,...

Quick correction before anybody says anything.

Sorry Fredrik, there is none anymore --- you have already done
clean-up and I merged it.  Just "print_map defined but not used".
