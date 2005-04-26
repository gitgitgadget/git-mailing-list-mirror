From: Philip Pokorny <ppokorny@mindspring.com>
Subject: Re: [ANNOUNCE] Cogito-0.8 (former git-pasky, big changes!)
Date: Tue, 26 Apr 2005 00:02:34 -0700
Message-ID: <426DE78A.3050508@mindspring.com>
References: <20050426032422.GQ13467@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 09:01:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQK48-0002W1-MY
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 09:01:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261373AbVDZHFZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 03:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261381AbVDZHD3
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 03:03:29 -0400
Received: from smtpauth09.mail.atl.earthlink.net ([209.86.89.69]:49129 "EHLO
	smtpauth09.mail.atl.earthlink.net") by vger.kernel.org with ESMTP
	id S261373AbVDZHCg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2005 03:02:36 -0400
Received: from [68.164.169.208] (helo=[172.16.1.11])
	by smtpauth09.mail.atl.earthlink.net with asmtp (TLSv1:RC4-MD5:128)
	(Exim 4.34)
	id 1DQK5c-0006ME-3w; Tue, 26 Apr 2005 03:02:36 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
To: pasky@ucw.cz, git@vger.kernel.org
In-Reply-To: <20050426032422.GQ13467@pasky.ji.cz>
X-ELNK-Trace: 662518af21fc89ef9c7f779228e2f6aeda0071232e20db4dc8f27ea7dc642ff4913448491e92a054350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 68.164.169.208
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis wrote:

> the history changed again (hopefully the
>last time?) because of fixing dates of some old commits.
>

Looks like the git-pasky-0.7 tags (and friends) are now dead links. For 
example:

[philip@xray cogito]$ cg-mkpatch git-pasky-0.7:HEAD
.git/objects/c8/3b95297c2a6336c2007548f909769e0862b509: No such file or 
directory
fatal: cat-file c83b95297c2a6336c2007548f909769e0862b509: bad file
Invalid id: c83b95297c2a6336c2007548f909769e0862b509


Is there any way to recover that, or has the timeline been irrevocably 
altered, and we're all now doomed to meet bastard daughters of long dead 
crew members? [grin]...

:v)

Actually, I really liked that Enterprise-C episode...
