X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: VCS comparison table
Date: Fri, 27 Oct 2006 10:46:56 -0400
Message-ID: <20061027144656.GA32451@fieldses.org>
References: <200610270202.k9R22Wxf004208@laptop13.inf.utfsm.cl> <4541D291.5020205@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 27 Oct 2006 14:48:36 +0000 (UTC)
Cc: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	bazaar-ng@lists.canonical.com
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <4541D291.5020205@op5.se>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30330>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GdSzD-0003HM-MF for gcvg-git@gmane.org; Fri, 27 Oct
 2006 16:47:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752209AbWJ0OrD (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 27 Oct 2006
 10:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752232AbWJ0OrD
 (ORCPT <rfc822;git-outgoing>); Fri, 27 Oct 2006 10:47:03 -0400
Received: from mail.fieldses.org ([66.93.2.214]:52446 "EHLO
 pickle.fieldses.org") by vger.kernel.org with ESMTP id S1752209AbWJ0OrB
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 27 Oct 2006 10:47:01 -0400
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
 (envelope-from <bfields@fieldses.org>) id 1GdSz2-0000Xh-5Q; Fri, 27 Oct 2006
 10:46:56 -0400
To: Andreas Ericsson <ae@op5.se>
Sender: git-owner@vger.kernel.org

On Fri, Oct 27, 2006 at 11:34:09AM +0200, Andreas Ericsson wrote:
> Horst H. von Brand wrote:
> >Jakub Narebski <jnareb@gmail.com> wrote:
> >>19. Ease of Use. Hmmm... I don't know for Git. I personally find it very
> >>easy to use, but I have not much experiences with other SCM. I wonder why
> >>Bazaar has "No" there...
> >
> >Extremely subjective. Easy to learn doesn't cut it either.
> 
> This one just needs to go.

It's certainly a hard question to answer, and will never be answered
completely, but unfortunately it's also a really *important* question.
The best SCM in the world isn't much use if I can't convince my
coworkers to learn the thing.

So I think it's helpful to attempt to find out whether we have a problem
here or not, even if the problem is more one of perception than reality.
Though obviously it would be more helpful to have something more
detailed than just a yes or no answer to "is git easy to use?"

> Could possibly be replaced with "Has tutorial/documentation online" or
> some such. No SCM is really intuitive to users that haven't
> experienced any of them before, so the only thing that really matters
> is how much documentation one can find online and how up-to-date it
> is.

Documentation helps, though sometimes extensive documentation is a sign
of a problem--it takes a lot more documentation to explain how to manage
a branch in CVS than it does in any sensible system....

