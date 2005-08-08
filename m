From: Junio C Hamano <junkio@cox.net>
Subject: Re: Request for help from binary packaging people.
Date: Mon, 08 Aug 2005 15:49:13 -0700
Message-ID: <7v8xzc11ue.fsf@assigned-by-dhcp.cox.net>
References: <7v8xzfde7t.fsf@assigned-by-dhcp.cox.net>
	<7vr7d6z3pn.fsf@assigned-by-dhcp.cox.net>
	<7vacjsdcbj.fsf@assigned-by-dhcp.cox.net>
	<7vwtmw5nx7.fsf_-_@assigned-by-dhcp.cox.net>
	<20050808185858.GC8041@shell0.pdx.osdl.net>
	<7vbr482ik5.fsf@assigned-by-dhcp.cox.net>
	<20050808222119.GE7762@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 09 00:50:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2GQp-0004E9-BG
	for gcvg-git@gmane.org; Tue, 09 Aug 2005 00:49:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331AbVHHWtQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Aug 2005 18:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932332AbVHHWtQ
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Aug 2005 18:49:16 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:17544 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932331AbVHHWtP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2005 18:49:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050808224914.OAJM12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 8 Aug 2005 18:49:14 -0400
To: Chris Wright <chrisw@osdl.org>
In-Reply-To: <20050808222119.GE7762@shell0.pdx.osdl.net> (Chris Wright's
	message of "Mon, 8 Aug 2005 15:21:19 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Chris Wright <chrisw@osdl.org> writes:

>> I take it to mean that we do not have to explicitly list perl
>> module dependencies.  If that is the case then I presume that
>> the current dependency list is fine.
>
> That's correct.  The only benefit to itemzing the package level dependency in
> this case is just for an error message that tells you which package
> you're missing rather than the low-level perl module.

Again, thanks.
