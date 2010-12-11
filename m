From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 01/14] msvc: Fix compilation errors in compat/win32/sys/poll.c
Date: Sat, 11 Dec 2010 23:09:51 +0100
Message-ID: <201012112309.51102.j6t@kdbg.org>
References: <4CFA8E64.6070402@ramsay1.demon.co.uk> <201012082042.06935.j6t@kdbg.org> <4D039E73.80301@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, kusmabite@gmail.com,
	"GIT Mailing-list" <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sat Dec 11 23:10:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRXeB-0000QX-8n
	for gcvg-git-2@lo.gmane.org; Sat, 11 Dec 2010 23:10:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751597Ab0LKWJz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Dec 2010 17:09:55 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:42798 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751432Ab0LKWJy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Dec 2010 17:09:54 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 0BF292C4002;
	Sat, 11 Dec 2010 23:09:50 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 3311719F587;
	Sat, 11 Dec 2010 23:09:51 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <4D039E73.80301@ramsay1.demon.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163460>

On Samstag, 11. Dezember 2010, Ramsay Jones wrote:
> Before sending the patch, I generated a
> before and after pre-processor file and spent about 2-3 hours using tkdiff,
> vim, grep etc., to try and determine if it was a "safe" change.

Thanks. This dispels my concerns.

-- Hannes
