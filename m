From: Darrin Thompson <darrint@progeny.com>
Subject: Fixing Commit And Author
Date: Fri, 04 Nov 2005 11:38:45 -0500
Message-ID: <1131122325.5446.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Nov 04 17:41:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EY4aY-00010B-OR
	for gcvg-git@gmane.org; Fri, 04 Nov 2005 17:38:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbVKDQiq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Nov 2005 11:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbVKDQiq
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Nov 2005 11:38:46 -0500
Received: from zealot.progeny.com ([216.37.46.162]:31703 "EHLO
	morimoto.progeny.com") by vger.kernel.org with ESMTP
	id S932165AbVKDQip (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Nov 2005 11:38:45 -0500
Received: from localhost.localdomain (morimoto.progeny.com [192.168.1.53])
	by morimoto.progeny.com (Postfix) with ESMTP id 8A740636AF
	for <git@vger.kernel.org>; Fri,  4 Nov 2005 11:38:44 -0500 (EST)
To: git@vger.kernel.org
X-Mailer: Evolution 2.2.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11141>

I've got a small project in git where I made a dumb error. All my
commits have author/committer information like this:

Author: Darrin Thompson <darrint@dhcp-1-211.(none)>  2005-10-20 16:50:38
Committer: Darrin Thompson <darrint@dhcp-1-211.(none)>  2005-10-20
16:50:38
Tags: svn-5099

I'd like to replace the commits (yes, I know that means all of them)
with new ones with corrected email addresses and also manage to migrate
my tags. A push in the right direction would be appreciated.

Next I'd like to do the same with the kernel sources... :-)

--
Darrin
