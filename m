From: David Miller <davem@davemloft.net>
Subject: Re: Git and GCC
Date: Wed, 05 Dec 2007 18:52:03 -0800 (PST)
Message-ID: <20071205.185203.262588544.davem@davemloft.net>
References: <4aca3dc20712051108s216d3331t8061ef45b9aa324a@mail.gmail.com> 	<20071205.182815.249974508.davem@davemloft.net> 	<4aca3dc20712051841o71ab773ft6dd0714ebc355dd5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: ismail@pardus.org.tr, gcc@gcc.gnu.org, git@vger.kernel.org
To: dberlin@dberlin.org
X-From: gcc-return-142712-gcc=m.gmane.org@gcc.gnu.org Thu Dec 06 03:52:33 2007
Return-path: <gcc-return-142712-gcc=m.gmane.org@gcc.gnu.org>
Envelope-to: gcc@gmane.org
Received: from sourceware.org ([209.132.176.174])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1J06qi-0007zK-Pf
	for gcc@gmane.org; Thu, 06 Dec 2007 03:52:29 +0100
Received: (qmail 21666 invoked by alias); 6 Dec 2007 02:52:10 -0000
Received: (qmail 21640 invoked by uid 22791); 6 Dec 2007 02:52:10 -0000
X-Spam-Check-By: sourceware.org
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net (HELO sunset.davemloft.net) (74.93.104.97)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 06 Dec 2007 02:52:06 +0000
Received: from localhost (localhost [127.0.0.1]) 	by sunset.davemloft.net (Postfix) with ESMTP id ADABFC8C15C; 	Wed,  5 Dec 2007 18:52:03 -0800 (PST)
In-Reply-To: <4aca3dc20712051841o71ab773ft6dd0714ebc355dd5@mail.gmail.com>
X-Mailer: Mew version 5.2 on Emacs 22.1 / Mule 5.0 (SAKAKI)
X-IsSubscribed: yes
Mailing-List: contact gcc-help@gcc.gnu.org; run by ezmlm
Precedence: bulk
List-Id: <gcc.gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcc=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
Delivered-To: mailing list gcc@gcc.gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67225>

From: "Daniel Berlin" <dberlin@dberlin.org>
Date: Wed, 5 Dec 2007 21:41:19 -0500

> It is true I gave up quickly, but this is mainly because i don't like
> to fight with my tools.
> I am quite fine with a distributed workflow, I now use 8 or so gcc
> branches in mercurial (auto synced from svn) and merge a lot between
> them. I wanted to see if git would sanely let me manage the commits
> back to svn.  After fighting with it, i gave up and just wrote a
> python extension to hg that lets me commit non-svn changesets back to
> svn directly from hg.

I find it ironic that you were even willing to write tools to
facilitate your hg based gcc workflow.  That really shows what your
thinking is on this matter, in that you're willing to put effort
towards making hg work better for you but you're not willing to expend
that level of effort to see if git can do so as well.

This is what really eats me from the inside about your dissatisfaction
with git.  Your analysis seems to be a self-fullfilling prophecy, and
that's totally unfair to both hg and git.
