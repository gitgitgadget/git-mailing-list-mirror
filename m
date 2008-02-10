From: Paul Gardiner <osronline@glidos.net>
Subject: Re: All I wanted was git-fast-export
Date: Sun, 10 Feb 2008 15:39:55 +0000
Message-ID: <47AF1ACB.1030609@glidos.net>
References: <47ADE275.3060109@glidos.net> <alpine.LSU.1.00.0802091803580.11591@racer.site> <47AE2CDF.4090208@glidos.net> <alpine.LSU.1.00.0802100054490.11591@racer.site> <47AECCDC.3050500@glidos.net> <alpine.LSU.1.00.0802101248260.11591@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 10 16:41:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOEJW-0008Fd-1L
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 16:41:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752508AbYBJPkQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 10:40:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbYBJPkP
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 10:40:15 -0500
Received: from mk-outboundfilter-2.mail.uk.tiscali.com ([212.74.114.38]:41919
	"EHLO mk-outboundfilter-2.mail.uk.tiscali.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753057AbYBJPkE (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Feb 2008 10:40:04 -0500
X-Trace: 3746045/mk-outboundfilter-2.mail.uk.tiscali.com/PIPEX/$MX-ACCEPTED/pipex-infrastructure/62.241.163.6
X-SBRS: None
X-RemoteIP: 62.241.163.6
X-IP-MAIL-FROM: osronline@glidos.net
X-IP-BHB: Once
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ao8CABaqrkc+8aMG/2dsb2JhbACmQA
X-IP-Direction: IN
Received: from astro.systems.pipex.net ([62.241.163.6])
  by smtp.pipex.tiscali.co.uk with ESMTP; 10 Feb 2008 15:40:00 +0000
Received: from [10.0.0.24] (80-42-19-184.dynamic.dsl.as9105.com [80.42.19.184])
	by astro.systems.pipex.net (Postfix) with ESMTP id 7C50EE000087
	for <git@vger.kernel.org>; Sun, 10 Feb 2008 15:39:59 +0000 (GMT)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <alpine.LSU.1.00.0802101248260.11591@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73361>

Johannes Schindelin wrote:
> But of course, I meant to suggest (admittedly, in a very short short-hand) 
> that you use "git filter-branch ... origin@{1}..origin" after cvsimport.

Sorry to be a bit thick, but I'm very new to git. Can you spell it out
for me? Where's that going to get the branch from? Where will the
rewritten one end up? And where's the backup old versions of what is
rewritten going to end up?

It looks very clever, like it might be a way of accessing filtering
one repository into another, but I haven't quite twigged how this
all works yet.

P.
