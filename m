From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH v3] Support ent:relative_path
Date: Sat, 5 May 2007 10:03:39 +0200
Message-ID: <20070505080339.GA2585@steel.home>
References: <463BD40C.6080909@gmail.com> <Pine.LNX.4.64.0705050324580.4015@racer.site> <7vwszolz26.fsf@assigned-by-dhcp.cox.net> <56b7f5510705042346s759a2ef9tfa3a223fe7af7c16@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Dana How <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 05 10:04:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkFFI-0007k4-8H
	for gcvg-git@gmane.org; Sat, 05 May 2007 10:04:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754678AbXEEIDo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 May 2007 04:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754666AbXEEIDo
	(ORCPT <rfc822;git-outgoing>); Sat, 5 May 2007 04:03:44 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:19261 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754541AbXEEIDm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 May 2007 04:03:42 -0400
Received: from tigra.home (195.4.202.37)
	by post.webmailer.de (fruni mo20) (RZmta 5.9)
	with ESMTP id 8048f6j453qJ8b ; Sat, 5 May 2007 10:03:39 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id C12B3277BD;
	Sat,  5 May 2007 10:03:39 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 39F9CD171; Sat,  5 May 2007 10:03:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <56b7f5510705042346s759a2ef9tfa3a223fe7af7c16@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaGCTl9Ag==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46249>

Dana How, Sat, May 05, 2007 08:46:46 +0200:
> Thanks for your reply.  I can wait for 1.5.2.

Actually, you (and everyone who likes your patch and the proposed
semantics) can wait indefinitely. Just keep the patch in a side branch
and rebase it or merge with Junio's master occasionally.
I believe many of us have some features they keep in their repos which
they never send upstream (for their own reasons. I customized some
warnings and added printing of ip addresses to git-fetch. Not
interesting for everyone, but is useful next time kernel.org has DNS
problems). Just become the maintainer of the feature.
