From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Weird shallow-tree conversion state, and branches of shallow
 trees
Date: Mon, 16 Apr 2007 08:08:32 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704160805280.5473@woody.linux-foundation.org>
References: <20070412005336.GA18378@curie-int.orbis-terrarum.net> 
 <fcaeb9bf0704142257x3761ef2cie3996420b3bcd24a@mail.gmail.com> 
 <Pine.LNX.4.64.0704151115270.5473@woody.linux-foundation.org> 
 <200704152051.35639.andyparkins@gmail.com> 
 <Pine.LNX.4.64.0704151317180.5473@woody.linux-foundation.org> 
 <20070416021729.GH2689@curie-int.orbis-terrarum.net>  <20070416030103.GB27533@thunk.org>
 <fcaeb9bf0704152023xaa119a4s8590452ff03befcf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Theodore Tso <tytso@mit.edu>,
	Git Mailing List <git@vger.kernel.org>,
	Andy Parkins <andyparkins@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Robin H. Johnson" <robbat2@gentoo.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 17:08:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdSp2-0000tm-1V
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 17:08:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752976AbXDPPIs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 11:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752987AbXDPPIs
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 11:08:48 -0400
Received: from smtp.osdl.org ([65.172.181.24]:38329 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752965AbXDPPIs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 11:08:48 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3GF8XIs024289
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 16 Apr 2007 08:08:33 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3GF8W7N005063;
	Mon, 16 Apr 2007 08:08:33 -0700
In-Reply-To: <fcaeb9bf0704152023xaa119a4s8590452ff03befcf@mail.gmail.com>
X-Spam-Status: No, hits=-0.451 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44649>



On Mon, 16 Apr 2007, Nguyen Thai Ngoc Duy wrote:
> 
> Changing Gentoo release process won't make Git the best choice while
> other SCM candidates can provide the same functionalities that Gentoo
> needs without changing the process.

Ahh, the old "argument by blackmail" approach.

You know what? Nobody really cares. Arguing by blackmail ("we'll use 
something else then") just means that you should go somewhere else. If you 
cannot respond intelligently to intelligent arguments, you really *are* 
better off using SVN. 

A billion flies aren't exactly wrong: crap really *is* good. If you're a 
fly or a maggot.

But if you ever actually want to be something *more* than a crap eater, 
come back then.

			Linus
