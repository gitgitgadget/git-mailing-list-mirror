From: Tommi Virtanen <tv@debian.org>
Subject: Re: [PATCH] cogito bugfixes and cleanups, mainly Debian things
Date: Mon, 12 Sep 2005 10:29:32 +0300
Organization: Debian GNU/Linux
Message-ID: <43252E5C.5090207@debian.org>
References: <11250540944027-git-send-email-tv@debian.org> <11250540952285-git-send-email-tv@debian.org> <20050912003156.GF15630@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 12 09:31:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEil9-0007lL-1w
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 09:29:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbVILH3o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 03:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbVILH3o
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 03:29:44 -0400
Received: from i1.inoi.fi ([194.100.97.46]:65455 "EHLO mail.srv.inoi.fi")
	by vger.kernel.org with ESMTP id S1751199AbVILH3o (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Sep 2005 03:29:44 -0400
Received: from mail.srv.inoi.fi (localhost.localdomain [127.0.0.1])
	by mail.srv.inoi.fi (Postfix) with ESMTP id D258D10C022;
	Mon, 12 Sep 2005 10:29:42 +0300 (EEST)
Received: from [10.105.0.184] (unknown [10.105.0.184])
	by mail.srv.inoi.fi (Postfix) with ESMTP id 9E7C610C01F;
	Mon, 12 Sep 2005 10:29:42 +0300 (EEST)
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050912003156.GF15630@pasky.or.cz>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8372>

Petr Baudis wrote:
>>As long as the cg-cancel name is around, provide docs for it too.
> cg-cancel is a compatibility alias only, so adding docs for it would
> only encourage its further use, which is precisely what I don't want.

Maybe then it should have documentation that basically states
"cg-cancel is deprecated, please use cg-reset".
