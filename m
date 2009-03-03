From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: proper way to merge?
Date: Tue, 03 Mar 2009 17:15:29 +0100
Message-ID: <49AD57A1.9080109@viscovery.net>
References: <450196A1AAAE4B42A00A8B27A59278E709F06FDA@EXCHANGE.trad.tradestation.com> <3e8340490903020033l78329c82la186cadaa528bc32@mail.gmail.com> <450196A1AAAE4B42A00A8B27A59278E709F07452@EXCHANGE.trad.tradestation.com> <49ACDD17.2060601@viscovery.net> <450196A1AAAE4B42A00A8B27A59278E709F075F9@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Bryan Donlan <bdonlan@gmail.com>, git@vger.kernel.org
To: John Dlugosz <JDlugosz@TradeStation.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 17:17:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeXIm-0000Yc-Bd
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 17:17:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753500AbZCCQPf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 11:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752421AbZCCQPe
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 11:15:34 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:11802 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785AbZCCQPd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 11:15:33 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LeXHF-0005Wa-Ry; Tue, 03 Mar 2009 17:15:30 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 9ABE46B7; Tue,  3 Mar 2009 17:15:29 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <450196A1AAAE4B42A00A8B27A59278E709F075F9@EXCHANGE.trad.tradestation.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112103>

John Dlugosz schrieb:
> " *	Some commands are not yet supported on Windows and excluded from
> the installation; namely: git archimport, git cvsexportcommit, git
> cvsimport, git cvsserver, git filter-branch, git instaweb, git
> send-email, git shell, git svn."

A-ha. If there ever was a reason to exclude filter-branch, then I think
this reason is no more.

> So I wonder why you think it *is* in msysgit?  This is the latest
> version from their site.

Because I don't use the msysgit installer, but compile git myself. I have
a working filter-branch.

-- Hannes
