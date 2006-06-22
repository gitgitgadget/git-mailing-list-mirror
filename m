From: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>
Subject: Re: [PATCH] gitweb: whitespace cleanup around '='
Date: Thu, 22 Jun 2006 12:19:22 +0200
Message-ID: <87psh1ze51.fsf@gmail.com>
References: <20060622023546.28cb4291.froese@gmx.de>
	<11509591773212-git-send-email-jnareb@gmail.com>
	<7vejxhwts4.fsf@assigned-by-dhcp.cox.net> <e7dh1c$61n$1@sea.gmane.org>
	<7vodwlsfek.fsf@assigned-by-dhcp.cox.net> <e7dp9m$v48$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 22 12:19:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtMHo-0001Ui-8j
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 12:19:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751776AbWFVKT2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 06:19:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751777AbWFVKT2
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 06:19:28 -0400
Received: from ifae-s0.ifae.es ([192.101.162.68]:64192 "EHLO ifae-s0.ifae.es")
	by vger.kernel.org with ESMTP id S1751776AbWFVKT2 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jun 2006 06:19:28 -0400
Received: from bela (nb-sbejar.ifae.es [192.101.162.156])
	by ifae-s0.ifae.es (8.11.6/8.11.6) with ESMTP id k5M9ISu14171;
	Thu, 22 Jun 2006 11:18:33 +0200
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <e7dp9m$v48$1@sea.gmane.org> (Jakub Narebski's message of "Thu,
	22 Jun 2006 11:52:53 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22321>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano wrote:
>
>> Jakub Narebski <jnareb@gmail.com> writes:
>
>>> I'm very sorry, I forgot that I applied Timo Hirvonen patch
>>>
>>>   "[PATCH] gitweb: Start search from HEAD"
>>>   Message-ID: <20060620152515.23e59396.tihirvon@gmail.com>
>> 
>> But I think what you have is this one instead:
>> 
>> Message-ID: <20060620164105.7276a45f.tihirvon@gmail.com>
>
> Is the 'note' extension to commit header implemented yet? It it is,then it
> would be nice if git-am recorded original email message-ids in the note
> header. Usually it is of no interest to user, so it should be hidden by
> default.

I put it at the end of the commit message, like the Signed-of-by
lines. And, yes, it would be nice if git-am would add it (--message-id
flag?). If more people is interested I'll try to send a patch.

        Santi
