From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: How to remove a specific hunk
Date: Fri, 26 Oct 2007 21:20:34 +0200
Message-ID: <20071026192034.GA3062@steel.home>
References: <4722036E.5030204@wanadoo.fr>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pascal Obry <pascal.obry@wanadoo.fr>
X-From: git-owner@vger.kernel.org Fri Oct 26 21:20:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlUjk-0006oy-9p
	for gcvg-git-2@gmane.org; Fri, 26 Oct 2007 21:20:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbXJZTUj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2007 15:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbXJZTUj
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Oct 2007 15:20:39 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:61692 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750996AbXJZTUi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2007 15:20:38 -0400
Received: from tigra.home (Fa859.f.strato-dslnet.de [195.4.168.89])
	by post.webmailer.de (klopstock mo23) (RZmta 14.0)
	with ESMTP id I03933j9QH4xLG ; Fri, 26 Oct 2007 21:20:35 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id E20BD277AE;
	Fri, 26 Oct 2007 21:20:34 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 5867F56D22; Fri, 26 Oct 2007 21:20:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4722036E.5030204@wanadoo.fr>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Ccul2ggT2NGA==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62436>

Pascal Obry, Fri, Oct 26, 2007 17:10:38 +0200:
> 
> I'm very new to Git... but start to love it :)
> 
> Before committing sometimes I want to remove a specific hunk. Say in
> file a.txt I have in the diff 3 hunks, I want to revert/delete/remove
> the second one. Is there a way to do that ?

Take a look at git-gui. Try right-clicking in the diff pane at the
bottom.
