From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Creating CVS-style patch headers with git-diff
Date: Sat, 08 Jan 2011 17:17:26 +0100
Message-ID: <m2k4if9xpl.fsf@igel.home>
References: <AANLkTinmq=3kJmtSVutf7dHAQ0QL3fr9_E3hZ7gDe1JY@mail.gmail.com>
	<4D284F57.2000808@dbservice.com>
	<AANLkTinx9qM=fjH53UodY0G870Ne3wpFiFEgEGNXxOY7@mail.gmail.com>
	<m2vd1za0af.fsf@igel.home>
	<AANLkTi=_YdTsvFboQAj447SUtcxrVhM18QkvSVdpvdMJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tomas Carnecky <tom@dbservice.com>, git@vger.kernel.org
To: David Chanters <david.chanters@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Jan 08 17:17:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbbUL-0004VR-VQ
	for gcvg-git-2@lo.gmane.org; Sat, 08 Jan 2011 17:17:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752967Ab1AHQR3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Jan 2011 11:17:29 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:38083 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752925Ab1AHQR3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jan 2011 11:17:29 -0500
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id E786C1C0F595;
	Sat,  8 Jan 2011 17:17:27 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id E2ABD1C00142;
	Sat,  8 Jan 2011 17:17:27 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id 8il8oOvZwpzW; Sat,  8 Jan 2011 17:17:26 +0100 (CET)
Received: from igel.home (ppp-88-217-122-113.dynamic.mnet-online.de [88.217.122.113])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Sat,  8 Jan 2011 17:17:26 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 80B06CA2A0; Sat,  8 Jan 2011 17:17:26 +0100 (CET)
X-Yow: Thank god!!..  It's HENNY YOUNGMAN!!
In-Reply-To: <AANLkTi=_YdTsvFboQAj447SUtcxrVhM18QkvSVdpvdMJ@mail.gmail.com>
	(David Chanters's message of "Sat, 8 Jan 2011 15:35:39 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164828>

David Chanters <david.chanters@googlemail.com> writes:

> Sorry about that, that's poor wording on my part.  I don't mean "CVS
> won't barf" -- I meant that GNU Patch can still apply the patch
> without the meta-data referencing git still.

So this has nothing at all to do with CVS.  And GNU patch will happily
ignore everything that it does not recognize.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
