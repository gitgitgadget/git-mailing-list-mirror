From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-fmt-merge-message problem..
Date: Wed, 12 Jul 2006 22:46:48 -0700
Message-ID: <7vr70qukdz.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0607122133250.5623@g5.osdl.org>
	<7vlkqyw0om.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0607122222310.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Jul 13 07:46:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0u2I-0002Hm-UU
	for gcvg-git@gmane.org; Thu, 13 Jul 2006 07:46:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbWGMFqv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Jul 2006 01:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbWGMFqv
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Jul 2006 01:46:51 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:52663 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751417AbWGMFqv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jul 2006 01:46:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060713054650.XQBY554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 13 Jul 2006 01:46:50 -0400
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0607122222310.5623@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 12 Jul 2006 22:29:14 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23817>

Linus Torvalds <torvalds@osdl.org> writes:

> On Wed, 12 Jul 2006, Junio C Hamano wrote:
>> 
>> Yes, this is a simple mistranslation from Perl to C.  A patch
>> will follow shortly.
>
> On a similar vein, how about this?
>
> I always end up editing the revert sentence by hand to make grammatical 
> sense.
>
> I think we always talk about "commit xyz".
>
> We never talk about "xyz commit", except when we end up talking about a 
> commit as a branch head (notably, I would say "the HEAD commit", or 
> possibly "the top-of-master commit", but here $commit is a SHA1 name, not 
> anything else).
>
> Hmm?

Makes sense.  Sign-off ;-)?

I wonder if we would want to abbreviate this, though.
