From: Andreas Ericsson <ae@op5.se>
Subject: Re: Rss produced by git is not valid xml?
Date: Sat, 19 Nov 2005 00:53:32 +0100
Message-ID: <437E697C.7090307@op5.se>
References: <200511181833.40048.ismail@uludag.org.tr> <200511182127.06958.ismail@uludag.org.tr> <20051118200217.GA2831@vrfy.org> <200511182208.24248.ismail@uludag.org.tr> <Pine.LNX.4.64.0511181220350.13959@g5.osdl.org> <20051118205513.GA3168@vrfy.org> <Pine.LNX.4.64.0511181314470.13959@g5.osdl.org> <Pine.LNX.4.64.0511181338460.13959@g5.osdl.org> <437E51EB.7050100@zytor.com> <Pine.LNX.4.64.0511181519100.13959@g5.osdl.org> <437E6505.8000201@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Nov 19 01:21:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdG2z-0000uw-Bz
	for gcvg-git@gmane.org; Sat, 19 Nov 2005 00:53:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101AbVKRXxe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 18:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbVKRXxe
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 18:53:34 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:13025 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751101AbVKRXxe
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 18:53:34 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP id 26B046BCFE
	for <git@vger.kernel.org>; Sat, 19 Nov 2005 00:53:33 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <437E6505.8000201@zytor.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12301>

H. Peter Anvin wrote:
> Linus Torvalds wrote:
> 
>>
>> On Fri, 18 Nov 2005, H. Peter Anvin wrote:
>>
>>> On the fly conversion on CVS import isn't particularly crazy, as long 
>>> as it's
>>> under user control.
>>
>>
>> Actually, it is.
>>
>> Why?
>>
>> How are you going to feed your changes back to the original (and 
>> initially main) project?
>>
>> Hint: they're not going to pull from your git tree, are they?
>>
>> Ahh. Maybe patches would be a good idea.
>>
>> Ooops.
>>
> 
> You're assuming there *IS* an original (and initially main) project.
> 
> There is another usage mode: "we're dumping CVS and switching to this 
> new-fangled git thing."  I have myself done this with several projects 
> by now.
> 


I'm guessing Linus' scenario is more common. I do it myself and I'd like 
it to keep working.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
