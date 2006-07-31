From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Fix up some fallout from "setup_git_directory()" cleanups
Date: Tue, 1 Aug 2006 01:19:17 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0608010118280.27436@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0607311311060.4168@g5.osdl.org>
 <7v7j1t5tgj.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0607311508060.4168@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 01 01:19:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7h2p-0001qk-TT
	for gcvg-git@gmane.org; Tue, 01 Aug 2006 01:19:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030396AbWGaXT1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Jul 2006 19:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030397AbWGaXT1
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 19:19:27 -0400
Received: from mail.gmx.net ([213.165.64.21]:65221 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030399AbWGaXT0 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Jul 2006 19:19:26 -0400
Received: (qmail invoked by alias); 31 Jul 2006 23:19:25 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp002) with SMTP; 01 Aug 2006 01:19:25 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607311508060.4168@g5.osdl.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24557>

Hi,

On Mon, 31 Jul 2006, Linus Torvalds wrote:

> "-Wshadow" _would_ be useful, if it had been designed right. But that 
> definitely implies _not_ warning about name clashes that are also 
> obvious type clashes.

Wouldn't this just be a _perfect_ task for 'sparse'?

Ciao,
Dscho
