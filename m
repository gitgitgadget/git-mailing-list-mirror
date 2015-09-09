From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [ANNOUNCE] Git v2.6.0-rc1
Date: Wed, 09 Sep 2015 18:48:14 +0200
Message-ID: <87io7jr12p.fsf@igel.home>
References: <xmqqio7k78sw.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 09 18:48:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZiXo-0002YM-Pu
	for gcvg-git-2@plane.gmane.org; Wed, 09 Sep 2015 18:48:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754703AbbIIQsV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Sep 2015 12:48:21 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:40229 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752843AbbIIQsU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Sep 2015 12:48:20 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3nB8Rj5jmlz3hj8g;
	Wed,  9 Sep 2015 18:48:16 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3nB8Rh2gdyzvk95;
	Wed,  9 Sep 2015 18:48:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id ZKJE5knCyl7j; Wed,  9 Sep 2015 18:48:15 +0200 (CEST)
X-Auth-Info: 7PTGbit6Pbyco5reyct8jMghvMdiSSZbMjEOh8RaqbFMX0w6IwnSyUq+weFuDF4P
Received: from igel.home (ppp-93-104-93-188.dynamic.mnet-online.de [93.104.93.188])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Wed,  9 Sep 2015 18:48:15 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id CA77D2C0AC6; Wed,  9 Sep 2015 18:48:14 +0200 (CEST)
X-Yow: ..  My pants just went on a wild rampage through
 a Long Island Bowling Alley!!
In-Reply-To: <xmqqio7k78sw.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 08 Sep 2015 17:09:19 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277558>

Junio C Hamano <gitster@pobox.com> writes:

>  * After "git am" without "-3" stops, running "git am -" pays attention

Is this a typo for --->                         "git am -3"?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
