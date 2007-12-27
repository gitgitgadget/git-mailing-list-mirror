From: Charles Bailey <charles@hashpling.org>
Subject: Re: Using git for file archival/backup purposes - deletion strategy
Date: Thu, 27 Dec 2007 16:36:40 +0000
Message-ID: <4773D498.8040204@hashpling.org>
References: <46a038f90712261443t6aa0cd76u46d8ae88fc7c1eba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 27 17:37:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J7vjP-0002OK-IB
	for gcvg-git-2@gmane.org; Thu, 27 Dec 2007 17:37:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470AbXL0Qgq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Dec 2007 11:36:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbXL0Qgp
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Dec 2007 11:36:45 -0500
Received: from pih-relay08.plus.net ([212.159.14.134]:35615 "EHLO
	pih-relay08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751432AbXL0Qgp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Dec 2007 11:36:45 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay08.plus.net with esmtp (Exim) id 1J7vit-00088H-Dr; Thu, 27 Dec 2007 16:36:43 +0000
Received: from [192.168.1.29] (heisenberg2.hashpling.org [192.168.1.29])
	by hashpling.plus.com (8.13.8/8.13.6) with ESMTP id lBRGaeS6005615;
	Thu, 27 Dec 2007 16:36:40 GMT
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <46a038f90712261443t6aa0cd76u46d8ae88fc7c1eba@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69263>

Martin Langhoff wrote:
> Ah! Local clones won't honour --depth!. A clone from git.kernel.org
> does get its .git/shallow file.

This should be fixed in git v1.5.4-rc0 and later.  For reference 
what version of git are you using?

Charles.
