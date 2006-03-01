From: Junio C Hamano <junkio@cox.net>
Subject: Re: impure renames / history tracking
Date: Wed, 01 Mar 2006 14:46:35 -0800
Message-ID: <7vk6bdeqb8.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0603011343170.13612@sheen.jakma.org>
	<4405C012.6080407@op5.se>
	<Pine.LNX.4.64.0603011558390.13612@sheen.jakma.org>
	<46a038f90603011005m68af7485qfdfffb9f82717427@mail.gmail.com>
	<Pine.LNX.4.64.0603011851430.13612@sheen.jakma.org>
	<7v3bi2ey63.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0603012105230.13612@sheen.jakma.org>
	<44061C59.20204@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Jakma <paul@clubi.ie>, git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 01 23:47:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEa5j-0000CN-7h
	for gcvg-git@gmane.org; Wed, 01 Mar 2006 23:46:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbWCAWqk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 17:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWCAWqk
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 17:46:40 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:62162 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751325AbWCAWqk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Mar 2006 17:46:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060301224448.RQC20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 1 Mar 2006 17:44:48 -0500
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <44061C59.20204@op5.se> (Andreas Ericsson's message of "Wed, 01
	Mar 2006 23:12:41 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17023>

Andreas Ericsson <ae@op5.se> writes:

> Just to cap off my own engagement in this discussion, here's the last
> time rename detection was seriously discussed on the list:
>
> http://www.gelato.unsw.edu.au/archives/git/0504/0147.html
>
> If you're going to implement something you might benefit from the
> suggestions made there.

Also, today's #git log has some interesting material.

	http://colabti.de/irclogger/irclogger_logs/git

For anybody who wants to discuss rename recording (not
tracking), the following is a must-read:

	http://article.gmane.org/gmane.comp.version-control.git/217
