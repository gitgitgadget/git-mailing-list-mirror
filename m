From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/3] git-format-patch: Make the second and subsequent mails replies to the first
Date: Fri, 14 Jul 2006 12:32:27 -0700
Message-ID: <7vwtagnfsk.fsf@assigned-by-dhcp.cox.net>
References: <20060710162920.GR20191@harddisk-recovery.com>
	<1152556878.8890.45.camel@josh-work.beaverton.ibm.com>
	<7vwtal9lu1.fsf@assigned-by-dhcp.cox.net>
	<1152897407.5177.8.camel@josh-work.beaverton.ibm.com>
	<7v4pxkoxjp.fsf@assigned-by-dhcp.cox.net>
	<1152904829.5177.19.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 14 21:32:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1TOs-0007fD-19
	for gcvg-git@gmane.org; Fri, 14 Jul 2006 21:32:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161067AbWGNTcb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Jul 2006 15:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161294AbWGNTcb
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Jul 2006 15:32:31 -0400
Received: from fed1rmmtai08.cox.net ([68.230.241.51]:59326 "EHLO
	fed1rmmtai08.cox.net") by vger.kernel.org with ESMTP
	id S1161067AbWGNTca (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jul 2006 15:32:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060714193229.LTAM8537.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 14 Jul 2006 15:32:29 -0400
To: Josh Triplett <josht@us.ibm.com>
In-Reply-To: <1152904829.5177.19.camel@josh-work.beaverton.ibm.com> (Josh
	Triplett's message of "Fri, 14 Jul 2006 12:20:28 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23910>

Josh Triplett <josht@us.ibm.com> writes:

> ..., but you
> suggested that you didn't mind having threading as the default.

Did I? ... then that was either a mistake or miscommunication.

I do mind changing the default output.  I do not mind threading
as the default ONLY IF user asks for output with these extra
headers.
