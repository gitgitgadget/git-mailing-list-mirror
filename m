From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [ANNOUCNE] repo - The Multiple Git Repository Tool
Date: Wed, 22 Oct 2008 14:13:20 -0700
Message-ID: <20081022211320.GW14786@spearce.org>
References: <20081022154245.GT14786@spearce.org> <7vzlkwtpbq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 22 23:14:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ksl2J-0000KA-9N
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 23:14:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752088AbYJVVNW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Oct 2008 17:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752155AbYJVVNW
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 17:13:22 -0400
Received: from george.spearce.org ([209.20.77.23]:50374 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751631AbYJVVNV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 17:13:21 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 10DF13835F; Wed, 22 Oct 2008 21:13:21 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vzlkwtpbq.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98912>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > Google developed two tools, repo and Gerrit, and open sourced them
> > under the Apache License:
> >
> >   http://android.git.kernel.org/?p=tools/repo.git
> >   http://android.git.kernel.org/?p=tools/gerrit.git
> >
> >   git://android.git.kernel.org/tools/repo.git
> >   git://android.git.kernel.org/tools/gerrit.git
> 
> Heh, very nice, with a very shallow history ;-)

Yea, well, some of our history messages are downright messy and/or
contain information we don't want to disclose to the public.  Its
apparently "normal" for Google to just drop history when it opens
a code base.  :-\

The repo and Gerrit histories are short enough that I might
be able to go through them and clean them up some (remove any
comments revealing Google secrets) and publish the history under a
different repository.  Folks can always graft it behind the (now)
real repository.

I can't promise anything, but I'll talk to my co-contributors and
consider doing this in the near future.

-- 
Shawn.
