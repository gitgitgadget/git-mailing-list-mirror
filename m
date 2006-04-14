From: Jason Riedy <ejr@EECS.Berkeley.EDU>
Subject: Re: Solaris test t5500 race condition
Date: Fri, 14 Apr 2006 09:41:59 -0700
Message-ID: <9647.1145032919@lotus.CS.Berkeley.EDU>
References: <20060414115317.GA5191@bohr.gbar.dtu.dk>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 14 18:42:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FURN1-0003gA-WE
	for gcvg-git@gmane.org; Fri, 14 Apr 2006 18:42:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbWDNQmD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Apr 2006 12:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbWDNQmD
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Apr 2006 12:42:03 -0400
Received: from lotus.CS.Berkeley.EDU ([128.32.36.222]:41377 "EHLO
	lotus.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S1751271AbWDNQmC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Apr 2006 12:42:02 -0400
Received: from lotus.CS.Berkeley.EDU (localhost [127.0.0.1])
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/3.141592645) with ESMTP id k3EGg0gH009652;
	Fri, 14 Apr 2006 09:42:00 -0700 (PDT)
Received: from lotus.CS.Berkeley.EDU (ejr@localhost)
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/Submit) with ESMTP id k3EGfxRc009651;
	Fri, 14 Apr 2006 09:42:00 -0700 (PDT)
To: "Peter Eriksen" <s022018@student.dtu.dk>
In-reply-to: <20060414115317.GA5191@bohr.gbar.dtu.dk> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18692>

And "Peter Eriksen" writes:
 - > -- >8 --
 - > [PATCH] t5500: test fix
 - 
 - With the patch it doesn't complain anymore.  There are many other 
 - problems with the tests on Solaris though.

I just ran next branch's tests on 5.8 with no problems.  Could 
you be a bit more specific?

Jason
