From: Russ Dill <Russ.Dill@gmail.com>
Subject: Re:  Re: Windows support
Date: Wed, 25 Jul 2007 19:13:17 +0000 (UTC)
Message-ID: <loom.20070725T211142-163@post.gmane.org>
References: <a1bbc6950707250335m3d37d4farceffc50945e31f6c@mail.gmail.com>  <693D0FFF-B271-4781-BCE2-3BF00C8BF426@zib.de> <316a20a40707250958w1fe9f6fdn41d75ca704aeb9cd@mail.gmail.com> A<loom.20070725T195200-46@post.gmane.org> <598D5675D34BE349929AF5EDE9B03E27012EDD12@az33exm24.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 25 21:14:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDmJH-0005Ya-24
	for gcvg-git@gmane.org; Wed, 25 Jul 2007 21:14:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760487AbXGYTNc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Jul 2007 15:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758929AbXGYTNb
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jul 2007 15:13:31 -0400
Received: from main.gmane.org ([80.91.229.2]:38547 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760610AbXGYTNa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jul 2007 15:13:30 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IDmIa-0003jg-7d
	for git@vger.kernel.org; Wed, 25 Jul 2007 21:13:28 +0200
Received: from 64-42-117-11.atgi.net ([64.42.117.11])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 25 Jul 2007 21:13:28 +0200
Received: from Russ.Dill by 64-42-117-11.atgi.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 25 Jul 2007 21:13:28 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 64.42.117.11 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.5) Gecko/20070713 Firefox/2.0.0.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53707>

Medve Emilian-EMMEDVE1 <Emilian.Medve <at> freescale.com> writes:

> 
> Hi Russ,
> 
> Try playing with the core.autocrlf config option.
> 

It seems to do the exact opposite of what I would like. My repository is
imported from SVN with git-svn and all the text files have dos line endings. I
would like to checkout with unix line endings, and checkin with dos line endings.
