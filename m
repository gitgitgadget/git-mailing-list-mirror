From: Junio C Hamano <junkio@cox.net>
Subject: Re: gitweb "tag" display
Date: Sat, 20 Aug 2005 12:09:59 -0700
Message-ID: <7v7jegl914.fsf@assigned-by-dhcp.cox.net>
References: <17130.56620.137642.941175@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.58.0508050658260.3258@g5.osdl.org>
	<Pine.LNX.4.58.0508050710460.3258@g5.osdl.org>
	<20050806033654.GA27953@vrfy.org>
	<7vacju9az9.fsf_-_@assigned-by-dhcp.cox.net>
	<7vpssq7vfa.fsf@assigned-by-dhcp.cox.net>
	<17158.27011.7426.577686@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 20 21:10:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E6YjL-0003C7-H4
	for gcvg-git@gmane.org; Sat, 20 Aug 2005 21:10:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932793AbVHTTKF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 20 Aug 2005 15:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932814AbVHTTKF
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Aug 2005 15:10:05 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:5867 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932797AbVHTTKB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Aug 2005 15:10:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050820191000.ZIIO12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 20 Aug 2005 15:10:00 -0400
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17158.27011.7426.577686@cargo.ozlabs.ibm.com> (Paul Mackerras's
	message of "Sat, 20 Aug 2005 09:21:39 +1000")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Paul Mackerras <paulus@samba.org> writes:

> I did something a little easier - if you click on the tag, it now
> displays the contents of the tag in the details pane.  Is that good
> enough?

Looks very nice, and a lot more sensible than those unsolicited
popups I hate very much.

> I implemented these two.  There is now a "Reread references" button in
> the File menu.  References other than tags and heads get displayed in
> a light blue box.

Wonderful.

> Hmmm... now I suppose we want a way to use gitk to drive the git
> bisection process... :)

Yes!  That was the direction I was implying.
