From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Consistent terminology: cached/staged/index
Date: Mon, 14 Feb 2011 07:59:43 +0100
Message-ID: <4D58D2DF.1050205@viscovery.net>
References: <AANLkTi=9OWqz66Ab6O9tc4eYSrhZZ1YC_+ta9sutAn30@mail.gmail.com> <20110213193738.GA26868@elie> <7v8vxjwnhj.fsf@alter.siamese.dyndns.org> <87k4h34bhj.fsf@catnip.gol.com> <7vr5bbupj4.fsf@alter.siamese.dyndns.org> <AANLkTi=PDhVgpTeFjTxFuVJGbAKTHzHhsNVcquqSD3Qq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Mon Feb 14 08:00:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PosQ1-00045W-B8
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 08:00:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452Ab1BNHAI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Feb 2011 02:00:08 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:61049 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751373Ab1BNHAG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Feb 2011 02:00:06 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1PosPh-0005Cc-29; Mon, 14 Feb 2011 08:00:01 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id A6A6D1660F;
	Mon, 14 Feb 2011 08:00:00 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <AANLkTi=PDhVgpTeFjTxFuVJGbAKTHzHhsNVcquqSD3Qq@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166692>

Am 2/14/2011 7:27, schrieb Miles Bader:
> "git diff -s"  ? ... since --staged is an alias for --cached :)

git config --global alias.diffc "diff --cached"

?

-- Hannes
