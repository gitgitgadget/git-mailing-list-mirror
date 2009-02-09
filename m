From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: [ANNOUNCE] tig-0.14
Date: Mon, 9 Feb 2009 23:07:50 +0100
Message-ID: <20090209220750.GA27232@m62s10.vlinux.de>
References: <20090205204436.GA6072@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Mon Feb 09 23:08:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWeJ4-0004A4-KW
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 23:08:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752913AbZBIWHF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 17:07:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752903AbZBIWHE
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 17:07:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:56814 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754559AbZBIWHB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 17:07:01 -0500
Received: (qmail invoked by alias); 09 Feb 2009 22:06:59 -0000
Received: from m62s10.vlinux.de (EHLO m62s10.vlinux.de) [83.151.21.204]
  by mail.gmx.net (mp071) with SMTP; 09 Feb 2009 23:06:59 +0100
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX1/gDJ8W/trg7D6C10CN0Gfzj388lfJR+NT+1fTEJq
	RUJRbzW58Mkjho
Received: by m62s10.vlinux.de (Postfix, from userid 1000)
	id A1B6A19950; Mon,  9 Feb 2009 23:07:50 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090205204436.GA6072@diku.dk>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109144>

First, let me say I like tig very much and apreciate your effort on
making it the best console based git viewer.

Now I have a little UI glitch, which might be solved already. If im
browsing through a lot of commits, I'd like to have a way to advance to
tne next/previous commit while also showing the diff like in the pictore
below. Right now I alwasy press 'q' to leave the diff view, select
commit C and press return to show me the diff. Wouldn't it be nice to
have a way to advance to the next diff without leaving the diff window?

  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  |  commit A
  | >commit B
  |  commit C
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  | diff --git a/tig.c b/tig.c
  | index aec50bc..2dd0ef6 100644
  | --- a/tig.c
  | +++ b/tig.c
    ....

Greetings,
Peter
