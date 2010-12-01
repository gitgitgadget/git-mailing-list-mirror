From: Jari Aalto <jari.aalto@cante.net>
Subject: Re: [PATCH] git-reset.txt: Use commit~1 notation over commit^
Date: Wed, 01 Dec 2010 21:37:52 +0200
Organization: Private
Message-ID: <877hftuvvz.fsf@picasso.cante.net>
References: <1291227258-17922-1-git-send-email-jari.aalto@cante.net>
	<1291230820.11917.25.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 01 20:40:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNsXH-0007Km-56
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 20:40:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755754Ab0LATkI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 14:40:08 -0500
Received: from lo.gmane.org ([80.91.229.12]:45232 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751335Ab0LATkI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 14:40:08 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PNsX6-0007Ex-2E
	for git@vger.kernel.org; Wed, 01 Dec 2010 20:40:04 +0100
Received: from a91-155-187-216.elisa-laajakaista.fi ([91.155.187.216])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 20:40:04 +0100
Received: from jari.aalto by a91-155-187-216.elisa-laajakaista.fi with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 20:40:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: a91-155-187-216.elisa-laajakaista.fi
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.2 (gnu/linux)
Cancel-Lock: sha1:uRyKgZ0aNtYZ02td80f4i7kct7E=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162582>

2010-12-01 21:13 Drew Northup <drew.northup@maine.edu>:
> "~" examples is actually a disservice to the documentation reader in a

Well. What I can say. I have witnessed close hand for thousands of
learners. Unfortunately they don't get educated that way. Bright people
may. But I'd rather address average Joe who is switching from SVN or the
like.

What people appreciate, while learning, is constency. Sticking to one
notation is better than giving multiple choices. And the "^" isn't
exactly readable, don't you agree?

    HEAD^^^^^^^^

Right. How many was there again?

Besides, the "^" key was probably inverted to work easily in US keybord.
It is not so in other parts of the world.

The fine print can be reserved to git-rev-parse(1) where you can get all
the details.

Jari
