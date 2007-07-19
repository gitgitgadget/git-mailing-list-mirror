From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Document how to tell git to not launch a pager
Date: Thu, 19 Jul 2007 11:29:08 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707191128040.27353@woody.linux-foundation.org>
References: <20070719104351.GA17182@midwinter.com>
 <20070719110224.GA4293@piper.oerlikon.madduck.net> <Pine.LNX.4.64.0707191211010.14781@racer.site>
 <Pine.LNX.4.64.0707191235490.32611@reaper.quantumfyre.co.uk>
 <86ir8gbo0a.fsf@lola.quinscape.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Jul 19 20:29:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBake-0003SD-Q9
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 20:29:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759324AbXGSS3W (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 14:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759893AbXGSS3V
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 14:29:21 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:47162 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758394AbXGSS3V (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jul 2007 14:29:21 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6JITEcs007989
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 19 Jul 2007 11:29:15 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6JIT8Lm015784;
	Thu, 19 Jul 2007 11:29:09 -0700
In-Reply-To: <86ir8gbo0a.fsf@lola.quinscape.zz>
X-Spam-Status: No, hits=-4.677 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53015>



On Thu, 19 Jul 2007, David Kastrup wrote:
> 
> Is that the reason why users of screen get punished by default?

No, the reason users of screen get punished is that we just think they are 
fun to torment.

Just use GIT_PAGER=cat, and be happy. In fact, I'd suggest not using 
screen at all (what a piece of horrid crap), but some people have trouble 
letting go.

		Linus
