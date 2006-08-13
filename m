From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [RFC] git-publish
Date: Sun, 13 Aug 2006 22:41:18 +0200
Message-ID: <20060813204118.GA21956@mars.ravnborg.org>
References: <Pine.LNX.4.64.0608131158500.9789@iabervon.org> <20060813191346.GA21487@mars.ravnborg.org> <Pine.LNX.4.64.0608131536590.9789@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Aug 13 22:41:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCMlw-0006Rf-3P
	for gcvg-git@gmane.org; Sun, 13 Aug 2006 22:41:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751403AbWHMUlV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Aug 2006 16:41:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbWHMUlU
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Aug 2006 16:41:20 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:5060 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751403AbWHMUlU (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Aug 2006 16:41:20 -0400
Received: from mars.ravnborg.org (0x535d98d8.hrnxx9.adsl-dhcp.tele.dk [83.93.152.216])
	by pasmtp.tele.dk (Postfix) with ESMTP id 33F14801D07;
	Sun, 13 Aug 2006 22:41:19 +0200 (CEST)
Received: by mars.ravnborg.org (Postfix, from userid 1000)
	id 9F72D43C01F; Sun, 13 Aug 2006 22:41:18 +0200 (CEST)
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0608131536590.9789@iabervon.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25295>

On Sun, Aug 13, 2006 at 04:11:32PM -0400, Daniel Barkalow wrote:
> On Sun, 13 Aug 2006, Sam Ravnborg wrote:
> 
> > But important note is that publishing is something I defer until some
> > limited test has been done. And when I omit that I have always ended u
> > pushing some crappy stuff that needs to be dealt with.
> 
> I also test before publishing. But I test before committing, too, because 
> I never get anything right (or even logically complete) the first time. My 
> cycle is edit/build/test, and if the test is successful, I commit and 
> push.

It happens that I discover bugs while working on next issue.
And sometime I get my light moments after commiting a patch.

Obviously I test before commit.

	Sam
