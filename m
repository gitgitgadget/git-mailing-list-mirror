From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Finding file revisions
Date: Thu, 28 Apr 2005 14:09:59 +0100
Message-ID: <1114693800.27227.115.camel@hades.cambridge.redhat.com>
References: <200504271251.00635.mason@suse.com>
	 <Pine.LNX.4.58.0504271027460.18901@ppc970.osdl.org>
	 <200504271423.37433.mason@suse.com>
	 <Pine.LNX.4.58.0504271506290.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Chris Mason <mason@suse.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 15:05:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DR8hE-0000Bl-LJ
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 15:04:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbVD1NKN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 09:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262113AbVD1NKN
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 09:10:13 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:21997 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262109AbVD1NKH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2005 09:10:07 -0400
Received: from nat-pool-stn.redhat.com ([62.200.124.98] helo=hades.cambridge.redhat.com)
	by pentafluge.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DR8mK-00042A-Ns; Thu, 28 Apr 2005 14:10:06 +0100
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504271506290.18901@ppc970.osdl.org>
X-Mailer: Evolution 2.0.4 (2.0.4-1.dwmw2.1) 
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 2005-04-27 at 15:19 -0700, Linus Torvalds wrote:
> Remember: time is not a nice linear stream.

Time is neither nice nor linear. Time is a complete illusion.

If _any_ of your tools are using the time for _any_ purpose other than
to display it to the user along with the author/committer information,
then you are probably making a mistake. 

Relative time does not represent the revision history of a distributed
system which supports merges. Any correlation you think you see is
_purely_ a coincidence.

-- 
dwmw2

