From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 5/5] git-daemon support for user-relative paths.
Date: Mon, 21 Nov 2005 15:29:28 -0800
Message-ID: <7vhda5mvfr.fsf@assigned-by-dhcp.cox.net>
References: <20051117193714.428785C7FA@nox.op5.se>
	<7voe4ird8v.fsf@assigned-by-dhcp.cox.net> <437DAA66.6070301@op5.se>
	<7voe4hfssj.fsf@assigned-by-dhcp.cox.net> <437E67AC.2010400@op5.se>
	<7vfypquz88.fsf@assigned-by-dhcp.cox.net> <4381AB38.7090209@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 22 00:34:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeL6L-0006mY-SL
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 00:29:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbVKUX3a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 18:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932477AbVKUX3a
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 18:29:30 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:34955 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932460AbVKUX3a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 18:29:30 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051121232852.NYYG6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 21 Nov 2005 18:28:52 -0500
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <4381AB38.7090209@op5.se> (Andreas Ericsson's message of "Mon, 21
	Nov 2005 12:10:48 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12501>

Andreas Ericsson <ae@op5.se> writes:

> Apart from comments and indentation it's more or less exactly what I 
> have in my revised git-daemon patch (although without what you mentioned 
> in your own reply to this mail).
>
> Do you want the revised one from me or will you apply the original with 
> this on top?

Well, let's push out what we have so far to "master" and then
finish up whatever breakage if any in tree.
