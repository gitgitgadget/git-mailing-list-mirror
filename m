From: Tom Tobin <korpios@korpios.com>
Subject: Re: [PATCH] Add color to git-add--interactive diffs
Date: Sun, 14 Oct 2007 03:38:54 -0500
Message-ID: <1192351134.7226.11.camel@athena>
References: <1192350236.7226.6.camel@athena>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 14 10:39:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Igz0F-0004eY-2d
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 10:39:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753956AbXJNIjA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 04:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754143AbXJNIjA
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 04:39:00 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:51063 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753732AbXJNIjA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 04:39:00 -0400
Received: by py-out-1112.google.com with SMTP id u77so2401982pyb
        for <git@vger.kernel.org>; Sun, 14 Oct 2007 01:38:59 -0700 (PDT)
Received: by 10.35.115.18 with SMTP id s18mr6053770pym.1192351138762;
        Sun, 14 Oct 2007 01:38:58 -0700 (PDT)
Received: from ?192.168.1.197? ( [24.124.68.243])
        by mx.google.com with ESMTPS id w29sm3189594pyg.2007.10.14.01.38.55
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 14 Oct 2007 01:38:56 -0700 (PDT)
In-Reply-To: <1192350236.7226.6.camel@athena>
X-Mailer: Evolution 2.12.0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60804>

On Sun, 2007-10-14 at 03:24 -0500, Tom Tobin wrote:
> Seeing the recent discussion and code regarding adding color to
> git-add--interactive, I thought I'd throw in my recent attempt at
> colorizing the diffs.  (This doesn't handle anything else, such as the
> prompts.)

Crap, my apologies; Evolution inserted a spurious line break in there.

I'll repost the patch.
