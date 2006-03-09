From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-fmt-merge-msg cleanup
Date: Wed, 08 Mar 2006 18:27:51 -0800
Message-ID: <7vzmk0fj2w.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0603081753270.32577@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 09 03:28:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHAsh-0003KO-MI
	for gcvg-git@gmane.org; Thu, 09 Mar 2006 03:28:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932710AbWCIC1x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Mar 2006 21:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932712AbWCIC1x
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Mar 2006 21:27:53 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:7069 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932710AbWCIC1x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Mar 2006 21:27:53 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060309022759.CUDC25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 8 Mar 2006 21:27:59 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603081753270.32577@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 8 Mar 2006 17:56:07 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17394>

Linus Torvalds <torvalds@osdl.org> writes:

> Since I've started using the "merge.summary" flag in my repo, my merge 
> messages look nicer, but I dislike how I get notifications of merges 
> within merges.
>
> So I'd suggest this trivial change..

Makes sense.  Thanks.
