From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: Gitk feature - show nearby tags
Date: Mon, 5 Jun 2006 23:11:33 +0200
Message-ID: <20060605211133.GC17300@diku.dk>
References: <17537.22675.678700.118093@cargo.ozlabs.ibm.com> <7vslmm8rcd.fsf@assigned-by-dhcp.cox.net> <20060603151240.GA4024@diku.dk> <7vejy48wp5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 05 23:11:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnMMO-0006q4-WB
	for gcvg-git@gmane.org; Mon, 05 Jun 2006 23:11:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750869AbWFEVLg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Jun 2006 17:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750887AbWFEVLg
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jun 2006 17:11:36 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:18158 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1750862AbWFEVLf (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Jun 2006 17:11:35 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id E736777002F;
	Mon,  5 Jun 2006 23:11:34 +0200 (CEST)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 21007-08; Mon,  5 Jun 2006 23:11:33 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id A5465770027;
	Mon,  5 Jun 2006 23:11:33 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 73E826DF823; Mon,  5 Jun 2006 23:08:15 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 87BE5625FB; Mon,  5 Jun 2006 23:11:33 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vejy48wp5.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21341>

Junio C Hamano <junkio@cox.net> wrote Sun, Jun 04, 2006:
> I do not necessarily think an ascii-art is needed, nor an
> appropriate way to present it to the curses user.

With certain limitations, I think it could be useful for some
epositories. Optionally, of course.

> When the user wants to "view" a commit, you could show from which
> branch heads and from which tags the commit is reachable, and perhaps
> which tag is the latest among the ones reachable from that commit, as
> part of the commit detail information you display on the lower pane
> (log/diff view).

Thanks for recapping, I've added this to the TODO file.

-- 
Jonas Fonseca
