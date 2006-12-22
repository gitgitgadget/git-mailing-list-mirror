From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: confusion over the new branch and merge config
Date: Fri, 22 Dec 2006 15:25:45 +0000
Message-ID: <200612221525.46132.alan@chandlerfamily.org.uk>
References: <Pine.LNX.4.64.0612211555210.18171@xanadu.home> <7vfyb85ojf.fsf@assigned-by-dhcp.cox.net> <200612220839.36067.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Andy Parkins <andyparkins@gmail.com>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Dec 22 16:26:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxmHh-00051g-Kt
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 16:26:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945912AbWLVP0G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 10:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945908AbWLVP0G
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 10:26:06 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk ([82.44.22.127]:58692
	"EHLO home.chandlerfamily.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1945912AbWLVP0F (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Dec 2006 10:26:05 -0500
Received: from kanger.home ([192.168.0.21])
	by home.chandlerfamily.org.uk with esmtp (Exim 4.63)
	(envelope-from <alan@chandlerfamily.org.uk>)
	id 1GxmHZ-0008I0-3c; Fri, 22 Dec 2006 15:26:01 +0000
To: git@vger.kernel.org
User-Agent: KMail/1.9.5
In-Reply-To: <200612220839.36067.andyparkins@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35181>

On Friday 22 December 2006 08:39, Andy Parkins wrote:

> Make it almost inconceivable that a remote branch is being starred,
> or that a local branch is making it into the "-r" output.
>
> Alan: could you show a tree of your .git/refs/heads and your
> .git/refs/remotes for the repository that is displaying this error?

It wasn't my repository I was responding to - it was Nicolas Pitre's 
post that listed both remote and local branches - and I then looked at 
the man page to see what -r did and saw that it said "only" remote 
branches.

-- 
Alan Chandler
http://www.chandlerfamily.org.uk
