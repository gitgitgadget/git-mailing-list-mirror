From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: corrupted Git repository
Date: Tue, 21 Jun 2011 15:47:13 +0200
Message-ID: <4E00A0E1.8000006@viscovery.net>
References: <BANLkTi=A=DpyfNwEeSd6N6ibCsA5qh_NPQ@mail.gmail.com>	<4E005404.5010901@drmicha.warpmail.net>	<BANLkTi=WVTGcGkUXjkuPYcxhMY0a5KPB7g@mail.gmail.com>	<4E006682.80101@drmicha.warpmail.net> <BANLkTi=GdEfXnAGa6V-33wqX2C-2x-9JQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Kasra Khosoussi <kasra.mail@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 21 15:47:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZ1IZ-00031p-OI
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 15:47:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755769Ab1FUNrS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 09:47:18 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:63713 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752600Ab1FUNrR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 09:47:17 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1QZ1IP-00087B-Uo; Tue, 21 Jun 2011 15:47:14 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id B10611660F;
	Tue, 21 Jun 2011 15:47:13 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <BANLkTi=GdEfXnAGa6V-33wqX2C-2x-9JQQ@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176153>

Am 6/21/2011 12:10, schrieb Kasra Khosoussi:
> Everything seems fine now

But it would still be good to know how the corruption could have happened.
Do you have any clues?

Disk full?
Ctrl-C in the middle of a git operation?
Some cron script interference (unlikely)?
Permission problems (unlikely)?
Networking problems (only if the repository is on a network mount)?
Something else?

-- Hannes
