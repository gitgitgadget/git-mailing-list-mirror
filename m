From: Peter Karlsson <peter@softwolves.pp.se>
Subject: Re: Recording merges after repo conversion
Date: Tue, 30 Oct 2007 14:34:27 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.62.0710301433150.652@perkele.intern.softwolves.pp.se>
References: <Pine.LNX.4.64.0710090807060.26773@ds9.cixit.se>
 <13D1D3DD-9652-4097-8364-DEF4F26540D3@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Benoit SIGOURE <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Tue Oct 30 15:20:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImrxM-0003zI-TL
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 15:20:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753857AbXJ3OUA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 10:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753303AbXJ3OT7
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 10:19:59 -0400
Received: from smtp.getmail.no ([84.208.20.33]:44181 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753859AbXJ3OT6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 10:19:58 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JQQ005BKAE3MV10@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Tue, 30 Oct 2007 15:18:03 +0100 (CET)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JQQ005FJ8D9TQ30@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Tue, 30 Oct 2007 14:34:21 +0100 (CET)
Received: from perkele ([84.215.146.18]) by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JQQ009OH8D92O30@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Tue, 30 Oct 2007 14:34:21 +0100 (CET)
Received: by perkele (Postfix, from userid 501)	id 91F5C2FC18; Tue,
 30 Oct 2007 14:34:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])	by perkele (Postfix)
 with ESMTP id 8E97A2FC0C; Tue, 30 Oct 2007 14:34:27 +0100 (CET)
In-reply-to: <13D1D3DD-9652-4097-8364-DEF4F26540D3@lrde.epita.fr>
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Benoit SIGOURE:

> I think you can use grafts do achieve this.

That seems to work, but the grafts list doesn't seem to propagate when I 
push/pull/clone. Is it possible to get that to work?

-- 
\\// Peter - http://www.softwolves.pp.se/
