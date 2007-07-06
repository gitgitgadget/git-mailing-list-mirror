From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: Email address from username and hostname preferred over $EMAIL
Date: Fri, 06 Jul 2007 10:02:39 -0500
Message-ID: <468E598F.90801@nrlssc.navy.mil>
References: <OF40A04FE5.AA34B1BF-ON8825730F.005D733A-8825730F.0062A716@beck	man.com>	<alpine.LFD.0.98.0707051357360.9434@woody.linux-foundation.org>	<468D917F.9090707@nrlssc.navy.mil> <7vir8yib4d.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>, mkraai@beckman.com,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 06 17:03:34 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6pLJ-00009F-JO
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 17:03:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757190AbXGFPDb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 11:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756234AbXGFPDb
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 11:03:31 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:55128 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755549AbXGFPDa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2007 11:03:30 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id l66F0uGG027293;
	Fri, 6 Jul 2007 10:00:59 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 6 Jul 2007 10:02:39 -0500
User-Agent: Thunderbird 2.0.0.0 (X11/20070326)
In-Reply-To: <7vir8yib4d.fsf@assigned-by-dhcp.cox.net>
X-OriginalArrivalTime: 06 Jul 2007 15:02:39.0149 (UTC) FILETIME=[B1E3CDD0:01C7BFDE]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-3.6.0.1039-15280000
X-TM-AS-Result: : Yes--16.230800-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTcwMDA3NS0xMzkw?=
	=?us-ascii?B?MTAtNzAwMTYwLTcwMzczMS03MDE1NzYtNzAyMzEyLTcwMzA0MS03?=
	=?us-ascii?B?MDIzNTgtNzAwNjE4LTcwMTcwOC03MDM5MDctNzA0NTY4LTcwMDgx?=
	=?us-ascii?B?MC03MDEyMzYtNzAxODM3LTcwNTE2Ny03MDM0MzYtNzA0MjQwLTcw?=
	=?us-ascii?B?NTE3OC0xNDgwNTEtMjAwNDA=?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51759>

Junio C Hamano wrote:
> Brandon Casey <casey@nrlssc.navy.mil> writes:
> Are Brandon Casey and Matt Kraai the same person?

heh, no. :) I see now that my patch did not make it. I tried
to use git-send-email on my system and it successfully delivered
to my imap mailbox, but failed delivering to the other recipients.

> I do not mind threadedness of the patch too much

ok.

> , but the patch
> recently posted by the latter does not have any description
> other than the title.
> 
> Other than that, I think the change itself seems sane.

I'll go ahead and post my patch again since I think it is a
little simpler and I like it better (imagine that :)

But it's such a simple fix it will be just an exercise for me.

-brandon
