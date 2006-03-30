From: Mark Wooding <mdw@distorted.org.uk>
Subject: Re: [PATCH] gitk: Use git wrapper to run git-ls-remote.
Date: Thu, 30 Mar 2006 18:26:03 +0000 (UTC)
Organization: Straylight/Edgeware development
Message-ID: <slrne2o8lr.l0.mdw@metalzone.distorted.org.uk>
References: <20060330123151.25779.73775.stgit@metalzone.distorted.org.uk> <7v8xqr3iwt.fsf@assigned-by-dhcp.cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 30 20:26:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FP1qY-0006Bl-CK
	for gcvg-git@gmane.org; Thu, 30 Mar 2006 20:26:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751359AbWC3S0L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Mar 2006 13:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbWC3S0L
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Mar 2006 13:26:11 -0500
Received: from excessus.demon.co.uk ([83.105.60.35]:50545 "HELO
	metalzone.distorted.org.uk") by vger.kernel.org with SMTP
	id S1751359AbWC3S0J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Mar 2006 13:26:09 -0500
Received: (qmail 4452 invoked by uid 110); 30 Mar 2006 18:26:03 -0000
To: git@vger.kernel.org
Received: (qmail 4439 invoked by uid 9); 30 Mar 2006 18:26:03 -0000
Path: not-for-mail
Newsgroups: mail.vger.git
NNTP-Posting-Host: metalzone.distorted.org.uk
X-Trace: metalzone.distorted.org.uk 1143743163 4437 172.29.199.2 (30 Mar 2006 18:26:03 GMT)
X-Complaints-To: usenet@distorted.org.uk
NNTP-Posting-Date: Thu, 30 Mar 2006 18:26:03 +0000 (UTC)
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18202>

Junio C Hamano <junkio@cox.net> wrote:

> Does anybody know what is going on?

I'll try staring at the Tcl source code some time.  I'm rather too busy
tonight, though.

There's also some very strange geometry management oddness going on in
gitk.  I'll try to sort that out too.

-- [mdw]
