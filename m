From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Newbie questions regarding jgit
Date: Tue, 11 Nov 2008 13:44:34 -0800
Message-ID: <20081111214434.GS2932@spearce.org>
References: <4919EECB.7070408@wellfleetsoftware.com> <2c6b72b30811111337v2fe23c75v25251838f721a007@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Farrukh Najmi <farrukh@wellfleetsoftware.com>, git@vger.kernel.org
To: Jonas Fonseca <jonas.fonseca@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 11 22:46:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L013W-0000Jr-4p
	for gcvg-git-2@gmane.org; Tue, 11 Nov 2008 22:45:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbYKKVof (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2008 16:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750966AbYKKVof
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Nov 2008 16:44:35 -0500
Received: from george.spearce.org ([209.20.77.23]:37480 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874AbYKKVof (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2008 16:44:35 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 7A6AA381FF; Tue, 11 Nov 2008 21:44:34 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <2c6b72b30811111337v2fe23c75v25251838f721a007@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100683>

Jonas Fonseca <jonas.fonseca@gmail.com> wrote:
> 
> I would also like to have a public available maven repository for
> JGit. If Shawn or Robin acks, I can look into hosting one in the SVN
> area of the Google Code project page. Given the lack of a real release
> cycle it probably only makes sense to have a snapshot repository.

I have an account on kernel.org and was planning on hosting snapshots
there, but I haven't had time to think about setting up a jgit area
and pushing something into it.  ;-)

We could also just host it in SVN in Google Code.  I can give
you admin rights on the egit project if you want to set it up and
maintain it there.  The downside is you need to use svn or git-svn
to upload files to it, right?

-- 
Shawn.
