From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: Missing pieces for 1.6.0 on MinGW?
Date: Sun, 3 Aug 2008 10:52:15 +0200
Message-ID: <E7278ED4-5423-4D53-B4B8-9AC620FDF769@zib.de>
References: <7vljzfkzkv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <johannes.sixt@telecom.at>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 03 10:53:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPZL2-0006kQ-12
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 10:53:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751997AbYHCIwN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 04:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751682AbYHCIwN
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 04:52:13 -0400
Received: from mailer.zib.de ([130.73.108.11]:57254 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751196AbYHCIwM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 04:52:12 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m738pvLl008905;
	Sun, 3 Aug 2008 10:52:02 +0200 (CEST)
Received: from [192.168.178.21] (brln-4db831ac.pool.einsundeins.de [77.184.49.172])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m738pudG002739
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 3 Aug 2008 10:51:57 +0200 (MEST)
In-Reply-To: <7vljzfkzkv.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.926)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91218>


On Aug 2, 2008, at 9:05 PM, Junio C Hamano wrote:

> Just a quick question before the weekend ends and -rc2 gets tagged.   
> (I
> lost track of that argv0 vs bin/git vs libexec/git-core/git-foo
> discussion).

I haven't found time to work on this and I also haven't observed
any progress made by others.


> Are there any missing but necessary patches we need before 1.6.0 for
> MinGW?

So we don't have patches, although we still have the problem
discussed last weekend.

Unfortunately, I cannot promise that I'll find time the next couple
of days to work on the issue.  I propose you just continue the
release cycle without waiting for MinGW.

	Steffen
