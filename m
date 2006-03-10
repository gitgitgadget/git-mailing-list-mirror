From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-rev-list feature request
Date: Thu, 09 Mar 2006 20:27:12 -0800
Message-ID: <7vhd663owv.fsf@assigned-by-dhcp.cox.net>
References: <17424.53563.622642.738307@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0603091950360.18022@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 10 05:27:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHZDk-0004md-Cr
	for gcvg-git@gmane.org; Fri, 10 Mar 2006 05:27:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbWCJE1R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Mar 2006 23:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbWCJE1R
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Mar 2006 23:27:17 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:46312 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751101AbWCJE1Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Mar 2006 23:27:16 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060310042528.QBHW6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 9 Mar 2006 23:25:28 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603091950360.18022@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 9 Mar 2006 19:56:20 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17447>

Linus Torvalds <torvalds@osdl.org> writes:

> So phase 1 already exists and was the hard part. phase 2 is just walking 
> the graph (that is now all in memory) from "cmit" using the "object->refs" 
> reverse references that got built up during phase 1.

Eh,... what reverse references???
