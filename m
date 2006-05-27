From: Timo Hirvonen <tihirvon@gmail.com>
Subject: Re: ~/.git/config ?
Date: Sat, 27 May 2006 12:09:34 +0300
Message-ID: <20060527120934.e6306067.tihirvon@gmail.com>
References: <20060526152837.GQ23852@progsoc.uts.edu.au>
	<20060526193325.d2a530a4.tihirvon@gmail.com>
	<20060526163829.GB10488@pasky.or.cz>
	<1148697382.5599.1.camel@dv>
	<dbfc82860605270150s5c43e32fja2e7ef934bc1ef0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: proski@gnu.org, pasky@suse.cz, wildfire@progsoc.uts.edu.au,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 27 11:07:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fjulr-0006jf-Ki
	for gcvg-git@gmane.org; Sat, 27 May 2006 11:07:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbWE0JHi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 May 2006 05:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbWE0JHi
	(ORCPT <rfc822;git-outgoing>); Sat, 27 May 2006 05:07:38 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:31407 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751448AbWE0JHi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 May 2006 05:07:38 -0400
Received: by nf-out-0910.google.com with SMTP id l36so10730nfa
        for <git@vger.kernel.org>; Sat, 27 May 2006 02:07:36 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=OOOl00V+CK8XPzA1IEu00hX5E7b8XHzz/fz3KXVe3RB3/w80wzEH65oM5iImmWaIytfg9HAllNKKO2nqQIt8Zr0/aAYE/8maWOntbFbKlX9xzonrjYEpQAnaIeEhZ2LZUx+hmiX0OvQ8EL/VTL+TSXynThCRkPuJhdJNXI9DF74=
Received: by 10.49.66.12 with SMTP id t12mr178554nfk;
        Sat, 27 May 2006 02:07:36 -0700 (PDT)
Received: from garlic.home.net ( [82.128.200.31])
        by mx.gmail.com with ESMTP id y24sm1371636nfb.2006.05.27.02.07.34;
        Sat, 27 May 2006 02:07:35 -0700 (PDT)
To: "Nikolai Weibull" <now@bitwi.se>
In-Reply-To: <dbfc82860605270150s5c43e32fja2e7ef934bc1ef0@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.17; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20838>

"Nikolai Weibull" <now@bitwi.se> wrote:

> On 5/27/06, Pavel Roskin <proski@gnu.org> wrote:
> > On Fri, 2006-05-26 at 18:38 +0200, Petr Baudis wrote:
> > >
> > > Then it should be called ~/.gitconfig. :-)
> >
> > No, make it .gitrc for compatibility with .cvsrc, .lynxrc and others.
> >
> > I know, it's becoming a bikeshed issue :-)
> 
> I want to paint part of it as well!
> 
> Wouldn't we be futureproofing ourselves by stuffing it in a
> subdirectory instead?  What if we want to add more files later?

Makes sense, we may want to put templates to ~/.gitsomething/templates/.

-- 
http://onion.dynserv.net/~timo/
