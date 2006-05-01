From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] built-in "git grep" (git grip).
Date: Sun, 30 Apr 2006 23:59:57 -0700
Message-ID: <7vhd4as00i.fsf@assigned-by-dhcp.cox.net>
References: <7v1wvetfuj.fsf@assigned-by-dhcp.cox.net>
	<e34bdf$ho4$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 01 09:00:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FaSO1-0000Mn-8t
	for gcvg-git@gmane.org; Mon, 01 May 2006 09:00:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbWEAG77 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 May 2006 02:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbWEAG77
	(ORCPT <rfc822;git-outgoing>); Mon, 1 May 2006 02:59:59 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:28413 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751291AbWEAG76 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 May 2006 02:59:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060501065958.TQYA21197.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 1 May 2006 02:59:58 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <e34bdf$ho4$1@sea.gmane.org> (Jakub Narebski's message of "Mon,
	01 May 2006 08:56:36 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19374>

Jakub Narebski <jnareb@gmail.com> writes:

> Wouldn't "git ggrep" (from git-aware grep) or "git bgrep" (from built-in
> grep), similar to the egrep and fgrep from the grep package?

The eventual goal is to rename it to "git grep" and remove the
shell based one, so the interim name does not matter.
