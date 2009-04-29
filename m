From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Eric Sink's blog - notes on git, dscms and a "whole product"
 approach
Date: Wed, 29 Apr 2009 07:54:50 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngvg1u9.65c.sitaramc@sitaramc.homelinux.net>
References: <46a038f90904270155i6c802fceoffc73eb5ab57130e@mail.gmail.com>
 <m3ocugod96.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 29 09:59:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lz4dX-00078O-Ft
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 09:55:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750804AbZD2HzJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 03:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750892AbZD2HzI
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 03:55:08 -0400
Received: from main.gmane.org ([80.91.229.2]:35413 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750804AbZD2HzG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 03:55:06 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Lz4dC-0007cl-Is
	for git@vger.kernel.org; Wed, 29 Apr 2009 07:55:02 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 29 Apr 2009 07:55:02 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 29 Apr 2009 07:55:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117863>

On 2009-04-28, Jakub Narebski <jnareb@gmail.com> wrote:

> ES> * The one where I lament that I want to like Darcs but I can't
>
> where Eric talks about difference between parentage in merge commit
> (which is needed for good merging) and "parentage"/weak link in
> cherry-picked commit; Git uses weak link = no link.

Well the patch-id is a sort of "compute on demand" link, so
it would qualify as a weak link, especially because git
manages to use it during a rebase.

I wanted to point that out but I didn't see a link to post
comments so I didn't bother.
