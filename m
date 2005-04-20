From: Ingo Molnar <mingo@elte.hu>
Subject: Re: git-viz tool for visualising commit trees
Date: Wed, 20 Apr 2005 12:08:24 +0200
Message-ID: <20050420100824.GB25477@elte.hu>
References: <20050417194818.GG1461@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, oliv__a@users.sourceforge.net
X-From: git-owner@vger.kernel.org Wed Apr 20 12:05:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOC4K-0000Ow-Ua
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 12:04:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbVDTKIo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 06:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbVDTKIo
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 06:08:44 -0400
Received: from mx2.elte.hu ([157.181.151.9]:55196 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261338AbVDTKIm (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 06:08:42 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx2.elte.hu (Postfix) with ESMTP id 186C6319D89;
	Wed, 20 Apr 2005 12:07:32 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id B87AF1FC2; Wed, 20 Apr 2005 12:08:32 +0200 (CEST)
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20050417194818.GG1461@pasky.ji.cz>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


* Petr Baudis <pasky@ucw.cz> wrote:

>   Hi,
> 
>   just FYI, Olivier Andrieu was kind enough to port his monotone-viz 
> tool to git (http://oandrieu.nerim.net/monotone-viz/ - use the one 
> from the monotone repository). The tool visualizes the history flow 
> nicely; see
> 
> 	http://rover.dkm.cz/~pasky/gitviz1.png
> 	http://rover.dkm.cz/~pasky/gitviz2.png
> 	http://rover.dkm.cz/~pasky/gitviz3.png
> 	http://rover.dkm.cz/~pasky/gitviz4.png
> 	http://rover.dkm.cz/~pasky/gitviz5.png
> 	http://rover.dkm.cz/~pasky/gitviz6.png
> 	http://rover.dkm.cz/~pasky/gitviz7.png
> 
> for some screenshots.

really nice stuff! Any plans to include it in git-pasky, via 'git gui' 
option or so? Also, which particular version has this included - the 
freshest tarball on the monotone-viz download site doesnt seem to 
include it.

	Ingo
