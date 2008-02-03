From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: [PATCH] Documentation/git-reset.txt: Use HEAD~N syntax everywhere (unify examples)
Date: Mon, 04 Feb 2008 01:48:15 +0200
Organization: Private
Message-ID: <bq6x38lc.fsf@blue.sea.net>
References: <3asc6spe.fsf@blue.sea.net>
	<7v7iho6p2m.fsf@gitster.siamese.dyndns.org>
	<20080202084406.GA15305@glandium.org> <8x235xa8.fsf@blue.sea.net>
	<20080203193024.GV29522@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 04 00:49:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLoaY-0006Oa-UH
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 00:49:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753492AbYBCXs5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 18:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753471AbYBCXs5
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 18:48:57 -0500
Received: from main.gmane.org ([80.91.229.2]:36524 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753457AbYBCXs4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 18:48:56 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JLoZx-00022m-Pf
	for git@vger.kernel.org; Sun, 03 Feb 2008 23:48:53 +0000
Received: from a91-155-178-181.elisa-laajakaista.fi ([91.155.178.181])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 03 Feb 2008 23:48:53 +0000
Received: from jari.aalto by a91-155-178-181.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 03 Feb 2008 23:48:53 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-178-181.elisa-laajakaista.fi
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/22.1 (windows-nt)
Cancel-Lock: sha1:vRXML0p/rdN4lAYPFFA135nlu14=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72423>

* Sun 2008-02-03 Dmitry Potapov <dpotapov@gmail.com>
* Message-Id: 20080203193024.GV29522@dpotapov.dyndns.org
> ^-syntax is very natural to specify the _previous_ commit. Have you
> notice we usually say "previous", not "one commit before"?

Only if you're grown with git. Everywhere else the concept of HEAD or
TIP is more natural, thus progression:

    HEAD, HEAD~1, HEAD~2

Jari

-- 
Welcome to FOSS revolution: we fix and modify until it shines
