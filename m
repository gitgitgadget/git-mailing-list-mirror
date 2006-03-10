From: Mark Wooding <mdw@distorted.org.uk>
Subject: Re: [PATCH] Add git-imap-send.
Date: Fri, 10 Mar 2006 00:38:56 +0000 (UTC)
Organization: Straylight/Edgeware development
Message-ID: <slrne11il0.fr9.mdw@metalzone.distorted.org.uk>
References: <440C3499.9080000@codeweavers.com> <7vacbz7vod.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0603091227560.20277@wbgn013.biozentrum.uni-wuerzburg.de> <4410140E.2000609@op5.se> <Pine.LNX.4.63.0603091243001.20908@wbgn013.biozentrum.uni-wuerzburg.de> <slrne10b8c.fr9.mdw@metalzone.distorted.org.uk> <Pine.LNX.4.63.0603091445280.21440@wbgn013.biozentrum.uni-wuerzburg.de>
X-From: git-owner@vger.kernel.org Fri Mar 10 01:42:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHViO-00044z-Je
	for gcvg-git@gmane.org; Fri, 10 Mar 2006 01:42:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbWCJAjI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Mar 2006 19:39:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422646AbWCJAjA
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Mar 2006 19:39:00 -0500
Received: from excessus.demon.co.uk ([83.105.60.35]:63158 "HELO
	metalzone.distorted.org.uk") by vger.kernel.org with SMTP
	id S1422651AbWCJAi6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Mar 2006 19:38:58 -0500
Received: (qmail 32167 invoked by uid 110); 10 Mar 2006 00:38:56 -0000
To: git@vger.kernel.org
Received: (qmail 32154 invoked by uid 9); 10 Mar 2006 00:38:56 -0000
Path: not-for-mail
Newsgroups: mail.vger.git
NNTP-Posting-Host: metalzone.distorted.org.uk
X-Trace: metalzone.distorted.org.uk 1141951136 32152 172.29.199.2 (10 Mar 2006 00:38:56 GMT)
X-Complaints-To: usenet@distorted.org.uk
NNTP-Posting-Date: Fri, 10 Mar 2006 00:38:56 +0000 (UTC)
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17442>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> I would be astonished if memcmp has to be timing proof for *all*
> applications, just to keep crypto people happy. I don't *want* a
> slow-down in my super-duper 3d shooter.

Oh, obviously that would be lunatic! ;-) Just making the point that it's
not /completely/ obvious that early stopping is what everyone wants...

-- [mdw]
