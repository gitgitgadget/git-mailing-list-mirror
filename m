From: Andreas Ericsson <ae@op5.se>
Subject: Re: Pulling tags from git.git
Date: Thu, 09 Mar 2006 18:24:45 +0100
Message-ID: <441064DD.2010903@op5.se>
References: <4dd15d180603061044h3f70d48bk8006c15e605fdca1@mail.gmail.com>	<4dd15d180603061054k36d1a434se7377ded1b3240bb@mail.gmail.com>	<440D5285.3050401@op5.se> <7voe0ilf25.fsf@assigned-by-dhcp.cox.net>	<440D7A7D.8070507@op5.se> <87zmk0dq75.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 09 18:25:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHOsc-0000w0-1p
	for gcvg-git@gmane.org; Thu, 09 Mar 2006 18:24:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbWCIRYr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Mar 2006 12:24:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbWCIRYr
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Mar 2006 12:24:47 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:53987 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1750799AbWCIRYr
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 9 Mar 2006 12:24:47 -0500
Received: from [192.168.1.20] (host-213.88.215.14.addr.se.sn.net [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id DA9906BCFF; Thu,  9 Mar 2006 18:24:45 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Florian Weimer <fw@deneb.enyo.de>
In-Reply-To: <87zmk0dq75.fsf@mid.deneb.enyo.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17428>

Florian Weimer wrote:
> * Andreas Ericsson:
> 
> [lightweight tags]
> 
> 
>>I'm fairly sure we shouldn't. The default update-hook prevents them
>>(if enabled), and I can't for the life of me think of why anyone would
>>want to distribute such tags.
> 
> 
> The current implementation is rather counter-intuitive because it's
> much easier to create lightweight tags, and you wonder why they aren't
> replicated by fetches (but some other tags are).


Well, you wouldn't want to go through the trouble of writing a 
tag-message for a temporary tag, but signing and writing a short note 
for a tag that you intend those who share your workload to have is not 
that much of a bother imo.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
