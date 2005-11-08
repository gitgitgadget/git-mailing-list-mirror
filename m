From: Junio C Hamano <junkio@cox.net>
Subject: Re: Comments on recursive merge..
Date: Mon, 07 Nov 2005 16:59:46 -0800
Message-ID: <7v4q6oosxp.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0511070837530.3193@g5.osdl.org>
	<20051107225807.GA10937@c165.ib.student.liu.se>
	<7vll00ov2l.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511071629270.3247@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Fredrik Kuivinen <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Tue Nov 08 02:00:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZHq3-000670-Hy
	for gcvg-git@gmane.org; Tue, 08 Nov 2005 01:59:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964954AbVKHA7t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Nov 2005 19:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964977AbVKHA7s
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Nov 2005 19:59:48 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:10416 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S964954AbVKHA7s (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2005 19:59:48 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051108005904.QAVJ29216.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 7 Nov 2005 19:59:04 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511071629270.3247@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 7 Nov 2005 16:33:56 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11298>

Linus Torvalds <torvalds@osdl.org> writes:

> On Mon, 7 Nov 2005, Junio C Hamano wrote:
>> 
>> This is the first time I see you pleased by something in git
>> that was done without very close supervision from you.
>
> That sounds like a backhanded way of saying that I'm micromanagering, 
> picky and difficult to work with ;)

Sorry, that is not what I meant to say at all.

You used to micromanage, but it was _very_ good for git back
then.  I admit that only once I found you too picky and
difficult to work with while I was fixing a bad premature-free
bug in the diffcore-rename code, but overall your attention to
detail well paid off.

Since I inherited the project, we added quite a lot of stuff,
but I was still unsure if we are making good progress, or just
stagnating with only small enhancements and obvious fixes.

But Fredrik merge turns out to be a spectacular success as you
found out, which is a triumph for Fredrik, but at the same time
it means I was not doing too bad myself ;-).
