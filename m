From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Google Gerrit
Date: Tue, 02 Mar 2010 16:30:31 +0100
Message-ID: <4B8D2F17.8040305@drmicha.warpmail.net>
References: <c1fb08351003020610q25b85b60hf9362aabc4b0126f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, sop@google.com
To: Anca Emanuel <anca.emanuel@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 02 16:33:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmU64-0003NA-Mr
	for gcvg-git-2@lo.gmane.org; Tue, 02 Mar 2010 16:33:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753165Ab0CBPdG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Mar 2010 10:33:06 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:37344 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752343Ab0CBPdD (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Mar 2010 10:33:03 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id ECDC2E2E75;
	Tue,  2 Mar 2010 10:33:02 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Tue, 02 Mar 2010 10:33:02 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=xltk07ulTxFPRgMhusuBqByN/X0=; b=D3xZCh46XUJwxAhcpMriTR2zUXwSaRc/LfzHWDMgSNKCfPfw/1PME6NgKjphLVI6+Kf7Jy8GLjIVIheH/lryf4JgY8tT7J0uDNh5eEIwzcYGB3e3l7P3mehY83Q68pxplqgZRzhyTmGnPl+gmliKRGZ2UPLiN39kVZPRbgDdKFg=
X-Sasl-enc: Q5z8RvUkxnG9V8dyKxMc2NKGTmC37SUvx0S3SdRE6NtG 1267543982
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 21C6B49F366;
	Tue,  2 Mar 2010 10:33:01 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9pre) Gecko/20100301 Lightning/1.0b2pre Shredder/3.0.3pre
In-Reply-To: <c1fb08351003020610q25b85b60hf9362aabc4b0126f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141401>

Anca Emanuel venit, vidit, dixit 02.03.2010 15:10:
> Hi, what do you think about Google Gerrit ? http://code.google.com/p/gerrit/
> 
> see it in action here: http://review.source.android.com
> 
> quote:
> "Gerrit is a web based code review system, facilitating online code
> reviews for projects using the Git version control system.
> Gerrit makes reviews easier by showing changes in a side-by-side
> display, and allowing inline comments to be added by any reviewer.
> Gerrit simplifies Git based project maintainership by permitting any
> authorized user to submit changes to the master Git repository, rather
> than requiring all approved changes to be merged in by hand by the
> project maintainer. This functionality enables a more centralized
> usage of Git."
> 
> git needs an friendly UI, web based is the future.

Maybe, one of the main Git guys here should look into it - such as the
one you cc'ed and who's one of the main Gerrit guys also?

Seriously, are you suggesting to use Gerrit for the management of
git.git (the Git source), or what is this post about? Also, please don't
crosspost. If you think kernel people should use Gerrit, post there only.

Michael
