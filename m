From: Junio C Hamano <junkio@cox.net>
Subject: Re: Merge with git-pasky II.
Date: Fri, 15 Apr 2005 00:43:47 -0700
Message-ID: <7vfyxsmqmk.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0504140051550.7211@ppc970.osdl.org>
	<7v64ypsqev.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org>
	<7vvf6pr4oq.fsf@assigned-by-dhcp.cox.net>
	<20050414121624.GZ25711@pasky.ji.cz>
	<7vll7lqlbg.fsf@assigned-by-dhcp.cox.net>
	<20050414193507.GA22699@pasky.ji.cz>
	<7vmzs1osv1.fsf@assigned-by-dhcp.cox.net>
	<20050414233159.GX22699@pasky.ji.cz>
	<7v7jj4q2j2.fsf@assigned-by-dhcp.cox.net>
	<20050414223039.GB28082@64m.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, Linus Torvalds <torvalds@osdl.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 09:41:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMLSD-0007mr-8A
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 09:41:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261760AbVDOHov (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 03:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261761AbVDOHov
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 03:44:51 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:18158 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261760AbVDOHou (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2005 03:44:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050415074448.QMHP19936.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 15 Apr 2005 03:44:48 -0400
To: Christopher Li <git@chrisli.org>
In-Reply-To: <20050414223039.GB28082@64m.dyndns.org> (Christopher Li's
 message of "Thu, 14 Apr 2005 18:30:39 -0400")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "CL" == Christopher Li <git@chrisli.org> writes:

>> - Result is this object $SHA1 with mode $mode at $path (takes
>> one of the trees); you can do update-cache --cacheinfo (if
>> you want to muck with dircache) or cat-file blob (if you want
>> to get the file) or both.

CL> Is that SHA1 for tree or the file object?

I am talking about a single file here.


