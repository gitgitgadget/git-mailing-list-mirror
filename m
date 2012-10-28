From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Removing unreachable objects in the presence of broken links?
Date: Sun, 28 Oct 2012 22:34:37 +0100
Message-ID: <m2r4oiffgy.fsf@igel.home>
References: <CAMuHMdUqUtDspOP2kE9wtGEr9aJHGGBG=HRomdY6NRa8gxar4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sun Oct 28 22:35:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSaVX-00035x-NX
	for gcvg-git-2@plane.gmane.org; Sun, 28 Oct 2012 22:35:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756040Ab2J1Vel (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2012 17:34:41 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:59079 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756027Ab2J1Vek (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2012 17:34:40 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3XqXJt0rWhz4KK2t;
	Sun, 28 Oct 2012 22:34:38 +0100 (CET)
X-Auth-Info: YyubHcaeAGUttJfRMtOUQ6ZivCI7rc1QQgEzuhMEpqs=
Received: from igel.home (ppp-93-104-156-214.dynamic.mnet-online.de [93.104.156.214])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3XqXJt0KQNzbbcM;
	Sun, 28 Oct 2012 22:34:38 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id AB41CCA2A1; Sun, 28 Oct 2012 22:34:37 +0100 (CET)
X-Yow: First, I'm going to give you all the ANSWERS to today's test..
 So just plug in your SONY WALKMANS and relax!!
In-Reply-To: <CAMuHMdUqUtDspOP2kE9wtGEr9aJHGGBG=HRomdY6NRa8gxar4A@mail.gmail.com>
	(Geert Uytterhoeven's message of "Sun, 28 Oct 2012 22:21:32 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208570>

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> Is there a way to force removing unreachable objects in the presence of broken
> links?

Does it help to forcibly expire the reflogs?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
