From: Frans Pop <elendil@planet.nl>
Subject: Re: Extremely slow progress during 'git reflog expire --all'
Date: Fri, 2 Apr 2010 23:50:19 +0200
Message-ID: <201004022350.20999.elendil@planet.nl>
References: <201004022154.14793.elendil@planet.nl> <20100402212858.GA28531@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 02 23:50:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nxol2-0006gM-KW
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 23:50:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755102Ab0DBVuY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Apr 2010 17:50:24 -0400
Received: from cpsmtpm-eml101.kpnxchange.com ([195.121.3.5]:58598 "EHLO
	CPSMTPM-EML101.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754811Ab0DBVuX (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Apr 2010 17:50:23 -0400
Received: from aragorn.fjphome.nl ([77.166.180.99]) by CPSMTPM-EML101.kpnxchange.com with Microsoft SMTPSVC(7.0.6001.18000);
	 Fri, 2 Apr 2010 23:50:21 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <20100402212858.GA28531@coredump.intra.peff.net>
Content-Disposition: inline
X-OriginalArrivalTime: 02 Apr 2010 21:50:22.0068 (UTC) FILETIME=[7E6CC340:01CAD2AE]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143855>

On Friday 02 April 2010, Jeff King wrote:
> Can you reproduce the problem on your repo? If so, can you possibly tar
> it up and make it available (probably just the .git directory would be
> enough)?

Yes, I can reproduce. I've run it a few times and broke it off each time 
before it finished as I really had no idea how much longer it might take.

$ du -sh .git
1008M   .git

I can make that available, but it's going to take a while to upload and I 
don't want to leave it up too long as I'll be abusing a project service 
for that. So the people who want to look at it would have grab it fairly 
promptly (within 2 days or so).

Is that OK?

Cheers,
FJP
