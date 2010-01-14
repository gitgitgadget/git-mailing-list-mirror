From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/5] MSVC: Windows-native implementation for subset of Pthreads API
Date: Thu, 14 Jan 2010 20:55:32 +0100
Message-ID: <201001142055.32527.j6t@kdbg.org>
References: <cover.1262895936.git.j6t@kdbg.org> <201001131940.43868.j6t@kdbg.org> <20100114051241.GF10586@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: kusmabite@gmail.com, msysgit <msysgit@googlegroups.com>,
	git@vger.kernel.org, "Andrzej K. Haczewski" <ahaczewski@gmail.com>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 20:56:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVVo5-0008SV-K0
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 20:56:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757575Ab0ANT4d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 14:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757573Ab0ANT4d
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 14:56:33 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:34185 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757565Ab0ANT4c (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 14:56:32 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 3F2A0CDF90;
	Thu, 14 Jan 2010 20:56:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 9618E19F60C;
	Thu, 14 Jan 2010 20:55:32 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <20100114051241.GF10586@dpotapov.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137019>

On Donnerstag, 14. Januar 2010, Dmitry Potapov wrote:
> I hope I have explained well enough why I can vouch that the above
> assignment works atomically WRT any Interlock function.

Your arguments are very convincing, thank you very much!

-- Hannes
