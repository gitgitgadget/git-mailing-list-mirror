From: Junio C Hamano <junkio@cox.net>
Subject: Re: Status of Mac OS/X ports of git and cogito?
Date: Fri, 26 Aug 2005 20:50:08 -0700
Message-ID: <7vd5o03uof.fsf@assigned-by-dhcp.cox.net>
References: <deofnh$jl0$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 27 05:51:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8rih-000756-Tz
	for gcvg-git@gmane.org; Sat, 27 Aug 2005 05:51:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030293AbVH0DuO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Aug 2005 23:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030295AbVH0DuO
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Aug 2005 23:50:14 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:48550 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1030293AbVH0DuN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2005 23:50:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050827035010.CMVA1860.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 26 Aug 2005 23:50:10 -0400
To: John Ellson <ellson@research.att.com>
In-Reply-To: <deofnh$jl0$1@sea.gmane.org> (John Ellson's message of "Fri, 26
	Aug 2005 21:30:23 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7840>

John Ellson <ellson@research.att.com> writes:

> Do git and cogito build easily on Mac OS/X now?  Are there
> binaries available anywhere?

Not that I know of.  We used to get portability patches from
Darwin folks, but I haven't seen any lately.

I am somewhat interested in what portability glitches we still
have, but not having an access to a machine, it is more of a
curiosity rather than a necessity for me.

Are Darwin folks on the list happy with the current codebase, or
have you given up because it is too GNU/Linux specific?
