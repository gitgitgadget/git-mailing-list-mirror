From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: How to check out the repository at a particular point in time
Date: Wed, 24 Aug 2011 08:48:13 -0700
Message-ID: <86vctm24le.fsf@red.stonehenge.com>
References: <201108221525.32982.trast@student.ethz.ch>
	<1314026326.37332.YahooMailClassic@web25408.mail.ukl.yahoo.com>
	<CAMOZ1Bti3ZtAEOtLiUYSkWE+rO_VQd09NAn58Cn4hZBu8f-aFQ@mail.gmail.com>
	<4E551BC3.8080701@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Witten <mfwitten@gmail.com>, rdiezmail-temp2@yahoo.de,
	Thomas Rast <trast@student.ethz.ch>, in-git-vger@baka.org,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Aug 24 17:48:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwFgl-00053i-1c
	for gcvg-git-2@lo.gmane.org; Wed, 24 Aug 2011 17:48:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751750Ab1HXPsS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Aug 2011 11:48:18 -0400
Received: from lax-gw09.mailroute.net ([199.89.0.109]:34785 "EHLO
	mail.mroute.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751172Ab1HXPsQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2011 11:48:16 -0400
Received: from localhost (localhost [127.0.0.1])
	by lax-gw09.mroute.net (Postfix) with ESMTP id 9B4E0138517;
	Wed, 24 Aug 2011 15:48:14 +0000 (GMT)
X-Virus-Scanned: by MailRoute
Received: from red.stonehenge.com (red.stonehenge.com [208.79.95.2])
	by lax-gw09.mroute.net (Postfix) with ESMTP id 81772138491;
	Wed, 24 Aug 2011 15:48:13 +0000 (GMT)
Received: by red.stonehenge.com (Postfix, from userid 1001)
	id 75B0F3AA1; Wed, 24 Aug 2011 08:48:13 -0700 (PDT)
x-mayan-date: Long count = 12.19.18.11.15; tzolkin = 13 Men; haab = 3 Mol
In-Reply-To: <4E551BC3.8080701@op5.se> (Andreas Ericsson's message of "Wed, 24
	Aug 2011 17:41:55 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180012>

>>>>> "Andreas" == Andreas Ericsson <ae@op5.se> writes:

Andreas> Whatever, really. The fact that pretty much everyone seems to know
Andreas> what a branch is and how it works in git after a (very) brief intro
Andreas> to it means it's either right on target or that people are so used to
Andreas> the fact that branch means something different in every scm that they
Andreas> don't even bother loading the word with some preconceived notion that
Andreas> used to be right in cvs.

It does lead to confusion though, and once you *really* understand that
a branch is a point, not a line, you can do a lot more cool things with
git, and rebase and stash make a lot more sense.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Smalltalk/Perl/Unix consulting, Technical writing, Comedy, etc. etc.
See http://methodsandmessages.posterous.com/ for Smalltalk discussion
