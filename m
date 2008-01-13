From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH v3] safecrlf: Add mechanism to warn about irreversible crlf conversions
Date: Mon, 14 Jan 2008 01:02:27 +0300
Message-ID: <20080113220227.GR2963@dpotapov.dyndns.org>
References: <1200241847776-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, torvalds@linux-foundation.org,
	git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Jan 13 23:24:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEBFO-0006xI-AV
	for gcvg-git-2@gmane.org; Sun, 13 Jan 2008 23:24:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754685AbYAMWXc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jan 2008 17:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754975AbYAMWX2
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jan 2008 17:23:28 -0500
Received: from smtp03.mtu.ru ([62.5.255.50]:51456 "EHLO smtp03.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754883AbYAMWXY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jan 2008 17:23:24 -0500
Received: from smtp03.mtu.ru (localhost.mtu.ru [127.0.0.1])
	by smtp03.mtu.ru (Postfix) with ESMTP id BC0561870D5A;
	Mon, 14 Jan 2008 01:23:22 +0300 (MSK)
Received: from dpotapov.dyndns.org (ppp85-140-170-195.pppoe.mtu-net.ru [85.140.170.195])
	by smtp03.mtu.ru (Postfix) with ESMTP id AF32B1870D0A;
	Mon, 14 Jan 2008 01:23:22 +0300 (MSK)
Received: from dpotapov by dpotapov.dyndns.org with local (Exim 4.63)
	(envelope-from <dpotapov@gmail.com>)
	id 1JEAuR-0003Zb-Ky; Mon, 14 Jan 2008 01:02:27 +0300
Content-Disposition: inline
In-Reply-To: <1200241847776-git-send-email-prohaska@zib.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-DCC-STREAM-Metrics: smtp03.mtu.ru 10001; Body=0 Fuz1=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70417>

Hi Steffan,

The patch looks good to me. So:

Acked-by: Dmitry Potapov <dpotapov@gmail.com>

Dmitry
