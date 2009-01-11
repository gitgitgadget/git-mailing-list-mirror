From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH v4] submodule: add --no-fetch parameter to update command
Date: Sun, 11 Jan 2009 10:31:58 +0900
Message-ID: <20090111103158.6117@nanako3.lavabit.com>
References: <1231553410-7541-2-git-send-email-git@fabian-franz.de>
 <1231553410-7541-1-git-send-email-git@fabian-franz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, j.sixt@viscovery.net, hjemli@gmail.com,
	gitster@pobox.com
To: Fabian Franz <git@fabian-franz.de>
X-From: git-owner@vger.kernel.org Sun Jan 11 02:34:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLpDQ-0000XH-3V
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 02:34:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753429AbZAKBcs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2009 20:32:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752834AbZAKBcs
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 20:32:48 -0500
Received: from karen.lavabit.com ([72.249.41.33]:49406 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752353AbZAKBcr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2009 20:32:47 -0500
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 59EDAC7AE6;
	Sat, 10 Jan 2009 19:32:46 -0600 (CST)
Received: from 6722.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id 5218Y9DPH2WE; Sat, 10 Jan 2009 19:32:46 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=KAvG7emTrmD6rB/90D+TwmQwFFvsozxs5/qjBC02PWkPGrAWJZUPocIrO9v7gj1dTrig64Zz6YsYIUMTA2k6ILivrtOroykM4TE/+SQO1eHTndTByJRflVTevdgjg6HGtrBnDgIch+233yNrMG6KamViP3f/lkKrNtO40yVXYxU=;
  h=From:To:Cc:Subject:Date:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <1231553410-7541-2-git-send-email-git@fabian-franz.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105148>

Quoting Fabian Franz <git@fabian-franz.de> writes:

> git submodule update --no-fetch makes it possible to use git submodule
> update in complete offline mode by not fetching new revisions.

I may be confused, but does it make any sense to update without fetching?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
