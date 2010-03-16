From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] Fix indentation problem in git-ls-files(1)
Date: Tue, 16 Mar 2010 20:47:57 +0100
Message-ID: <m2pr34kpzm.fsf@igel.home>
References: <m2tyswb1jp.fsf@igel.home>
	<7v3a0fr740.fsf@alter.siamese.dyndns.org> <m3r5nzw05p.fsf@hase.home>
	<ca433831003070927h4c3e24e1m75c7be88355f9663@mail.gmail.com>
	<m23a01yzcc.fsf@igel.home> <4B9F2DB0.30400@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Mark Lodato <lodatom@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Mar 16 20:48:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrckK-0007UO-P2
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 20:48:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755846Ab0CPTsE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Mar 2010 15:48:04 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:40134 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753584Ab0CPTsB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Mar 2010 15:48:01 -0400
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 7345D1C002CA;
	Tue, 16 Mar 2010 20:47:58 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id 69DF9902C1;
	Tue, 16 Mar 2010 20:47:58 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.3.149])
	by localhost (dynscan1.mnet-online.de [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id L-7Krf2cwF4Y; Tue, 16 Mar 2010 20:47:57 +0100 (CET)
Received: from igel.home (DSL01.83.171.163.37.ip-pool.NEFkom.net [83.171.163.37])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Tue, 16 Mar 2010 20:47:57 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 37673CA297; Tue, 16 Mar 2010 20:47:57 +0100 (CET)
X-Yow: I demand IMPUNITY!
In-Reply-To: <4B9F2DB0.30400@viscovery.net> (Johannes Sixt's message of "Tue,
	16 Mar 2010 08:05:20 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.94 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142350>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Andreas Schwab schrieb:
>> The nested list in the description of the -t option wasn't properly
>> indented.  Additionally, make it a horizontal labeled list since the
>> labels are all short.
>
> IMHO, converting a vertical list to a horizontal list is a step in the
> wrong direction, even if the labels are short. It is far easier to scan a
> vertical list for a match than a horizontal list.

The linebreak after the label is useless when all labels are much
shorter than the indentation.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
