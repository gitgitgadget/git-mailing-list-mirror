From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: What's in git.git repository
Date: Sat, 15 Oct 2005 12:03:09 +0200
Message-ID: <20051015100309.GR8383MdfPADPa@greensroom.kotnet.org>
References: <7vwtkfpbyk.fsf@assigned-by-dhcp.cox.net>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 15 12:04:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQisn-0008Iz-Aa
	for gcvg-git@gmane.org; Sat, 15 Oct 2005 12:03:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751072AbVJOKDN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Oct 2005 06:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbVJOKDN
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Oct 2005 06:03:13 -0400
Received: from smtp19.wxs.nl ([195.121.6.15]:7659 "EHLO smtp19.wxs.nl")
	by vger.kernel.org with ESMTP id S1751072AbVJOKDN (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Oct 2005 06:03:13 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp19.wxs.nl (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with SMTP id <0IOE00B4GBXADL@smtp19.wxs.nl> for git@vger.kernel.org; Sat,
 15 Oct 2005 12:03:10 +0200 (CEST)
Received: (qmail 14124 invoked by uid 500); Sat, 15 Oct 2005 10:03:09 +0000
In-reply-to: <7vwtkfpbyk.fsf@assigned-by-dhcp.cox.net>
To: Junio C Hamano <junkio@cox.net>
Mail-followup-to: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10129>

On Fri, Oct 14, 2005 at 10:48:35PM -0700, Junio C Hamano wrote:
> I'd have this graduate to the "master" branch after some more
> testing, only if people are interested in it; otherwise I'm
> thinking about dropping this (I am not particularly interested
> in this enhancement myself).

Dereferencing of tags to trees could be interesting for tools
such as dirdiff.  Of course, you can always do the dereferencing
yourself and I'm planning on rewriting it in C anyway.

skimo
