From: Jing Xue <jingxue@digizenstudio.com>
Subject: Re: yet another workflow question...
Date: Thu, 11 Oct 2007 16:40:19 -0400
Message-ID: <20071011164019.3n4l3rayckck8c4w@intranet.digizenstudio.com>
References: <e2a1d0aa0710110711m77ca967bmd1d5ffd5d3099aab@mail.gmail.com>
	<200710111610.55364.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=UTF-8;
	DelSp="Yes";
	format="flowed"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Patrick Doyle <wpdster@gmail.com>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 11 22:40:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ig4pb-0003kB-66
	for gcvg-git-2@gmane.org; Thu, 11 Oct 2007 22:40:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754438AbXJKUkW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2007 16:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754520AbXJKUkW
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Oct 2007 16:40:22 -0400
Received: from k2smtpout01-02.prod.mesa1.secureserver.net ([64.202.189.89]:56006
	"HELO k2smtpout01-01.prod.mesa1.secureserver.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1754329AbXJKUkV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2007 16:40:21 -0400
Received: (qmail 11343 invoked from network); 11 Oct 2007 20:40:20 -0000
Received: from unknown (HELO ip-72-167-33-213.ip.secureserver.net) (72.167.33.213)
  by k2smtpout01-01.prod.mesa1.secureserver.net (64.202.189.88) with ESMTP; 11 Oct 2007 20:40:20 -0000
Received: from localhost (unknown [127.0.0.1])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id 8297E100079;
	Thu, 11 Oct 2007 20:40:20 +0000 (UTC)
Received: from ip-72-167-33-213.ip.secureserver.net ([127.0.0.1])
	by localhost (ip-72-167-33-213.ip.secureserver.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h5CziCPceNdP; Thu, 11 Oct 2007 16:40:19 -0400 (EDT)
Received: by ip-72-167-33-213.ip.secureserver.net (Postfix, from userid 48)
	id DD21E10007A; Thu, 11 Oct 2007 16:40:19 -0400 (EDT)
Received: from mailrelay3.private.geico.com (mailrelay3.private.geico.com
	[205.143.204.110]) by intranet.digizenstudio.com (Horde MIME library) with
	HTTP; Thu, 11 Oct 2007 16:40:19 -0400
In-Reply-To: <200710111610.55364.andyparkins@gmail.com>
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) H3 (4.1.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60632>


Quoting Andy Parkins <andyparkins@gmail.com>:

>  - Mobility.  This one is a bit distributed, but I hope you'll let   
> me have it.
>    I often do work on my desktop at home, my desktop at work and my laptop.
>    By setting my remotes up correctly in git it's really easy to walk to
>    another system and pick up exactly where I left off from the other
>    computer.  More importantly though, when you accidentally make changes in
>    two places, there is no danger of data loss.

To extend on this point, after picking up the randomly checked-in save  
point on another computer, the save point itself can be easily  
git-reset'ed.  So there won't be commits like "it's utter broken but i  
got to go home" polluting the history.  I find that extremely handy.

Cheers.
-- 
Jing Xue
