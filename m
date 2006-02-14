From: Nicolas Vilz 'niv' <niv@iaglans.de>
Subject: several quick questions
Date: Tue, 14 Feb 2006 17:28:34 +0100
Message-ID: <43F20532.5000609@iaglans.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Feb 14 17:36:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F934I-0005cc-AO
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 17:30:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422630AbWBNQaT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 11:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422631AbWBNQaS
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 11:30:18 -0500
Received: from geht-ab-wie-schnitzel.de ([217.69.165.145]:29971 "EHLO
	vsectoor.geht-ab-wie-schnitzel.de") by vger.kernel.org with ESMTP
	id S1422630AbWBNQaR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2006 11:30:17 -0500
Received: from localhost (localhost [127.0.0.1])
	by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id 0241D3E92
	for <git@vger.kernel.org>; Tue, 14 Feb 2006 17:30:15 +0100 (CET)
Received: from vsectoor.geht-ab-wie-schnitzel.de ([127.0.0.1])
	by localhost (vsectoor.geht-ab-wie-schnitzel.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 01727-10 for <git@vger.kernel.org>;
	Tue, 14 Feb 2006 17:30:15 +0100 (CET)
Received: from [192.168.100.26] (unknown [10.0.0.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id 2A09E3E6B
	for <git@vger.kernel.org>; Tue, 14 Feb 2006 17:30:14 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051204)
X-Accept-Language: en-us, en
To: git <git@vger.kernel.org>
X-Enigmail-Version: 0.92.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16139>

Hello everyone,

i wonder, how i revoke a straight forward merge of two trees... I
actually wanted to be look like somewhere in the git-repository, where
some branches are merged back with the master tree, but i think, that
wasn't "cg-merge -c <tree to merge with the actual one>"...

my result was that my master tree has now the same sha1-sum as my
development-tree and gitk visualisation differs from that what i saw in
the git-repository. (Several Arrows headed into back into one line...)

maybe that was because i didn't do anything in my master tree in the
meantime.

And another thing, is there no posibility to get back to some commits or
tags? I realized you can rebranch tags... what, if i want to switch back
to git version 1.1.6 in the git repository? Or a certain commit?

do you have to make a new private branch out of the tag 1.1.6?

i used svn and there i could go back some revisions. I haven't found
such a feature in git, yet... but i think i am blind all the time.

I like git very much and every new day I like it more.

Sincerly
Nicolas
