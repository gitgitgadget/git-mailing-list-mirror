From: Andreas Ericsson <ae@op5.se>
Subject: Re: gitweb.cgi in C
Date: Thu, 08 Dec 2005 23:48:22 +0100
Message-ID: <4398B836.8090709@op5.se>
References: <43988299.4090101@tiscali.cz> <20051208222759.GO22159@pasky.or.cz> <7vfyp3b4ki.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 08 23:50:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EkUYz-0001Sd-HB
	for gcvg-git@gmane.org; Thu, 08 Dec 2005 23:48:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932690AbVLHWsZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Dec 2005 17:48:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932693AbVLHWsY
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Dec 2005 17:48:24 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:62593 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S932690AbVLHWsY
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 8 Dec 2005 17:48:24 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id BE4B96BCBE; Thu,  8 Dec 2005 23:48:22 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfyp3b4ki.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13384>

Junio C Hamano wrote:
> Petr Baudis <pasky@suse.cz> writes:
> 
> 
>>Dear diary, on Thu, Dec 08, 2005 at 07:59:37PM CET, I got a letter
>>where Majkls <majkls@tiscali.cz> said that...
>>
>>>What do you think about gitweb.cgi in C?
>>
>>To add to the collective dismay - why bother?
> 
> 
> It _might_ make sense to do gitweb using libified git Smurf is
> working on, in order to reduce forks and execs, but that is
> mostly independent of rewriting that in C.
> 

In that case it would be better and way cooler to have mod_git for Apache.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
