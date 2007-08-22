From: Jing Xue <jingxue@digizenstudio.com>
Subject: Re: git-svnimport: what to do after -i?
Date: Wed, 22 Aug 2007 13:04:42 -0400
Message-ID: <20070822130442.7mioy28ps0sg48sc@intranet.digizenstudio.com>
References: <20070822113325.1bihryuk4gko8kgs@intranet.digizenstudio.com>
	<20070822165846.GA17815@dervierte>
Mime-Version: 1.0
Content-Type: text/plain;
	charset=UTF-8;
	DelSp="Yes";
	format="flowed"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Steven Walter <stevenrwalter@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 22 19:04:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INtdR-0001Mh-Vo
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 19:04:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933442AbXHVREp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 13:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933436AbXHVREo
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 13:04:44 -0400
Received: from k2smtpout04-01.prod.mesa1.secureserver.net ([64.202.189.166]:49405
	"HELO k2smtpout04-01.prod.mesa1.secureserver.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933428AbXHVREn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 13:04:43 -0400
Received: (qmail 9555 invoked from network); 22 Aug 2007 17:04:43 -0000
Received: from unknown (HELO ip-72-167-33-213.ip.secureserver.net) (72.167.33.213)
  by k2smtpout04-01.prod.mesa1.secureserver.net (64.202.189.166) with ESMTP; 22 Aug 2007 17:04:43 -0000
Received: from localhost (unknown [127.0.0.1])
	by ip-72-167-33-213.ip.secureserver.net (Postfix) with ESMTP id 593AC1000A2;
	Wed, 22 Aug 2007 17:04:43 +0000 (UTC)
Received: from ip-72-167-33-213.ip.secureserver.net ([127.0.0.1])
	by localhost (ip-72-167-33-213.ip.secureserver.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JNTRvR60kvuQ; Wed, 22 Aug 2007 13:04:42 -0400 (EDT)
Received: by ip-72-167-33-213.ip.secureserver.net (Postfix, from userid 48)
	id B4D9C100A0E; Wed, 22 Aug 2007 13:04:42 -0400 (EDT)
Received: from mailrelay3.private.geico.com (mailrelay3.private.geico.com
	[205.143.204.110]) by intranet.digizenstudio.com (Horde MIME library) with
	HTTP; Wed, 22 Aug 2007 13:04:42 -0400
In-Reply-To: <20070822165846.GA17815@dervierte>
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) H3 (4.1.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56401>


Quoting Steven Walter <stevenrwalter@gmail.com>:

>
> See if "git reset --hard master" doesn't check out the files for you.  I
> seem to recall an issue where, after an import, no files were checked
> out.  reset fixed it for me.

Nope...  Tried that and "git reset --hard HEAD". Both simply print:

HEAD is now at 7be0678... <the last commit message imported>.

Thanks.
-- 
Jing Xue
