From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Add git-annotate, a tool for assigning blame.
Date: Tue, 28 Feb 2006 10:08:05 +0100
Message-ID: <440412F5.9050909@op5.se>
References: <11404323692193-git-send-email-ryan@michonline.com> <20060220234054.GA7903@c165.ib.student.liu.se> <7vlkw57f63.fsf@assigned-by-dhcp.cox.net> <20060228082736.GA4593@c165.ib.student.liu.se> <20060228084737.GA13537@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Fredrik Kuivinen <freku045@student.liu.se>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 28 10:08:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FE0q3-0008PD-Bl
	for gcvg-git@gmane.org; Tue, 28 Feb 2006 10:08:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbWB1JII (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Feb 2006 04:08:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932105AbWB1JII
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Feb 2006 04:08:08 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:30648 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932086AbWB1JIH
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2006 04:08:07 -0500
Received: from [192.168.1.20] (host-213.88.215.14.addr.se.sn.net [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id E0FFD6BD00; Tue, 28 Feb 2006 10:08:05 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <20060228084737.GA13537@mythryan2.michonline.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16925>

Ryan Anderson wrote:
> On Tue, Feb 28, 2006 at 09:27:36AM +0100, Fredrik Kuivinen wrote:
> 
>>On Mon, Feb 20, 2006 at 04:01:56PM -0800, Junio C Hamano wrote:
>>
>>>Fredrik Kuivinen <freku045@student.liu.se> writes:
>>>
>>>
>>>>I have also been working on a blame program.
>>
>>...
>>
>>
>>>BTW, these days I always compile things with 
>>>
>>>	-Wall -Wdeclaration-after-statement
>>>
>>>which caught quite a many.
>>
>>Just out of curiosity, why do you prefer declarations before
>>statements?
> 
> 
> I won't speak for Junio, but the explanations I've heard in the past are
> basically:
> 
> 1) It keeps all declarations in one spot.
> 2) If your function is complicated enough to not need a variable until
> fairly far into the function, it probably should be two (or more) functions.
> 

3) Not all compilers support it.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
