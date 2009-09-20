From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Documentation problems
Date: Sun, 20 Sep 2009 22:52:13 +0200
Message-ID: <m2zl8p9w5e.fsf@igel.home>
References: <4AB66D4C.70301@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bruce Korb <bruce.korb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 20 22:52:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MpTOQ-0007Zn-GT
	for gcvg-git-2@lo.gmane.org; Sun, 20 Sep 2009 22:52:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbZITUwN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Sep 2009 16:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750964AbZITUwN
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Sep 2009 16:52:13 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:39450 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750868AbZITUwM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Sep 2009 16:52:12 -0400
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 7C5261C000BD;
	Sun, 20 Sep 2009 22:52:15 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id 70AB4901DD;
	Sun, 20 Sep 2009 22:52:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.3.149])
	by localhost (dynscan1.mnet-online.de [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id 3G+U0YBEvnUo; Sun, 20 Sep 2009 22:53:12 +0200 (CEST)
Received: from igel.home (DSL01.83.171.154.153.ip-pool.NEFkom.net [83.171.154.153])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Sun, 20 Sep 2009 22:52:14 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 3C1A310DCA6; Sun, 20 Sep 2009 22:52:14 +0200 (CEST)
X-Yow: Yow!  Those people look exactly like Donnie and Marie Osmond!!
In-Reply-To: <4AB66D4C.70301@gmail.com> (Bruce Korb's message of "Sun, 20 Sep
	2009 10:58:36 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128861>

Bruce Korb <bruce.korb@gmail.com> writes:

> I'm trying to figure out what a ``tree-ish''.
> I cannot seem to use many of the commands until I know.
>
> <tree-ish>
>     Indicates a tree, commit or tag object name. A command that takes a
>     <tree-ish> argument ultimately wants to operate on a <tree> object
>     but automatically dereferences <commit> and <tag> objects that point at a <tree>.
>
> I need a translation.  :(  Thank you.  Regards, Bruce

See gitglossary(7).

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
