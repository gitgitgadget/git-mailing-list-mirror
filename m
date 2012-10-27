From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: git config error message
Date: Sat, 27 Oct 2012 10:44:47 +0200
Message-ID: <m27gqc9udc.fsf@linux-m68k.org>
References: <CAB9Jk9AQkSiv=F8NeYs+uspR5f4CeJS5L-hwZUXdq7dts1W5ng@mail.gmail.com>
	<m2bofo9v93.fsf@linux-m68k.org>
	<CAB9Jk9CONVSZvBUgnZHiniwPHHvcap8Wyjyw-sCHaSokDoNRWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git <git@vger.kernel.org>
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 27 10:45:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TS212-0008Od-Gd
	for gcvg-git-2@plane.gmane.org; Sat, 27 Oct 2012 10:45:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757071Ab2J0Ioy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2012 04:44:54 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:37118 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755361Ab2J0Iov (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2012 04:44:51 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3XpbH41wgtz4KK87;
	Sat, 27 Oct 2012 10:44:48 +0200 (CEST)
X-Auth-Info: N6BvsudjihO5vG6WT8TByDRKZKailSENzdadLQKH8F8=
Received: from linux.local (ppp-93-104-148-157.dynamic.mnet-online.de [93.104.148.157])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3XpbH41YM2zbbgf;
	Sat, 27 Oct 2012 10:44:48 +0200 (CEST)
Received: by linux.local (Postfix, from userid 501)
	id 7DF811E550C; Sat, 27 Oct 2012 10:44:47 +0200 (CEST)
X-Yow: I had pancake makeup for brunch!
In-Reply-To: <CAB9Jk9CONVSZvBUgnZHiniwPHHvcap8Wyjyw-sCHaSokDoNRWA@mail.gmail.com>
	(Angelo Borsotti's message of "Sat, 27 Oct 2012 10:32:48 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208501>

Angelo Borsotti <angelo.borsotti@gmail.com> writes:

> I wrote "value", but I meant "name". The first example I made contains
> a name with a nonexistent section, the second a name with a
> nonexistent key.

And a nonexistent key is a valid key, so not an error.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
