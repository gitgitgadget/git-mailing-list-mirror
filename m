From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Enhancement Request: "locale" git option
Date: Thu, 04 Dec 2014 17:53:34 +0100
Message-ID: <874mtbjr01.fsf@igel.home>
References: <54801C39020000A1000182FA@gwsmtp1.uni-regensburg.de>
	<54801B50.4080500@web.de> <20141204095557.GE27455@peff.net>
	<CACBZZX4Rin6jj2viTUmdpEqLb9TWnMf+p_vRF8BbLrTWFDcp3A@mail.gmail.com>
	<548087F8.1030103@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jeff King <peff@peff.net>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
	Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Dec 04 17:53:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwZey-0000Me-35
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 17:53:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932513AbaLDQxk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 11:53:40 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:48561 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932240AbaLDQxj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 11:53:39 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3jtjmc2XvKz3hkyl;
	Thu,  4 Dec 2014 17:53:36 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3jtjmb3ytPzvh2h;
	Thu,  4 Dec 2014 17:53:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id UVbpBzZjS-pE; Thu,  4 Dec 2014 17:53:34 +0100 (CET)
X-Auth-Info: zg8iubhwTTdUuw9dnuhOtUZxCP3wFIro6RELf+QWpZeofOYVfy8XI1qEmOlVQHjZ
Received: from igel.home (host-188-174-211-246.customer.m-online.net [188.174.211.246])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Thu,  4 Dec 2014 17:53:34 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
	id 09C6E2C16EB; Thu,  4 Dec 2014 17:53:34 +0100 (CET)
X-Yow: Today, THREE WINOS from DETROIT sold me a framed photo of
 TAB HUNTER before his MAKEOVER!
In-Reply-To: <548087F8.1030103@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Thu, 04 Dec 2014 17:12:40 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260765>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> The main issue at hand is really that we have localised git but not its
> man pages. Even if you understand English, the man pages don't help you
> at all if you can't connect the technical terms used there to their
> localised counterparts in git's messages. (NO_GETTEXT=y is my solution.)

So the problem is just that the localisation is incomplete.  This is
unfortunate, but happens with a lot of software out there, and providing
a git-only solution doesn't help the case.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
