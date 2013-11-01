From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: What's cooking in git.git (Nov 2013, #01; Fri, 1)
Date: Sat, 02 Nov 2013 00:09:54 +0100
Message-ID: <878ux7g1ml.fsf@linux-k42r.v.cablecom.net>
References: <xmqqob6320rt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 02 00:10:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VcNr3-0003Fg-H8
	for gcvg-git-2@plane.gmane.org; Sat, 02 Nov 2013 00:10:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753128Ab3KAXKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Nov 2013 19:10:07 -0400
Received: from psi.thgersdorf.net ([176.9.98.78]:37045 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751870Ab3KAXKG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Nov 2013 19:10:06 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 5DC594D6578;
	Sat,  2 Nov 2013 00:10:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id w7v3jZ-1Av29; Sat,  2 Nov 2013 00:09:54 +0100 (CET)
Received: from linux-k42r.v.cablecom.net.thomasrast.ch (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id E93D64D6414;
	Sat,  2 Nov 2013 00:09:53 +0100 (CET)
In-Reply-To: <xmqqob6320rt.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 01 Nov 2013 15:52:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237230>

Junio C Hamano <gitster@pobox.com> writes:

> * tr/merge-recursive-index-only (2013-10-28) 3 commits
>  - merge-recursive: -Xindex-only to leave worktree unchanged
>  - merge-recursive: internal flag to avoid touching the worktree
>  - merge-recursive: remove dead conditional in update_stages()

FWIW -- since you dropped the earlier note to the same effect -- I still
consider this "hold until Michael finds a use for it".

-- 
Thomas Rast
tr@thomasrast.ch
