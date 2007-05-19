From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: Commits gone AWOL, but not reported by git-fsck --unreachable
Date: Sat, 19 May 2007 12:20:56 -0400
Message-ID: <A04FB6C2-20B2-4263-9D58-6C281C04C6C4@silverinsanity.com>
References: <20070519103011.GU17511@curie-int.orbis-terrarum.net> <20070519115245.GA10035@coredump.intra.peff.net> <20070519120933.GW17511@curie-int.orbis-terrarum.net> <20070519121154.GA10268@coredump.intra.peff.net> <pan.2007.05.19.15.45.46@progsoc.org> <vpq646opzio.fsf@bauges.imag.fr>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Anand Kumria <wildfire@progsoc.org>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sat May 19 18:21:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpRgK-0001rm-LG
	for gcvg-git@gmane.org; Sat, 19 May 2007 18:21:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755848AbXESQVD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 12:21:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754518AbXESQVD
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 12:21:03 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:38454 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757852AbXESQVA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 12:21:00 -0400
Received: from [IPv6???1] (localhost [127.0.0.1])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id E6C771FFC03B;
	Sat, 19 May 2007 16:20:59 +0000 (UTC)
In-Reply-To: <vpq646opzio.fsf@bauges.imag.fr>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47754>


On May 19, 2007, at 12:08 PM, Matthieu Moy wrote:

> The commit introducing it is 566842f62bdf1f16c2e94fb431445d2e6c0f3f0b,
> and I'd say it's in git 1.5.1:
>
> $ git-describe --tags 566842f62bdf1f16c2e94fb431445d2e6c0f3f0b
> v1.5.1-34-g566842f

Actually, I think that means it's 34 commits *after* v1.5.1, not  
before.  It's in 1.5.2-rc0, but none of the 1.5.1.* series.

~~ Brian
