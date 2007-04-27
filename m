From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: FEATURE REQUEST: git-format-path: Add option to encode patch content
Date: Fri, 27 Apr 2007 21:29:17 +0200
Message-ID: <20070427192917.GA23169@steel.home>
References: <ps5qyry4.fsf@cante.net> <Pine.LNX.4.64.0704271541010.12006@racer.site> <d51pzpqo.fsf@cante.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Fri Apr 27 21:29:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhW8Q-0006z9-8J
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 21:29:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757164AbXD0T3X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 15:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757161AbXD0T3X
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 15:29:23 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:48323 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757166AbXD0T3U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 15:29:20 -0400
Received: from tigra.home ([195.4.170.117] [195.4.170.117])
	by post.webmailer.de (mrclete mo29) (RZmta 5.8)
	with ESMTP id H04addj3RFp6cv ; Fri, 27 Apr 2007 21:29:18 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 042E9277BD;
	Fri, 27 Apr 2007 21:29:17 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 7319BBF16; Fri, 27 Apr 2007 21:29:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <d51pzpqo.fsf@cante.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzxtolEo88=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45745>

Jari Aalto, Fri, Apr 27, 2007 19:33:35 +0200:
> > Having said that, I think that you can actually teach every mail app 
> > (except maybe web-based ones) to respect formatting, including white 
> > space.
> 
> I hope the development team considers this. There is another uses case
> that I can think of too:
> 
> - Sending non us-ascii patches (different langauge)

not a good use case: you can send text/plain mails with UTF-8 content
just as easily. And the patches will apply.

P.S. You ignored the suggestion to implement base64. Why?
