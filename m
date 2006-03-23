From: Andreas Ericsson <ae@op5.se>
Subject: Re: Question about possible git races
Date: Thu, 23 Mar 2006 03:55:29 +0100
Message-ID: <44220E21.7040204@op5.se>
References: <200603201724.12442.astralstorm@o2.pl> <4421DD9E.7030201@op5.se> <200603230224.54736.astralstorm@o2.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 23 03:55:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMFzB-0005ms-8Z
	for gcvg-git@gmane.org; Thu, 23 Mar 2006 03:55:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964913AbWCWCzd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Mar 2006 21:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964914AbWCWCzd
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Mar 2006 21:55:33 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:18375 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S964913AbWCWCzc
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Mar 2006 21:55:32 -0500
Received: from [192.168.1.20] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 210406BD14; Thu, 23 Mar 2006 03:55:30 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Radoslaw Szkodzinski <astralstorm@o2.pl>
In-Reply-To: <200603230224.54736.astralstorm@o2.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17849>

Radoslaw Szkodzinski wrote:
> On Thursday 23 March 2006 00:28, Andreas Ericsson wrote yet:
> 
>>Btw. I'm assuming you're aware you'll have to GPL this app of yours,
>>since git is GPL and you'll be using the git produce in a way that makes
>>it vital to your app.
> 
> 
> It will be, but not because of git (it's execve()ing it), but rather because 
> of the principle.
> 

Ah, Good Thing. Just to clarify for the archives though, it *is* 
required since it's using git in a way that makes git a fundamental, 
non-replaceable part of its core operations.

> Intermediate results will probably be:
> - later yet another porcelain, written in C
> 

yagit? yagp? What I wanna know is when jigit's gonna hit the streets. :)



-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
