From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: Question on merge and mergetool settings
Date: Wed, 29 Apr 2009 23:36:53 +0200
Message-ID: <200904292336.54256.markus.heidelberg@web.de>
References: <450196A1AAAE4B42A00A8B27A59278E70AE3F2FE@EXCHANGE.trad.tradestation.com> <200904292200.11373.markus.heidelberg@web.de> <450196A1AAAE4B42A00A8B27A59278E70B002E12@EXCHANGE.trad.tradestation.com>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "John Dlugosz" <JDlugosz@tradestation.com>
X-From: git-owner@vger.kernel.org Wed Apr 29 23:37:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzHSl-0003Lh-Ea
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 23:37:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754970AbZD2Vg6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 17:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754516AbZD2Vg5
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 17:36:57 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:60286 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754463AbZD2Vg5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 17:36:57 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id D3888FDFECED;
	Wed, 29 Apr 2009 23:36:56 +0200 (CEST)
Received: from [89.59.108.55] (helo=.)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1LzHSa-0006PT-00; Wed, 29 Apr 2009 23:36:56 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <450196A1AAAE4B42A00A8B27A59278E70B002E12@EXCHANGE.trad.tradestation.com>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX19LNRxH5f55ox+4YxyV0gQZpCdQF56TwH6ctzjS
	M+i9Ef07WfaS50SudliEV3980wo5HThLCYF95cynXgg6DwYzML
	qcwCkyfm0wtXzPsWzJXA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117952>

John Dlugosz, 29.04.2009:
> > There is remote.<name>.url, mergetool.<name>.path
> > There is no merge.url, merge.path, mergetool.<name>.url
> 
> Can the git-config document be relied on to be complete and up to date?

That would be rather unrealistic, but I think it's pretty good. The
above mentioned config options for example are included there :)
The options in the sendemail.* namespace for another example are only
mentioned in the git-send-email doc.

Markus
