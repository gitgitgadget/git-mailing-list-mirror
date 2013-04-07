From: John Keeping <john@keeping.me.uk>
Subject: Re: What's cooking in git.git (Apr 2013, #02; Fri, 5)
Date: Sun, 7 Apr 2013 11:38:43 +0100
Message-ID: <20130407103843.GU2222@serenity.lan>
References: <7vip40bolc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 07 12:38:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOmzv-0002LY-Li
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 12:38:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933306Ab3DGKiv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 06:38:51 -0400
Received: from pichi.aluminati.org ([72.9.246.58]:56906 "EHLO
	pichi.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933286Ab3DGKiu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 06:38:50 -0400
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 76620161E34D;
	Sun,  7 Apr 2013 11:38:49 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sjWwOjUxF5sQ; Sun,  7 Apr 2013 11:38:48 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id EFB64161E3F4;
	Sun,  7 Apr 2013 11:38:45 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <7vip40bolc.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220306>

On Fri, Apr 05, 2013 at 03:27:11PM -0700, Junio C Hamano wrote:
> * jk/merge-tree-added-identically (2013-03-27) 1 commit
>  - merge-tree: fix "same file added in subdir"
> 
>  We would most likely want to change things the other way around.
> 
>  Expecting a reroll.

I was hoping to get some feedback on my most recent message [1] before
sending a reroll of this.

[1] http://article.gmane.org/gmane.comp.version-control.git/219378
