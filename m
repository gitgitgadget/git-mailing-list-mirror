From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Push Windows to Linux Repository Problem
Date: Sun, 23 Dec 2012 10:06:36 +0100
Message-ID: <m27go9dtnn.fsf@linux-m68k.org>
References: <50D65090.4010303@bellsouth.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Dennis Putnam <dap1@bellsouth.net>
X-From: git-owner@vger.kernel.org Sun Dec 23 10:07:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TmhWU-0001Xz-Iu
	for gcvg-git-2@plane.gmane.org; Sun, 23 Dec 2012 10:07:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751565Ab2LWJGo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Dec 2012 04:06:44 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:39923 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188Ab2LWJGl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Dec 2012 04:06:41 -0500
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3YTd3y3MMjz4KK9C;
	Sun, 23 Dec 2012 10:06:38 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3YTd3y2Ks1zbbcn;
	Sun, 23 Dec 2012 10:06:38 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id HLXSI6dLPYwY; Sun, 23 Dec 2012 10:06:37 +0100 (CET)
X-Auth-Info: qYzQz9EB8ZsLLYDnC97qJGs1vdyXs8ZTY/M7TVKKtfw=
Received: from linux.local (ppp-93-104-130-3.dynamic.mnet-online.de [93.104.130.3])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Sun, 23 Dec 2012 10:06:37 +0100 (CET)
Received: by linux.local (Postfix, from userid 501)
	id E7B481E541D; Sun, 23 Dec 2012 10:06:36 +0100 (CET)
X-Yow: My face is new, my license is expired, and I'm under a doctor's care!!!!
In-Reply-To: <50D65090.4010303@bellsouth.net> (Dennis Putnam's message of
	"Sat, 22 Dec 2012 19:30:08 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212083>

Dennis Putnam <dap1@bellsouth.net> writes:

> I keep getting "fatal: Could not read from remote repository."

Can you "git ls-remote" the repository?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
