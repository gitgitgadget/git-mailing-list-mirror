From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: the standard hotfix from production scenario not working for me in git...
Date: Thu, 28 Jul 2011 21:31:13 +0200
Message-ID: <m2fwlqi4n2.fsf@igel.home>
References: <1311874508381-6630648.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: deanhiller <dhiller@ghx.com>
X-From: git-owner@vger.kernel.org Thu Jul 28 21:31:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmWIm-0002RD-5s
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 21:31:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755536Ab1G1TbS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 15:31:18 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:34992 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755515Ab1G1TbR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 15:31:17 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 0720D186DEC3;
	Thu, 28 Jul 2011 21:31:13 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id 08C3B1C000AC;
	Thu, 28 Jul 2011 21:31:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id n9RXajNoWqNh; Thu, 28 Jul 2011 21:31:13 +0200 (CEST)
Received: from igel.home (ppp-88-217-118-247.dynamic.mnet-online.de [88.217.118.247])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Thu, 28 Jul 2011 21:31:13 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 0FB46CA293; Thu, 28 Jul 2011 21:31:13 +0200 (CEST)
X-Yow: Where do your SOCKS go when you lose them in th' WASHER?
In-Reply-To: <1311874508381-6630648.post@n2.nabble.com> (deanhiller's message
	of "Thu, 28 Jul 2011 10:35:08 -0700 (PDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178109>

deanhiller <dhiller@ghx.com> writes:

> 5. git addANDrm * (is there a way to do this??????)

$ git add -A .

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
