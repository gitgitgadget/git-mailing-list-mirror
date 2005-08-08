From: Junio C Hamano <junkio@cox.net>
Subject: Re: Request for help from binary packaging people.
Date: Mon, 08 Aug 2005 15:02:50 -0700
Message-ID: <7vbr482ik5.fsf@assigned-by-dhcp.cox.net>
References: <7v8xzfde7t.fsf@assigned-by-dhcp.cox.net>
	<7vr7d6z3pn.fsf@assigned-by-dhcp.cox.net>
	<7vacjsdcbj.fsf@assigned-by-dhcp.cox.net>
	<7vwtmw5nx7.fsf_-_@assigned-by-dhcp.cox.net>
	<20050808185858.GC8041@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 09 00:04:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2Fhu-0008Sg-Tl
	for gcvg-git@gmane.org; Tue, 09 Aug 2005 00:02:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbVHHWCw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Aug 2005 18:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbVHHWCw
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Aug 2005 18:02:52 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:38587 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932283AbVHHWCv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2005 18:02:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050808220251.IQKR19627.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 8 Aug 2005 18:02:51 -0400
To: Chris Wright <chrisw@osdl.org>
In-Reply-To: <20050808185858.GC8041@shell0.pdx.osdl.net> (Chris Wright's
	message of "Mon, 8 Aug 2005 11:58:58 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Chris Wright <chrisw@osdl.org> writes:

> ...  Also, rpm is able to determine the perl dependencies
> automatically (of course, ditto for shared libraries).

I take it to mean that we do not have to explicitly list perl
module dependencies.  If that is the case then I presume that
the current dependency list is fine.
