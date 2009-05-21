From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] git-svn: add --authors-prog option
Date: Thu, 21 May 2009 07:30:18 -0700
Message-ID: <7vljoqbkat.fsf@alter.siamese.dyndns.org>
References: <20090510003509.GA2000@dcvr.yhbt.net>
	<1242350835-22684-1-git-send-email-lodatom@gmail.com>
	<20090521084343.GA6401@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alex Vandiver <alexmv@MIT.EDU>,
	Eygene Ryabinkin <rea-git@codelabs.ru>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Mark Lodato <lodatom@gmail.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu May 21 16:30:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M79Hx-0007c9-Ja
	for gcvg-git-2@gmane.org; Thu, 21 May 2009 16:30:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753857AbZEUOaT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2009 10:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753847AbZEUOaS
	(ORCPT <rfc822;git-outgoing>); Thu, 21 May 2009 10:30:18 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:54789 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753738AbZEUOaR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2009 10:30:17 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090521143018.CBRF20430.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Thu, 21 May 2009 10:30:18 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id uEWJ1b0034aMwMQ03EWJJC; Thu, 21 May 2009 10:30:18 -0400
X-Authority-Analysis: v=1.0 c=1 a=UjTZZmnVF2gA:10 a=xLGSft7owA8A:10
 a=Hbzmh3xeAAAA:8 a=pGLkceISAAAA:8 a=Ee8u8gBEAAAA:8 a=-zBy0DUhNBB0qEmutNQA:9
 a=dd8VuJBKmqMjh2dqCYluMzDzQRUA:4 a=BEwxGj72lFYA:10 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <20090521084343.GA6401@dcvr.yhbt.net> (Eric Wong's message of "Thu\, 21 May 2009 01\:43\:43 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119686>

Eric Wong <normalperson@yhbt.net> writes:

> Mark Lodato <lodatom@gmail.com> wrote:
>> Signed-off-by: Mark Lodato <lodatom@gmail.com>
>
> Thanks again Mark, sorry again for the late response, it's been
> a long few weeks for me.
>
> Acked-by: Eric Wong <normalperson@yhbt.net>
>
> And pushed out to git://git.bogomips.org/git-svn along with
> a few others that I had acked:
>
> Alex Vandiver (3):
>       git-svn: Fix for svn paths removed > log-window-size revisions ago
>       git-svn: Correctly report max revision when following deleted paths
>       git-svn: Set svn.authorsfile if it is passed to git svn clone
>
> Eygene Ryabinkin (1):
>       git-svn testsuite: use standard configuration for Subversion tools
>
> Mark Lodato (1):
>       git-svn: add --authors-prog option

Thanks, pulled.
