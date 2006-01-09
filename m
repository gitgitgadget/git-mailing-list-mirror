From: Andreas Ericsson <ae@op5.se>
Subject: Re: [ANNOUCNE] GIT 1.1.0
Date: Mon, 09 Jan 2006 23:22:40 +0100
Message-ID: <43C2E230.1000107@op5.se>
References: <7v4q4eurgu.fsf@assigned-by-dhcp.cox.net> <43C2CAED.8030304@cc.jyu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 09 23:23:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ew5Ps-0003pG-J3
	for gcvg-git@gmane.org; Mon, 09 Jan 2006 23:23:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751571AbWAIWWn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jan 2006 17:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751570AbWAIWWn
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jan 2006 17:22:43 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:49805 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1751571AbWAIWWm
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 9 Jan 2006 17:22:42 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 4CA516BD09; Mon,  9 Jan 2006 23:22:41 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: lamikr@cc.jyu.fi
In-Reply-To: <43C2CAED.8030304@cc.jyu.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14377>

lamikr wrote:
>>- "git --version" from an interim snapshot gives a more
>>  descriptive version name than "1.0-GIT" (Linus).
>> 
>>
> 
> I installed 1.1.0 today and it shows me
> 
> $ git --version
> git version 1.0.GIT
> 

You did not have git-describe installed prior to building 1.1.0. If you 
re-install right on top the one you did today the version-file will be 
generated correctly.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
