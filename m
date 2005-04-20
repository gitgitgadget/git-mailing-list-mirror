From: "David A. Wheeler" <dwheeler@dwheeler.com>
Subject: Re: [script] ge: export commits as patches
Date: Tue, 19 Apr 2005 22:34:43 -0400
Message-ID: <4265BFC3.9080105@dwheeler.com>
References: <20050419134843.GA19146@elte.hu> <20050419170320.GG12757@pasky.ji.cz> <20050419185607.GA26756@elte.hu> <20050419194108.GN12757@pasky.ji.cz>
Reply-To: dwheeler@dwheeler.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 04:28:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO4xC-0004mO-DR
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 04:28:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbVDTCcu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 22:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261303AbVDTCcu
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 22:32:50 -0400
Received: from cujo.runbox.com ([193.71.199.138]:63644 "EHLO cujo.runbox.com")
	by vger.kernel.org with ESMTP id S261299AbVDTCct (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2005 22:32:49 -0400
Received: from [10.9.9.1] (helo=bolivar.runbox.com)
	by greyhound.runbox.com with esmtp (Exim 4.34)
	id 1DO51E-0001qJ-1o; Wed, 20 Apr 2005 04:32:48 +0200
Received: from [70.18.250.120] (helo=[192.168.2.73])
	by bolivar.runbox.com with asmtp (uid:258406) (Exim 4.34)
	id 1DO51D-0000lI-PA; Wed, 20 Apr 2005 04:32:48 +0200
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050419194108.GN12757@pasky.ji.cz>
X-Sender: 258406@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Forget my earlier "aspatch" proposal, that's a lousy name.

How about "mkpatch"?  Seems like a reasonable name for
a command that makes a patch.  GNU Arch uses that command name.
CVS & Subversion basically do this as part of "diff"
(which is another possibility).

--- David A. Wheeler
