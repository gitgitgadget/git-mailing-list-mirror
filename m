From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Unable to clone GIT project
Date: Fri, 21 Sep 2012 20:37:57 +0200
Message-ID: <m2wqzn9q7u.fsf@igel.home>
References: <0D5A104FDD13FC4C9EE1E66F4FA3ABF60FCFDB65@NOIX10HMNOI01.AMER.DELL.COM>
	<20120916104651.GF32381@localhost.localdomain>
	<CABPQNSbPF=_a7-+JnojM2DQAkkj7ZLhSnO+n-Ab=LSrHge1dnQ@mail.gmail.com>
	<20120917202124.GC24888@sigill.intra.peff.net>
	<0D5A104FDD13FC4C9EE1E66F4FA3ABF60FCFE5FB@NOIX10HMNOI01.AMER.DELL.COM>
	<m2392fk8dx.fsf@igel.home>
	<0D5A104FDD13FC4C9EE1E66F4FA3ABF60FD03E66@NOIX10HMNOI01.AMER.DELL.COM>
	<0D5A104FDD13FC4C9EE1E66F4FA3ABF60FD03E94@NOIX10HMNOI01.AMER.DELL.COM>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <peff@peff.net>, <kusmabite@gmail.com>,
	<flatworm@users.sourceforge.net>, <git@vger.kernel.org>
To: <Ankush_Aggarwal@DELL.com>
X-From: git-owner@vger.kernel.org Fri Sep 21 20:38:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TF87C-0006oN-Bl
	for gcvg-git-2@plane.gmane.org; Fri, 21 Sep 2012 20:38:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413Ab2IUSiE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2012 14:38:04 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:36876 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757369Ab2IUSiD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2012 14:38:03 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3XNk866l0mz3hhZP;
	Fri, 21 Sep 2012 20:37:58 +0200 (CEST)
X-Auth-Info: pTXsFrN49uAjl6fiLKws0CJ7GP4fdshUelmr7ID5hKA=
Received: from igel.home (ppp-88-217-127-217.dynamic.mnet-online.de [88.217.127.217])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3XNk8612Rpzbbjv;
	Fri, 21 Sep 2012 20:37:58 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id BD3AFCA2A5; Fri, 21 Sep 2012 20:37:57 +0200 (CEST)
X-Yow: ...Get me a GIN and TONIC!!...make it HAIR TONIC!!
In-Reply-To: <0D5A104FDD13FC4C9EE1E66F4FA3ABF60FD03E94@NOIX10HMNOI01.AMER.DELL.COM>
	(Ankush Aggarwal's message of "Fri, 21 Sep 2012 18:02:17 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206148>

That doesn't solve the mystery why you need libiconv in the first place.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
