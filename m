From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: libgit2 - a true git library
Date: Fri, 31 Oct 2008 16:28:29 -0700
Message-ID: <20081031232829.GC14786@spearce.org>
References: <20081031170704.GU14786@spearce.org> <20081031174745.GA4058@artemis.corp> <alpine.LFD.2.00.0810311558540.13034@xanadu.home> <20081031213114.GA21799@artemis.corp> <CBF2AF68-BA41-4394-A837-F62864CF8BFB@ai.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org,
	Scott Chacon <schacon@gmail.com>
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Sat Nov 01 00:29:50 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw3R1-0000S0-96
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 00:29:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbYJaX2a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 19:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbYJaX2a
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 19:28:30 -0400
Received: from george.spearce.org ([209.20.77.23]:42281 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751025AbYJaX2a (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 19:28:30 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 7A6AD3835F; Fri, 31 Oct 2008 23:28:29 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CBF2AF68-BA41-4394-A837-F62864CF8BFB@ai.rug.nl>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99678>

Pieter de Bie <pdebie@ai.rug.nl> wrote:
> On 31 okt 2008, at 22:31, Pierre Habouzit wrote:
>>
>> Many of the people needing a library for libgit are probably reading  
>> the
>> list, I'll let them comment
>
> As a more concrete comment, is there anything you would like to hear
> from GUI developers during the development of libgit2? I'm not sure I
> can contribute much in terms of code, but if you need any constructive
> comments, I can help with that.

We'd like to hear feedback on the API.  Look at the operations
your application does with git-core.

  Can you express that with the libgit2 API?
  If not, why not?
  Is it just that the docs are unclear?
  Is the API missing?
  What would you like to invoke to get the data you need?
  ...

You are the end-user of the library, so it needs to suit you.  Ok,
you aren't the only end-user, but you and other developers like
you... :-)

-- 
Shawn.
