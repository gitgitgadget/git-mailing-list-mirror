From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: git-blame.el: what is format-spec?
Date: Fri, 04 Dec 2009 17:38:30 +0100
Message-ID: <m2fx7qae49.fsf@igel.home>
References: <87vdgm3e1k.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sergei Organov <osv@javad.com>
X-From: git-owner@vger.kernel.org Fri Dec 04 17:38:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGbB0-0006ea-Oq
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 17:38:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753544AbZLDQi2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 11:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755631AbZLDQi1
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 11:38:27 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:46753 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753077AbZLDQi0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 11:38:26 -0500
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id E67D51C15502;
	Fri,  4 Dec 2009 17:38:31 +0100 (CET)
Received: from localhost (dynscan2.mnet-online.de [192.168.1.215])
	by mail.m-online.net (Postfix) with ESMTP id 952A9908A0;
	Fri,  4 Dec 2009 17:38:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.3.149])
	by localhost (dynscan2.mnet-online.de [192.168.1.215]) (amavisd-new, port 10024)
	with ESMTP id uaHGCmc6sfm1; Fri,  4 Dec 2009 17:38:30 +0100 (CET)
Received: from igel.home (DSL01.83.171.145.25.ip-pool.NEFkom.net [83.171.145.25])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Fri,  4 Dec 2009 17:38:30 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 3F90CCA28C; Fri,  4 Dec 2009 17:38:30 +0100 (CET)
X-Yow: I'm a fuschia bowling ball somewhere in Brittany
In-Reply-To: <87vdgm3e1k.fsf@osv.gnss.ru> (Sergei Organov's message of "Fri,
	04 Dec 2009 19:21:59 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134534>

Sergei Organov <osv@javad.com> writes:

> What is format-spec function in current git-blame.el? Neither my GNU
> Emacs 22.2.1 nor Google knows anything about it.

It's part of Emacs since more than 9 years, imported from Gnus.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
