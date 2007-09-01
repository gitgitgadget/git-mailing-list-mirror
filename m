From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [ANNOUNCE] git/gitweb.git repository
Date: Fri, 31 Aug 2007 19:15:23 -0700 (PDT)
Message-ID: <400762.26134.qm@web31810.mail.mud.yahoo.com>
References: <7v4pifw45n.fsf@gitster.siamese.dyndns.org>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Luben Tuikov <ltuikov@yahoo.com>, git@vger.kernel.org,
	jnareb@gmail.com
To: Junio C Hamano <gitster@pobox.com>, Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat Sep 01 04:15:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRIWJ-0008Oa-36
	for gcvg-git@gmane.org; Sat, 01 Sep 2007 04:15:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbXIACPY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 22:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751250AbXIACPY
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 22:15:24 -0400
Received: from web31810.mail.mud.yahoo.com ([68.142.207.73]:40795 "HELO
	web31810.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751225AbXIACPY (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 Aug 2007 22:15:24 -0400
Received: (qmail 26742 invoked by uid 60001); 1 Sep 2007 02:15:23 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=wxx6yTk6yocVUI/gR0uKxHES1vN+7ZG663uBNtmAlo5VMGdqEeUnQOSb3bZi8243TOdGPiY5laBQNDxNajc94oPTmM73daAATisKb9/S9Qkds13NMvrnxK6xY3qGgcQzNe8PoXRwxoLPFUAeI33cVVJFKYi5y0h/INWtMCGjdrU=;
X-YMail-OSG: 6P9JpPUVM1kxHrFMo1aA2tXy5QFnqSFBvEnECP0f88z4B97_pKk_gX2.4HK9JW8TovDgkW6.aOEH1M5vZVrIneidB4Ugc7zqtU7sWCSC2dZ01x8-
Received: from [64.215.88.90] by web31810.mail.mud.yahoo.com via HTTP; Fri, 31 Aug 2007 19:15:23 PDT
In-Reply-To: <7v4pifw45n.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57246>

--- Junio C Hamano <gitster@pobox.com> wrote:
> Petr Baudis <pasky@suse.cz> writes:
> 
> > On Sat, Sep 01, 2007 at 03:25:16AM CEST, Johannes Schindelin wrote:
> >> On Fri, 31 Aug 2007, Luben Tuikov wrote:
> >> 
> >> > So what's the review process now?
> >> 
> >> Umm.  Pasky set it up, so it's Pasky who decides what goes in and what 
> >> not.  What exactly is your problem?
> >
> >   Junio will pull from it, so he has full right to ask. :-)
> 
> Well, I won't blindly pull from it, but honestly when it comes
> to gitweb I trust Pasky's judgement as much as I trust myself,
> if not even more.  And I think the review process Pasky
> described is good --- people will see both the patches on the
> list and code in action at repo.or.cz/.
> 
> I am a bit worried about the 'master' being a "StGIT stack",
> though.  Playgrounds to be cherry-picked from (aka 'pu') would
> make *perfect* sense to be managed that way (and the topics that
> go only 'pu' of git.git itself are managed the same except that
> I do not do so using StGIT), but I think we need a stable
> history for the branch git.git will eventually pull from.

That was my concern too, but seeing the immediate hostility
I got about asking about the review process I decided not
to mention it.

I'd be interesting to see how gitweb support pans out
given this initial hostility to inquiry of accountability.

Over the years I've seen that the best support and accountability
has been had when the maintainer is not the main contributor/developer,
especially for shared development. Otherwise personal preferences over
feature X and Y come into play and then things get ugly.  This is
why you were such a good maintainer of gitweb.

   Luben
