From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Figured out how to get Mozilla into git
Date: Fri, 9 Jun 2006 20:01:08 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606092000110.5498@g5.osdl.org>
References: <9e4733910606081917l11354e49q25f0c4aea40618ea@mail.gmail.com> 
 <46a038f90606082006t5c6a5623q4b9cf7b036dad1e5@mail.gmail.com> 
 <46a038f90606091814n1922bf25l94d913238b260296@mail.gmail.com> 
 <Pine.LNX.4.64.0606091825080.5498@g5.osdl.org>  <Pine.LNX.4.64.0606091837040.5498@g5.osdl.org>
  <9e4733910606091848r5fb4d565taabfc5198140daf2@mail.gmail.com> 
 <Pine.LNX.4.64.0606091853180.5498@g5.osdl.org>
 <9e4733910606091921o1d07826w8292dc22b1872345@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 10 05:01:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fotiv-0002cD-9V
	for gcvg-git@gmane.org; Sat, 10 Jun 2006 05:01:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbWFJDBO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Jun 2006 23:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbWFJDBO
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jun 2006 23:01:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59798 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932314AbWFJDBN (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Jun 2006 23:01:13 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5A319gt015729
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 9 Jun 2006 20:01:10 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5A318EQ007619;
	Fri, 9 Jun 2006 20:01:09 -0700
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910606091921o1d07826w8292dc22b1872345@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21588>



On Fri, 9 Jun 2006, Jon Smirl wrote:
>
> No more cvs diff taking four minutes to finish. I have to do that
> every time I want to generate a 10 line patch. Diffs can run locally.
> No more cvs update to replace files I deleted because I messed up
> edits in them. And I can have local branches, yeah!

More importantly, when the CVS server is down (can you say 
"sourceforge"?), who cares?

> What are we going to do about the BEOS developers on Mozilla? There
> are a couple more obscure OSes.

Well, the git cvsserver exporter apparently works well enough...

			Linus
