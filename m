From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH 0/3] (hopefully) Proper fix to set show_all_errors where needed
Date: Fri, 03 Sep 2010 16:18:58 +0200
Message-ID: <8762ymewq5.fsf@meyering.net>
References: <vpq39ttxumz.fsf@bauges.imag.fr>
	<1283428655-12680-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Sep 03 16:19:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrX6q-0006Tw-GB
	for gcvg-git-2@lo.gmane.org; Fri, 03 Sep 2010 16:19:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753630Ab0ICOTK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Sep 2010 10:19:10 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:39837 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752365Ab0ICOTJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Sep 2010 10:19:09 -0400
Received: from mx.meyering.net (unknown [82.230.74.64])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 2240C94011B
	for <git@vger.kernel.org>; Fri,  3 Sep 2010 16:18:59 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id A4A47D872; Fri,  3 Sep 2010 16:18:58 +0200 (CEST)
In-Reply-To: <1283428655-12680-1-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Thu, 2 Sep 2010 13:57:32 +0200")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155248>

Matthieu Moy wrote:
> So, after my toy untested patch, here's a cleaner version. I splitted
> it into really small patches, to avoid modifying code while I move it,
> but Junio, feel free to squash 1/3 and 2/3 if you prefer.
>
> This fixes a regression, so this should be in the next release if the
> patch is OK.
>
> Jim: can you confirm if it fixes your problem?

Hi Matthieu,
Thanks for all of those patches.
Unfortunately, I was unable to reproduce the state
that provoked my problem.
