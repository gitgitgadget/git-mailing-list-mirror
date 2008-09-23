From: Peter Krefting <peter@softwolves.pp.se>
Subject: Re: [CORRECTION] Git-1.6.0.2-preview20080921 on Windows
Date: Tue, 23 Sep 2008 06:08:20 +0100 (CET)
Organization: /universe/earth/europe/norway/oslo
Message-ID: <alpine.DEB.2.00.0809230606060.22061@perkele.intern.softwolves.pp.se>
References: <82166911-C34F-439C-A2F3-CEBD7346A1D6@zib.de>
 <691F01A6-CA78-46DA-8388-C8339A3F0F04@zib.de>
 <Pine.LNX.4.64.0809220939140.20111@ds9.cixit.se>
 <loom.20080922T101605-640@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Frederik Hohlfeld <frederik.hohlfeld@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 07:09:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ki09Y-0003SK-JO
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 07:09:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751926AbYIWFI0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 01:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751900AbYIWFI0
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 01:08:26 -0400
Received: from smtp.getmail.no ([84.208.20.33]:34446 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751775AbYIWFIZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 01:08:25 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0K7M00605U9ZUD00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Tue, 23 Sep 2008 07:08:24 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K7M00H8BU9MU990@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Tue, 23 Sep 2008 07:08:10 +0200 (CEST)
Received: from perkele ([84.215.142.63]) by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K7M00D7YU9M91D1@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Tue, 23 Sep 2008 07:08:10 +0200 (CEST)
Received: by perkele (Postfix, from userid 501)	id ED4742FC02; Tue,
 23 Sep 2008 07:08:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])	by perkele (Postfix)
 with ESMTP id E9AEF2FC01; Tue, 23 Sep 2008 06:08:20 +0100 (CET)
In-reply-to: <loom.20080922T101605-640@post.gmane.org>
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96522>

Frederik Hohlfeld:

> Do I understand it right, that this is also without working git-svn (or 
> maybe even without git-svn at all)?

Yes, like the previous releases, git-svn is not included in the build. There 
is an older release availabe which has a git-svn in it, but it says that it 
doesn't quite work right. I guess it needs a volunteer to look at it and 
figure out how to fix it...

-- 
\\// Peter - http://www.softwolves.pp.se/
