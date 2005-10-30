From: Junio C Hamano <junkio@cox.net>
Subject: Re: GIT 0.99.9
Date: Sat, 29 Oct 2005 20:39:48 -0700
Message-ID: <7vslujy8or.fsf@assigned-by-dhcp.cox.net>
References: <7vd5lnztav.fsf@assigned-by-dhcp.cox.net>
	<43643AF8.9090001@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 30 04:41:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EW43C-00082t-HR
	for gcvg-git@gmane.org; Sun, 30 Oct 2005 04:40:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932809AbVJ3Dju (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 29 Oct 2005 23:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932810AbVJ3Dju
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Oct 2005 23:39:50 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:16053 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932809AbVJ3Djt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Oct 2005 23:39:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051030033859.IIAB24014.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 29 Oct 2005 23:38:59 -0400
To: gitzilla@gmail.com
In-Reply-To: <43643AF8.9090001@gmail.com> (A. Large Angry's message of "Sat,
	29 Oct 2005 20:16:08 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10813>

A Large Angry SCM <gitzilla@gmail.com> writes:

> It's nice to see the TODO list get shorter for a change! Especially 
> since the removed TODO items are not on the HAVEDONE list.

Huh?  What are you talking about?

Most of the items that were on the TODO list and marked [DONE]
are on the HAVEDONE list, although I rephrased many of them to
be more appropriate for the release notes.  The only thing that
I did not list on HAVEDONE list was 'whatchanged -m'
documentation.  There are many documentation contributions from
the list I do not mention in HAVEDONE.

I dropped from the TODO list was the "Perhaps show ^{commit},
^{tree} instead of ^{} from ls-remote", whose benefit was
dubious.
