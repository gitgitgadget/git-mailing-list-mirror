From: jidanni@jidanni.org
Subject: grammar patches not best use of talent
Date: Mon, 12 Jan 2009 10:51:34 +0800
Message-ID: <87bpudp77t.fsf_-_@jidanni.org>
References: <7vprito32u.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 12 03:53:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMCvI-0004u6-OJ
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 03:53:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752006AbZALCvk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 21:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751578AbZALCvk
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 21:51:40 -0500
Received: from sd-green-bigip-81.dreamhost.com ([208.97.132.81]:55184 "EHLO
	homiemail-a4.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751308AbZALCvj (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Jan 2009 21:51:39 -0500
Received: from jidanni.org (122-127-36-11.dynamic.hinet.net [122.127.36.11])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a4.dreamhost.com (Postfix) with ESMTP id 530984093C
	for <git@vger.kernel.org>; Sun, 11 Jan 2009 18:51:38 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105281>

I've decided to back out of my plan to patch grammar.
$ perl -nwle '/\w+\s+handful.*/i&& print $&' Documentation/*|sort -uf
a handful commits on top of that,
A handful documentation fixes.
A handful documentation updates.
a handful example hooks are copied in the
a handful fixes to run it
a handful of examples:
A handful of sample hooks are installed when
a handful pack-objects changes to help you cope better
a handful small fixes to gitweb.
a handful the real changes in non-zero
first handful of characters, show the full
only handful hexdigits prefix.
only handful hexdigits prefix.  Non default number of
only handful hexdigits prefix.  This is

At first some of the above lines irritated me, but who am I to say
that English must be said like my mom says it, and is never allowed to
evolve further. Nope, I'll stick to correcting 2+2=3 type things.
