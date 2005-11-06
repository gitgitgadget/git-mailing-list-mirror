From: Nikolai Weibull <mailing-lists.git@rawuncut.elitemail.org>
Subject: Re: Documentation Directions
Date: Sun, 6 Nov 2005 23:03:48 +0100
Message-ID: <20051106220348.GA9036@puritan.petwork>
References: <E1EYoQE-0002QX-VM@jdl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Nov 06 23:05:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYscC-0008BP-7o
	for gcvg-git@gmane.org; Sun, 06 Nov 2005 23:03:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbVKFWDt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 Nov 2005 17:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbVKFWDt
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Nov 2005 17:03:49 -0500
Received: from mxfep02.bredband.com ([195.54.107.73]:53499 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S932267AbVKFWDs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Nov 2005 17:03:48 -0500
Received: from ironport.bredband.com ([195.54.107.82] [195.54.107.82])
          by mxfep02.bredband.com with ESMTP
          id <20051106220347.IXTR16437.mxfep02.bredband.com@ironport.bredband.com>
          for <git@vger.kernel.org>; Sun, 6 Nov 2005 23:03:47 +0100
Received: from c-fa2b70d5.018-10-67626713.cust.bredbandsbolaget.se (HELO puritan.petwork) ([213.112.43.250])
  by ironport.bredband.com with ESMTP; 06 Nov 2005 23:03:17 +0100
X-IronPort-AV: i="3.97,298,1125871200"; 
   d="scan'208"; a="8132755:sNHT30689334"
Received: by puritan.petwork (Postfix, from userid 1000)
	id F417DADFE2; Sun,  6 Nov 2005 23:03:48 +0100 (CET)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <E1EYoQE-0002QX-VM@jdl.com>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11230>

Jon Loeliger wrote:

> - Is the plan to update all docs to use $GIT_DIR instead of .git?

Well, shouldn't we go all the way and use ${GIT_DIR:-.git} then?  :-)

        nikolai

-- 
Nikolai Weibull: now available free of charge at http://bitwi.se/!
Born in Chicago, IL USA; currently residing in Gothenburg, Sweden.
main(){printf(&linux["\021%six\012\0"],(linux)["have"]+"fun"-97);}
