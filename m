From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: GSoC project mentors
Date: Thu, 8 Mar 2007 10:07:56 -0500
Message-ID: <20070308150756.GB30674@spearce.org>
References: <7vhcsw9h8p.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 08 16:08:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPKDv-0006i4-2R
	for gcvg-git@gmane.org; Thu, 08 Mar 2007 16:08:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752032AbXCHPIC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Mar 2007 10:08:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752063AbXCHPIB
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Mar 2007 10:08:01 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:49830 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752032AbXCHPIA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2007 10:08:00 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HPKDg-0000ub-Qp; Thu, 08 Mar 2007 10:07:53 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8B4F420FBAE; Thu,  8 Mar 2007 10:07:56 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vhcsw9h8p.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41746>

Junio C Hamano <junkio@cox.net> wrote:
> I was trying to see who have been active recently to find GSoC
> mentor candidates by running:
> 
> 	$ git shortlog -s -n --since=4.months | head -n 20

You aren't alone; I did the same stupid thing last night.  Only
without the --since=4.months argument.  Which is the old calling
convention.  At least your little warning would have saved me.  ;-)

<plug>
We need GSoC project mentors!

Reading http://git.or.cz/gitwiki/SoC2007Ideas it appears as though
(with the exception of 2 projects that Martin Langhoff is interested
in, thanks Martin!) I am *the* GSoC mentor.  I really hoped that we
could get more community involvement than that.  Junio's "top 20"
is an interesting set of people, but there are still some very
interesting and qualified names in the top 65...

Please, look over the SoC2007Ideas list on the wiki and stick your
name next to a project or two that you have watched on the mailing
list, are interested in seeing get added to Git, and would like to
help out with this summer.

Being a GSoC mentor does have a time commitment.  You will need to
work with the student via email to help them find their way around
the Git source code, and to help them refine their changes such
that they are suitable for acceptance to the respective Git tree.

Remember, our goal here is to have a working enhancement that Junio
would be proud to merge!
</plug>

-- 
Shawn.
