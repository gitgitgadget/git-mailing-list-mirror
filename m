From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] contrib/git-svn: add show-ignore command
Date: Sun, 26 Feb 2006 15:46:01 -0800
Message-ID: <20060226234601.GA28732@localdomain>
References: <11409493473353-git-send-email-normalperson@yhbt.net> <7vlkvx7mve.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 27 00:46:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDVac-0003Rx-BY
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 00:46:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbWBZXqF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Feb 2006 18:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbWBZXqE
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Feb 2006 18:46:04 -0500
Received: from hand.yhbt.net ([66.150.188.102]:58023 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751107AbWBZXqE (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Feb 2006 18:46:04 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 27D327DC005;
	Sun, 26 Feb 2006 15:46:02 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun, 26 Feb 2006 15:46:01 -0800
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vlkvx7mve.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16806>

Junio C Hamano <junkio@cox.net> wrote:
> After Andrew Morten raised the issue, I've made sure I _really_
> enable my pre-applypatch hook.
> 
> Please enable your pre-commit hook (comes with the distribution
> as a sample hook) to catch these trailing whitespaces before
> they hit your commit objects.

Oops, sorry about this one.  I forgot it on the directory I was working
on at the time.  I've also added Dave Jones' whitespace hilighter lines
to my .vimrc as well.

-- 
Eric Wong
