From: Andreas Ericsson <ae@op5.se>
Subject: Re: Teach "approxidate" about weekday syntax
Date: Sat, 19 Nov 2005 01:07:07 +0100
Message-ID: <437E6CAB.8060200@op5.se>
References: <Pine.LNX.4.64.0511171223110.13959@g5.osdl.org>	<7v1x1eubpr.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.64.0511171505080.13959@g5.osdl.org>	<Pine.LNX.4.64.0511171520390.13959@g5.osdl.org>	<20051118121210.GA19714@abridgegame.org>	<Pine.LNX.4.63.0511181419340.28109@wbgn013.biozentrum.uni-wuerzburg.de>	<Pine.LNX.4.58.0511180806550.25159@shark.he.net>	<Pine.LNX.4.64.0511180857170.13959@g5.osdl.org> <7vzmo1ecbf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 19 01:24:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdGG9-0006Rj-TE
	for gcvg-git@gmane.org; Sat, 19 Nov 2005 01:07:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbVKSAHK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 19:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbVKSAHK
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 19:07:10 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:16609 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751137AbVKSAHJ
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 19:07:09 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 345DC6BCFE; Sat, 19 Nov 2005 01:07:08 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmo1ecbf.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12304>

Junio C Hamano wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
> 
> 
>>On Fri, 18 Nov 2005, Randy.Dunlap wrote:
>>
>>>~Randy  [who would just use ISO standard date format]
>>
>>That actually _does_ work, and has done so since the beginning:
>>
>>   [torvalds@g5 git]$ ./test-date "2005-11-02 14:45:00"
> 
> 
> Doesn't ISO spell that as "2005-11-02T14:45:00"?
> 

nox!exon:~$ date --iso-8601=seconds
2005-11-19T01:04:56+0100

No human will spell it with T though.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
