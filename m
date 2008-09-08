From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [RFC] cherry-pick using multiple parents to implement -x
Date: Mon, 8 Sep 2008 16:58:02 +0200
Message-ID: <20080908145802.GB8528@cuci.nl>
References: <20080907103415.GA3139@cuci.nl> <7vhc8rjyxj.fsf@gitster.siamese.dyndns.org> <20080908115129.GA19031@cuci.nl> <20080908143807.GB10252@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Sep 08 17:00:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KciCv-0003g2-6i
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 16:59:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752126AbYIHO6G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 10:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752080AbYIHO6F
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 10:58:05 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:44337 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750989AbYIHO6E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 10:58:04 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 42A315465; Mon,  8 Sep 2008 16:58:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080908143807.GB10252@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95257>

Shawn O. Pearce wrote:
>"Stephen R. van den Berg" <srb@cuci.nl> wrote:
>> Whereas cherry-pick would (optionally) generate a cousin reference for every
>> commit it picks.

>Sorry for wandering into a thread in the middle.  But we've already
>been down this road before, and decided the additional header wasn't
>worth it from cherry-pick.  What's changed?

I'm not familiar with the old thread.  Any pointers?  (I tried googling,
but couldn't seem to find it).

>  The fact that gitk
>wants to hyperlink this?  Why can't it just regex out a string of
>hex digits longer than 6 and see if there is a commit that matches?

To avoid (accidental) duplication of the old thread, I'll try and read
that first.
-- 
Sincerely,
           Stephen R. van den Berg.
The Horkheimer Effect: "The odds of it being cloudy are directly proportional
to the importance of an astronomical event."
