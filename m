From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Update documentation for git-format-patch
Date: Wed, 31 May 2006 17:24:45 +0200
Organization: At home
Message-ID: <e5kcfi$124$1@sea.gmane.org>
References: <93c3eada0605310332p19241861g466e1516a2aaf0df@mail.gmail.com> <93c3eada0605310411r712dab8au9b1c7d8ecb595a66@mail.gmail.com> <20060531112803.GB3877@spinlock.ch> <20060531141408.G366d89c7@leonov.stosberg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Wed May 31 17:27:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlSaV-0007KC-U8
	for gcvg-git@gmane.org; Wed, 31 May 2006 17:26:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964999AbWEaP0V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 May 2006 11:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965068AbWEaP0V
	(ORCPT <rfc822;git-outgoing>); Wed, 31 May 2006 11:26:21 -0400
Received: from main.gmane.org ([80.91.229.2]:34765 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S964999AbWEaP0U (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 May 2006 11:26:20 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FlSZY-0007Ba-TO
	for git@vger.kernel.org; Wed, 31 May 2006 17:25:25 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 31 May 2006 17:25:24 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 31 May 2006 17:25:24 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21069>

Dennis Stosberg wrote:

> --c|--check::
> -        Display suspicious lines in the patch.  The definition
> -        of 'suspicious lines' is currently the lines that has
> -        trailing whitespaces, and the lines whose indentation
> -        has a SP character immediately followed by a TAB
> -        character.

So is this option also lost in built-in git-format-patch?

> -CONFIGURATION
> --------------
> -You can specify extra mail header lines to be added to each
> -message in the repository configuration as follows:
> -
> -[format]
> -        headers = "Organization: git-foo\n"

So is this configuration option also lost in built-in git-format-patch?


-- 
Jakub Narebski
Warsaw, Poland
