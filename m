From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: 'dotest' script broken
Date: Sun, 26 Jun 2005 18:39:32 -0400
Message-ID: <42BF2EA4.4070207@pobox.com>
References: <42BF2167.9030404@pobox.com> <Pine.LNX.4.58.0506261450000.19755@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 27 00:35:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dmfir-0005LA-U8
	for gcvg-git@gmane.org; Mon, 27 Jun 2005 00:35:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261645AbVFZWlH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Jun 2005 18:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261643AbVFZWki
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jun 2005 18:40:38 -0400
Received: from mail.dvmed.net ([216.237.124.58]:14541 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261636AbVFZWjf (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Jun 2005 18:39:35 -0400
Received: from cpe-065-184-065-144.nc.res.rr.com ([65.184.65.144] helo=[10.10.10.88])
	by mail.dvmed.net with esmtpsa (Exim 4.51 #1 (Red Hat Linux))
	id 1Dmfmo-0006zC-Sy; Sun, 26 Jun 2005 22:39:35 +0000
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506261450000.19755@ppc970.osdl.org>
X-Spam-Score: 0.0 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> Looks like you updated "dotest", but didn't update "mailinfo"? Why? 


Duh.  I was so used to just updating git-tools without 'make install'

Sorry for the noise.

	Jeff
