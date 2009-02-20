From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] Add bare repository indicator for __git_ps1
Date: Fri, 20 Feb 2009 17:39:40 +0100
Message-ID: <499EDCCC.3030700@drmicha.warpmail.net>
References: <499EC48B.9070004@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 17:41:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaYRC-00010c-7e
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 17:41:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753084AbZBTQjv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 11:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751779AbZBTQju
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 11:39:50 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:38037 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753084AbZBTQjt (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Feb 2009 11:39:49 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id B67782A24D7;
	Fri, 20 Feb 2009 11:39:48 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Fri, 20 Feb 2009 11:39:48 -0500
X-Sasl-enc: cFuOA1fqXDTQPqVxZomtzgdVdNzxAwXROYlzCKTWbVoi 1235147988
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 08A421AAAB;
	Fri, 20 Feb 2009 11:39:47 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre) Gecko/20090219 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <499EC48B.9070004@trolltech.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110862>

> User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US;
> rv:1.8.1.19) Gecko/20081209 Lightning/0.9 Thunderbird/2.0.0.19
> ThunderGit/0.1a Mnenhy/0.7.6.666

Marius Storm-Olsen venit, vidit, dixit 20.02.2009 15:56:
> Prefixes the branch name with "BARE:" if you're in a bare
> repository.
> 
> Signed-off-by: Marius Storm-Olsen <marius@trolltech.com> --- Patch
> tried sent via ThunderGit extension. Sorry if it's mangled :-)

Now what's that ThunderGit thingy? ;)

Seriously, I see you and Dscho have been carrying this on, and soon
external commands may be lauched. Is this going in a git specific
direction rather than attaching patch files unmangled (UnflowedTB)?

Michael
