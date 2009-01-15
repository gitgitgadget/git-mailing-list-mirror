From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [ANNOUNCE] tig-0.13
Date: Thu, 15 Jan 2009 16:08:41 +0100
Message-ID: <20090115150841.GA23045@diku.dk>
References: <20090113233643.GA28898@diku.dk> <20090114232456.GA6937@b2j> <20090114235607.GA5546@diku.dk> <20090115014617.GC6937@b2j> <20090115130659.GA18081@diku.dk> <20090115145003.GA6938@b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 15 16:10:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNTrE-0004Dp-GV
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 16:10:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753480AbZAOPIp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 10:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753356AbZAOPIo
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 10:08:44 -0500
Received: from mgw2.diku.dk ([130.225.96.92]:40925 "EHLO mgw2.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753303AbZAOPIo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 10:08:44 -0500
Received: from localhost (localhost [127.0.0.1])
	by mgw2.diku.dk (Postfix) with ESMTP id BA9B719BC13
	for <git@vger.kernel.org>; Thu, 15 Jan 2009 16:08:42 +0100 (CET)
Received: from mgw2.diku.dk ([127.0.0.1])
 by localhost (mgw2.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 12958-15 for <git@vger.kernel.org>; Thu, 15 Jan 2009 16:08:41 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw2.diku.dk (Postfix) with ESMTP id BACF019BC10
	for <git@vger.kernel.org>; Thu, 15 Jan 2009 16:08:41 +0100 (CET)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP id 0BD686DF823
	for <git@vger.kernel.org>; Thu, 15 Jan 2009 16:07:31 +0100 (CET)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id 9CE5D39AA00; Thu, 15 Jan 2009 16:08:41 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20090115145003.GA6938@b2j>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105831>

bill lam <cbill.lam@gmail.com> wrote Thu, Jan 15, 2009:
> On Thu, 15 Jan 2009, Jonas Fonseca wrote:
> > presence of a {/usr/incude/}ncursesw/ncurses.h header. Where are the
> > unicode ncurses.h files found on your system?
> 
> on ubuntu,
> /usr/incude/ncursesw/curses.h 
> /usr/incude/ncursesw/ncurses.h  ( just a sym link to curses.h above ) 

Then I am puzzled why the configure script doesn't find it. Can you send
me your config.log and the output of running configure. Maybe off-list.

-- 
Jonas Fonseca
