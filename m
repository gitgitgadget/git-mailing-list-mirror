From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Creating CVS-style patch headers with git-diff
Date: Sat, 08 Jan 2011 16:21:44 +0100
Message-ID: <m2vd1za0af.fsf@igel.home>
References: <AANLkTinmq=3kJmtSVutf7dHAQ0QL3fr9_E3hZ7gDe1JY@mail.gmail.com>
	<4D284F57.2000808@dbservice.com>
	<AANLkTinx9qM=fjH53UodY0G870Ne3wpFiFEgEGNXxOY7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tomas Carnecky <tom@dbservice.com>, git@vger.kernel.org
To: David Chanters <david.chanters@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Jan 08 16:21:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pbac7-0007u1-8i
	for gcvg-git-2@lo.gmane.org; Sat, 08 Jan 2011 16:21:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752870Ab1AHPVr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jan 2011 10:21:47 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:42953 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752837Ab1AHPVr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jan 2011 10:21:47 -0500
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id BE9B6186DEE7;
	Sat,  8 Jan 2011 16:21:45 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id A98E11C0017A;
	Sat,  8 Jan 2011 16:21:45 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id GdHiySwA8Lov; Sat,  8 Jan 2011 16:21:45 +0100 (CET)
Received: from igel.home (ppp-88-217-122-113.dynamic.mnet-online.de [88.217.122.113])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Sat,  8 Jan 2011 16:21:44 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id ABDD3CA2A0; Sat,  8 Jan 2011 16:21:44 +0100 (CET)
X-Yow: It's the RINSE CYCLE!!  They've ALL IGNORED the RINSE CYCLE!!
In-Reply-To: <AANLkTinx9qM=fjH53UodY0G870Ne3wpFiFEgEGNXxOY7@mail.gmail.com>
	(David Chanters's message of "Sat, 8 Jan 2011 13:43:31 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164823>

David Chanters <david.chanters@googlemail.com> writes:

> Well, any one of those goals, really.  I just want to generate a patch
> that CVS won't barf on

What does "CVS won't barf" mean in this context?  CVS does not operate
on patches.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
