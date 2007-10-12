From: Peter Karlsson <peter@softwolves.pp.se>
Subject: Re: RCS keyword expansion
Date: Fri, 12 Oct 2007 07:27:58 +0200 (CEST)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.62.0710120726470.11771@perkele.intern.softwolves.pp.se>
References: <Pine.LNX.4.64.0710111542420.23849@ds9.cixit.se>
 <86fy0hvgbh.fsf@blue.stonehenge.com>
 <Pine.LNX.4.62.0710111953460.7441@perkele.intern.softwolves.pp.se>
 <20071011192103.GD2804@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Fri Oct 12 07:28:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgD4G-0002i1-3S
	for gcvg-git-2@gmane.org; Fri, 12 Oct 2007 07:28:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755351AbXJLF2A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2007 01:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755322AbXJLF17
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Oct 2007 01:27:59 -0400
Received: from smtp.getmail.no ([84.208.20.33]:48457 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755304AbXJLF15 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2007 01:27:57 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JPS00F019UJGR00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Fri, 12 Oct 2007 07:27:55 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JPS0045Q9UI5MB0@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Fri, 12 Oct 2007 07:27:54 +0200 (CEST)
Received: from perkele ([84.215.146.18]) by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JPS002FI9UI7AE0@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Fri, 12 Oct 2007 07:27:54 +0200 (CEST)
Received: by perkele (Postfix, from userid 501)	id BA02D2FC18; Fri,
 12 Oct 2007 07:27:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])	by perkele (Postfix)
 with ESMTP id B78D12FC0C	for <git@vger.kernel.org>; Fri,
 12 Oct 2007 07:27:58 +0200 (CEST)
In-reply-to: <20071011192103.GD2804@steel.home>
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60657>

Alex Riesen:

> That's confusing. If your web site is just a checkout, what is the "make 
> install" for?

Exactly. That's what I wondering.

> If it is a repo, you have the version information anyway, and at all 
> times.

Yes, but not embedded in the page in a format that is visible to the 
visitor. For CVS I use something like this:

<p class="date">$Date$</p>

to embed the last update time into the page.

-- 
\\// Peter - http://www.softwolves.pp.se/
