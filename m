From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] built-in "git grep" (git grip).
Date: Tue, 02 May 2006 11:39:32 +0200
Message-ID: <445728D4.60301@op5.se>
References: <7v1wvetfuj.fsf@assigned-by-dhcp.cox.net> <e34bdf$ho4$1@sea.gmane.org> <7vhd4as00i.fsf@assigned-by-dhcp.cox.net> <e34cb4$is1$1@sea.gmane.org> <44571967.7080807@op5.se> <7vy7xkn6kd.fsf@assigned-by-dhcp.cox.net> <e378fs$lpc$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 02 11:39:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FarM2-0000Sk-V2
	for gcvg-git@gmane.org; Tue, 02 May 2006 11:39:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbWEBJjf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 May 2006 05:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbWEBJjf
	(ORCPT <rfc822;git-outgoing>); Tue, 2 May 2006 05:39:35 -0400
Received: from linux-server1.op5.se ([193.201.96.2]:32975 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1750824AbWEBJje
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 2 May 2006 05:39:34 -0400
Received: from [192.168.1.20] (host-213.88.215.14.addr.se.sn.net [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id 193096BCBC; Tue,  2 May 2006 11:39:33 +0200 (CEST)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <e378fs$lpc$1@sea.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19413>

Jakub Narebski wrote:
> Junio C Hamano wrote:
> 
> 
>>Andreas Ericsson <ae@op5.se> writes:
>>
>>
>>>"git grip" work just fine for me, since it's only intended for testing
>>>and performance improvements so far. I also think it's clearer for
>>>end-users looking for a grep command if they're not faced with
>>>fgrep/egrep/ggrep/bgrep alongside plain "grep".
>>
>>I renamed "git grip" to "git grep" and "git diffn" to "git diff"
>>both in "next" branch to avoid confusion.  Thanks Andreas,
>>Jakub, and others for input.
> 
> 
> So, is there a way to use old, script version of those commands?
> 

Use "master" branch or "git-grep" syntax if you're trying "next" branch.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
