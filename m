From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 5/5] gitweb: Quote filename in HTTP Content-Disposition: header
Date: Mon, 25 Sep 2006 21:11:29 -0700
Message-ID: <7v7izrw9la.fsf@assigned-by-dhcp.cox.net>
References: <200609260153.08503.jnareb@gmail.com>
	<200609260159.43684.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 26 06:12:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GS4IP-000673-8i
	for gcvg-git@gmane.org; Tue, 26 Sep 2006 06:11:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbWIZELc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 00:11:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750876AbWIZELc
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 00:11:32 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:18101 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750847AbWIZELa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Sep 2006 00:11:30 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060926041130.WWGO6077.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>;
          Tue, 26 Sep 2006 00:11:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id SsBT1V00Y1kojtg0000000
	Tue, 26 Sep 2006 00:11:27 -0400
To: Jakub Narebski <jnareb@gmail.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27767>

Jakub Narebski <jnareb@gmail.com> writes:

> Finish work started by a2f3db2f5de2a3667b0e038aa65e3e097e642e7d commit
> (although not documented in commit message) of quoting using quotemeta
> the filename in HTTP -content_disposition header.  Uniquify output.
>
> Just in case filename contains end of line character.

What do you mean by "uniquify output"?
