From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's cooking in git.git (topics)
Date: Mon, 30 Apr 2007 16:20:49 -0700
Message-ID: <7vlkg9bga6.fsf@assigned-by-dhcp.cox.net>
References: <11776622643106-git-send-email-junkio@cox.net>
	<11776622643639-git-send-email-junkio@cox.net>
	<7v3b2jdo9h.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.98.0704291142510.9964@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue May 01 01:21:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HifBL-0002Ok-7Y
	for gcvg-git@gmane.org; Tue, 01 May 2007 01:21:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423775AbXD3XVJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Apr 2007 19:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423780AbXD3XVI
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Apr 2007 19:21:08 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:50995 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423775AbXD3XUx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2007 19:20:53 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070430232052.CQOT1218.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Mon, 30 Apr 2007 19:20:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id tbLp1W00T1kojtg0000000; Mon, 30 Apr 2007 19:20:50 -0400
In-Reply-To: <alpine.LFD.0.98.0704291142510.9964@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sun, 29 Apr 2007 11:45:49 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45894>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sun, 29 Apr 2007, Junio C Hamano wrote:
>>
>> * lt/objalloc (Mon Apr 16 22:13:09 2007 -0700) 1 commit
>>  - Make the object lookup hash use a "object index" instead of a
>>    pointer
>
> I think you should just drop this. 

Yeah.  I was mostly concentrating on maint/master for the past
several days, and blindly carrying it around was cheaper than
deciding to drop it in my workflow.
