From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Omit patches that have already been merged from format-patch output.
Date: Mon, 12 Sep 2005 04:48:55 -0700
Message-ID: <7voe6yik0o.fsf@assigned-by-dhcp.cox.net>
References: <46a038f905091101529e045af@mail.gmail.com>
	<7voe6zqr9y.fsf@assigned-by-dhcp.cox.net>
	<46a038f905091200245f6330d9@mail.gmail.com>
	<46a038f905091202343306846@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 12 13:52:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEmpL-0001xv-5G
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 13:50:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbVILLs6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 07:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbVILLs5
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 07:48:57 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:43395 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750763AbVILLs5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2005 07:48:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050912114856.IDYC9510.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 12 Sep 2005 07:48:56 -0400
To: martin.langhoff@gmail.com
In-Reply-To: <46a038f905091202343306846@mail.gmail.com> (Martin Langhoff's
	message of "Mon, 12 Sep 2005 21:34:30 +1200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8377>

Martin Langhoff <martin.langhoff@gmail.com> writes:

> Strike that. PEBCAK: my branch entry was pointing to the wrong place. Sorry. 

Thanks for quick correction.  Just from a curiosity, do you run
GIT from the proposed updates branch?  I am asking because that
suspect git-format-patch change is supposed to be only in there.

I am somewhat seriously curious.  How many of you on the list
regularly look at what is in the proposed updates, and how many
of you actually run it?
