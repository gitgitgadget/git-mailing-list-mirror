From: Junio C Hamano <junkio@cox.net>
Subject: [OT] western cultural imperialism at vger?
Date: Wed, 21 Dec 2005 15:24:39 -0800
Message-ID: <7v8xue11ag.fsf_-_@assigned-by-dhcp.cox.net>
References: <20051222.072045.31468866.yoshfuji@linux-ipv6.org>
	<7v1x065blx.fsf@assigned-by-dhcp.cox.net>
	<7v3bkm3vw4.fsf@assigned-by-dhcp.cox.net>
	<20051222.080828.28117009.yoshfuji@linux-ipv6.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 22 00:25:24 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EpDKg-0003ru-Tf
	for gcvg-git@gmane.org; Thu, 22 Dec 2005 00:25:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964975AbVLUXYt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Dec 2005 18:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964979AbVLUXYs
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Dec 2005 18:24:48 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:2263 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S964975AbVLUXYr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2005 18:24:47 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051221232253.NGDN17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 21 Dec 2005 18:22:53 -0500
To: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <20051222.080828.28117009.yoshfuji@linux-ipv6.org> (YOSHIFUJI
	Hideaki's message of "Thu, 22 Dec 2005 08:08:28 +0900 (JST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13913>

YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org> writes:

> In article <7v3bkm3vw4.fsf@assigned-by-dhcp.cox.net> (at Wed, 21 Dec 2005 14:52:59 -0800), Junio C Hamano <junkio@cox.net> says:
>
>> This is the second reply to Yoshifuji-san today that did not
>> come back to me from the list (but I did get it back from my ISP
>> due to BCCing myself), so I am resending.
>
> I got all of them; with and without my Japanese name on To:.

Your "oops this is the corrected patch" message appeared in my
mailbox only once, which suggests vger discarded it.  It does
not appear on marc nor gmane archive either.

It seems to me that vger drops messages whose content-type is
"text/plain; charset=iso-2022-jp"; this western cultural
imperialism is inexcusable -- the list accepts iso-8859-1 just
fine, so it is not like it is us-ascii only.  It just does not
like iso-2022-jp.

Nah, I am just joking about the "imperialism" part, but I think
that is what is happening.

Most of your messages, although you have your Japanese name on
the From: header line, are charset=us-ascii, and indeed the body
of them are us-ascii only, and is flowing on the list just fine.
The "oops this is the corrected patch" message from you was done
as a reply to your own message, which started with something
like this (Japanese omitted for obvious reasons):

    In article <20051221.192342.132228413.yoshfuji@linux-ipv6.org> (at Wed, 21 Dec 2005 19:23:42 +0900 (JST)), YOSHIFUJI Hideaki / [J][J][J][J] <yoshfuji@linux-ipv6.org> says:

    > Hello.
    > 
    > Allow address enclosed by [] in URLs, like:
    >    git push '[3ffe:ffff:...:1]:GIT/git'
    > or
    >    git push 'ssh://[3ffe:ffff:...:1]/GIT/git'
    > 
    > Signed-off-by: YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>

    oops, this is not correct. Please use this instead.

Which made your MUA to send it in iso-2022-jp, and I suspect
that is why I saw it only once, direct delivery.
