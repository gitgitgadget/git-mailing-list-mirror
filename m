From: Peter Karlsson <peter@softwolves.pp.se>
Subject: Re: git-gui translators: gitgui-0.10.0 coming soon
Date: Fri, 14 Mar 2008 07:27:28 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.1.00.0803140723450.30157@perkele.intern.softwolves.pp.se>
References: <20080313052713.GU8410@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Mar 14 07:29:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ja3Pw-000346-HK
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 07:29:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbYCNG2U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 02:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbYCNG2U
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 02:28:20 -0400
Received: from smtp.getmail.no ([84.208.20.33]:62397 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750972AbYCNG2T (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 02:28:19 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JXP00801JB6OX00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Fri, 14 Mar 2008 07:28:18 +0100 (CET)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JXP004BSJ9SNJ30@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Fri, 14 Mar 2008 07:27:28 +0100 (CET)
Received: from perkele ([84.215.142.63]) by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JXP00M1NJ9SND10@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Fri, 14 Mar 2008 07:27:28 +0100 (CET)
Received: by perkele (Postfix, from userid 501)	id 090F12FC3B; Fri,
 14 Mar 2008 07:27:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])	by perkele (Postfix)
 with ESMTP id 059332FB8C; Fri, 14 Mar 2008 07:27:28 +0100 (CET)
In-reply-to: <20080313052713.GU8410@spearce.org>
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77184>

Shawn O. Pearce:

> If you get a chance, please review your translations and send a patch if 
> there are any updates.

I've committed changes to the mob branch. They come in several steps, but 
feel free to squash them if you want to. I also re-generated the translation 
template ("make -B po/git-gui.pot") and merged the other translation files.

These are the relevant commits:

6de2c8c334668020ba2a6c5ba9f19b6e149bceca Updated Swedish translation (391t0f0u).
e5fba18e03555638a875343b7a228c27d66e6296 Re-generated template and merged translations with it.
89f47ee07f8d1ae5ca3c025c0c8338d8db61428f Merged with git-gui.pot and updated (386t0f0u).
60b941c229a9ddb756fa1f3bac8f3e029eda5b19 Additional fixes.


$ git push
[...]
To mob@repo.or.cz:/srv/git/git-gui/git-gui-i18n.git
    48ed49f..6de2c8c  mob -> mob

-- 
\\// Peter - http://www.softwolves.pp.se/
