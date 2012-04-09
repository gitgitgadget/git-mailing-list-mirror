From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] Avoid bug in Solaris xpg4/sed as used in submodule
Date: Mon, 09 Apr 2012 23:07:11 +0200
Message-ID: <m2vcl8bon4.fsf@igel.home>
References: <1333997276-sup-2760@pinkfloyd.chass.utoronto.ca>
	<1334002082-5375-1-git-send-email-bwalton@artsci.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain
Cc: gitster@pobox.com, git@vger.kernel.org
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Mon Apr 09 23:07:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHLo6-0006Vy-4L
	for gcvg-git-2@plane.gmane.org; Mon, 09 Apr 2012 23:07:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756104Ab2DIVHT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Apr 2012 17:07:19 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:38776 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752044Ab2DIVHR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2012 17:07:17 -0400
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3VRPGS0GDVz3hhZk;
	Mon,  9 Apr 2012 23:07:11 +0200 (CEST)
Received: from igel.home (ppp-93-104-153-14.dynamic.mnet-online.de [93.104.153.14])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3VRPGR51Sxz4KK3Y;
	Mon,  9 Apr 2012 23:07:11 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 57C2BCA29F; Mon,  9 Apr 2012 23:07:11 +0200 (CEST)
X-Yow: YOW!  I can see 1987!!  PRESIDENT FORD is doing the REMAKE of "PAGAN
 LOVE SONG"...he's playing ESTHER WILLIAMS!!
In-Reply-To: <1334002082-5375-1-git-send-email-bwalton@artsci.utoronto.ca>
	(Ben Walton's message of "Mon, 9 Apr 2012 16:08:02 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.95 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195040>

Ben Walton <bwalton@artsci.utoronto.ca> writes:

> +	# Note: The extra [^/] is to work around a bug in Solairs'

s/Solairs/Solaris/

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
