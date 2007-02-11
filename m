From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Allow aliases to expand to shell commands
Date: Sun, 11 Feb 2007 17:36:51 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702111735000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070209014852.GA13207@thunk.org> <1171123504783-git-send-email-tytso@mit.edu>
 <11711235041527-git-send-email-tytso@mit.edu> <11711235042388-git-send-email-tytso@mit.edu>
 <20070210181357.GE25607@thunk.org> <Pine.LNX.4.63.0702102129110.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070211001346.GA19656@thunk.org> <Pine.LNX.4.63.0702111701160.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070211162136.GA26461@thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Sun Feb 11 17:37:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGHhC-0002Jn-Bq
	for gcvg-git@gmane.org; Sun, 11 Feb 2007 17:36:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbXBKQgz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 11:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbXBKQgz
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 11:36:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:37470 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750718AbXBKQgy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 11:36:54 -0500
Received: (qmail invoked by alias); 11 Feb 2007 16:36:53 -0000
X-Provags-ID: V01U2FsdGVkX18k8u1jCOwk+tsAjdA982QyneOhloGnmlH6oJ/6j5
	LErQ==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070211162136.GA26461@thunk.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39291>

Hi,

On Sun, 11 Feb 2007, Theodore Tso wrote:

> [I was talking about my local git-shell being allowed the git wrapper, 
>  to set config variables]
>
> Why did you add that ability, out of curiosity?

It seemed a good idea to make the description for gitweb a config 
variable, and I wanted the users to change that themselves. It no longer 
seems a good idea, so I will probably just undo my changes.

Ciao,
Dscho
