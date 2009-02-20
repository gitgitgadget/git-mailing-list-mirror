From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] Add bare repository indicator for __git_ps1
Date: Fri, 20 Feb 2009 18:13:00 +0100
Message-ID: <499EE49C.1070707@drmicha.warpmail.net>
References: <499EC48B.9070004@trolltech.com> <alpine.DEB.1.00.0902201734450.6302@intel-tinevez-2-302> <200902201746.15242.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marius Storm-Olsen <marius@trolltech.com>, spearce@spearce.org,
	Git Mailing List <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Feb 20 18:14:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaYxZ-0007IV-7m
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 18:14:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759669AbZBTRNM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 12:13:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759659AbZBTRNL
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 12:13:11 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:37631 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759655AbZBTRNK (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Feb 2009 12:13:10 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 634F129DF44;
	Fri, 20 Feb 2009 12:13:08 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Fri, 20 Feb 2009 12:13:08 -0500
X-Sasl-enc: 5ZKP1EzmmcBijGf815OG1sDd4mTaGidUx68EmSqKvNvG 1235149988
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 67ED14DCAD;
	Fri, 20 Feb 2009 12:13:07 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre) Gecko/20090219 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <200902201746.15242.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110868>

Thomas Rast venit, vidit, dixit 20.02.2009 17:46:
> Johannes Schindelin wrote:
>> Hi,
>>
>> On Fri, 20 Feb 2009, Marius Storm-Olsen wrote:
>>
>>> +		local c
>>> +		+		if test "$(git config --bool core.bare)" ==
>>> "true"; then
>> Indeed, it seems that this got mangled, unfortunately.
> 
> Actually it seems the patch itself is fine, but the mail is still
> flagged format=flowed, so f=f-aware readers will mangle it on display.

Unmangled here also, viewing with TB, f-f disabled or not, unless I make
the window very small of course.

Michael
