From: chris@seberino.org
Subject: "git reset --hard" == "git checkout HEAD" == "git reset --hard
	HEAD" ???
Date: Fri, 2 Jan 2009 11:57:24 -0800
Message-ID: <20090102195724.GA23119@seberino.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 02 20:59:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIqAR-0004xx-Gg
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 20:58:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757056AbZABT51 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 14:57:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755711AbZABT50
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 14:57:26 -0500
Received: from li30-51.members.linode.com ([65.49.60.51]:58081 "EHLO
	seberino.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755325AbZABT5Z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 14:57:25 -0500
Received: by seberino.org (Postfix, from userid 1000)
	id 3A7D4184BB; Fri,  2 Jan 2009 11:57:24 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104412>

Does "git reset --hard" == "git checkout HEAD" == "git reset --hard HEAD" ???

It seems we have 2 ways to blow away work we haven't checked in yet then right?

chris
