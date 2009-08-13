From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] svn: Add && to t9107-git-svn-migrarte.sh
Date: Wed, 12 Aug 2009 22:36:17 -0700
Message-ID: <20090813053617.GA18588@dcvr.yhbt.net>
References: <20090810083234.GA8698@dcvr.yhbt.net> <1250046867-13655-1-git-send-email-adambrewster@gmail.com> <20090812094940.GA22273@dcvr.yhbt.net> <c376da900908121735w7ee3c581pd1281efc83a2075d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Adam Brewster <adambrewster@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 07:37:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MbT02-0000Ku-TZ
	for gcvg-git-2@gmane.org; Thu, 13 Aug 2009 07:37:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751994AbZHMFgR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2009 01:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbZHMFgR
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Aug 2009 01:36:17 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:45528 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751184AbZHMFgR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2009 01:36:17 -0400
Received: from localhost (user-118bg0q.cable.mindspring.com [66.133.192.26])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 4292E1F7E2;
	Thu, 13 Aug 2009 05:36:18 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <c376da900908121735w7ee3c581pd1281efc83a2075d@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125785>

Adam Brewster <adambrewster@gmail.com> wrote:
> Eric,
> 
> Thanks the help in getting this right.

No problem!  Thanks for fixing a long-standing issue with git svn.

I've pushed this last patch out along with a few others to
git://yhbt.net/git-svn for Junio

-- 
Eric Wong
