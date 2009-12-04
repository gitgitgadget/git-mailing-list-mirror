From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [ANNOUNCE] Git 1.6.5.4
Date: Fri, 04 Dec 2009 11:12:43 +0100
Message-ID: <m2r5rb9hes.fsf@igel.home>
References: <7v638o76ra.fsf@alter.siamese.dyndns.org>
	<m2hbs85koj.fsf@igel.home> <4B17ABE3.6060003@drmicha.warpmail.net>
	<m2d42w5fqq.fsf@igel.home> <4B17D078.6080000@drmicha.warpmail.net>
	<20091203150323.GI23717@inocybe.localdomain>
	<7viqco54xh.fsf@alter.siamese.dyndns.org>
	<20091203202738.GP23717@inocybe.localdomain>
	<7vfx7r4we7.fsf@alter.siamese.dyndns.org>
	<20091203220020.GS23717@inocybe.localdomain>
	<7vbpif4rn2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Todd Zullinger <tmz@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 04 11:12:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGV9h-0000kE-7k
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 11:12:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753087AbZLDKMl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 05:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752561AbZLDKMk
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 05:12:40 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:39159 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752139AbZLDKMj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 05:12:39 -0500
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 426A61C15AE2;
	Fri,  4 Dec 2009 11:12:44 +0100 (CET)
Received: from localhost (dynscan2.mnet-online.de [192.168.1.215])
	by mail.m-online.net (Postfix) with ESMTP id E0FA0903FD;
	Fri,  4 Dec 2009 11:12:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.3.149])
	by localhost (dynscan2.mnet-online.de [192.168.1.215]) (amavisd-new, port 10024)
	with ESMTP id TcJFkc9p5D9s; Fri,  4 Dec 2009 11:12:43 +0100 (CET)
Received: from igel.home (DSL01.83.171.145.25.ip-pool.NEFkom.net [83.171.145.25])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Fri,  4 Dec 2009 11:12:43 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 533C1CA28C; Fri,  4 Dec 2009 11:12:43 +0100 (CET)
X-Yow: I'm definitely not in Omaha!
In-Reply-To: <7vbpif4rn2.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 03 Dec 2009 14:30:41 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134503>

Junio C Hamano <gitster@pobox.com> writes:

> I think it depends on the likelihood that a distro has xmlto so old that
> it does not understand --stringparam yet it uses stylesheet so new that
> setting the parameter makes a positive difference (either it gives the
> full URL or at least squelches the "You should define the parameter"
> noise) in the output.

openSUSE 11.2, for example.  Its xmlto has a non-standard --xsltopts
option that passes its argument down to xsltproc.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
