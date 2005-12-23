From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] send-pack: reword non-fast-forward error message.
Date: Fri, 23 Dec 2005 13:13:46 +0100
Message-ID: <43ABE9FA.4010604@op5.se>
References: <Pine.LNX.4.63.0512220048360.13453@wbgn013.biozentrum.uni-wuerzburg.de>	<7vd5jqvsn1.fsf@assigned-by-dhcp.cox.net> <43AA79EB.6040800@op5.se>	<7vek45lyor.fsf@assigned-by-dhcp.cox.net> <7vu0d0j24z.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Dec 23 13:13:57 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eplo0-0006MP-BT
	for gcvg-git@gmane.org; Fri, 23 Dec 2005 13:13:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030509AbVLWMNs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Dec 2005 07:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030511AbVLWMNs
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Dec 2005 07:13:48 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:24204 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1030509AbVLWMNr
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Dec 2005 07:13:47 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP id D56D96BD22
	for <git@vger.kernel.org>; Fri, 23 Dec 2005 13:13:46 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <7vu0d0j24z.fsf_-_@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13992>

Junio C Hamano wrote:
> Junio C Hamano <junkio@cox.net> writes:
> 
> 
>>Andreas Ericsson <ae@op5.se> writes:
>>
>>
>>>Junio C Hamano wrote:
>>>
>>>>In a sense, both are "pull first?" situation, and it probably is
>>>>more confusing to give different messages to the user in these
>>>>two cases.  From the end-user point of view they are the same
>>>>"remote is not strict subset.".
>>>
>>>In non-git'ish, does this mean "you're not up to date, so pull before 
>>>pushing" ? If so, why not say so? I'm sure it could prevent a fair few 
>>>problems for users (not least those new to scm's).
> 
> 
> That is reasonable.  How about this?
> 

Me likes.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
