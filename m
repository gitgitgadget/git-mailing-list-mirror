From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: change symlink
Date: Tue, 30 Oct 2012 22:50:58 +0100
Message-ID: <m27gq7ochp.fsf@igel.home>
References: <CAH_OBie-irmpBrJG6KB3W8bgYjQdyVYiUR-SvJPnx1FXUya0uA@mail.gmail.com>
	<m2mwz3odys.fsf@igel.home>
	<CAH_OBidWxkhG3o4C4OPP4OxyQQfw_fF_h4C9KR9AnoOZ27=9TQ@mail.gmail.com>
	<m2fw4vod81.fsf@igel.home>
	<CAH_OBifch3uuXYHQ1R9vS6xFu8LuY3mUfiPsHcs3F=HMvnBzyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: shawn wilson <ag4ve.us@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 22:51:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTJiL-0002Cv-LM
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 22:51:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757514Ab2J3VvA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 17:51:00 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:56091 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750764Ab2J3Vu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 17:50:59 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3XrmZp5xrxz4KK47;
	Tue, 30 Oct 2012 22:50:58 +0100 (CET)
X-Auth-Info: 9oxu072I+t1/fLy/vUQZtoNUQYyFoVnrsU4cQBMietQ=
Received: from igel.home (ppp-88-217-108-88.dynamic.mnet-online.de [88.217.108.88])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3XrmZp5fL5zbbj2;
	Tue, 30 Oct 2012 22:50:58 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 628D1CA2A2; Tue, 30 Oct 2012 22:50:58 +0100 (CET)
X-Yow: My face is new, my license is expired, and I'm under a doctor's care!!!!
In-Reply-To: <CAH_OBifch3uuXYHQ1R9vS6xFu8LuY3mUfiPsHcs3F=HMvnBzyg@mail.gmail.com>
	(shawn wilson's message of "Tue, 30 Oct 2012 21:42:44 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208752>

shawn wilson <ag4ve.us@gmail.com> writes:

> why is this different?

You didn't tell git about t2/one/test.  You need to add it first to make
it known.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
