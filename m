From: Junio C Hamano <junkio@cox.net>
Subject: Re: Now What?
Date: Thu, 03 Nov 2005 01:00:57 -0800
Message-ID: <7vpspijeba.fsf@assigned-by-dhcp.cox.net>
References: <E1EXTw5-00063o-Gt@jdl.com> <20051103014307.GA1988@pe.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 03 10:01:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXaxz-0004ts-VR
	for gcvg-git@gmane.org; Thu, 03 Nov 2005 10:01:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbVKCJBA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Nov 2005 04:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbVKCJA7
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Nov 2005 04:00:59 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:22675 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751242AbVKCJA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2005 04:00:59 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051103090036.MQLT4527.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 3 Nov 2005 04:00:36 -0500
To: Chris Shoemaker <c.shoemaker@cox.net>
In-Reply-To: <20051103014307.GA1988@pe.Belkin> (Chris Shoemaker's message of
	"Wed, 2 Nov 2005 20:43:07 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11071>

Chris Shoemaker <c.shoemaker@cox.net> writes:

> "I cloned a remote repo. Then I pulled a branch from the remote repo
> and it started changing all the these files.  I paniced and hit
> ctrl-c.  Doh!  I should have checked out the branch locally before
> pulling.  Now what?  How can I recover without cloning the repo
> again?"

Although I am not sure what this example is about,...

> In general, for each common operation, it'd be nice to explain how to
> "undo". 

I think this makes sense.
