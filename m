From: Seth Falcon <sethfalcon@gmail.com>
Subject: Re: git-format-patch question
Date: Sun, 28 May 2006 18:01:07 -0700
Message-ID: <m2irnplk4s.fsf@ziti.fhcrc.org>
References: <m2odxikktm.fsf@ziti.fhcrc.org>
	<7vpshxdh0s.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon May 29 03:02:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FkW8r-0007NL-RL
	for gcvg-git@gmane.org; Mon, 29 May 2006 03:01:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbWE2BBM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 28 May 2006 21:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbWE2BBM
	(ORCPT <rfc822;git-outgoing>); Sun, 28 May 2006 21:01:12 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:62548 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751083AbWE2BBL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 May 2006 21:01:11 -0400
Received: by py-out-1112.google.com with SMTP id e30so233800pya
        for <git@vger.kernel.org>; Sun, 28 May 2006 18:01:10 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type;
        b=CVGD5g2x50XY3sXiB15GDT7dBE6zZoJsmBbs3Y4J0E9wQAPEW9kJDTdgL6ZepTBWeHVWVIgZLz+pj+PAP4oN3LYsk7QZV4+HePIQ+2Qa6NE6nm+G9mQ7sIGYRXI/BIpZe8eWROwZ9lKZFUs/rBgUeXw35xchA4CS+MZlESp+LuQ=
Received: by 10.35.97.17 with SMTP id z17mr1373728pyl;
        Sun, 28 May 2006 18:01:10 -0700 (PDT)
Received: from ziti.fhcrc.org ( [67.171.24.140])
        by mx.gmail.com with ESMTP id n80sm830541pye.2006.05.28.18.01.09;
        Sun, 28 May 2006 18:01:09 -0700 (PDT)
To: git@vger.kernel.org
In-Reply-To: <7vpshxdh0s.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Sun, 28 May 2006 13:35:31 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20913>

Junio C Hamano <junkio@cox.net> writes:

> Seth Falcon <sethfalcon@gmail.com> writes:
>
>> 1. When is one supposed to use --signoff?  I gather the answer is
>>    project specific, but a statement of what's expected for git
>>    itself would probably help clarify things for me.
>
> You shouldn't ;-).  Rather, you should sign-off when you make a
> commit, or if you are forwarding somebody else's patch, before
> you send the e-mail off.  
>
>> 2. How should I add extra notes to an email generated using
>>    git-format-patch?  Is this in the docs somewhere that I missed?  Is
>>    there a recommended way to do this?
>
> Read the format-patch output in your e-mail buffer and edit just
> like you edit any text you write in your e-mail.

Thanks for the quick answers.  I guess I was imagining things to be
more complicated than they are :-)
