From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: bogus "fatal: Not a git repository"
Date: Thu, 25 May 2006 23:38:33 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0605252336590.31700@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0605250804390.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 25 23:38:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjNXk-0008Ai-IT
	for gcvg-git@gmane.org; Thu, 25 May 2006 23:38:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030438AbWEYVil (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 17:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030439AbWEYVik
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 17:38:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:2689 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030438AbWEYVij (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 May 2006 17:38:39 -0400
Received: (qmail invoked by alias); 25 May 2006 21:38:37 -0000
Received: from lxweb002.wuerzburg.citynet.de (EHLO localhost) [81.209.129.202]
  by mail.gmx.net (mp036) with SMTP; 25 May 2006 23:38:37 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605250804390.5623@g5.osdl.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20767>

Hi,

On Thu, 25 May 2006, Linus Torvalds wrote:

> The reason is commit 73136b2e8a8ee024320c5ac6a0f14f912432bf03 by Dscho: it 
> adds calls to git-repo-config in git-parse-remote.sh to get the remote 
> shorthands etc.

Yes, I did not think of that special case. Sorry. If you need it, here is 
Acked-By: Johannes Schindelin <Johannes.Schindelin@gmx.de>

Ciao,
Dscho
