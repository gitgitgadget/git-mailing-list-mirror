From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: git branch -a prefixes origin/ branches with remotes/
Date: Thu, 01 Apr 2010 00:04:26 +0200
Message-ID: <m2iq8c2ln9.fsf@igel.home>
References: <18137.1270056387@relay.known.net>
	<k2r76718491003311459u4bbaeb4ax5b2e550acdd14c88@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: layer <layer@known.net>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 01 00:08:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nx657-00050H-H8
	for gcvg-git-2@lo.gmane.org; Thu, 01 Apr 2010 00:08:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320Ab0CaWIK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Mar 2010 18:08:10 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:51808 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932144Ab0CaWII (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Mar 2010 18:08:08 -0400
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 4966D1C0020D;
	Thu,  1 Apr 2010 00:08:06 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id BC42290A31;
	Thu,  1 Apr 2010 00:08:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.3.149])
	by localhost (dynscan1.mnet-online.de [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id qwiMDtBQFkNo; Thu,  1 Apr 2010 00:05:55 +0200 (CEST)
Received: from igel.home (ppp-88-217-99-165.dynamic.mnet-online.de [88.217.99.165])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Thu,  1 Apr 2010 00:05:48 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 6C449CA29C; Thu,  1 Apr 2010 00:04:26 +0200 (CEST)
X-Yow: The fact that 47 PEOPLE are yelling and sweat is cascading
 down my SPINAL COLUMN is fairly enjoyable!!
In-Reply-To: <k2r76718491003311459u4bbaeb4ax5b2e550acdd14c88@mail.gmail.com>
	(Jay Soffian's message of "Wed, 31 Mar 2010 17:59:49 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.94 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143697>

Jay Soffian <jaysoffian@gmail.com> writes:

> (Note to git list: there should be a man page that has a single-line
> summary of each command and states whether the command is plumbing or
> porcelain. Maybe there is and I just don't know it.)

git(1)

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
