From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 3/3] buitin-status: Add tests for submodule summary
Date: Wed, 12 Mar 2008 08:38:03 +0100
Message-ID: <47D7885B.6060500@viscovery.net>
References: <1205288512-20435-1-git-send-email-pkufranky@gmail.com> <1205288512-20435-2-git-send-email-pkufranky@gmail.com> <1205288512-20435-3-git-send-email-pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 08:38:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZLXy-0003Wu-5y
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 08:38:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbYCLHiH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 03:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbYCLHiG
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 03:38:06 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:21441 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751098AbYCLHiG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 03:38:06 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JZLWa-0007W3-B9; Wed, 12 Mar 2008 08:37:20 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 0C4B06D9; Wed, 12 Mar 2008 08:38:04 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <1205288512-20435-3-git-send-email-pkufranky@gmail.com>
X-Spam-Score: 0.2 (/)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_80=2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76935>

Ping Yin schrieb:
> ---
>  t/t7502-status.sh |   76 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 76 insertions(+), 0 deletions(-)

Signed-off-by?

Would you please add a test case that uses "git status --amend"? It would
help diagnose failures with regard to "HEAD^" on Windows greatly.

-- Hannes
