From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Committing a change from one branch another branch
Date: Thu, 13 Mar 2014 11:21:33 +0100
Message-ID: <87bnxav1oy.fsf@igel.home>
References: <CAD6G_RRQVDxQj==-2vAT3WCiYMC=BmZhi__JWi4yy86Uaoa-og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jagan Teki <jagannadh.teki@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 13 11:21:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WO2lj-00054k-5E
	for gcvg-git-2@plane.gmane.org; Thu, 13 Mar 2014 11:21:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754059AbaCMKVj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2014 06:21:39 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:46770 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753671AbaCMKVg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2014 06:21:36 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3fl5g16c7mz4KK4M;
	Thu, 13 Mar 2014 11:21:33 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3fl5g16D3qzbbhy;
	Thu, 13 Mar 2014 11:21:33 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id miCJMOQuYTZ0; Thu, 13 Mar 2014 11:21:33 +0100 (CET)
X-Auth-Info: 6x2c0r/Qna3lmWR7L/0ccOptWkSvkCMdg/cZEVPKOnI=
Received: from igel.home (ppp-46-244-180-61.dynamic.mnet-online.de [46.244.180.61])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Thu, 13 Mar 2014 11:21:33 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
	id 2CDDC2C1656; Thu, 13 Mar 2014 11:21:33 +0100 (CET)
X-Yow: Don't worry, nobody really LISTENS to lectures in MOSCOW, either!
 ..  FRENCH, HISTORY, ADVANCED CALCULUS, COMPUTER PROGRAMMING,
 BLACK STUDIES, SOCIOBIOLOGY!..  Are there any QUESTIONS??
In-Reply-To: <CAD6G_RRQVDxQj==-2vAT3WCiYMC=BmZhi__JWi4yy86Uaoa-og@mail.gmail.com>
	(Jagan Teki's message of "Thu, 13 Mar 2014 15:26:24 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244027>

Jagan Teki <jagannadh.teki@gmail.com> writes:

> How can we do this, any idea?

git cherry-pick

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
