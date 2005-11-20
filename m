From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [PATCH] Cogito documentation updates
Date: 20 Nov 2005 07:37:07 -0800
Message-ID: <86veyn49gc.fsf@blue.stonehenge.com>
References: <20051120101112.GA2302@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 20 16:37:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdrFn-0007fv-G9
	for gcvg-git@gmane.org; Sun, 20 Nov 2005 16:37:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbVKTPhP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Nov 2005 10:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbVKTPhP
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Nov 2005 10:37:15 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:8233 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1751252AbVKTPhN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Nov 2005 10:37:13 -0500
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id A1D0F8F32B;
	Sun, 20 Nov 2005 07:37:08 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 23148-01; Sun, 20 Nov 2005 07:37:08 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 2C81F8F32C; Sun, 20 Nov 2005 07:37:08 -0800 (PST)
To: Jonas Fonseca <fonseca@diku.dk>
x-mayan-date: Long count = 12.19.12.14.12; tzolkin = 3 Eb; haab = 10 Ceh
In-Reply-To: <20051120101112.GA2302@diku.dk>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12384>

>>>>> "Jonas" == Jonas Fonseca <fonseca@diku.dk> writes:

Jonas>  - local cg-fetch now works without the cp option -u

But it still requires cp -d, unless some other patch fixed that recently.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
