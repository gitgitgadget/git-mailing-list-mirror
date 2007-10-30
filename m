From: Peter Karlsson <peter@softwolves.pp.se>
Subject: Re: Recording merges after repo conversion
Date: Tue, 30 Oct 2007 22:06:32 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <Pine.LNX.4.62.0710302204590.6976@perkele.intern.softwolves.pp.se>
References: <Pine.LNX.4.64.0710090807060.26773@ds9.cixit.se>
 <13D1D3DD-9652-4097-8364-DEF4F26540D3@lrde.epita.fr>
 <Pine.LNX.4.62.0710301433150.652@perkele.intern.softwolves.pp.se>
 <8c5c35580710300729t4a7b375dud01253d9b4ef7196@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7BIT
Cc: Benoit SIGOURE <tsuna@lrde.epita.fr>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 30 22:08:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImyJS-0008C5-Ai
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 22:07:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753743AbXJ3VHh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 17:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753695AbXJ3VHh
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 17:07:37 -0400
Received: from smtp.getmail.no ([84.208.20.33]:35814 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752906AbXJ3VHg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 17:07:36 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JQQ00L2OTCNUH00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Tue, 30 Oct 2007 22:07:35 +0100 (CET)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JQQ00KKVTAQ2MB0@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Tue, 30 Oct 2007 22:06:27 +0100 (CET)
Received: from perkele ([84.215.146.18]) by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JQQ00MEQTAQPF80@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Tue, 30 Oct 2007 22:06:26 +0100 (CET)
Received: by perkele (Postfix, from userid 501)	id E28712FC18; Tue,
 30 Oct 2007 22:06:32 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])	by perkele (Postfix)
 with ESMTP id DFF192FC0C; Tue, 30 Oct 2007 22:06:32 +0100 (CET)
In-reply-to: <8c5c35580710300729t4a7b375dud01253d9b4ef7196@mail.gmail.com>
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62757>

Lars Hjemli:

> No, the grafts file is purely local.

Hmm, any chance that will change in a future version?

> To achieve your goal, you'd have to 'git filter-branch' before 
> pushing/cloning. But beware: this _will_ rewrite your current branch(es).

Ouch. I'll have to think about whether I want to do that, then...

-- 
\\// Peter - http://www.softwolves.pp.se/
