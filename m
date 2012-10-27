From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: git config error message
Date: Sat, 27 Oct 2012 18:12:45 +0200
Message-ID: <m2r4oj99mq.fsf@igel.home>
References: <CAB9Jk9AQkSiv=F8NeYs+uspR5f4CeJS5L-hwZUXdq7dts1W5ng@mail.gmail.com>
	<m2bofo9v93.fsf@linux-m68k.org>
	<CAB9Jk9CONVSZvBUgnZHiniwPHHvcap8Wyjyw-sCHaSokDoNRWA@mail.gmail.com>
	<CAP30j15pUwX9sD3FXAfroxFK9paHmb1eAg+M5YAHT4aB22DBEw@mail.gmail.com>
	<CAB9Jk9COSZOske5xzgnE=1oHe7qiwwOzHYE6pJkuZ0sZyZYhng@mail.gmail.com>
	<m2d3049hvs.fsf@igel.home>
	<CAB9Jk9A-uXXXKCBKvxyDN6QQx1b0zqemg7UbeRMcWeY7gi4MRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ben Walton <bdwalton@gmail.com>, git <git@vger.kernel.org>
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 27 18:13:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TS90O-0006mB-Ll
	for gcvg-git-2@plane.gmane.org; Sat, 27 Oct 2012 18:13:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759246Ab2J0QMs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2012 12:12:48 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:38309 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759133Ab2J0QMr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2012 12:12:47 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3XpnCx4y3Fz3hhdT;
	Sat, 27 Oct 2012 18:12:45 +0200 (CEST)
X-Auth-Info: 8pSB63GRQrgYKKUmfjC04Jas+JZPFMhjEeBeceHQEDo=
Received: from igel.home (ppp-93-104-148-157.dynamic.mnet-online.de [93.104.148.157])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3XpnCx4ckhzbbgR;
	Sat, 27 Oct 2012 18:12:45 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 44ADDCA2A1; Sat, 27 Oct 2012 18:12:45 +0200 (CEST)
X-Yow: These PRESERVES should be FORCE-FED to PENTAGON OFFICIALS!!
In-Reply-To: <CAB9Jk9A-uXXXKCBKvxyDN6QQx1b0zqemg7UbeRMcWeY7gi4MRQ@mail.gmail.com>
	(Angelo Borsotti's message of "Sat, 27 Oct 2012 16:50:32 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208511>

Angelo Borsotti <angelo.borsotti@gmail.com> writes:

> when the section or key is absent

When the key is malformed you get an error, otherwise not.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
