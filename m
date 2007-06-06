From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC PATCH] Add git quick reference
Date: Wed, 06 Jun 2007 13:36:06 -0700
Message-ID: <7vps48zuq1.fsf@assigned-by-dhcp.cox.net>
References: <20070602182423.GC19952@diku.dk>
	<20070603171547.GA1965@fieldses.org> <20070604184546.GA27088@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Wed Jun 06 22:36:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hw2Em-0005tG-Gp
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 22:36:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383AbXFFUgJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 16:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757135AbXFFUgJ
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 16:36:09 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:54737 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751383AbXFFUgI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 16:36:08 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070606203607.YUHB14072.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Wed, 6 Jun 2007 16:36:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 8Lc61X00W1kojtg0000000; Wed, 06 Jun 2007 16:36:07 -0400
In-Reply-To: <20070604184546.GA27088@diku.dk> (Jonas Fonseca's message of
	"Mon, 4 Jun 2007 20:45:46 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49310>

Jonas Fonseca <fonseca@diku.dk> writes:

> J. Bruce Fields <bfields@fieldses.org> wrote Sun, Jun 03, 2007:
>> On Sat, Jun 02, 2007 at 08:24:23PM +0200, Jonas Fonseca wrote:
>> > It attempts to list some of the most commonly used commands, which should
>> > give new users an idea of how to get started.
>> > 
>> > Available both as a manpage (generated via a script) and HTML page.
>> 
>> We have a "git quick start" here:
>> 
>> 	http://www.kernel.org/pub/software/scm/git/docs/user-manual.html#git-quick-start
>> 
>> and there's one on the wiki:
>> 
>> 	http://git.or.cz/gitwiki/QuickStart
>> 
>> I think the one in the manual tries to follow the organization of the
>> manual more closely.
>
> I like the manual version best. However, it is not as "visually" clean
> and simple as I would like, but perhaps this sort of "use case" approach
> is better.
>
>> I haven't tried to compare those two recently, or to compare yours to
>> either of them.  If you could compare and suggest any improvements,
>> that'd be helpful.
>
> I will see what I can do when I get the time and courage. :)
>
>> I like your name better ("quick reference" as opposed to "quick start").
>
> Yes, "quick start" suggest (at least to me) that it is a tutorial and it
> seems far from that.

When I started the "everyday" document, I wanted to make it a
cheat sheet usable by people who are not so familiar with the
workflow.  The "quick reference" would be good for people who
want a cheat sheet without need for workflow description.
