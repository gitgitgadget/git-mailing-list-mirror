From: Petr Baudis <pasky@suse.cz>
Subject: Re: Libification project (SoC)
Date: Fri, 16 Mar 2007 13:55:29 +0100
Message-ID: <20070316125529.GD4489@pasky.or.cz>
References: <20070316042406.7e750ed0@home.brethil> <20070316045928.GB31606@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Mar 16 13:55:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSBy3-00066M-0B
	for gcvg-git@gmane.org; Fri, 16 Mar 2007 13:55:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933618AbXCPMzb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 08:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933629AbXCPMzb
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 08:55:31 -0400
Received: from w241.dkm.cz ([62.24.88.241]:33487 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933618AbXCPMza (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 08:55:30 -0400
Received: (qmail 23498 invoked by uid 2001); 16 Mar 2007 13:55:29 +0100
Content-Disposition: inline
In-Reply-To: <20070316045928.GB31606@spearce.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42358>

On Fri, Mar 16, 2007 at 05:59:28AM CET, Shawn O. Pearce wrote:
> "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br> wrote:
> >  3. I don't code in Perl, is it a problem? I mean, the project's
> > goal is to have a Perl binding but I think it goes far from
> > that: we could have a python module, a C program, or anything
> > that shows the libgit is useful.
> 
> No, I don't see that as a problem at all.  We have some Perl
> experts on the mailing list who would like to see Perl bindings.
> Some of the Perl binding is pure C code, and some if it is this
> weird Perl macro language...  so I expect those Perl experts to come
> out of the woodwork and help the community to create a prototype
> set of bindings.  There's also Ruby and Python interests around,
> so we may see bindings for those too.  ;-)

I'll add perl binding as soon as libgit part is there; the
infrastructure is already in place (not now but it's in git history, you
just have to dig it out), so it should be pretty easy too; so even if I
wouldn't, someone surely will. ;-) I don't think knowing Perl or
moreover the Perl XS horrors should be a prerequisite for this project.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
