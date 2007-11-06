From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-revert is one of the most misunderstood command in
 git, help users out.
Date: Tue, 6 Nov 2007 22:25:48 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711062225090.4362@racer.site>
References: <1194289301-7800-1-git-send-email-madcoder@debian.org>
 <200711062106.57083.robin.rosenberg.lists@dewire.com> <20071106201324.GA30262@glandium.org>
 <200711062221.58475.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mike Hommey <mh@glandium.org>, Junio C Hamano <gitster@pobox.com>,
	Steven Grimm <koreth@midwinter.com>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 23:27:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpWsv-0004wY-7E
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 23:27:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754389AbXKFW0q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 17:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754505AbXKFW0p
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 17:26:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:45234 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754332AbXKFW0p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 17:26:45 -0500
Received: (qmail invoked by alias); 06 Nov 2007 22:26:43 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp012) with SMTP; 06 Nov 2007 23:26:43 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+ir88Tnmaiu3jEPEq2dVOA2NkpTJ3ZfrbQVEdfDf
	2TUkmdZ3UOhuVX
X-X-Sender: gene099@racer.site
In-Reply-To: <200711062221.58475.robin.rosenberg.lists@dewire.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63739>

Hi,

On Tue, 6 Nov 2007, Robin Rosenberg wrote:

> tisdag 06 november 2007 skrev Mike Hommey:
> > Maybe the documentation could emphasise on how to undo things when the
> > user makes mistakes.
> > Sometimes, saving your repo can be as simple as git reset --hard HEAD@{1}.
> > This is not, unfortunately, a works-for-all-cases command.
> 
> Yea, git-undo(7). 

In related news, I know a few users who need an un-rm-rf.  Anyone?

Ciao,
Dscho
