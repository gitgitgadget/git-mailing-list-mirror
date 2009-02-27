From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: help with reflog
Date: Fri, 27 Feb 2009 08:24:57 +0100
Message-ID: <49A79549.1020802@viscovery.net>
References: <450196A1AAAE4B42A00A8B27A59278E709E04E87@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: John Dlugosz <JDlugosz@TradeStation.com>
X-From: git-owner@vger.kernel.org Fri Feb 27 08:26:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lcx77-0006As-T4
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 08:26:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754276AbZB0HZG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 02:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754132AbZB0HZE
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 02:25:04 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:43252 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753833AbZB0HZD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Feb 2009 02:25:03 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Lcx5d-00011v-MD; Fri, 27 Feb 2009 08:24:58 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 709BB6C4; Fri, 27 Feb 2009 08:24:57 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <450196A1AAAE4B42A00A8B27A59278E709E04E87@EXCHANGE.trad.tradestation.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111640>

John Dlugosz schrieb:
> My Log for 'HEAD' only has 14 entries.  Shouldn't it go back for 90 days?

Did you initialize or clone *this*particular*repository* more than 90 days
ago?

> I see nothing in the 'config' file.

Are you saying that the .git/config file is empty?
What does 'git config core.logallrefupdates' report?

-- Hannes
