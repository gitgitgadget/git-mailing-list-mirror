From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/3] Call extended-semantics commands through variables.
Date: Sat, 11 Feb 2006 15:32:56 -0800
Message-ID: <7v64nllbdj.fsf@assigned-by-dhcp.cox.net>
References: <7vwtg2mmx5.fsf@assigned-by-dhcp.cox.net>
	<4230.1139699411@lotus.CS.Berkeley.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 12 00:33:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F84Ee-0000Or-VT
	for gcvg-git@gmane.org; Sun, 12 Feb 2006 00:33:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842AbWBKXc6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Feb 2006 18:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbWBKXc6
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Feb 2006 18:32:58 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:14781 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750840AbWBKXc5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2006 18:32:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060211233017.CCPB26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 11 Feb 2006 18:30:17 -0500
To: Jason Riedy <ejr@EECS.Berkeley.EDU>
In-Reply-To: <4230.1139699411@lotus.CS.Berkeley.EDU> (Jason Riedy's message of
	"Sat, 11 Feb 2006 15:10:11 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15966>

Jason Riedy <ejr@EECS.Berkeley.EDU> writes:

> And I worry about using different programs in different 
> scripts, so I just changed all of them.

That's a good point.  I stand corrected.
