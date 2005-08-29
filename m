From: "Bryan O'Donoghue" <typedef@eircom.net>
Subject: cogito/git usage question
Date: Mon, 29 Aug 2005 11:45:33 +0100
Message-ID: <4312E74D.5020203@eircom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Aug 29 12:39:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9h2W-0002Wi-Ri
	for gcvg-git@gmane.org; Mon, 29 Aug 2005 12:38:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750904AbVH2Kit (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Aug 2005 06:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751035AbVH2Kit
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Aug 2005 06:38:49 -0400
Received: from zeus2.kernel.org ([204.152.191.36]:2253 "EHLO zeus2.kernel.org")
	by vger.kernel.org with ESMTP id S1750904AbVH2Kis (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Aug 2005 06:38:48 -0400
Received: from eurodubx.europlex.local (mail.europlex.ie [83.141.76.10])
	by zeus2.kernel.org (8.13.1/8.13.1) with ESMTP id j7TAclp2001721
	for <git@vger.kernel.org>; Mon, 29 Aug 2005 03:38:48 -0700
Received: from [10.100.10.207] ([10.100.10.207]) by eurodubx.europlex.local with Microsoft SMTPSVC(6.0.3790.211);
	 Mon, 29 Aug 2005 11:35:46 +0100
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
X-OriginalArrivalTime: 29 Aug 2005 10:35:46.0500 (UTC) FILETIME=[6A5C7840:01C5AC85]
X-Virus-Scanned: ClamAV version 0.85, clamav-milter version 0.85 on zeus2
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7899>

Greetings all.

I have a copy of
http://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
which is currently at revision 2.6.13 as at this morning.

cg-tag-ls lists every version from 2.6.11 to the current 2.6.13
inclusive. cg-tag-ls also lists kernel version 2.6.13-rc6. What I'm
wondering is how exactly I set copy of the tree to that version, so that
I can apply the -mm patchset ?

I've asked uncle Google and searched the git mailing list archives, as
well as looking through the git and cogito documentation, however, it is
not immediately obvious to me at this point what the correct command to
do this is. I'd be very grateful, if somebody could point that out.

Best Regards,
Bryan

-- 
"Fiery the angels fell. Deep thunder rolled around their shores, burning
with the fires of Orc." -- Roy Batty, Blade Runner.
