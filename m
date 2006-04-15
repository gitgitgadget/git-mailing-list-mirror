From: Junio C Hamano <junkio@cox.net>
Subject: Re: [WISH] prepend diffstat in front of the patch
Date: Sat, 15 Apr 2006 02:16:54 -0700
Message-ID: <7vejzzi4ft.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550604150207h6fdb0042x3a9bbfa63269a8c8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 15 11:17:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUgtn-0007V3-7f
	for gcvg-git@gmane.org; Sat, 15 Apr 2006 11:17:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424AbWDOJQ4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Apr 2006 05:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbWDOJQ4
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Apr 2006 05:16:56 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:6577 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751605AbWDOJQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Apr 2006 05:16:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060415091655.ONAG18351.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 15 Apr 2006 05:16:55 -0400
To: "Marco Costalba" <mcostalba@gmail.com>
In-Reply-To: <e5bfff550604150207h6fdb0042x3a9bbfa63269a8c8@mail.gmail.com>
	(Marco Costalba's message of "Sat, 15 Apr 2006 11:07:40 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18734>

"Marco Costalba" <mcostalba@gmail.com> writes:

> Perhaps I missed something, but I would like to see --stat and -p as 
> _cumulative_ options .

Yes, you missed my write-up on "Recent unresolved issues",
especially this entry:

    * Message-ID: <7vek02ynif.fsf@assigned-by-dhcp.cox.net>
      diff --with-raw, --with-stat? (me)

and the thread that introduced the --stat option.

It is also what I want, but there is only 24 hours in a day and
there is this thing called day-job.
