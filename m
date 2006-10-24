From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/1 (amend)] gitweb: Use fixed string for "next" link in commitdiff view
Date: Tue, 24 Oct 2006 02:17:49 -0700
Message-ID: <7vfydehy2q.fsf@assigned-by-dhcp.cox.net>
References: <200610230037.57183.jnareb@gmail.com>
	<200610240008.08325.jnareb@gmail.com>
	<20061023232117.GV20017@pasky.or.cz>
	<200610241104.18517.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 24 11:17:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcIPx-0000X8-Mo
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 11:17:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030227AbWJXJRu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Oct 2006 05:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030228AbWJXJRu
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 05:17:50 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:55241 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1030227AbWJXJRu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Oct 2006 05:17:50 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061024091750.TGHC12581.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>;
          Tue, 24 Oct 2006 05:17:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id e9Ht1V00C1kojtg0000000
	Tue, 24 Oct 2006 05:17:54 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200610241104.18517.jnareb@gmail.com> (Jakub Narebski's message
	of "Tue, 24 Oct 2006 11:04:18 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29952>

Jakub Narebski <jnareb@gmail.com> writes:

> Use fixed string instead of shortened SHA1 identifier of commit
> as a name for "mext" link in commitdiff view.
>
> While at it make sure that we don't mistake option for a second
> commit.
>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---

Q1. (amend) to fix what?
Q2. "mext"?
