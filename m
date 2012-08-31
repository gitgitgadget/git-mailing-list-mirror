From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: (minor concern) git using the pager should not be a default
Date: Fri, 31 Aug 2012 20:09:34 +0200
Message-ID: <m2a9xblyqp.fsf@igel.home>
References: <503E3CFE.1080603@sigmadesigns.com>
	<7vd329wpt0.fsf@alter.siamese.dyndns.org>
	<nngligvdk0q.fsf@transit.us.cray.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Emmanuel Michon <emmanuel_michon@sigmadesigns.com>,
	<git@vger.kernel.org>
To: <dag@cray.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 20:10:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7Vfr-0008Bq-RP
	for gcvg-git-2@plane.gmane.org; Fri, 31 Aug 2012 20:10:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754585Ab2HaSKU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Aug 2012 14:10:20 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:51198 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754539Ab2HaSJn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2012 14:09:43 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 3X7pW36bKJz4KK4F;
	Fri, 31 Aug 2012 20:09:35 +0200 (CEST)
X-Auth-Info: Ep/m431LQuc4SNNjqroMHprZJ/GFTJSD7sbeBf3MttU=
Received: from igel.home (ppp-88-217-116-91.dynamic.mnet-online.de [88.217.116.91])
	by mail.mnet-online.de (Postfix) with ESMTPA id 3X7pW34GqMzbbgc;
	Fri, 31 Aug 2012 20:09:35 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id E65E5CA2A3; Fri, 31 Aug 2012 20:09:34 +0200 (CEST)
X-Yow: Yow!  Are we wet yet?
In-Reply-To: <nngligvdk0q.fsf@transit.us.cray.com> (dag@cray.com's message of
	"Fri, 31 Aug 2012 12:54:45 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204601>

<dag@cray.com> writes:

> Is "status" considered a plumbing layer command?  Because I have often
> wondered why it does not use the pager by default.  I pipe it through
> less all the time and it's kind of annoying that it works differently
> than everything else.

I would be pretty annoyed if git status would page by default.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
