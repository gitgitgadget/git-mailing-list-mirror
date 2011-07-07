From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: changing first commit message
Date: Thu, 07 Jul 2011 18:08:13 +0200
Message-ID: <m2pqlm2hw2.fsf@igel.home>
References: <C1602FFC-8FBE-4E55-94F7-96DF745C0345@uab.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Shantanu Pavgi <pavgi@uab.edu>
X-From: git-owner@vger.kernel.org Thu Jul 07 18:08:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qer7u-0002ZG-2d
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jul 2011 18:08:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752210Ab1GGQIS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jul 2011 12:08:18 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:45909 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750830Ab1GGQIR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2011 12:08:17 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 823CE1C01DDC;
	Thu,  7 Jul 2011 18:08:15 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id 603451C00048;
	Thu,  7 Jul 2011 18:08:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id dpacLccTtFhD; Thu,  7 Jul 2011 18:08:14 +0200 (CEST)
Received: from igel.home (ppp-88-217-111-131.dynamic.mnet-online.de [88.217.111.131])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Thu,  7 Jul 2011 18:08:14 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 002DFCA29C; Thu,  7 Jul 2011 18:08:13 +0200 (CEST)
X-Yow: Who wants some OYSTERS with SEN-SEN an' COOL WHIP?
In-Reply-To: <C1602FFC-8FBE-4E55-94F7-96DF745C0345@uab.edu> (Shantanu Pavgi's
	message of "Thu, 7 Jul 2011 10:56:57 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176762>

Shantanu Pavgi <pavgi@uab.edu> writes:

> How do I reword the first commit message? I was able to reword commit
> messages after the first commit using 'git rebase -i <first-commit-id>',
> but I am not sure how to reword the first commit message itself. Any help?

$ git rebase -h
[...]
    --root                rebase all reachable commits up to the root(s)
[...]

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
