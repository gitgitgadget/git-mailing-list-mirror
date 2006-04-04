From: Jason Riedy <ejr@EECS.Berkeley.EDU>
Subject: Re: [RFH] Solaris cloning woes...
Date: Tue, 04 Apr 2006 11:53:45 -0700
Message-ID: <24378.1144176825@lotus.CS.Berkeley.EDU>
References: <7vu099916v.fsf@assigned-by-dhcp.cox.net>
Cc: git@vger.kernel.org, Peter Eriksen <s022018@student.dtu.dk>
X-From: git-owner@vger.kernel.org Tue Apr 04 20:53:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQqf4-0000ee-RC
	for gcvg-git@gmane.org; Tue, 04 Apr 2006 20:53:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbWDDSxw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Apr 2006 14:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbWDDSxw
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Apr 2006 14:53:52 -0400
Received: from lotus.CS.Berkeley.EDU ([128.32.36.222]:23450 "EHLO
	lotus.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S1750800AbWDDSxw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Apr 2006 14:53:52 -0400
Received: from lotus.CS.Berkeley.EDU (localhost [127.0.0.1])
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/3.141592645) with ESMTP id k34IrkgH024392;
	Tue, 4 Apr 2006 11:53:46 -0700 (PDT)
Received: from lotus.CS.Berkeley.EDU (ejr@localhost)
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/Submit) with ESMTP id k34IrkHr024391;
	Tue, 4 Apr 2006 11:53:46 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
In-reply-to: <7vu099916v.fsf@assigned-by-dhcp.cox.net> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18404>

And Junio C Hamano writes:
 - Once this is confirmed to fix the problem on Solaris boxes, I'd
 - like to include and do an 1.2.5, just in case OpenSolaris folks
 - would want to play with it, and also put them in the "master"
 - branch.

I haven't run into the problem since, but I almost never saw
it in the first place.  Have you been able to trigger it
reliably?  Maybe I'm "lucky" that my Sun's so slow...

Jason
