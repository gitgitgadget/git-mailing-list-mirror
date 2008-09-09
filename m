From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC] cherry-pick using multiple parents to implement -x
Date: Tue, 9 Sep 2008 10:51:22 +0200
Message-ID: <20080909085122.GC12631@cuci.nl>
References: <20080907103415.GA3139@cuci.nl> <7vhc8rjyxj.fsf@gitster.siamese.dyndns.org> <20080908115129.GA19031@cuci.nl> <20080908143807.GB10252@spearce.org> <20080908145802.GB8528@cuci.nl> <20080908150017.GD10252@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Sep 09 10:52:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kcyxb-0003Ec-6G
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 10:52:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753871AbYIIIvY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 04:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753744AbYIIIvY
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 04:51:24 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:37238 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752907AbYIIIvX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 04:51:23 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 970C15465; Tue,  9 Sep 2008 10:51:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080908150017.GD10252@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95360>

Shawn O. Pearce wrote:
>"Stephen R. van den Berg" <srb@cuci.nl> wrote:
>> Shawn O. Pearce wrote:
>> >"Stephen R. van den Berg" <srb@cuci.nl> wrote:
>> >> Whereas cherry-pick would (optionally) generate a cousin reference for every
>> >> commit it picks.

>> >Sorry for wandering into a thread in the middle.  But we've already
>> >been down this road before, and decided the additional header wasn't
>> >worth it from cherry-pick.  What's changed?

>> I'm not familiar with the old thread.  Any pointers?  (I tried googling,
>> but couldn't seem to find it).

>Here's at least one instance of it:

>http://www.gelato.unsw.edu.au/archives/git/0604/19514.html

Found it, thanks.  Digested it, and yes, some things changed.
I'll make a formal proposal which should take care of all the old
objections.
-- 
Sincerely,
           Stephen R. van den Berg.

"Be spontaneous!"
