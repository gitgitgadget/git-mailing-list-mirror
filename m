From: David Lang <david.lang@digitalinsight.com>
Subject: Re: git-rev-list: "--bisect" flag
Date: Sat, 18 Jun 2005 22:05:40 -0700 (PDT)
Message-ID: <Pine.LNX.4.62.0506182204350.11617@qynat.qvtvafvgr.pbz>
References: <Pine.LNX.4.58.0506172306210.2268@ppc970.osdl.org><2cfc403205061817181e4d6d5e@mail.gmail.com>
 <Pine.LNX.4.58.0506182022130.2268@ppc970.osdl.org>
 <Pine.LNX.4.58.0506182141400.2268@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: jon@blackcubes.dyndns.org, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 19 07:00:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Djrv0-00035h-HB
	for gcvg-git@gmane.org; Sun, 19 Jun 2005 07:00:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261954AbVFSFGB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Jun 2005 01:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbVFSFGB
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Jun 2005 01:06:01 -0400
Received: from warden2-p.diginsite.com ([209.195.52.120]:40099 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S261954AbVFSFF4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2005 01:05:56 -0400
Received: from atlims01.diginsite.com by warden2.diginsite.com
          via smtpd (for vger.kernel.org [12.107.209.244]) with SMTP; Sat, 18 Jun 2005 22:00:53 -0700
Received: by ATHEXC01 with Internet Mail Service (5.5.2657.72)
	id <MYMQ35V3>; Sun, 19 Jun 2005 01:05:50 -0400
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvexc00.digitalinsight.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2657.72)
	id MY4YZQSV; Sat, 18 Jun 2005 22:05:37 -0700
To: Linus Torvalds <torvalds@osdl.org>
X-X-Sender: dlang@dlang.diginsite.com
In-Reply-To: <Pine.LNX.4.58.0506182141400.2268@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 18 Jun 2005, Linus Torvalds wrote:

> The performance problem seems to really be pretty theoretical: I can
> bisect the developemnt from 2.6.12-rc2 to current head in 0.59 seconds, so
> it's not like it's horribly slow for something like a couple of months
> worth of development.

if it takes you about as long to type the command (and scan it to make 
sure you didn't mistype it) as it does to execute you don't have a 
performance problem :-)

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
