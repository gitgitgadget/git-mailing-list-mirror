From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] count-delta.c: Match the delta data semantics change in version 3.
Date: Fri, 10 Feb 2006 09:19:05 -0800
Message-ID: <7vlkwjw2ra.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602091736500.5397@localhost.localdomain>
	<7v7j846qco.fsf@assigned-by-dhcp.cox.net>
	<7vbqxg3tdd.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602092053200.5397@localhost.localdomain>
	<Pine.LNX.4.64.0602101017420.5397@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 11 01:49:06 2006
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1F7bvL-0000u2-00
	for <gcvg-git@gmane.org>; Fri, 10 Feb 2006 18:19:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbWBJRTI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Feb 2006 12:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbWBJRTI
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Feb 2006 12:19:08 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:36045 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751337AbWBJRTH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2006 12:19:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060210171614.WPUZ17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 10 Feb 2006 12:16:14 -0500
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0602101017420.5397@localhost.localdomain> (Nicolas
	Pitre's message of "Fri, 10 Feb 2006 10:20:40 -0500 (EST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15908>

You are right about that comment.  Thanks.
