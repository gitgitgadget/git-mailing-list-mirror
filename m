From: Mark Wooding <mdw@distorted.org.uk>
Subject: Re: [PATCH] Invoke git-repo-config directly.
Date: Fri, 17 Mar 2006 10:51:33 +0000 (UTC)
Organization: Straylight/Edgeware development
Message-ID: <slrne1l55l.fr9.mdw@metalzone.distorted.org.uk>
References: <20060314211022.GA12498@localhost.localdomain> <Pine.LNX.4.64.0603141351470.3618@g5.osdl.org> <20060314224027.GB14733@localhost.localdomain> <Pine.LNX.4.64.0603141506130.3618@g5.osdl.org> <7vek13ieap.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0603151450070.3618@g5.osdl.org> <7vlkvbffhz.fsf@assigned-by-dhcp.cox.net> <20060316075324.GA19650@pfit.vm.bytemark.co.uk> <7v64mebxsu.fsf@assigned-by-dhcp.cox.net> <slrne1inu0.fr9.mdw@metalzone.distorted.org.uk> <44196DE7.8010205@op5.se> <7vy7z97rdr.fsf@assigned-by-dhcp.cox.net>
X-From: git-owner@vger.kernel.org Fri Mar 17 11:51:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FKCYl-0000ig-Rx
	for gcvg-git@gmane.org; Fri, 17 Mar 2006 11:51:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752588AbWCQKvi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Mar 2006 05:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752590AbWCQKvi
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Mar 2006 05:51:38 -0500
Received: from excessus.demon.co.uk ([83.105.60.35]:17895 "HELO
	metalzone.distorted.org.uk") by vger.kernel.org with SMTP
	id S1752588AbWCQKvh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Mar 2006 05:51:37 -0500
Received: (qmail 837 invoked by uid 110); 17 Mar 2006 10:51:33 -0000
To: git@vger.kernel.org
Received: (qmail 824 invoked by uid 9); 17 Mar 2006 10:51:33 -0000
Path: not-for-mail
Newsgroups: mail.vger.git
NNTP-Posting-Host: metalzone.distorted.org.uk
X-Trace: metalzone.distorted.org.uk 1142592693 511 172.29.199.2 (17 Mar 2006 10:51:33 GMT)
X-Complaints-To: usenet@distorted.org.uk
NNTP-Posting-Date: Fri, 17 Mar 2006 10:51:33 +0000 (UTC)
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17665>

Junio C Hamano <junkio@cox.net> wrote:

> and the above would not break things.

Indeed.  I just translated Junio's `git_exec' shell function into a
one-liner.

-- [mdw]
