From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Specifying revisions in the future
Date: Sun, 05 Feb 2012 22:37:25 +0100
Message-ID: <m21uq9x8q2.fsf@igel.home>
References: <jgjkk0$qrg$1@dough.gmane.org> <vpqipjlf309.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: jpaugh@gmx.us, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Feb 05 22:38:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ru9mZ-00042j-2o
	for gcvg-git-2@plane.gmane.org; Sun, 05 Feb 2012 22:37:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752806Ab2BEVh3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Feb 2012 16:37:29 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:50880 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752144Ab2BEVh2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2012 16:37:28 -0500
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 7589D1C1D9E1;
	Sun,  5 Feb 2012 22:37:25 +0100 (CET)
X-Auth-Info: qL3qedBDsrdRxD/0aioodFrWyvDcdxOSxpdgHPlS9iI=
Received: from igel.home (ppp-88-217-114-0.dynamic.mnet-online.de [88.217.114.0])
	by mail.mnet-online.de (Postfix) with ESMTPA id 62E711C0006C;
	Sun,  5 Feb 2012 22:37:25 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 1E49FCA29F; Sun,  5 Feb 2012 22:37:25 +0100 (CET)
X-Yow: I will invent "TIDY BOWL"...
In-Reply-To: <vpqipjlf309.fsf@bauges.imag.fr> (Matthieu Moy's message of "Sun,
	05 Feb 2012 21:18:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189968>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> "the successor of <commit>", OTOH, is not well defined, since there can
> be several successors, and one can't order them reliably (you can't
> really know the set of successors, because they can exist in different
> repositories).

Yet it would be nice to have a concise notation for "the nth successor
of <commit> towards <commit>" (using --first-parent ordering when
ambiguous).

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
