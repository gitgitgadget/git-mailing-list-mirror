From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Pushing a new branch to a remote and tracking it
Date: Wed, 28 Jul 2010 00:35:25 +0200
Message-ID: <m26300o8nm.fsf@igel.home>
References: <AANLkTikxmhndNqGDpwfBm41OuaPvnB=2xqp6gkYOTQiF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bradley Wagner <bradley.wagner@hannonhill.com>
X-From: git-owner@vger.kernel.org Wed Jul 28 00:35:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdskJ-00054n-4D
	for gcvg-git-2@lo.gmane.org; Wed, 28 Jul 2010 00:35:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384Ab0G0Wf3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jul 2010 18:35:29 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:38042 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751015Ab0G0Wf2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jul 2010 18:35:28 -0400
Received: from frontend1.mail.m-online.net (unknown [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id A00841C15962;
	Wed, 28 Jul 2010 00:35:26 +0200 (CEST)
Received: from igel.home (ppp-88-217-116-227.dynamic.mnet-online.de [88.217.116.227])
	by mail.mnet-online.de (Postfix) with ESMTP id 781491C00248;
	Wed, 28 Jul 2010 00:35:26 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id E426BCA29C; Wed, 28 Jul 2010 00:35:25 +0200 (CEST)
X-Yow: Yow!  I'm out of work...I could go into shock absorbers...or SCUBA
 GEAR!!
In-Reply-To: <AANLkTikxmhndNqGDpwfBm41OuaPvnB=2xqp6gkYOTQiF@mail.gmail.com>
	(Bradley Wagner's message of "Tue, 27 Jul 2010 18:12:09 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152012>

Bradley Wagner <bradley.wagner@hannonhill.com> writes:

> Is there a more elegant way to: 1) create a branch, 2) push it to a
> remote and 3) continue to track it.

git push --set-upstream (since v1.7.0)

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
