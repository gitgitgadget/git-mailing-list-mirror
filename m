From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] makefile: Add a cscope target
Date: Sat, 6 Oct 2007 10:23:58 +0200
Message-ID: <20071006082358.GA2711@steel.home>
References: <20071005223336.GA4556@luggage>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kristof Provost <Kristof@provost-engineering.be>
X-From: git-owner@vger.kernel.org Sat Oct 06 10:25:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ie4y4-0002Eo-Vd
	for gcvg-git-2@gmane.org; Sat, 06 Oct 2007 10:25:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752120AbXJFIYE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Oct 2007 04:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751915AbXJFIYD
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Oct 2007 04:24:03 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:34021 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751656AbXJFIYB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Oct 2007 04:24:01 -0400
Received: from tigra.home (Fae62.f.strato-dslnet.de [195.4.174.98])
	by post.webmailer.de (fruni mo54) (RZmta 13.4)
	with ESMTP id N02e2cj967JsDx ; Sat, 6 Oct 2007 10:23:58 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id B2656277AE;
	Sat,  6 Oct 2007 10:23:58 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 30E00C776; Sat,  6 Oct 2007 10:23:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20071005223336.GA4556@luggage>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Cculz1E3BTaA==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60141>

Kristof Provost, Sat, Oct 06, 2007 00:33:36 +0200:
> +cscope:
> +	$(RM) cscope*

You may want to add the cscope* to .gitignore
