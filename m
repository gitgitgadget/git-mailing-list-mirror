From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git
Date: Wed, 22 Mar 2006 11:15:02 -0800
Message-ID: <7vmzfi8f61.fsf@assigned-by-dhcp.cox.net>
References: <7vodzzb5q3.fsf@assigned-by-dhcp.cox.net>
	<20060322115218.GT18185@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 22 20:15:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FM8nU-0001e8-TQ
	for gcvg-git@gmane.org; Wed, 22 Mar 2006 20:15:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbWCVTPF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Mar 2006 14:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbWCVTPF
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Mar 2006 14:15:05 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:38820 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932367AbWCVTPD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Mar 2006 14:15:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060322191200.QXIL17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 22 Mar 2006 14:12:00 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060322115218.GT18185@pasky.or.cz> (Petr Baudis's message of
	"Wed, 22 Mar 2006 12:52:18 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17820>

Petr Baudis <pasky@suse.cz> writes:

>>    A new configuration option, 'core.warnambiguousrefs', can be
>>    set to warn you if you use "frotz" to name a ref when you
>>    have more than one "frotz" under $GIT_DIR/refs (e.g. you have
>>    both branch "frotz" and tag "frotz", and/or you have
>>    refs/remotes/frotz/HEAD).
>
> Is there any reason why this isn't enabled by default?

Not in particular, other than Inertia and trying one baby step
at a time.
