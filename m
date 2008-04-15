From: Petr Baudis <pasky@suse.cz>
Subject: Re: RFC: Website redesign
Date: Tue, 15 Apr 2008 13:57:41 +0200
Message-ID: <20080415115741.GB26302@machine.or.cz>
References: <3175605f-ff32-4fd6-bed3-7ae596ecbcde@q1g2000prf.googlegroups.com> <2c6b72b30804140656g14c24d8cwae016d62fe12f4a7@mail.gmail.com> <56e37551-4b8f-4164-a71d-79dba8635b7d@l28g2000prd.googlegroups.com> <96F7571C-1D9D-4F0A-99F1-A2307DAB0374@wincent.com> <bd6139dc0804141129h25c829e2i320f227594763d71@mail.gmail.com> <pan.2008.04.14.20.39.10@progsoc.org> <20080414213339.GB10300@dpotapov.dyndns.org> <pan.2008.04.15.03.25.00@progsoc.org> <8607f754-92c8-49ca-9bc9-11e58b66ef40@q1g2000prf.googlegroups.com> <acfbfe5b-f3a1-4c22-a873-ed329552d1bb@b5g2000pri.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dill <sarpulhu@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 15 13:58:30 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jljnw-0003Cw-Hr
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 13:58:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754113AbYDOL5o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2008 07:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761549AbYDOL5o
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 07:57:44 -0400
Received: from w241.dkm.cz ([62.24.88.241]:58463 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751625AbYDOL5n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 07:57:43 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 826653939B47; Tue, 15 Apr 2008 13:57:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <acfbfe5b-f3a1-4c22-a873-ed329552d1bb@b5g2000pri.googlegroups.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79591>

  Hi,

On Mon, Apr 14, 2008 at 11:48:21PM -0700, Dill wrote:
> Perhaps we should just make the home page a wiki! It would work really
> good! If we use a theme like they do at wiki.ubuntu.com or somewhere
> else we could make it look really nice for a home page. Then once it's
> set up, no one has to manage the page, worry about commits, who's
> doing what, etc, and just have the pages edited and worked on by the
> community at large who register at the site to edit. (Unlike the wiki
> in use now something would have to be done to stop the spam, like
> having those boxes at registration where you have pick the letters
> out) Once set up it would simplify things. Do I dare say that Hg uses
> the wiki idea. Works but their theme really looks horrible. Of course
> git would do it better. ;) Ours would be way more pretty! Anyone else
> think a wiki would work for home page? If we could get some work done
> on the theme on moinmoin and get it upgraded and completely set up we
> could do a mockup of what it could look like and if people like it
> just get rid of the old and have the wiki page be the start page. It
> would also solve the news problem as I'm willing and I'm sure others
> would too edit to make sure it's up to date.

  let's keep two things separate here: design and content. Design-wise,
it does not matter if it is wiki or not, it is a completely different
issue. And making the wiki look good would be non-trivial amount of work
and the benefits seem unclear to me - so far, we aren't exactly drowning
in patches for the website either (though I admit that some of them
might have been lost anyway if the contributor was unlucky and not
persistent enough ;-).

-- 
				Petr "Pasky" Baudis
Whatever you can do, or dream you can, begin it.
Boldness has genius, power, and magic in it.	-- J. W. von Goethe
