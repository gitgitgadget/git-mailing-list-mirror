From: tab@snarc.org (Vincent Hanquez)
Subject: Re: git-viz tool for visualising commit trees
Date: Thu, 21 Apr 2005 15:15:56 +0200
Message-ID: <20050421131556.GA30472@snarc.org>
References: <20050420100824.GB25477@elte.hu> <20050421.034227.104037433.oandrieu@nerim.net> <20050421092120.GA20626@elte.hu> <20050421.133136.78712855.oandrieu@nerim.net> <20050421130242.GA5817@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Olivier Andrieu <oandrieu@nerim.net>, pasky@ucw.cz,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 15:12:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DObSz-0005ee-Hk
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 15:11:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261354AbVDUNP7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 09:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbVDUNP7
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 09:15:59 -0400
Received: from darwin.snarc.org ([81.56.210.228]:39861 "EHLO darwin.snarc.org")
	by vger.kernel.org with ESMTP id S261354AbVDUNP6 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2005 09:15:58 -0400
Received: by darwin.snarc.org (Postfix, from userid 1000)
	id A39A64BE11; Thu, 21 Apr 2005 15:15:56 +0200 (CEST)
To: Ingo Molnar <mingo@elte.hu>
Content-Disposition: inline
In-Reply-To: <20050421130242.GA5817@elte.hu>
X-Warning: Email may contain unsmilyfied humor and/or satire.
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 21, 2005 at 03:02:42PM +0200, Ingo Molnar wrote:
> when i run git-viz in a git-controlled directory, it seems to start up 
> fine, but i get an error message: "Could not execute dot". Closing that 
> window gives me the ability to do an 'Open', but git-viz does not seem 
> to recognize any of my GIT repositories as such. (perhaps there's some 
> GIT version dependency? I've got Linus' latest & greatest installed.)

Hey Ingo,

you probably don't have graphviz (dot is one of graphviz executable).
I have no idea if that is related to the later though.
-- 
Vincent Hanquez
