From: Junio C Hamano <junkio@cox.net>
Subject: Re: Errors pushing tags in "next"
Date: Fri, 23 Mar 2007 01:16:27 -0700
Message-ID: <7v7it8s7c4.fsf@assigned-by-dhcp.cox.net>
References: <382665.13897.qm@web31804.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: ltuikov@yahoo.com
X-From: git-owner@vger.kernel.org Fri Mar 23 09:16:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HUewr-0005mQ-QZ
	for gcvg-git@gmane.org; Fri, 23 Mar 2007 09:16:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934257AbXCWIQa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Mar 2007 04:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934267AbXCWIQ3
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Mar 2007 04:16:29 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:63341 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934257AbXCWIQ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2007 04:16:28 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070323081627.LHVO1606.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Fri, 23 Mar 2007 04:16:27 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id e8GT1W0041kojtg0000000; Fri, 23 Mar 2007 04:16:27 -0400
In-Reply-To: <382665.13897.qm@web31804.mail.mud.yahoo.com> (Luben Tuikov's
	message of "Fri, 23 Mar 2007 00:44:49 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42910>

Luben Tuikov <ltuikov@yahoo.com> writes:

> BTW, git has always said to me "Pushing version ... to the masses"
> whenever I'd do "git-push --tags web".

Sorry, I must be blind, and git-grep is too.

$ git grep -e 'to the masses' -e 'Pushing v'

returns absolutely empty.

Puzzled...
