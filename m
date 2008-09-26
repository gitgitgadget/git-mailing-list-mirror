From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Remove empty directories in recursive merge
Date: Fri, 26 Sep 2008 08:06:36 -0700
Message-ID: <20080926150636.GA17584@spearce.org>
References: <87k5d1v71l.fsf@cup.kalibalik.dk> <20080925201245.GB3959@blimp.localhost> <20080925203329.GC3959@blimp.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 26 17:08:30 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjEv4-00023Q-Qe
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 17:07:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752872AbYIZPGh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2008 11:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752848AbYIZPGh
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 11:06:37 -0400
Received: from george.spearce.org ([209.20.77.23]:48262 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752811AbYIZPGh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2008 11:06:37 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 9BDEB3835F; Fri, 26 Sep 2008 15:06:36 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080925203329.GC3959@blimp.localhost>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96865>

Alex Riesen <raa.lkml@gmail.com> wrote:
> Alex Riesen, Thu, Sep 25, 2008 22:12:45 +0200:
> > The code was actually supposed to do that, but was accidentally broken.
> > Noticed by Anders Melchiorsen.
> > 
> > Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> 
> Shawn, the change is intentionally based on Junios master,

Actually I think this is 'maint' worthy.  It applies clean there.
I'm trying to slate it for maint.

> so people can just apply it. But if you wish, I can rebase it on top
> of Miklos' patches.

Its small.  I can manage to merge it over myself.  Thanks.

-- 
Shawn.
