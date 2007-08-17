From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [linux-pm] Re: Storing Maintainers info around the kernel tree
Date: Fri, 17 Aug 2007 04:18:36 +0200
Message-ID: <46C5057C.5010602@gmail.com>
References: <Pine.LNX.4.44L0.0708162156550.9927-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>,
	Kyle Moffett <mrmacman_g4@mac.com>,
	Salikh Zakirov <salikh@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	LKML Kernel <linux-kernel@vger.kernel.org>,
	Joe Perches <joe@perches.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-pm@lists.linux-foundation.org, git@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
X-From: git-owner@vger.kernel.org Fri Aug 17 04:23:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILrUW-0005tc-5a
	for gcvg-git@gmane.org; Fri, 17 Aug 2007 04:23:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761761AbXHQCXG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Aug 2007 22:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760983AbXHQCXG
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Aug 2007 22:23:06 -0400
Received: from smtpq1.groni1.gr.home.nl ([213.51.130.200]:50827 "EHLO
	smtpq1.groni1.gr.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758657AbXHQCXE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2007 22:23:04 -0400
Received: from [213.51.130.188] (port=37363 helo=smtp3.groni1.gr.home.nl)
	by smtpq1.groni1.gr.home.nl with esmtp (Exim 4.30)
	id 1ILrU4-00076i-GU; Fri, 17 Aug 2007 04:22:44 +0200
Received: from cc334381-b.groni1.gr.home.nl ([82.73.12.33]:58180 helo=[192.168.0.3])
	by smtp3.groni1.gr.home.nl with esmtp (Exim 4.30)
	id 1ILrU2-0006qr-QR; Fri, 17 Aug 2007 04:22:42 +0200
User-Agent: Thunderbird 2.0.0.6 (X11/20070728)
In-Reply-To: <Pine.LNX.4.44L0.0708162156550.9927-100000@netrider.rowland.org>
X-AtHome-MailScanner-Information: Please contact support@home.nl for more information
X-AtHome-MailScanner: Found to be clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56040>

On 08/17/2007 03:58 AM, Alan Stern wrote:

> On Fri, 17 Aug 2007, Rene Herman wrote:
> 
>> On 08/16/2007 11:39 PM, Stefan Richter wrote:
>>> Rene Herman wrote:

>>>> I personally don't think there's a whole lot wrong with more and 
>>>> more expecting people who submit patches (for whom this automation 
>>>> is intended) to be using git.
>>> 
>>> You mean "people who frequently submit patches for various different
>>> subsystems".
>> 
>> Erm, I guess. Is that agreeing or disagreeing with me?
> 
> Don't forget also that the MAINTAINERS information is (or should be!)
> used by people who want to submit bug reports, not just by people who
> submit patches.  Bug reporters shouldn't need to use Git.

Like I said:

>> If it's about non-developer users, I suspect it would to a fairly large
>> degree be an "in theory" thing to expect that said user does want the
>> information in a downloaded releases, but not in git, and not online 
>> where git-web could also easily display all the information right 
>> alongside the files.

And again, generating the MAINTAINERS file/info into releases is fine as well.

Rene.
