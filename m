From: Junio C Hamano <junkio@cox.net>
Subject: Re: Gitk feature - show nearby tags
Date: Mon, 05 Jun 2006 13:08:19 -0700
Message-ID: <7v4pyz4b7w.fsf@assigned-by-dhcp.cox.net>
References: <17537.22675.678700.118093@cargo.ozlabs.ibm.com>
	<7vslmm8rcd.fsf@assigned-by-dhcp.cox.net>
	<20060603151240.GA4024@diku.dk>
	<7vejy48wp5.fsf@assigned-by-dhcp.cox.net>
	<20060605000423.GA29521@diku.dk>
	<7v3bek7589.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 05 22:08:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnLNJ-0003Ie-Jd
	for gcvg-git@gmane.org; Mon, 05 Jun 2006 22:08:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbWFEUIW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Jun 2006 16:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbWFEUIW
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jun 2006 16:08:22 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:62379 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751400AbWFEUIV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jun 2006 16:08:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060605200820.IKXQ19284.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 5 Jun 2006 16:08:20 -0400
To: Jonas Fonseca <fonseca@diku.dk>
In-Reply-To: <7v3bek7589.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 04 Jun 2006 18:37:10 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21336>

Junio C Hamano <junkio@cox.net> writes:

> Jonas Fonseca <fonseca@diku.dk> writes:
>
> Whichever was the latest when I wrote the message.  I see you
> have added a handful commits on it since then.
>
>>>     - Press UP or DOWN and I can move the highlight to
>>>       neighbouring commits.  This is wonderful, but the lower
>>>       pane does not follow this -- it keeps showing the original
>>>       commit, and I have to say ENTER again.
>>
>> .. this unnecessary.
>
> Maybe I am misusing it then.

Sorry, I *was* misusing it.  I was doing PageUp/PageDown.  Duh.

I typed uparrow and downarrow while in the split view and it was
doing what I wanted to do.
