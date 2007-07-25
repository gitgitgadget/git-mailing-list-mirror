From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach git-commit about commit message templates.
Date: Wed, 25 Jul 2007 00:39:58 -0700
Message-ID: <7vlkd5dj8x.fsf@assigned-by-dhcp.cox.net>
References: <20070723041741.GA22461@midwinter.com>
	<Pine.LNX.4.64.0707231059490.14781@racer.site>
	<46A481B4.7000502@midwinter.com>
	<Pine.LNX.4.64.0707231136530.14781@racer.site>
	<46A48949.1020501@midwinter.com>
	<7vfy3fkpr8.fsf@assigned-by-dhcp.cox.net>
	<46A5EA2D.1030707@midwinter.com>
	<7v3azdh400.fsf@assigned-by-dhcp.cox.net>
	<46A6F0C8.7010204@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Wed Jul 25 09:40:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDbTe-0003O7-OP
	for gcvg-git@gmane.org; Wed, 25 Jul 2007 09:40:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763744AbXGYHkB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 03:40:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763616AbXGYHkB
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 03:40:01 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:50509 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763534AbXGYHkA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 03:40:00 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070725074000.MSRY1358.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Wed, 25 Jul 2007 03:40:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Tjfy1X00A1kojtg0000000; Wed, 25 Jul 2007 03:39:59 -0400
In-Reply-To: <46A6F0C8.7010204@midwinter.com> (Steven Grimm's message of "Wed,
	25 Jul 2007 14:42:16 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53673>

Steven Grimm <koreth@midwinter.com> writes:

> Junio C Hamano wrote:
>> No, I am way more cunning and lazy than that.  I did not have
>> hunch about the common case, so I just had you (and anybody else
>> who would join the thread) do necessary thinking and guessing
>> for me ;-)
>>
>
> Ah, good. So it sounds like what I've got is at least an okay first
> cut from a functionality point of view. Dscho (or anyone else), any
> objections to the code in v2 of my patch? I believe I addressed all
> the feedback from v1.

I have already queued it for 1.5.3-rc3.  Thanks.
