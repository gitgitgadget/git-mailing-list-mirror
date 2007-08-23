From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Make "git reset" a builtin. (incomplete)
Date: Wed, 22 Aug 2007 18:30:28 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708221825470.30176@woody.linux-foundation.org>
References: <46CC3090.7080500@gmail.com> <86absjenc3.fsf@lola.quinscape.zz>
 <46CC3C17.8040901@op5.se> <864pirej6w.fsf@lola.quinscape.zz>
 <alpine.LFD.0.999.0708221154150.16727@xanadu.home> <Pine.LNX.4.64.0708221713540.20400@racer.site>
 <86mywjcwv7.fsf@lola.quinscape.zz> <alpine.LFD.0.999.0708221149440.30176@woody.linux-foundation.org>
 <86absjcqfq.fsf@lola.quinscape.zz> <alpine.LFD.0.999.0708221252040.30176@woody.linux-foundation.org>
 <85ir77ky0u.fsf@lola.goethe.zz> <alpine.LFD.0.999.0708221607590.30176@woody.linux-foundation.org>
 <85wsvnjg0v.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Aug 23 03:30:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IO1X0-0005re-Rq
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 03:30:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752260AbXHWBaj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 21:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754219AbXHWBaj
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 21:30:39 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:43376 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750960AbXHWBai (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Aug 2007 21:30:38 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7N1UXds013165
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 22 Aug 2007 18:30:35 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7N1USgL014748;
	Wed, 22 Aug 2007 18:30:28 -0700
In-Reply-To: <85wsvnjg0v.fsf@lola.goethe.zz>
X-Spam-Status: No, hits=-4.749 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.28__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56445>



On Thu, 23 Aug 2007, David Kastrup wrote:
> 
> By golly, you are right.  Pretty much all projects that are defined by
> not including a script language don't include a script language.

The point is, you made a totally bogus and unsubstantiated claim: you 
claimed that projects that are written in C would be (direct quotes from 
your *idiotic* claims): "But it would stop being as hackable." and "if you 
are aiming for a job that gets finished and then no longer touched."

Both of those claims were pure and unadulterated *CRAP*.

Which I pointed out. You just seem to have trouble admitting it.

And both of those claims seemed to be the whole gist of your argument.

If you make your arguments based on stuff that is obviously crap and 
untrue, don't be surprised when people then consider your arguments to be 
less than convincing.

		Linus
