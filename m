From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: git:// protocol over SSL/TLS
Date: Fri, 27 Dec 2013 15:29:59 +0100
Message-ID: <87ioua4ba0.fsf@igel.home>
References: <CAErtv27qUMo9LsGAZtk5Zv9qnZRB_YAXhtskvrrNbWGqadQh7Q@mail.gmail.com>
	<20131227173655.3f3109e7ba848c90b302e2f9@domain007.com>
	<CAErtv25JGxEs3ytAB019yajQooNs4k=bzukSE9kuHWAbir9-BQ@mail.gmail.com>
	<87mwjm4c3s.fsf@igel.home> <vpqwqiqpe80.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Sergey Sharybin <sergey.vfx@gmail.com>,
	Konstantin Khomoutov <flatworm@users.sourceforge.net>,
	Git List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Dec 27 15:30:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VwYQc-00059m-CK
	for gcvg-git-2@plane.gmane.org; Fri, 27 Dec 2013 15:30:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753128Ab3L0OaJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Dec 2013 09:30:09 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:37233 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753052Ab3L0OaI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Dec 2013 09:30:08 -0500
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3drVmp3nZ5z3hjmF;
	Fri, 27 Dec 2013 15:30:02 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3drVmp2m5xzbbcQ;
	Fri, 27 Dec 2013 15:30:02 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id aM9VPJDFnBbs; Fri, 27 Dec 2013 15:29:59 +0100 (CET)
X-Auth-Info: Cz0oE+bRkGrlYbyov6sbPs2Nw3Lu41Y9+VODwaapXCc=
Received: from igel.home (ppp-46-244-233-18.dynamic.mnet-online.de [46.244.233.18])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Fri, 27 Dec 2013 15:29:59 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
	id 20B202C1EFA; Fri, 27 Dec 2013 15:29:59 +0100 (CET)
X-Yow: With YOU, I can be MYSELF..  We don't NEED Dan Rather..
In-Reply-To: <vpqwqiqpe80.fsf@anie.imag.fr> (Matthieu Moy's message of "Fri,
	27 Dec 2013 15:20:47 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239738>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> You can verify integrity after the fact, but not guarantee
> confidentiality ... so it again depends on the definition of "security".

Since the OP is talking about anonymous access there is no need for
confidentiality in this case.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
