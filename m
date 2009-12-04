From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: git-blame.el: what is format-spec?
Date: Fri, 04 Dec 2009 18:42:08 +0100
Message-ID: <m2bpieab67.fsf@igel.home>
References: <87vdgm3e1k.fsf@osv.gnss.ru> <m2fx7qae49.fsf@igel.home>
	<87ljhi3cao.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sergei Organov <osv@javad.com>
X-From: git-owner@vger.kernel.org Fri Dec 04 18:42:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGcAc-00084X-PF
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 18:42:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbZLDRmG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 12:42:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932346AbZLDRmF
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 12:42:05 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:60311 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932212AbZLDRmE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 12:42:04 -0500
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id B0DFD1C0011C;
	Fri,  4 Dec 2009 18:42:09 +0100 (CET)
Received: from localhost (dynscan2.mnet-online.de [192.168.1.215])
	by mail.m-online.net (Postfix) with ESMTP id A5A1D905B1;
	Fri,  4 Dec 2009 18:42:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.3.149])
	by localhost (dynscan2.mnet-online.de [192.168.1.215]) (amavisd-new, port 10024)
	with ESMTP id 1FPTp5R9eXGc; Fri,  4 Dec 2009 18:42:08 +0100 (CET)
Received: from igel.home (DSL01.83.171.145.25.ip-pool.NEFkom.net [83.171.145.25])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Fri,  4 Dec 2009 18:42:08 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 3E70BCA28C; Fri,  4 Dec 2009 18:42:08 +0100 (CET)
X-Yow: Yow!  We're going to a new disco!
In-Reply-To: <87ljhi3cao.fsf@osv.gnss.ru> (Sergei Organov's message of "Fri,
	04 Dec 2009 19:59:43 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134555>

Sergei Organov <osv@javad.com> writes:

> However, isn't it a bad idea to require Gnus(!) for git-blame to run? Gnus
> is not installed on our server where I've encountered the problem. 

Gnus has been part of Emacs since more than 10 years.

> Was format-spec actually moved to core emacs recently?

Yes, in 23.1.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
