From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git-who
Date: Wed, 08 Oct 2008 08:13:49 +0200
Message-ID: <48EC4F9D.4020202@viscovery.net>
References: <DE2CF127-A7FD-4765-A8E4-5235C5F1B9A9@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Rhodes, Kate" <masukomi@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 08 08:15:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnSK8-0006KW-9w
	for gcvg-git-2@gmane.org; Wed, 08 Oct 2008 08:15:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519AbYJHGNw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2008 02:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbYJHGNw
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Oct 2008 02:13:52 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:19572 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259AbYJHGNv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2008 02:13:51 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KnSIv-0003kV-Ox; Wed, 08 Oct 2008 08:13:49 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 62D0A6B7; Wed,  8 Oct 2008 08:13:49 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <DE2CF127-A7FD-4765-A8E4-5235C5F1B9A9@gmail.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97761>

Rhodes, Kate schrieb:
> Once upon a someone asked about seeing who had touched some files. Petr
> Baudis responded with a quickie script that did the job.

Wouldn't

   git shortlog -s -- path/to/file

solve your problem?

-- Hannes
