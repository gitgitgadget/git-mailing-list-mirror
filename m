From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Isn't "dangling" a misnomer?
Date: Mon, 26 Feb 2007 18:02:05 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702261801010.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <3c6c07c20702260835v4865ace1u18a20f6b1d0030b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Mike Coleman <tutufan@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 26 18:03:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLjFZ-0001W6-J8
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 18:02:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030340AbXBZRCU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 12:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030338AbXBZRCU
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 12:02:20 -0500
Received: from mail.gmx.net ([213.165.64.20]:36969 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030340AbXBZRCT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 12:02:19 -0500
Received: (qmail invoked by alias); 26 Feb 2007 17:02:05 -0000
X-Provags-ID: V01U2FsdGVkX18IhUl2kNEIYXAd6YHpVmo/cf8qot/0mIMEl5voWZ
	8GwA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <3c6c07c20702260835v4865ace1u18a20f6b1d0030b5@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40630>

Hi,

On Mon, 26 Feb 2007, Mike Coleman wrote:

> I've been reading and rereading the git documentation and tripping 
> slightly over the word "dangling", as in "dangling object".  In 
> traditional use, one might talk of a dangling pointer A, where A points 
> to B and B is destroyed/invalidated/etc.  As a literal example, A might 
> be a machine address like 0x8808FEFE, which points to an area of memory 
> that once had a particular meaning, but now does not, leaving the 
> pointer "dangling".

Think of the history as a large tree with branches. If a branch is 
dangling, it is about to be pruned.

Ciao,
Dscho
