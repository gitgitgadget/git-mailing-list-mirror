From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git
Date: Fri, 10 Feb 2006 07:02:50 -0800
Message-ID: <7vpslvw92d.fsf@assigned-by-dhcp.cox.net>
References: <7vslqtf2p1.fsf@assigned-by-dhcp.cox.net>
	<12c511ca0602091514p35c3904bha8d5d406e5472969@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 11 03:16:17 2006
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1F7ajg-0002YM-00
	for <gcvg-git@gmane.org>; Fri, 10 Feb 2006 17:03:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbWBJPCy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Feb 2006 10:02:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbWBJPCy
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Feb 2006 10:02:54 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:54740 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932127AbWBJPCx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2006 10:02:53 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060210150124.QOFA6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 10 Feb 2006 10:01:24 -0500
To: Tony Luck <tony.luck@intel.com>
In-Reply-To: <12c511ca0602091514p35c3904bha8d5d406e5472969@mail.gmail.com>
	(Tony Luck's message of "Thu, 9 Feb 2006 15:14:59 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15914>

Tony Luck <tony.luck@intel.com> writes:

> On 2/8/06, Junio C Hamano <junkio@cox.net> wrote:
> [ ... about the "next" branch ... ]
>
> This is pretty much the workflow in my test/release branches (mostly
> documented in Documentation/howto/using-topic-branches.txt).

Yup.  Sorry I did not make that clear.  You deserve the credit.

I am beginning to feel this workflow might benefit from some
tool support, but I haven't had enough experience to talk about
exactly what they are yet.

For example, listing topics that have ever been merged into a
particular branch, listing topics that have not been fully
merged into a particular branch, etc. are things I find myself
doing frequently.  I vaguely recall seeing your post that has
these things.
