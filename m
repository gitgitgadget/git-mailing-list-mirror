From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Git tag output order is incorrect (IMHO)
Date: Thu, 18 Jul 2013 19:42:03 +0200
Message-ID: <87wqon7ok4.fsf@igel.home>
References: <840FACA0-7E13-41DB-A0F8-124FAB53BFBD@rtcamp.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Rahul Bansal <rahul.bansal@rtcamp.com>
X-From: git-owner@vger.kernel.org Thu Jul 18 19:42:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzsDV-0002NQ-DQ
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 19:42:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759220Ab3GRRmJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 13:42:09 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:49433 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758838Ab3GRRmH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 13:42:07 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3bx2j94dJ0z3hhVt;
	Thu, 18 Jul 2013 19:42:05 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3bx2j945mczbbpG;
	Thu, 18 Jul 2013 19:42:05 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id OV3xHutwyh99; Thu, 18 Jul 2013 19:42:04 +0200 (CEST)
X-Auth-Info: gijUmtMJLNIIGbm97W1Lt6Rbft75NK5vmmf0SJlMCaY=
Received: from igel.home (ppp-88-217-116-104.dynamic.mnet-online.de [88.217.116.104])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Thu, 18 Jul 2013 19:42:04 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 7817EE450B; Thu, 18 Jul 2013 19:42:04 +0200 (CEST)
X-Yow: Yow!  I like my new DENTIST...
In-Reply-To: <840FACA0-7E13-41DB-A0F8-124FAB53BFBD@rtcamp.com> (Rahul Bansal's
	message of "Thu, 18 Jul 2013 20:57:00 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230711>

Rahul Bansal <rahul.bansal@rtcamp.com> writes:

> IMHO "git tag" is expected to show tag-list ordered by versions. 

A git tag can be anything, not related to versions at all.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
