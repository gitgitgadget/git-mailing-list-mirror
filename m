From: Keith Cascio <keith@CS.UCLA.EDU>
Subject: Re: diff settings
Date: Sat, 24 Jan 2009 12:01:25 -0800 (PST)
Message-ID: <alpine.GSO.2.00.0901241159050.23073@kiwi.cs.ucla.edu>
References: <alpine.GSO.2.00.0901240936080.23073@kiwi.cs.ucla.edu> <87ocxwv6qg.fsf@iki.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Sat Jan 24 21:04:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQojo-0002D2-7s
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 21:04:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752155AbZAXUBi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 15:01:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752895AbZAXUBh
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 15:01:37 -0500
Received: from Kiwi.CS.UCLA.EDU ([131.179.128.19]:57379 "EHLO kiwi.cs.ucla.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752491AbZAXUBh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 15:01:37 -0500
Received: from kiwi.cs.ucla.edu (localhost.cs.ucla.edu [127.0.0.1])
	by kiwi.cs.ucla.edu (8.13.8+Sun/8.13.8/UCLACS-6.0) with ESMTP id n0OK1PF8025680;
	Sat, 24 Jan 2009 12:01:25 -0800 (PST)
Received: from localhost (keith@localhost)
	by kiwi.cs.ucla.edu (8.13.8+Sun/8.13.8/Submit) with ESMTP id n0OK1PFl025676;
	Sat, 24 Jan 2009 12:01:25 -0800 (PST)
X-Authentication-Warning: kiwi.cs.ucla.edu: keith owned process doing -bs
In-Reply-To: <87ocxwv6qg.fsf@iki.fi>
User-Agent: Alpine 2.00 (GSO 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107001>

> It seems that the answer is "no", but aliases are a work-around:
> 
>     git config --global alias.dff "diff -w"
> 
> Then "git dff" is your new "git diff -w". :-)

That feature is gonna come in handy.  It doesn't 100% fulfill my needs here but 
I like it!  Thanks, I did not know about alias.*
