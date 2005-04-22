From: David Greaves <david@dgreaves.com>
Subject: wit suggestion
Date: Fri, 22 Apr 2005 23:46:20 +0100
Message-ID: <42697EBC.2080201@dgreaves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing Lists <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 23 00:42:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DP6qJ-0002Dj-PL
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 00:41:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbVDVWqY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 18:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbVDVWqY
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 18:46:24 -0400
Received: from s2.ukfsn.org ([217.158.120.143]:27055 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S261262AbVDVWqW (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2005 18:46:22 -0400
Received: from localhost (lucy.ukfsn.org [127.0.0.1])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 21E15E6D90; Fri, 22 Apr 2005 23:44:23 +0100 (BST)
Received: from mail.ukfsn.org ([127.0.0.1])
 by localhost (lucy.ukfsn.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 29874-04; Fri, 22 Apr 2005 23:44:23 +0100 (BST)
Received: from oak.dgreaves.com (modem-3676.llama.dialup.pol.co.uk [217.135.190.92])
	by mail.ukfsn.org (Postfix) with ESMTP
	id 8D93EE6D65; Fri, 22 Apr 2005 23:44:22 +0100 (BST)
Received: from ash.dgreaves.com ([10.0.0.90])
	by oak.dgreaves.com with esmtp (Exim 4.20)
	id 1DP6ui-0004if-FK; Fri, 22 Apr 2005 23:46:20 +0100
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
To: Christian Meder <chris@absolutegiganten.org>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi Christian

Can I suggest a 'summary diff' option

It's basically a diff between the tree of the commit and the tree of the 
parent commit

It would show what files have changed rather than the diff of the files 
that have changed. (kinda like diffstat without the ++++++++ for now)

(or maybe just do a diffstat if it's easier)

Of course you could click through to a per-file diff eventually...

David

-- 
