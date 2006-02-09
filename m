From: Junio C Hamano <junkio@cox.net>
Subject: Re: gitweb using "--cc"?
Date: Thu, 09 Feb 2006 14:00:30 -0800
Message-ID: <7vk6c48a69.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602081532360.2458@g5.osdl.org>
	<43EAA560.8030504@didntduck.org>
	<Pine.LNX.4.64.0602081817040.2458@g5.osdl.org>
	<7vu0b9jkad.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602090822100.2458@g5.osdl.org>
	<Pine.LNX.4.64.0602091029310.2458@g5.osdl.org>
	<7v3bisb9qn.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602091216460.2458@g5.osdl.org>
	<Pine.LNX.4.64.0602091235210.2458@g5.osdl.org>
	<7v8xsk9s3v.fsf@assigned-by-dhcp.cox.net>
	<7v4q389rwi.fsf@assigned-by-dhcp.cox.net>
	<7voe1g8air.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 09 23:00:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7Jq7-0000f3-FC
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 23:00:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbWBIWAd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Feb 2006 17:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750806AbWBIWAd
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Feb 2006 17:00:33 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:33714 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750805AbWBIWAc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2006 17:00:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060209215715.FJZC20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 9 Feb 2006 16:57:15 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7voe1g8air.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 09 Feb 2006 13:53:00 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15833>

Junio C Hamano <junkio@cox.net> writes:

> On top of your patch, it was quite easy ;-)
>
> After the "Evil merge" in your test script, I added these:
>
>...
>
>         git diff-tree -M --cc HEAD

Sorry for the noise.  The test was broken.
