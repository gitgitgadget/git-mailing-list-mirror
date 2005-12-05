From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: More merge questions (why doesn't this work?)
Date: Mon, 05 Dec 2005 16:01:45 +0100
Message-ID: <20051205150145.GA30765MdfPADPa@greensroom.kotnet.org>
References: <7vek4xsx49.fsf@assigned-by-dhcp.cox.net>
 <20051202091946.1631.qmail@science.horizon.com>
 <7vacfj6c4l.fsf@assigned-by-dhcp.cox.net>
 <20051202130911.GY8383MdfPADPa@greensroom.kotnet.org>
 <7v4q5r2qb2.fsf@assigned-by-dhcp.cox.net>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 05 16:04:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EjHqn-0006ge-6C
	for gcvg-git@gmane.org; Mon, 05 Dec 2005 16:01:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432AbVLEPBy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Dec 2005 10:01:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbVLEPBy
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Dec 2005 10:01:54 -0500
Received: from psmtp04.wxs.nl ([195.121.247.13]:57731 "EHLO psmtp04.wxs.nl")
	by vger.kernel.org with ESMTP id S932432AbVLEPBx (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Dec 2005 10:01:53 -0500
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp04.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.07 (built Jun 24 2005))
 with SMTP id <0IR1001735QX5A@psmtp04.wxs.nl> for git@vger.kernel.org; Mon,
 05 Dec 2005 16:01:47 +0100 (MET)
Received: (qmail 5143 invoked by uid 500); Mon, 05 Dec 2005 15:01:45 +0000
In-reply-to: <7v4q5r2qb2.fsf@assigned-by-dhcp.cox.net>
To: Junio C Hamano <junkio@cox.net>
Mail-followup-to: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13215>

On Fri, Dec 02, 2005 at 12:32:17PM -0800, Junio C Hamano wrote:
> Sven Verdoolaege <skimo@kotnet.org> writes:
> > I do.  git commit won't let me commit an empty tree, or at
> > least I haven't figured out how to make it do that.
> 
> You are right, at least for the initial commit (for subsequent
> commits it happily commits an empty tree).
> 
> Now why anybody would want to it is a different matter.  Is it
> because you would want to record that your project started from
> scratch, as opposed to some import from an existing non
> versioned (or versioned by another SCM) working tree?

Something like that, yes.

In the beginning there as nothing and git commited the nothingness.

skimo
