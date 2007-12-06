From: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: git guidance
Date: Thu, 06 Dec 2007 16:46:24 -0500
Message-ID: <47586DB0.5040706@cfl.rr.com>
References: <20071129105220.v40i22q4gw4cgoso@intranet.digizenstudio.com> <200712072035.47359.a1426z@gawab.com> <47583E57.9050208@op5.se> <200712072155.04643.a1426z@gawab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Andreas Ericsson <ae@op5.se>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jing Xue <jingxue@digizenstudio.com>,
	linux-kernel@vger.kernel.org, git@vger.kernel.org
To: Al Boldi <a1426z@gawab.com>
X-From: git-owner@vger.kernel.org Thu Dec 06 22:47:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0OYS-0003c5-CO
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 22:46:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752534AbXLFVqZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 16:46:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752474AbXLFVqZ
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 16:46:25 -0500
Received: from iriserv.iradimed.com ([72.242.190.170]:28653 "EHLO iradimed.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752073AbXLFVqX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 16:46:23 -0500
Received: from [10.1.1.235] ([10.1.1.235]) by iradimed.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 6 Dec 2007 16:46:37 -0500
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <200712072155.04643.a1426z@gawab.com>
X-OriginalArrivalTime: 06 Dec 2007 21:46:37.0474 (UTC) FILETIME=[7A427020:01C83851]
X-TM-AS-Product-Ver: SMEX-7.5.0.1243-5.0.1023-15590.001
X-TM-AS-Result: No--10.583800-5.000000-31
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67342>

Al Boldi wrote:
> When you read server, don't read it as localized; a server can be 
> distributed.  What distinguishes a server from an engine is that it has to 
> handle a multi-user use-case.  How that is implemented, locally or remotely 
> or distributed, is another issue.

And again, git handles both use cases, so what's your point?

> As explained before in this thread, replicating the git tree on the client 
> still doesn't provide the required transparency.

It has been pointed out to you that it DOES.  Either that or nobody else 
understands your nebulous use of "transparency" so maybe you should 
define it like we've been asking you.  Furthermore, the comment you 
replied to said nothing about transparency, nor did your comment it was 
in reply to; rather it was pointing out the fact that your statement 
that the git can not perform version control on the client is patently 
false.

>> How is that different from what every SCM, including git, is doing today?
>> The user needs to tell the scm when it's time to take a snapshot of the
>> current state. Git is distributed though, so committing is usually not the
>> same as publishing. Is that lack of a single command to commit and publish
>> what's nagging you? If it's not, I completely fail to see what you're
>> getting at, unless you've only ever looked at repositories without a
>> worktree attached, or you think that git should work like an editor's
>> "undo" functionality, which would be quite insane.
> 
> You need to re-read the thread.

Perhaps you should.  We have been trying to get you to explain how you 
think git isn't "transparent" while at the same time pointing out how we 
think it is.  You have failed to demonstrate any evidence to back up 
your claims, all of which have been shown to be false.
