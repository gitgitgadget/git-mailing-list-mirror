From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [RFC] Fourth round of support for cloning submodules
Date: Thu, 24 May 2007 14:23:35 +0200
Organization: eudaptics software gmbh
Message-ID: <465583C7.32BC66BB@eudaptics.com>
References: <Pine.LNX.4.64.0705240039370.4113@racer.site>
	 <7vtzu3yrh9.fsf@assigned-by-dhcp.cox.net> <20070524072216.GE942MdfPADPa@greensroom.kotnet.org>
	 <20070524072945.GO28023@spearce.org> <20070524073652.GH942MdfPADPa@greensroom.kotnet.org>
	 <Pine.LNX.4.64.0705241039200.4648@racer.site> <20070524105112.GI942MdfPADPa@greensroom.kotnet.org>
	 <Pine.LNX.4.64.0705241201270.4648@racer.site> <20070524111645.GK942MdfPADPa@greensroom.kotnet.org>
	 <Pine.LNX.4.64.0705241230410.4648@racer.site> <20070524114354.GN942MdfPADPa@greensroom.kotnet.org> <Pine.LNX.4.64.0705241315290.4648@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 24 14:23:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrCLf-00006q-46
	for gcvg-git@gmane.org; Thu, 24 May 2007 14:23:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756634AbXEXMW6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 08:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755891AbXEXMW6
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 08:22:58 -0400
Received: from main.gmane.org ([80.91.229.2]:34478 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756634AbXEXMW5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 08:22:57 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HrCLF-0002zi-1B
	for git@vger.kernel.org; Thu, 24 May 2007 14:22:53 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 24 May 2007 14:22:53 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 24 May 2007 14:22:53 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48249>

Johannes Schindelin wrote:
> I was more thinking about something like this:
> 3fa7ded19a8da868d3af7c942f86358e6720f0c7        refs/heads/submodule^{URL:/home/sverdool/public_html/cloog.git}

where 3fa7ded... is the commit (gitlink) that appears in the tree?

-- Hannes
