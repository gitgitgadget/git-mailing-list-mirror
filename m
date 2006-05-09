From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH/RFC] gitopt - command-line parsing enhancements
Date: Tue, 9 May 2006 14:14:13 -0700
Message-ID: <20060509211413.GA12589@localdomain>
References: <1147151209168-git-send-email-normalperson@yhbt.net> <7vzmhr7fys.fsf@assigned-by-dhcp.cox.net> <20060509194825.GC3676@localdomain> <7vr7332ba0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 09 23:14:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdZX7-0007Wm-Vs
	for gcvg-git@gmane.org; Tue, 09 May 2006 23:14:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751020AbWEIVOP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 May 2006 17:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751021AbWEIVOP
	(ORCPT <rfc822;git-outgoing>); Tue, 9 May 2006 17:14:15 -0400
Received: from hand.yhbt.net ([66.150.188.102]:41189 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751019AbWEIVOP (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 May 2006 17:14:15 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 46B502DC034;
	Tue,  9 May 2006 14:14:13 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue,  9 May 2006 14:14:13 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vr7332ba0.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19852>

Junio C Hamano <junkio@cox.net> wrote:
> If you can make it an iterator style, it would be a lot easier
> to see what is going on, I suspect.  Then you would not even
> need the callback function pointers and small functions created
> by magic eat() macros.

That sounds like a great idea, I'll work on it tonight.

-- 
Eric Wong
