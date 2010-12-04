From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Can't seem to commit
Date: Sat, 04 Dec 2010 17:57:41 +0100
Message-ID: <m2zkslbhmi.fsf@igel.home>
References: <1291480384128-5803287.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: weloki <weloki@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 04 17:57:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POvQi-0004B8-OT
	for gcvg-git-2@lo.gmane.org; Sat, 04 Dec 2010 17:57:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754974Ab0LDQ5n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Dec 2010 11:57:43 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:37538 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985Ab0LDQ5m (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Dec 2010 11:57:42 -0500
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id CCDD71C0F570;
	Sat,  4 Dec 2010 17:57:41 +0100 (CET)
Received: from igel.home (ppp-88-217-106-50.dynamic.mnet-online.de [88.217.106.50])
	by mail.mnet-online.de (Postfix) with ESMTP id C2D111C0017B;
	Sat,  4 Dec 2010 17:57:41 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 9DD50CA2A0; Sat,  4 Dec 2010 17:57:41 +0100 (CET)
X-Yow: Where's the Coke machine?  Tell me a joke!!
In-Reply-To: <1291480384128-5803287.post@n2.nabble.com> (weloki@gmail.com's
	message of "Sat, 4 Dec 2010 08:33:04 -0800 (PST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2.90 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162897>

weloki <weloki@gmail.com> writes:

> There is probably an easy solution to this but I'm seeing something really
> weird...
> I can't seem to commit anything to my new branch. When I try to commit it
> just says "no changes added to commit (use "git add" and/or "git commit
> -a")"
> When I try to do git add it doesn't seem to do anything.

If you are unsure what to do you should always try "git status" first.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
