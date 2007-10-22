From: Andreas Ericsson <ae@op5.se>
Subject: Re: Git User's Survey 2007 unfinished summary continued
Date: Mon, 22 Oct 2007 16:29:02 +0200
Message-ID: <471CB3AE.7080802@op5.se>
References: <8fe92b430710081355i7d3dbaa2q9a8939b55d7ca7dc@mail.gmail.com>	 <Pine.LNX.4.64.0710130130380.25221@racer.site>	 <1192827476.4522.93.camel@cacharro.xalalinux.org>	 <4719B655.90204@op5.se> <DE4FB702-24E8-421F-8447-04A5C7F7B5D2@zib.de>	 <8fe92b430710201606i47e85b24k17abd819bf0d353b@mail.gmail.com>	 <Pine.LNX.4.64.0710210031130.25221@racer.site>	 <471AFD07.4040606@op5.se>	 <Pine.LNX.4.64.0710212308540.25221@racer.site>	 <471C586A.9030900@op5.se> <8fe92b430710220526i65ecb862ie1037e9d94d93b83@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Steffen Prohaska <prohaska@zib.de>,
	Federico Mena Quintero <federico@novell.com>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 22 16:29:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjyHr-0003lk-8E
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 16:29:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753292AbXJVO3L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 10:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753184AbXJVO3J
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 10:29:09 -0400
Received: from mail.op5.se ([193.201.96.20]:44491 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751961AbXJVO3I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 10:29:08 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id CFAB41730683;
	Mon, 22 Oct 2007 16:29:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.473
X-Spam-Level: 
X-Spam-Status: No, score=-2.473 tagged_above=-10 required=6.6
	tests=[AWL=0.026, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mWbmTtsbgzfW; Mon, 22 Oct 2007 16:29:06 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 1878E17305A3;
	Mon, 22 Oct 2007 16:29:04 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <8fe92b430710220526i65ecb862ie1037e9d94d93b83@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62012>

Jakub Narebski wrote:
> On 10/22/07, Andreas Ericsson <ae@op5.se> wrote:
> [...]
>>>>>> On 10/20/07, Steffen Prohaska <prohaska@zib.de> wrote:
>>>>>>
>>>>>>> Maybe we could group commands into more categories?
> 
>> Similarly, it might be helpful to have help topics the gdb way, like
>> "git help patches". It's one of those things that people have come to
>> expect from a software tool, so perhaps we should humor them? Given gits
>> "every help topic is a man-page" idiom, this shouldn't require any real
>> technical effort.
>>
>> Such topics should probably include
>> merge/merges/merging - overview of various ways of putting two lines of
>> development back together
>> patch/patches - how to create, send and apply
>> tags/branches/refs - what they are, why they're good, link to merging
> 
> Very good idea. It is definitely something that can be worked on.
> 
> By the way, what do you think about "spying" version of git, specially
> marked release which gathers statistics of porcelain used, with
> frequency of its use, and git-sendstats command added in this release?
> 

I like it and I'd use it. What's more interesting is that I could 
probably get my co-workers to do the same.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
