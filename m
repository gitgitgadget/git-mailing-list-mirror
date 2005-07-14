From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [PATCH] stgit: allow spaces in filenames (second try)
Date: Thu, 14 Jul 2005 16:01:48 +0100
Message-ID: <tnx3bqhtorn.fsf@arm.com>
References: <20050714062733.21779.33599.sendpatchset@bryan-larsens-ibook-g4.local>
	<tnxu0ixn0ux.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bryan.larsen@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 14 17:07:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dt5Hy-00019O-W1
	for gcvg-git@gmane.org; Thu, 14 Jul 2005 17:06:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263040AbVGNPFh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jul 2005 11:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263046AbVGNPDh
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jul 2005 11:03:37 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:28655 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S263044AbVGNPCT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2005 11:02:19 -0400
Received: from cam-mail2.cambridge.arm.com (cam-mail2.cambridge.arm.com [10.1.127.39])
	by cam-admin0.cambridge.arm.com (8.12.10/8.12.10) with ESMTP id j6EF1es4023465;
	Thu, 14 Jul 2005 16:01:40 +0100 (BST)
Received: from ZIPPY.Emea.Arm.com (cam-exch2.emea.arm.com [10.1.255.58])
	by cam-mail2.cambridge.arm.com (8.9.3/8.9.3) with ESMTP id QAA04240;
	Thu, 14 Jul 2005 16:02:15 +0100 (BST)
Received: from localhost.localdomain ([10.1.69.144]) by ZIPPY.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.211);
	 Thu, 14 Jul 2005 16:02:14 +0100
To: Bryan Larsen <bryanlarsen@yahoo.com>
In-Reply-To: <tnxu0ixn0ux.fsf@arm.com> (Catalin Marinas's message of "Thu,
 14 Jul 2005 11:22:30 +0100")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
X-OriginalArrivalTime: 14 Jul 2005 15:02:14.0396 (UTC) FILETIME=[04E34BC0:01C58885]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Catalin Marinas <catalin.marinas@gmail.com> wrote:
> One note about patch description. I would prefer to have the
> convention of the Linux kernel patches:
>
> ---
> Short description line

Probably without this line in the e-mail body since it is already in
the subject line.

-- 
Catalin
