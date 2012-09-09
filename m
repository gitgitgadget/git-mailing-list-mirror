From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Keeping two repos in sync
Date: Sun, 09 Sep 2012 10:36:07 +0200
Message-ID: <m2k3w3lhjc.fsf@igel.home>
References: <CACffvTqt9UHw1wLVDZ=PDqJuktcD8M7uUfnnuDZ5cf9gwxsSqA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: David Chanters <david.chanters@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Sep 09 10:36:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAd06-0002EG-O3
	for gcvg-git-2@plane.gmane.org; Sun, 09 Sep 2012 10:36:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298Ab2IIIgK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Sep 2012 04:36:10 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:36763 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750794Ab2IIIgJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Sep 2012 04:36:09 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3XF5MC3GT7z3hhcq;
	Sun,  9 Sep 2012 10:36:07 +0200 (CEST)
X-Auth-Info: JjdDRCPe+/Gf6mJV9qvmNLpjdCAEHwhTq5GGtzGZvNw=
Received: from igel.home (ppp-93-104-149-132.dynamic.mnet-online.de [93.104.149.132])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3XF5MC2zFqzbbhY;
	Sun,  9 Sep 2012 10:36:07 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 1EB3FCA2A5; Sun,  9 Sep 2012 10:36:07 +0200 (CEST)
X-Yow: When you get your PH.D. will you get able to work at BURGER KING?
In-Reply-To: <CACffvTqt9UHw1wLVDZ=PDqJuktcD8M7uUfnnuDZ5cf9gwxsSqA@mail.gmail.com>
	(David Chanters's message of "Sun, 9 Sep 2012 09:12:32 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205067>

Add "bsd" as a remote in "portable" and cherry-pick each commit in
"bsd".

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
