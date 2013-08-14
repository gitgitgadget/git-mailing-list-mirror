From: Tim Chase <git@tim.thechases.com>
Subject: Re: Proper URI for "svn clone" on a network share (Win32)
Date: Wed, 14 Aug 2013 18:26:57 -0500
Message-ID: <20130814182657.3c03c5df@bigbox.christie.dr>
References: <20130814124933.77b51a04@bigbox.christie.dr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 15 01:25:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9kRg-0000M9-DG
	for gcvg-git-2@plane.gmane.org; Thu, 15 Aug 2013 01:25:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933280Ab3HNXZg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Aug 2013 19:25:36 -0400
Received: from boston.accountservergroup.com ([50.22.11.22]:50077 "EHLO
	boston.accountservergroup.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933153Ab3HNXZf (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Aug 2013 19:25:35 -0400
Received: from 172-0-250-128.lightspeed.rcsntx.sbcglobal.net ([172.0.250.128]:45265 helo=bigbox.christie.dr)
	by boston.accountservergroup.com with esmtpsa (SSLv3:DHE-RSA-AES128-SHA:128)
	(Exim 4.80)
	(envelope-from <git@tim.thechases.com>)
	id 1V9kRb-0000IC-51
	for git@vger.kernel.org; Wed, 14 Aug 2013 18:25:35 -0500
In-Reply-To: <20130814124933.77b51a04@bigbox.christie.dr>
X-Mailer: Claws Mail 3.8.1 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - boston.accountservergroup.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - tim.thechases.com
X-Get-Message-Sender-Via: boston.accountservergroup.com: none
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232321>

On 2013-08-14 12:49, Tim Chase wrote:
> If it makes any difference, this is within a cmd.exe shell (with
> $PATH set appropriately so git is being found).

Just a follow-up, I tried it within the "bash"ish shell included in
the git install and got the same error regarding "/tmp/report.tmp".

-tkc
