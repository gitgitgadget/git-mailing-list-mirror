From: Junio C Hamano <junkio@cox.net>
Subject: Re: Change set based shallow clone
Date: Sat, 09 Sep 2006 18:22:08 -0700
Message-ID: <7vvenwv7lr.fsf@assigned-by-dhcp.cox.net>
References: <9e4733910609081413p32456768g280bdc9b232d7902@mail.gmail.com>
	<Pine.LNX.4.64.0609081944060.27779@g5.osdl.org>
	<17666.13716.401727.601933@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0609082054560.27779@g5.osdl.org>
	<e5bfff550609090147q37d61f37j9c3e8ae6d3a0cf35@mail.gmail.com>
	<Pine.LNX.4.64.0609091022360.27779@g5.osdl.org>
	<e5bfff550609091104s3709b82fld3057a07a84ae857@mail.gmail.com>
	<Pine.LNX.4.64.0609091256110.27779@g5.osdl.org>
	<20060909204307.GB16906@coredump.intra.peff.net>
	<Pine.LNX.4.64.0609091433460.27779@g5.osdl.org>
	<9e4733910609091554m2a8a001axd575defff9a0e7a9@mail.gmail.com>
	<Pine.LNX.4.64.0609091708340.27779@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 10 03:21:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GME0w-00042h-ET
	for gcvg-git@gmane.org; Sun, 10 Sep 2006 03:21:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965074AbWIJBVf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 9 Sep 2006 21:21:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965075AbWIJBVf
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Sep 2006 21:21:35 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:44681 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S965074AbWIJBVf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Sep 2006 21:21:35 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060910012134.NVFJ6077.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>;
          Sat, 9 Sep 2006 21:21:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id LRMZ1V00m1kojtg0000000
	Sat, 09 Sep 2006 21:21:35 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0609091708340.27779@g5.osdl.org> (Linus Torvalds's
	message of "Sat, 9 Sep 2006 17:18:10 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26778>

Linus Torvalds <torvalds@osdl.org> writes:

> But hey, maybe somebody can come up with some operation that becomes 
> _much_ cheaper with the above kind of sequence number. It shouldn't be 
> hard to test..

Sometimes I get a feeling that we are saying the same thing in
the same thread but in parallel without reading what the other
is saying.  This is such a thread ;-).
