From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: What's the status of MinGW port.
Date: Mon, 08 Sep 2008 09:08:08 +0200
Message-ID: <48C4CF58.4020906@viscovery.net>
References: <42b562540809072128o62854572y1eb8d2e69e7193f1@mail.gmail.com> <42b562540809072134xed61f0as6f1201a641ec973c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Kevin Yu <yujie052@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 08 09:13:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcawY-00023W-SV
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 09:13:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751790AbYIHHIN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 03:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751814AbYIHHIM
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 03:08:12 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:7798 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751649AbYIHHIM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 03:08:12 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Kcar3-0003Me-1J; Mon, 08 Sep 2008 09:08:09 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 9F8B46B7; Mon,  8 Sep 2008 09:08:08 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <42b562540809072134xed61f0as6f1201a641ec973c@mail.gmail.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95221>

Kevin Yu schrieb:
>       GIT is a great tool, but I'm running Windows XP.
>       It seems like msysgit hasn't been updated for a long time,
> neither has the mingw.git branch.
>       Is there any plan to create a native version of GIT on MS Windows?

There are no plans anymore to create such a thing.

It is already there: http://code.google.com/p/msysgit/

If the lack of activity is worrysome to you, you could help create a
release tarball for 1.6.0(.x).

-- Hannes
