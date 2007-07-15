From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Add --show-size to git log to print message size
Date: Sun, 15 Jul 2007 12:48:58 +0200
Message-ID: <20070715104858.GG2568@steel.home>
References: <e5bfff550707140952hb60735bi95a4f03636c4aa99@mail.gmail.com> <7vodiehko7.fsf@assigned-by-dhcp.cox.net> <e5bfff550707141346q2eba4ab8ka1c85e8b5a2c1b1d@mail.gmail.com> <20070715093529.GD2568@steel.home> <e5bfff550707150306t3196f723ia3071ac301fb3f24@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 15 12:49:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IA1f4-00042T-Hq
	for gcvg-git@gmane.org; Sun, 15 Jul 2007 12:49:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755781AbXGOKtI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Jul 2007 06:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755611AbXGOKtH
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jul 2007 06:49:07 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:64814 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753287AbXGOKtG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2007 06:49:06 -0400
Received: from tigra.home (Fca5f.f.strato-dslnet.de [195.4.202.95])
	by post.webmailer.de (klopstock mo50) (RZmta 8.3)
	with ESMTP id z01c11j6F8fNIe ; Sun, 15 Jul 2007 12:49:03 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id D9AC5277BD;
	Sun, 15 Jul 2007 12:48:58 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id B3F9AC164; Sun, 15 Jul 2007 12:48:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <e5bfff550707150306t3196f723ia3071ac301fb3f24@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaGCTNzsQ==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52541>

Marco Costalba, Sun, Jul 15, 2007 12:06:53 +0200:
> 
> Hope this clears any doubts regarding (supposed) slowness of Qt classes.

No, it does not. Look at the implementation of memchr.
