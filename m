From: Junio C Hamano <junkio@cox.net>
Subject: Re: merge summaries
Date: Fri, 18 May 2007 16:34:05 -0700
Message-ID: <7vhcq94sgi.fsf@assigned-by-dhcp.cox.net>
References: <25A3C618-8D12-42A8-9478-D3A4E7633CE7@zib.de>
	<alpine.LFD.0.98.0705181130580.3890@woody.linux-foundation.org>
	<7vodki55px.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.98.0705181206051.3890@woody.linux-foundation.org>
	<20070518215603.GS15393@fieldses.org>
	<alpine.LFD.0.98.0705181611520.3890@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat May 19 01:34:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpBxd-00063M-IJ
	for gcvg-git@gmane.org; Sat, 19 May 2007 01:34:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754768AbXERXeK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 19:34:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754888AbXERXeJ
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 19:34:09 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:43708 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754768AbXERXeI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 19:34:08 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070518233407.BKFL12190.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Fri, 18 May 2007 19:34:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 0na51X00Q1kojtg0000000; Fri, 18 May 2007 19:34:06 -0400
In-Reply-To: <alpine.LFD.0.98.0705181611520.3890@woody.linux-foundation.org>
	(Linus Torvalds's message of "Fri, 18 May 2007 16:12:26 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47683>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Fri, 18 May 2007, J. Bruce Fields wrote:
>> 
>> I never quite understood what they're for--do they add any information
>> not already available in the history?  If not, and if people still find
>> them helpful anyway, then I dunno, it looks like a sign of some sort of
>> failure of our history display tools.
>
> I don't think they add much in the case of a graphical viewer, but for 
> "git log", it does make it look nicer..

Especially if you do "git log --first-parent" ;-).
