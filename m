From: Junio C Hamano <junkio@cox.net>
Subject: Re: Rebase semantic and cherry-pick
Date: Wed, 29 Mar 2006 18:38:20 -0800
Message-ID: <7vwtec7j37.fsf@assigned-by-dhcp.cox.net>
References: <1143596622.2481.10.camel@mattlaptop.metaesthetics.net>
	<Pine.LNX.4.64.0603281749060.15714@g5.osdl.org>
	<7vlkutc36w.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0603291102440.15714@g5.osdl.org>
	<e0fe1h$d5r$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 30 04:39:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FOn3n-0005wV-Ou
	for gcvg-git@gmane.org; Thu, 30 Mar 2006 04:38:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751450AbWC3CiY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Mar 2006 21:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbWC3CiY
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Mar 2006 21:38:24 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:33731 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751450AbWC3CiX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Mar 2006 21:38:23 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060330023821.MXFZ6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 29 Mar 2006 21:38:21 -0500
To: jnareb@gmail.com
In-Reply-To: <e0fe1h$d5r$1@sea.gmane.org> (Jakub Narebski's message of "Thu,
	30 Mar 2006 03:59:16 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18184>

Jakub Narebski <jnareb@gmail.com> writes:

> Perhaps if possible also have
>
> git cherry-pick --whole-branch branchname
>
> meaning
>
> git cherry-pick branchname:begining..branchname:HEAD

There is no branchname:beginning in git.
