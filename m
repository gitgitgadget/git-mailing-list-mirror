From: chris@seberino.org
Subject: How make "git checkout <commit> <file>" *not* alter index?
Date: Mon, 5 Jan 2009 21:18:52 -0800
Message-ID: <20090106051852.GA3278@seberino.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 06 06:20:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LK4MR-0007X8-Gn
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 06:20:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750976AbZAFFSx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 00:18:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750958AbZAFFSx
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 00:18:53 -0500
Received: from li30-51.members.linode.com ([65.49.60.51]:42785 "EHLO
	seberino.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750878AbZAFFSw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 00:18:52 -0500
Received: by seberino.org (Postfix, from userid 1000)
	id 2DB45184AE; Mon,  5 Jan 2009 21:18:52 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104636>

I want to pull an old version of a file into my local directory and make it
appear like work I haven't added to index yet...


So how modify


git checkout <commit> <file>

to do this?

cs
