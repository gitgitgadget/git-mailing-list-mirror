From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: Email address from username and hostname preferred over $EMAIL
Date: Thu, 05 Jul 2007 19:49:03 -0500
Message-ID: <468D917F.9090707@nrlssc.navy.mil>
References: <OF40A04FE5.AA34B1BF-ON8825730F.005D733A-8825730F.0062A716@beck man.com> <alpine.LFD.0.98.0707051357360.9434@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: mkraai@beckman.com, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jul 06 02:49:57 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6c1E-0006vx-Rw
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 02:49:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762220AbXGFAt1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Jul 2007 20:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760464AbXGFAt1
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jul 2007 20:49:27 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:58205 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762220AbXGFAtT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2007 20:49:19 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id l660lOfU022605;
	Thu, 5 Jul 2007 19:47:27 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 5 Jul 2007 19:49:03 -0500
User-Agent: Thunderbird 2.0.0.0 (X11/20070326)
In-Reply-To: <alpine.LFD.0.98.0707051357360.9434@woody.linux-foundation.org>
X-OriginalArrivalTime: 06 Jul 2007 00:49:03.0698 (UTC) FILETIME=[731A2B20:01C7BF67]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-3.6.0.1039-15280000
X-TM-AS-Result: : Yes--7.095800-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTcwMDA3NS0xMzkw?=
	=?us-ascii?B?MTAtNzAxNDU1LTcwMjA0NC03MDQwMzQtNzAwNjE4LTcwMTIzNi03?=
	=?us-ascii?B?MDI2MDktNzAxNTc2LTcwNjg5MS03MDMxNTctNzAyMDIwLTcwMDQ3?=
	=?us-ascii?B?Ni0xNDgwNTEtMjAwNDA=?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51708>

Linus Torvalds wrote:

> If you want it to prefer $EMAIL, you'd need to change the initialization 
> of git_default_email, methinks.
> 
> 		Linus

I just sent an email to the list, and not in reply to this thread
because I thought I read a comment about not posting a patch deep in
a thread.

But, I'm thinking I should have just posted it as a reply to the thread
since I quoted a portion of your message.

-brandon
