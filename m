From: Zack Brown <zbrown@tumblerings.org>
Subject: git/cogito suggestion: tags with descriptions
Date: Mon, 5 Sep 2005 11:45:51 -0700
Message-ID: <20050905184551.GA14720@tumblerings.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Sep 05 20:46:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECLyf-0007zs-9y
	for gcvg-git@gmane.org; Mon, 05 Sep 2005 20:45:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932400AbVIESpy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Sep 2005 14:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932402AbVIESpy
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Sep 2005 14:45:54 -0400
Received: from dsl092-000-086.sfo1.dsl.speakeasy.net ([66.92.0.86]:62357 "EHLO
	tumblerings.org") by vger.kernel.org with ESMTP id S932400AbVIESpx
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 5 Sep 2005 14:45:53 -0400
Received: from zbrown by tumblerings.org with local (Exim 4.50)
	id 1ECLyZ-0004tv-Pi
	for git@vger.kernel.org; Mon, 05 Sep 2005 11:45:51 -0700
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8110>

Hi folks,

I've been using git on my new projects, and loving it!

When I use tags, I typically will use a name like "0.3_basic_description"
and "0.4_full_outline", because I want to know not only what version number I'm
considering, but also the reason why I chose to tag that particular version.

The problem is that when I want to seek to a particular version to see where my
head was at, I have to do all that typing, or cut and paste the full text of the
tag, which is not terribly annoying, but it seems unnecessary. The version
number is the unique ID I'm really interested in, and the descriptive part of
the name is just extra, so I know what I'm talking about.

It would be great if tags also allowed a brief description to go along with
them, that would show up in cg-tag-ls. Then I could seek to a tag that's just
an easy-to-type version number, and still have an idea of what's significant
about that version because of the descriptive text.

Be well,
Zack

-- 
Zack Brown
