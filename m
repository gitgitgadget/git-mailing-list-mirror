From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 7/7] make "git fetch" update all fetch repositories
Date: Tue, 29 Apr 2008 09:16:22 +0200
Message-ID: <4816CB46.1050100@op5.se>
References: <cover.1209391614.git.bonzini@gnu.org> <55a4068681841e6c3579f4183b469fc7aa4de266.1209391615.git.bonzini@gnu.org> <20080428181012.GB6710@steel.home> <48161544.90500@gnu.org> <20080428213339.GC10600@steel.home> <4816A989.2010204@gnu.org> <20080429053814.GA3332@steel.home> <4816C527.4000406@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	spearce@spearce.org, gitster@pobox.com, peff@peff.net,
	johannes.schindelin@gmx.de, srb@cuci.nl
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Tue Apr 29 09:17:24 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jqk5U-0008I4-KN
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 09:17:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754821AbYD2HQ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 03:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755674AbYD2HQ0
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 03:16:26 -0400
Received: from mail.op5.se ([193.201.96.20]:36588 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754301AbYD2HQ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 03:16:26 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 25E671F08063;
	Tue, 29 Apr 2008 09:16:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EEzu3qn9O+7D; Tue, 29 Apr 2008 09:16:27 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.27])
	by mail.op5.se (Postfix) with ESMTP id 8C6411F08028;
	Tue, 29 Apr 2008 09:16:26 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.12 (X11/20080226)
In-Reply-To: <4816C527.4000406@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80663>

Paolo Bonzini wrote:
> Alex Riesen wrote:
>> Paolo Bonzini, Tue, Apr 29, 2008 06:52:25 +0200:
>>> Alex Riesen wrote:
>>>> Paolo Bonzini, Mon, Apr 28, 2008 20:19:48 +0200:
>>>>>> my v4l2
>>>>>> repo (which is a pretty collection of all kinds of remotes)
>>>>> I can add a global boolean configuration to change the default 
>>>>> value of  skipDefaultRemote.
>>>>>
>>>> With the default NOT so that current behaviour stays?
>>> No, absolutely.  In fact if I were you I would set skipDefaultUpdate  
>>> *now* on the remotes of that repo.
>>
>> And all the others, who don't read this discussion, are just expected
>> to adapt?
> 
> Man, that's what release notes are for.  You are expected to read those.
> 

So you actually read the release-notes for every application you have
installed? Remind me to never employ you. I doubt you'd ever get any
work done.

Failing that, would you get slightly annoyed, or perhaps even quite
vexed if you find out that insert-program-used-to-do-some-work-with-here
did omething stupid that made you lose some of your work?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
