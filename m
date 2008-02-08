From: Paul Gardiner <osronline@glidos.net>
Subject: Re: Any tricks for speeding up cvsps?
Date: Fri, 08 Feb 2008 10:11:15 +0000
Message-ID: <47AC2AC3.6020704@glidos.net>
References: <47AC1FDC.9000502@glidos.net> <47AC2775.5090403@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 08 11:12:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNQD9-00072k-Ef
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 11:11:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932843AbYBHKL0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 05:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932837AbYBHKL0
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 05:11:26 -0500
Received: from mk-outboundfilter-2.mail.uk.tiscali.com ([212.74.114.38]:36130
	"EHLO mk-outboundfilter-2.mail.uk.tiscali.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932714AbYBHKLZ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Feb 2008 05:11:25 -0500
X-Trace: 2851983/mk-outboundfilter-2.mail.uk.tiscali.com/PIPEX/$MX-ACCEPTED/pipex-infrastructure/62.241.162.32
X-SBRS: None
X-RemoteIP: 62.241.162.32
X-IP-MAIL-FROM: osronline@glidos.net
X-IP-BHB: Once
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ao8CAL+5q0c+8aIg/2dsb2JhbACrfQ
X-IP-Direction: IN
Received: from ranger.systems.pipex.net ([62.241.162.32])
  by smtp.pipex.tiscali.co.uk with ESMTP; 08 Feb 2008 10:11:21 +0000
Received: from [10.0.0.24] (80-42-19-184.dynamic.dsl.as9105.com [80.42.19.184])
	by ranger.systems.pipex.net (Postfix) with ESMTP id B05CAE000088
	for <git@vger.kernel.org>; Fri,  8 Feb 2008 10:11:18 +0000 (GMT)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <47AC2775.5090403@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73067>

Johannes Sixt wrote:
> I've used fast-export (not git-fast-export) to convert a CVS repository:
> 
> http://repo.or.cz/w/fast-export.git
> 
> It worked better than git-cvsimport because the repository was a real mess.

That looks to require going either via svn or mercurial. Is that right?
And if so, which did you find best?

P.
