From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] config: read system-wide defaults from /etc/gitconfig
Date: Thu, 15 Feb 2007 02:03:40 -0800
Message-ID: <20070215100340.GA30015@localdomain>
References: <slrnet5p5h.s9h.siprbaum@xp.machine.xx> <Pine.LNX.4.63.0702141246160.22628@wbgn013.biozentrum.uni-wuerzburg.de> <45D35092.8040901@xs4all.nl> <7vr6sso8w8.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0702142015150.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7vfy98o78i.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0702142049430.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7v1wkshtxg.fsf@assigned-by-dhcp.cox.net> <7v4ppnhkps.fsf@assigned-by-dhcp.cox.net> <20070215095903.GA6292@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, hanwen@xs4all.nl,
	Peter Baumann <siprbaum@stud.informatik.uni-erlangen.de>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 15 11:03:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHdSr-0002su-0r
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 11:03:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965430AbXBOKDm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 05:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965464AbXBOKDm
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 05:03:42 -0500
Received: from hand.yhbt.net ([66.150.188.102]:58627 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965430AbXBOKDl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 05:03:41 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 2EB2E7DC09A;
	Thu, 15 Feb 2007 02:03:40 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Thu, 15 Feb 2007 02:03:40 -0800
Content-Disposition: inline
In-Reply-To: <20070215095903.GA6292@localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39806>

Eric Wong <normalperson@yhbt.net> wrote:
> Junio C Hamano <junkio@cox.net> wrote:
> > Junio C Hamano <junkio@cox.net> writes:
> > different.  So I think the above "hack" I described still honors
> > its intended use.

GIT_CONFIG continues to work here with the latest git-svn + your hack

-- 
Eric Wong
