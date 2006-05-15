From: David Lang <dlang@digitalinsight.com>
Subject: gateway status?
Date: Mon, 15 May 2006 11:26:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.62.0605151122500.29452@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-From: git-owner@vger.kernel.org Mon May 15 20:27:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfhmR-0008RA-UU
	for gcvg-git@gmane.org; Mon, 15 May 2006 20:26:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965118AbWEOS0w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 14:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965121AbWEOS0w
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 14:26:52 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:28551 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S965118AbWEOS0v
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 May 2006 14:26:51 -0400
Received: from no.name.available by warden.diginsite.com
          via smtpd (for vger.kernel.org [209.132.176.167]) with SMTP; Mon, 15 May 2006 11:26:51 -0700
Received: from dlang.diginsite.com ([10.201.10.67]) by wlvims02.corp.ad.diginsite.com with InterScan Message Security Suite; Mon, 15 May 2006 11:26:49 -0700
X-X-Sender: dlang@dlang.diginsite.com
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20075>

I seem to remember seeing discussion of gateways to cvs/svn that would let 
a project use a git repository and allow clients to use cvs/svn clients to 
retreive data.

am I remembering correctly, and are these tools ready for production use? 
the popfile project is getting ready to abandon sourceforge and move to 
self-hosting, but before I suggest that they use git I need to know the 
current status of these projects (I think the ability to export directly 
into the other interfaces is a significant advantage)

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
