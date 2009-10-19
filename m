From: Norbert Preining <preining@logic.at>
Subject: Re: Creating something like increasing revision numbers
Date: Mon, 19 Oct 2009 03:42:56 +0200
Message-ID: <20091019014256.GE17397@gamma.logic.tuwien.ac.at>
References: <20091018144158.GA9789@gandalf.dynalias.org> <alpine.LNX.2.00.0910181727130.32515@iabervon.org> <20091019004447.GC11739@gamma.logic.tuwien.ac.at> <alpine.LFD.2.00.0910182122100.21739@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Oct 19 03:43:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzhH6-0007XD-B2
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 03:43:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752739AbZJSBmy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Oct 2009 21:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752347AbZJSBmy
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Oct 2009 21:42:54 -0400
Received: from mx.logic.tuwien.ac.at ([128.130.175.19]:49533 "EHLO
	mx.logic.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750846AbZJSBmx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Oct 2009 21:42:53 -0400
Received: from gamma.logic.tuwien.ac.at ([128.130.175.3] ident=Debian-exim)
	by mx.logic.tuwien.ac.at with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <preining@logic.at>)
	id 1MzhGy-0001th-DZ; Mon, 19 Oct 2009 03:42:56 +0200
Received: from preining by gamma.logic.tuwien.ac.at with local (Exim 4.69)
	(envelope-from <preining@logic.at>)
	id 1MzhGy-0004qU-9S; Mon, 19 Oct 2009 03:42:56 +0200
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0910182122100.21739@xanadu.home>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130637>

On So, 18 Okt 2009, Nicolas Pitre wrote:
> However, given what you want to do is really to stick to the SVN way of 
> doing things, then why don't you simply stay with SVN?  Git works in a 

I fear so.

> fundamentally different way than SVN, and if you aren't willing/able to 
> change your workflow away from the SVN way then there is really not much 
> for you to gain by switching to Git.

Well, as I said in the beginning, the metadata handling of svn is a pain
in huge repositories like ours with thousands of subdirectories of subdirs
of subdirs and 80k+ files. That was the reason I thought about git.

But I am coming to the conclusion that I will use git for my other projects,
but not for that one.

Best wishes

Norbert

-------------------------------------------------------------------------------
Dr. Norbert Preining                                        Associate Professor
JAIST Japan Advanced Institute of Science and Technology   preining@jaist.ac.jp
Vienna University of Technology                               preining@logic.at
Debian Developer (Debian TeX Task Force)                    preining@debian.org
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
GLASSEL (n.)
A seaside pebble which was shiny and interesting when wet, and which
is now a lump of rock, which children nevertheless insist on filing
their suitcases with after the holiday.
			--- Douglas Adams, The Meaning of Liff
