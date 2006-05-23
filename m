From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: Re: Make more commands builtin
Date: Tue, 23 May 2006 14:54:00 +0200
Message-ID: <20060523125400.GA11128@bohr.gbar.dtu.dk>
References: <20060523122056.GA5777@bohr.gbar.dtu.dk> <e4uvku$o28$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue May 23 14:54:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiWP4-0001lO-QA
	for gcvg-git@gmane.org; Tue, 23 May 2006 14:54:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbWEWMyE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 08:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbWEWMyE
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 08:54:04 -0400
Received: from bohr.gbar.dtu.dk ([192.38.95.24]:63951 "HELO bohr.gbar.dtu.dk")
	by vger.kernel.org with SMTP id S1751340AbWEWMyC (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 May 2006 08:54:02 -0400
Received: (qmail 11310 invoked by uid 5842); 23 May 2006 14:54:01 +0200
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <e4uvku$o28$1@sea.gmane.org>
User-Agent: Mutt/1.5.7i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20603>

On Tue, May 23, 2006 at 02:36:54PM +0200, Jakub Narebski wrote:
> Peter Eriksen wrote:
> 
> > Btw.
> > 
> > I used these commands to produce the patch series:
> > 
> > git diff --stat -C 24b65a30015aedd..pe/builtin
> > git-send-email --no-chain-reply-to --compose \
> >                --from=s022018@student.dtu.dk --not-signed-off-by-cc \
> >                --quiet \
> >                --subject="Make more commands builtin" \
> >                --to=git@vger.kernel.org Patches/*
> 
> I wonder why the patches themselves are not replies to the main/summary
> email, i.e. "Make more commands builtin" email...

It seems thay are:

Subject: Make more commands builtin
Message-Id: <11483865361243-git-send-email-1>

Subject: [PATCH 1/8] Builtin git-ls-files.
Message-Id: <11483865362613-git-send-email-1>
In-Reply-To: <11483865361243-git-send-email-1>

Subject: [PATCH 2/8] Builtin git-ls-tree.
Message-Id: <11483865362923-git-send-email-1>
In-Reply-To: <11483865361243-git-send-email-1>

Peter
