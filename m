From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Can git pull from a mercurial repository?
Date: Tue, 18 Sep 2012 14:56:26 +0200
Message-ID: <m2mx0nij5x.fsf@igel.home>
References: <k39lir$gpm$1@ger.gmane.org> <505863B2.9020805@unixsol.org>
	<000801cd9596$885ad6a0$991083e0$@schmitz-digital.de>
	<m2txuvik7g.fsf@igel.home>
	<000901cd959a$c0fcaf20$42f60d60$@schmitz-digital.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "'Georgi Chorbadzhiyski'" <gf@unixsol.org>, <git@vger.kernel.org>
To: "Joachim Schmitz" <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Tue Sep 18 14:56:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDxME-0002HH-AM
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 14:56:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754672Ab2IRM43 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 08:56:29 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:49012 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752958Ab2IRM43 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 08:56:29 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3XLkjR2pvsz3hhfZ;
	Tue, 18 Sep 2012 14:56:27 +0200 (CEST)
X-Auth-Info: DpY1596nDlfNXoANeNDn8U4SlD28YTXARUcFX7B5M8o=
Received: from igel.home (ppp-93-104-159-39.dynamic.mnet-online.de [93.104.159.39])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3XLkjR2NxMzbbhS;
	Tue, 18 Sep 2012 14:56:27 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 040B2CA2A2; Tue, 18 Sep 2012 14:56:26 +0200 (CEST)
X-Yow: I just bought FLATBUSH from MICKEY MANTLE!
In-Reply-To: <000901cd959a$c0fcaf20$42f60d60$@schmitz-digital.de> (Joachim
	Schmitz's message of "Tue, 18 Sep 2012 14:40:13 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205830>

"Joachim Schmitz" <jojo@schmitz-digital.de> writes:

> Git can access cvs and svn repos, right?

It uses the facilities provided by cvs and svn, respectively.

> And without having cvs/scv on the machine...

Git does not reimplement either cvs nor svn.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
