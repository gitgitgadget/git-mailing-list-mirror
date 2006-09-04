From: Junio C Hamano <junkio@cox.net>
Subject: Re: Bogofilter is my emails
Date: Sun, 03 Sep 2006 18:23:51 -0700
Message-ID: <7vy7t0s9ug.fsf@assigned-by-dhcp.cox.net>
References: <20060903040222.GB29756@spearce.org>
	<Pine.LNX.4.64.0609031550330.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 04 03:24:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GK3CM-0007ID-HJ
	for gcvg-git@gmane.org; Mon, 04 Sep 2006 03:24:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbWIDBXg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Sep 2006 21:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbWIDBXg
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Sep 2006 21:23:36 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:39111 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932198AbWIDBXf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Sep 2006 21:23:35 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060904012335.DBZI6235.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>;
          Sun, 3 Sep 2006 21:23:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id J1Pb1V00g1kojtg0000000
	Sun, 03 Sep 2006 21:23:36 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609031550330.27779@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 3 Sep 2006 16:09:38 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26394>

Linus Torvalds <torvalds@osdl.org> writes:

> On Sun, 3 Sep 2006, Shawn Pearce wrote:
>> 
>> I'm not quite sure how to fix either message to get them to the list.
>> Neither email was a patch so I'm not going to try resending them
>> but I'm certainly a little curious as to how my email writing style
>> twice tripped bogofilter's spam switch.
>
> I'm surprised and disgusted that vger started using bogofilter.
>...
> 		Linus
>
> -- 
> VGER BF report: U 0.720981

Hehe, and it still considers that your message is highly spammy
(1.0 being definite spam, 0.0 being definite ham, if I am not
mistaken).

The filter at least should learn to recognize "^\t\tLinus$" ;-).


-- 
VGER BF report: U 0.669453
