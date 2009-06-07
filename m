From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: post-rebase hook (correction from Re: post-update hook)
Date: Mon, 08 Jun 2009 05:41:48 +0900
Message-ID: <20090608054148.6117@nanako3.lavabit.com>
References: <4A2BC306.3000001@box.net> <4A2BC367.7020309@box.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Soham Mehta <soham@box.net>
X-From: git-owner@vger.kernel.org Sun Jun 07 22:42:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDPCU-00015x-PK
	for gcvg-git-2@gmane.org; Sun, 07 Jun 2009 22:42:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754715AbZFGUmc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2009 16:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754439AbZFGUmb
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jun 2009 16:42:31 -0400
Received: from karen.lavabit.com ([72.249.41.33]:47077 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754205AbZFGUmb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2009 16:42:31 -0400
Received: from d.earth.lavabit.com (d.earth.lavabit.com [192.168.111.13])
	by karen.lavabit.com (Postfix) with ESMTP id 1DA5E11B7C7;
	Sun,  7 Jun 2009 15:42:33 -0500 (CDT)
Received: from 4622.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id 2HDE0O6R0QJM; Sun, 07 Jun 2009 15:42:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=1SlI6V6TDkE/UUtgB2uRmBQfcYPLDm8r47qXfcYmMSSZnL5HKWtaJ4y4g4wzB/CMmOtgN9Xrv7ezmTwDpIQPkhiC/fG7E8EIqUUrBOf0YmE16HGsNv6BMbqiTkjz7jNgn6SZRgDxqWlRMGfFDnD9mE//SP1ExnzrWUVHl2sybsA=;
  h=From:To:Cc:Subject:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <4A2BC367.7020309@box.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121000>

Quoting Soham Mehta <soham@box.net>:

> thus spake Soham Mehta , On 6/7/2009 6:39 AM:
>> Wondering why there isn't a post-update (post-reset, post-cherrypick
>> etc) hook in git? Is it only a matter of creating one, or is there a
>> reason?
>>
> Oops, I meant post-rebase hook

There are five valid reasons you might want a hook to a git operation.

http://thread.gmane.org/gmane.comp.version-control.git/70781/focus=71069

I don't think yours is backed by any of them.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
