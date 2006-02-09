From: Andreas Ericsson <ae@op5.se>
Subject: Re: What's in git.git
Date: Thu, 09 Feb 2006 10:04:53 +0100
Message-ID: <43EB05B5.20307@op5.se>
References: <7vslqtf2p1.fsf@assigned-by-dhcp.cox.net> <BAYC1-PASMTP1142DA49F5BC7B7B42B22FAE030@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 09 10:05:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F77jX-0004xg-Je
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 10:05:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965230AbWBIJE4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Feb 2006 04:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965233AbWBIJE4
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Feb 2006 04:04:56 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:59043 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S965230AbWBIJEz
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 9 Feb 2006 04:04:55 -0500
Received: from [192.168.1.20] (host-213.88.215.14.addr.se.sn.net [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id EA6116BD0D; Thu,  9 Feb 2006 10:04:53 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: sean <seanlkml@sympatico.ca>
In-Reply-To: <BAYC1-PASMTP1142DA49F5BC7B7B42B22FAE030@CEZ.ICE>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15795>

sean wrote:
> On Wed, 08 Feb 2006 22:47:54 -0800
> Junio C Hamano <junkio@cox.net> wrote:
> 
> 
> 
>>One *major* change I am thinking about doing is to change my
>>workflow a bit.  So far, the proposed updates branch "pu" was
>>almost impossible to follow unless you are really a devoted git
>>developer, because it is always rebased to the latest master and
>>then topic branches are merged onto it.  While that keeps the
>>number of unnecessary merge nodes between master and pu to the
>>minimum, it actively discouraged for the branch to be followed
>>by developers.
> 
> 
> I've always followed it okay by just using "git branch -d pu" each time 
> before pulling from you.   Your "next" branch does sound like an 
> improvement though.
> 

I thought

	Pull: +pu:pu

was supposed to handle such things automatically. It has always pulled 
properly for me anyways.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
