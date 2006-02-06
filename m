From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-commit: revamp the git-commit semantics.
Date: Sun, 05 Feb 2006 23:31:16 -0800
Message-ID: <7virrtaqpn.fsf@assigned-by-dhcp.cox.net>
References: <7vpsm2hzng.fsf@assigned-by-dhcp.cox.net>
	<20060205225116.GC24561@blinkenlights.visv.net>
	<7vwtg9cq0k.fsf@assigned-by-dhcp.cox.net>
	<7vzml5b7az.fsf@assigned-by-dhcp.cox.net>
	<20060206022553.GB25603@blinkenlights.visv.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 06 08:31:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F60qH-0004Fe-HI
	for gcvg-git@gmane.org; Mon, 06 Feb 2006 08:31:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbWBFHbS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Feb 2006 02:31:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750708AbWBFHbS
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Feb 2006 02:31:18 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:51195 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750705AbWBFHbR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2006 02:31:17 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060206072830.EZSW17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 6 Feb 2006 02:28:30 -0500
To: Michael Fischer <michael@visv.net>
In-Reply-To: <20060206022553.GB25603@blinkenlights.visv.net> (Michael
	Fischer's message of "Sun, 5 Feb 2006 21:25:54 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15651>

Michael Fischer <michael@visv.net> writes:

> On Sun, Feb 05, Junio C Hamano wrote:
>> Junio C Hamano <junkio@cox.net> writes:
>> 
>> > To keep yourself up to date:
>> >
>> > 	$ git clone git://git.kernel.org/pub/scm/git master.git
>> 
>> Silly me.  This URL is wrong.
>> 
>> 	$ git clone git://git.kernel.org/pub/scm/git/git master.git
>
> Thanks. Instructions followed, patch tried:
>
> From within a subdirectory:
>
> $ git commit -m"fix the bounce file" bounce.html 
> assuming --include paths...
> $
>
> Both my nits are solved. Happy. Thanks.

Thanks for the feedback.
