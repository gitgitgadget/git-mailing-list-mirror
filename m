From: Junio C Hamano <gitster@pobox.com>
Subject: Re: filenames with " b" in them create confusing git diff-tree output
Date: Wed, 20 Jun 2007 13:50:12 -0700
Message-ID: <7v3b0mtkor.fsf@assigned-by-dhcp.pobox.com>
References: <18041.3163.329391.298926@cargo.ozlabs.ibm.com>
	<7v4pl2v1lf.fsf@assigned-by-dhcp.pobox.com>
	<alpine.LFD.0.98.0706201315310.3593@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jun 20 22:50:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1786-0002m2-Cj
	for gcvg-git@gmane.org; Wed, 20 Jun 2007 22:50:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752472AbXFTUuQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Jun 2007 16:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752431AbXFTUuP
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jun 2007 16:50:15 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:37335 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752246AbXFTUuN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2007 16:50:13 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070620205013.GBKR6565.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Wed, 20 Jun 2007 16:50:13 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id DwqC1X0051kojtg0000000; Wed, 20 Jun 2007 16:50:12 -0400
In-Reply-To: <alpine.LFD.0.98.0706201315310.3593@woody.linux-foundation.org>
	(Linus Torvalds's message of "Wed, 20 Jun 2007 13:23:12 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50570>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Some maybe we should have some generic method of asking for any filename 
> to be quoted in particular ways?

Probably, especially if you notice there has been a separate
thread whose title begins with a word "Stupid".
