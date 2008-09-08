From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC] cherry-pick using multiple parents to implement -x
Date: Mon, 8 Sep 2008 08:00:17 -0700
Message-ID: <20080908150017.GD10252@spearce.org>
References: <20080907103415.GA3139@cuci.nl> <7vhc8rjyxj.fsf@gitster.siamese.dyndns.org> <20080908115129.GA19031@cuci.nl> <20080908143807.GB10252@spearce.org> <20080908145802.GB8528@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Mon Sep 08 17:03:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KciF3-0004VU-E7
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 17:01:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752050AbYIHPAT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 11:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752080AbYIHPAS
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 11:00:18 -0400
Received: from george.spearce.org ([209.20.77.23]:52546 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751032AbYIHPAR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 11:00:17 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 24F743835C; Mon,  8 Sep 2008 15:00:17 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080908145802.GB8528@cuci.nl>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95258>

"Stephen R. van den Berg" <srb@cuci.nl> wrote:
> Shawn O. Pearce wrote:
> >"Stephen R. van den Berg" <srb@cuci.nl> wrote:
> >> Whereas cherry-pick would (optionally) generate a cousin reference for every
> >> commit it picks.
> 
> >Sorry for wandering into a thread in the middle.  But we've already
> >been down this road before, and decided the additional header wasn't
> >worth it from cherry-pick.  What's changed?
> 
> I'm not familiar with the old thread.  Any pointers?  (I tried googling,
> but couldn't seem to find it).

Here's at least one instance of it:

http://www.gelato.unsw.edu.au/archives/git/0604/19514.html
 
There may be more instances in the archives.

-- 
Shawn.
