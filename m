From: Alp Toker <alp@atoker.com>
Subject: Re: [PATCH] Fix some doubled word typos
Date: Mon, 10 Jul 2006 02:42:43 +0100
Message-ID: <44B1B093.9000201@atoker.com>
References: <11524377844177-git-send-email-alp@atoker.com>	<44B1A01F.5090408@atoker.com> <7vodvye10h.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 10 03:43:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fzknj-0002W9-Co
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 03:43:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964965AbWGJBmu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Jul 2006 21:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964976AbWGJBmu
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Jul 2006 21:42:50 -0400
Received: from host-84-9-44-142.bulldogdsl.com ([84.9.44.142]:38669 "EHLO
	ndesk.org") by vger.kernel.org with ESMTP id S964965AbWGJBmu (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jul 2006 21:42:50 -0400
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by ndesk.org (Postfix) with ESMTP id 543234B2B2;
	Mon, 10 Jul 2006 02:42:44 +0100 (BST)
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vodvye10h.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23581>

Junio C Hamano wrote:
> Actually, I am a bit more careful than that ;-).
> 
> I have split your patch into two, and applied the part that
> applicable to "master" first.  The tip of ew/svn topic branch (I
> do not publish topic branch tips) have two patches that are
> still not in even "pu", and one of these two patches is your
> Documentation/git-svn.txt patch.  These two will appear in
> "next" hopefully soon -- I just haven't gotten around to them.

I hadn't realised that git-svn work was happening on a topic branch. In 
light of that, it makes perfect sense to split out the commit as you 
did. It's good to hear that git isn't just truncating patches.

Cheers.
