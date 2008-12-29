From: jidanni@jidanni.org
Subject: Re: "git-whatever" the new style vs. "git whatever"?
Date: Tue, 30 Dec 2008 06:22:17 +0800
Message-ID: <87ocyu4o6e.fsf@jidanni.org>
References: <495940AD.2070602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: bss@iguanasuicide.net, git@vger.kernel.org
To: gitzilla@gmail.com
X-From: git-owner@vger.kernel.org Mon Dec 29 23:24:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHQWY-0006v8-4H
	for gcvg-git-2@gmane.org; Mon, 29 Dec 2008 23:23:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754512AbYL2WWW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Dec 2008 17:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754496AbYL2WWV
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Dec 2008 17:22:21 -0500
Received: from sd-green-bigip-202.dreamhost.com ([208.97.132.202]:57563 "EHLO
	homiemail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754487AbYL2WWU (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Dec 2008 17:22:20 -0500
Received: from jidanni.org (122-127-33-187.dynamic.hinet.net [122.127.33.187])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by homiemail-a1.g.dreamhost.com (Postfix) with ESMTP id 7E1B8119E07;
	Mon, 29 Dec 2008 14:22:19 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104136>

>> That shouldn't be a problem for much longer because "git-whatever"
>> will stop working.  From what I understand, "git whatever" has
>> always been the preferred form, and the fact that "git-whatever"
>> worked was just a implementation detail.

I thought if A worked from the start, and now B also works, you all
must have been moving to B, and so I made all my shell scripts use B.

ALAS> This is a revisionist history. Check the history of the git command to
ALAS> find out when it was created and then check the ML archives for
ALAS> related discussions.

All I know is we beginners just encounter both forms in the literature
and won't know about looking into whatever histories... and assumed until
this post that git-whatever was the new style! OK, now I know the truth.
