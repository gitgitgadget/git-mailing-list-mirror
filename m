From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: Git/Mercurial interoperability (and what about bzr?) (was: Re:
 [VOTE] git versus mercurial)
Date: Sat, 1 Nov 2008 11:16:58 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.64.0811011114170.29441@ds9.cixit.se>
References: <ge0rla$mce$1@ger.gmane.org> <ge70nl$l6t$1@ger.gmane.org>
 <alpine.DEB.1.00.0810281445190.22125@pacific.mpi-cbg.de.mpi-cbg.de>
 <Pine.LNX.4.64.0810281536360.27029@ds9.cixit.se> <E026EBDF-F402-49AB-A7A8-0A0EFB513907@ai.rug.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Sat Nov 01 11:20:09 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwDYt-0000wm-OO
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 11:18:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752750AbYKAKRU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 06:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbYKAKRU
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 06:17:20 -0400
Received: from ds9.cixit.se ([193.15.169.228]:53051 "EHLO ds9.cixit.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752723AbYKAKRR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 06:17:17 -0400
Received: from ds9.cixit.se (peter@localhost [127.0.0.1])
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id mA1AH4Y1031292
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 1 Nov 2008 11:17:04 +0100
Received: from localhost (peter@localhost)
	by ds9.cixit.se (8.12.3/8.12.3/Debian-7.2) with ESMTP id mA1AGwQm031283;
	Sat, 1 Nov 2008 11:17:03 +0100
X-Authentication-Warning: ds9.cixit.se: peter owned process doing -bs
In-Reply-To: <E026EBDF-F402-49AB-A7A8-0A0EFB513907@ai.rug.nl>
Accept: text/plain
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (ds9.cixit.se [127.0.0.1]); Sat, 01 Nov 2008 11:17:09 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99725>

Hi!

Pieter de Bie:

> What would you want that the fast-export/imports are lacking? I think
> they are excellent tools to build some integration on.

Speed. I am cloning from a rather overloaded server on the other side
of the globe (the US). If I were to go the fast-export/import route, I
fear it would take even longer.

> You might want to look at my git-bzr script

Looks very interesting. *adding to my things-to-examine list*

-- 
\\// Peter - http://www.softwolves.pp.se/
