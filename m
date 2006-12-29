From: Shawn Pearce <spearce@spearce.org>
Subject: Re: branch.pu.forcefetch
Date: Thu, 28 Dec 2006 23:31:57 -0500
Message-ID: <20061229043157.GB12072@spearce.org>
References: <1167251519.2247.10.camel@dv> <7vfyb159dn.fsf@assigned-by-dhcp.cox.net> <1167341346.12660.17.camel@dv> <7vzm97tzbt.fsf@assigned-by-dhcp.cox.net> <1167355326.15189.34.camel@dv> <7v8xgrsabr.fsf@assigned-by-dhcp.cox.net> <1167363263.15189.79.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 29 05:32:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1H09Pk-0000o5-AM
	for gcvg-git@gmane.org; Fri, 29 Dec 2006 05:32:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932647AbWL2EcE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Dec 2006 23:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932648AbWL2EcE
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Dec 2006 23:32:04 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:60943 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932647AbWL2EcD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Dec 2006 23:32:03 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1H09Or-0008P8-7V; Thu, 28 Dec 2006 23:31:21 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id ABE9B20FB65; Thu, 28 Dec 2006 23:31:57 -0500 (EST)
To: Pavel Roskin <proski@gnu.org>
Content-Disposition: inline
In-Reply-To: <1167363263.15189.79.camel@dv>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35579>

Pavel Roskin <proski@gnu.org> wrote:
> Just a random idea - if fast-forward fails, save the original head
> somewhere under refs as a backup.  It's like "patch" saving *.orig files
> if there is any doubt that the patch was applied cleanly.

That's the entire point of the reflog.  :-)

-- 
Shawn.
