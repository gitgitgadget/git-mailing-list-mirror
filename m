From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: using git-svn with --no-metadata
Date: Sat, 21 Aug 2010 22:03:10 +0200
Message-ID: <m2pqxbzqbl.fsf@igel.home>
References: <E1OmnCj-0001Z7-2U@smtp.tt-solutions.com>
	<20100821183711.GA14986@dcvr.yhbt.net>
	<20100821190711.GA19129@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Vadim Zeitlin <vz-git@zeitlins.org>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Aug 21 22:03:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmuHm-0007BA-4X
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 22:03:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752033Ab0HUUDO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Aug 2010 16:03:14 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:33175 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751887Ab0HUUDN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Aug 2010 16:03:13 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 090C11C0031D;
	Sat, 21 Aug 2010 22:03:10 +0200 (CEST)
Received: from igel.home (ppp-93-104-151-37.dynamic.mnet-online.de [93.104.151.37])
	by mail.mnet-online.de (Postfix) with ESMTP id 95D331C0036E;
	Sat, 21 Aug 2010 22:03:10 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 42B9DCA299; Sat, 21 Aug 2010 22:03:10 +0200 (CEST)
X-Yow: How's the wife?  Is she at home enjoying capitalism?
In-Reply-To: <20100821190711.GA19129@dcvr.yhbt.net> (Eric Wong's message of
	"Sat, 21 Aug 2010 19:07:11 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154155>

Eric Wong <normalperson@yhbt.net> writes:

> "noMetadata" is a limited and sometimes harmful option.
> Recommend git-filter-branch instead (if at all) for one-shot
> imports instead.

s/instead//

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
