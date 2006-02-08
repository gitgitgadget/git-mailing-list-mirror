From: Jason Riedy <ejr@EECS.Berkeley.EDU>
Subject: Re: [PATCH] .gitignore git-rerere and config.mak
Date: Tue, 07 Feb 2006 19:55:31 -0800
Message-ID: <1303.1139370931@lotus.CS.Berkeley.EDU>
References: <7vk6c7uj21.fsf@assigned-by-dhcp.cox.net>
X-From: git-owner@vger.kernel.org Wed Feb 08 04:55:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6gQb-0003uz-OP
	for gcvg-git@gmane.org; Wed, 08 Feb 2006 04:55:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964874AbWBHDzc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Feb 2006 22:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbWBHDzc
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Feb 2006 22:55:32 -0500
Received: from lotus.CS.Berkeley.EDU ([128.32.36.222]:33181 "EHLO
	lotus.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S932172AbWBHDzc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2006 22:55:32 -0500
Received: from lotus.CS.Berkeley.EDU (localhost [127.0.0.1])
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8) with ESMTP id k183tVxV001305
	for <git@vger.kernel.org>; Tue, 7 Feb 2006 19:55:31 -0800 (PST)
Received: from lotus.CS.Berkeley.EDU (ejr@localhost)
	by lotus.CS.Berkeley.EDU (8.12.8/8.12.8/Submit) with ESMTP id k183tVL5001304
	for <git@vger.kernel.org>; Tue, 7 Feb 2006 19:55:31 -0800 (PST)
To: git@vger.kernel.org
In-reply-to: <7vk6c7uj21.fsf@assigned-by-dhcp.cox.net> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15730>

And Junio C Hamano writes:
 - I am not sure about this part.  It is plausible that somebody
 - who privately uses config.mak has it in _his_ repository under
 - version control.

Like me.  That way I don't have to worry about conflicts in the
Makefile.  But I can change .gitignore in those branches...

Jason
