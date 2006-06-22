From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: whitespace cleanup around '='
Date: Thu, 22 Jun 2006 02:33:55 -0700
Message-ID: <7vodwlsfek.fsf@assigned-by-dhcp.cox.net>
References: <20060622023546.28cb4291.froese@gmx.de>
	<11509591773212-git-send-email-jnareb@gmail.com>
	<7vejxhwts4.fsf@assigned-by-dhcp.cox.net> <e7dh1c$61n$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 22 11:34:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtLZZ-0002NL-08
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 11:34:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964895AbWFVJd6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 05:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932478AbWFVJd6
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 05:33:58 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:14482 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932470AbWFVJd5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jun 2006 05:33:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060622093356.KUY554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 22 Jun 2006 05:33:56 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <e7dh1c$61n$1@sea.gmane.org> (Jakub Narebski's message of "Thu,
	22 Jun 2006 09:32:09 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22317>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano wrote:
>
>> I thought we were both reasonably sure that we are now in
>> sync...  I could apply it by hand but once I start doing that
>> I'm afraid we will never converge.
>> 
>> It's quite frustrating.
>
> I'm very sorry, I forgot that I applied Timo Hirvonen patch
>
>   "[PATCH] gitweb: Start search from HEAD"
>   (<20060620152515.23e59396.tihirvon@gmail.com>)
>   http://permalink.gmane.org/gmane.comp.version-control.git/22197>
>
> on top of 'next'.

I remember discussing things with Timo and was putting it on
hold since I knew you were also actively futzing on gitweb.

But I think what you have is this one instead:

Message-ID: <20060620164105.7276a45f.tihirvon@gmail.com>

I applied it in jn/gitweb topic and then applied your whitespace
fixes on top of the result, after discarding the whitespace
cleanup I sent out earlier.  So let's make sure we are resync'ed
and continue from here.  I'll push out the updated "next"
soonish.
