From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: t0300-credentials: poll failed: invalid argument
Date: Wed, 14 Sep 2011 10:15:58 +0200
Message-ID: <201109141015.58333.trast@student.ethz.ch>
References: <5C993C44-D045-4344-95C1-94D3E6DB0316@silverinsanity.com> <20110829174309.GA11524@sigill.intra.peff.net> <201109091613.13137.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Brian Gernhardt <benji@silverinsanity.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 14 10:16:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3kdd-0003Vu-2D
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 10:16:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753255Ab1INIQB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 04:16:01 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:36750 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753181Ab1INIQA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 04:16:00 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.289.1; Wed, 14 Sep
 2011 10:15:53 +0200
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.339.1; Wed, 14 Sep
 2011 10:15:58 +0200
User-Agent: KMail/1.13.7 (Linux/3.0.4-43-desktop; KDE/4.6.5; x86_64; ; )
In-Reply-To: <201109091613.13137.trast@student.ethz.ch>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181345>

Thomas Rast wrote:
>   $ uname -a
>   Darwin mackeller.inf.ethz.ch 11.1.0 Darwin Kernel Version 11.1.0: Tue Jul 26 16:07:11 PDT 2011; root:xnu-1699.22.81~1/RELEASE_X86_64 x86_64
[...]
>   --- expect-stderr       2011-09-09 14:12:13.000000000 +0000
>   +++ stderr      2011-09-09 14:12:13.000000000 +0000
>   @@ -1,2 +1,3 @@
>    askpass: Username:
>    askpass: Password:
>   +fatal: poll failed: Invalid argument
> 
> for each of the tests 15--19.  Is it supposed to be fixed?

Ping?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
