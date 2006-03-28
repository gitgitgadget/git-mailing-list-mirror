From: Junio C Hamano <junkio@cox.net>
Subject: Re: Gitk strangeness..
Date: Mon, 27 Mar 2006 18:12:07 -0800
Message-ID: <7vwtefmi6g.fsf@assigned-by-dhcp.cox.net>
References: <7v64lzo1j7.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0603271802030.15714@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 28 04:12:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FO3gr-0001lB-5K
	for gcvg-git@gmane.org; Tue, 28 Mar 2006 04:12:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbWC1CMK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Mar 2006 21:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbWC1CMK
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Mar 2006 21:12:10 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:21152 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932173AbWC1CMJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Mar 2006 21:12:09 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060328021208.HSUY6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 27 Mar 2006 21:12:08 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603271802030.15714@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 27 Mar 2006 18:05:49 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18101>

Linus Torvalds <torvalds@osdl.org> writes:

> Maybe it's not a new thing, and it's just that the recent pattern of 
> merges in the git tree makes any version of gitk do horrible things.

It is both, but new gitk plays a major part of it.

There are too wide horizontal lines when many merges are
involved.  My "next" branch from yesterday (which is essentially
what my "master" branch today) was somewhat more pleasant to
read with older gitk, but only somewhat.
