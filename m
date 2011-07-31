From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: File Systems and a Theory of Edits
Date: Mon, 01 Aug 2011 00:20:49 +0200
Message-ID: <m2sjpmt7lq.fsf@igel.home>
References: <CADo4Y9hG=-Bye5g7OWROJNbbUOcnH0hj0f3csws5V+YzEUKAMg@mail.gmail.com>
	<CACBZZX48aDN_Njm+qMvovfz1tjdhnmXe5-bbJe=0_Q3LbLWoPA@mail.gmail.com>
	<4E350F15.9050009@lsrfire.ath.cx>
	<CADo4Y9gU_Z73gCPCESvVZhLOJUJg+mTqHkeqpNv2L8xLJvKxEQ@mail.gmail.com>
	<CADo4Y9gECLJ45g_r-uZBRnfEVXBRw2EoF2HkRu=0-eJ2YCuBLA@mail.gmail.com>
	<CAMOZ1BtrgO1XhJfR2-1Mpd8Ytrz4pjVyhbPdbNxDP84hhiip+A@mail.gmail.com>
	<CADo4Y9i=PYBv33Jnu2osQX_FL97ng9FZ8TFeMMuc5CDGUhu1Gg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org
To: mike@nahas.com
X-From: git-owner@vger.kernel.org Mon Aug 01 00:21:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QneNZ-0004WL-SW
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 00:21:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752975Ab1GaWUz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jul 2011 18:20:55 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:47326 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752931Ab1GaWUx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jul 2011 18:20:53 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id EDA44188A16E;
	Mon,  1 Aug 2011 00:20:50 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id 026031C000A9;
	Mon,  1 Aug 2011 00:20:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id Q4g9gvptM0xP; Mon,  1 Aug 2011 00:20:50 +0200 (CEST)
Received: from igel.home (ppp-88-217-126-95.dynamic.mnet-online.de [88.217.126.95])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Mon,  1 Aug 2011 00:20:50 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 11AE4CA293; Mon,  1 Aug 2011 00:20:49 +0200 (CEST)
X-Yow: Wait..  is this a FUN THING or the END of LIFE in Petticoat Junction??
In-Reply-To: <CADo4Y9i=PYBv33Jnu2osQX_FL97ng9FZ8TFeMMuc5CDGUhu1Gg@mail.gmail.com>
	(Michael Nahas's message of "Sun, 31 Jul 2011 17:13:11 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178283>

Michael Nahas <mike.nahas@gmail.com> writes:

> 3 working trees would be even better.  I've been wondering if I can
> make another working trees by creating a .git/ directory and
> symlinking to the .git/objects and ./git/refs of my current
> repository.

Have you looked at git-new-workdir?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
