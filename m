From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: Considering teaching plumbing to users harmful
Date: Wed, 16 Jul 2008 22:23:21 +0200
Message-ID: <20080716202321.GA30485@cuci.nl>
References: <alpine.DEB.1.00.0807161804400.8950@racer> <32541b130807161053w24a21d7bh1fa800a714ce75db@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 22:24:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJDXy-00059J-8t
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 22:24:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752559AbYGPUXX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 16:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752734AbYGPUXX
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 16:23:23 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:60592 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752219AbYGPUXW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 16:23:22 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 61B6F5466; Wed, 16 Jul 2008 22:23:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <32541b130807161053w24a21d7bh1fa800a714ce75db@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88742>

Avery Pennarun wrote:
>Also, inevitably, someone will ask "what happened to those simple svn
>revision numbers?" or "when I do a merge, why are the patches from
>branch #1 interspersed with the ones from branch #2 in git log?"  The
>answers are "look at gitk to see the real merge history, that's way
>more powerful than svn, and check out git-bisect!" and "use git log
>--topo-order" respectively, but those are pretty nontrivial answers
>too.

Try --first-parent, it simplifies the history.
-- 
Sincerely,
           Stephen R. van den Berg.

The eleventh commandment: Thou shalt not re-curse!
