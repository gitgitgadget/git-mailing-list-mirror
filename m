From: "Justin Leung" <jleung@redback.com>
Subject: Re: Verilog/ASIC development support is insufficient in git , help!
Date: Sat, 10 May 2008 22:29:51 -0700
Message-ID: <83EE186A7AF140179C6C73B367471EC7@justinuTop>
References: <EB66C79C87CF49E59CB39EA4C286AE05@justinuTop> <BA7F9A3C7EDA4CDD99016093B0DB55C0@justinuTop> <B03D1DC3-7088-41AF-BB8B-9A696E7C5B8E@sb.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, <justin0927@hotmail.com>
To: "Kevin Ballard" <kevin@sb.org>
X-From: git-owner@vger.kernel.org Sun May 11 07:30:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jv497-0006u7-5p
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 07:30:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbYEKFaF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 01:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751100AbYEKFaE
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 01:30:04 -0400
Received: from prattle.redback.com ([155.53.12.9]:40832 "EHLO
	prattle.redback.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751098AbYEKFaD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 01:30:03 -0400
Received: from localhost (localhost [127.0.0.1])
	by prattle.redback.com (Postfix) with ESMTP id DE7436819C0;
	Sat, 10 May 2008 22:29:56 -0700 (PDT)
Received: from prattle.redback.com ([127.0.0.1])
 by localhost (prattle [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 15586-02; Sat, 10 May 2008 22:29:56 -0700 (PDT)
Received: from justinuTop (unknown [172.31.253.90])
	by prattle.redback.com (Postfix) with ESMTP id A3DD96819BF;
	Sat, 10 May 2008 22:29:56 -0700 (PDT)
In-Reply-To: <B03D1DC3-7088-41AF-BB8B-9A696E7C5B8E@sb.org>
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Windows Mail 6.0.6001.18000
X-MimeOLE: Produced By Microsoft MimeOLE V6.0.6001.18000
X-Virus-Scanned: by amavisd-new at redback.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81738>

Hi Kevin,

The ability of inter-user (designer-verifier) code sync'ing without letting 
the incomplete or incompatible RTL code to propagate to the main build 
stream is going to facilitate the design flow and efficiency .

The ability of local revision control means that no more over writing of 
design files until commit .

I think these 2 things will really buy us alot .

 Justin

> Honestly, it sounds like SVN is actually a good fit here. Just because 
> git is awesome for many things does not mean it is the end-all-be-all  of 
> version control systems. SVN still has its place as the last true 
> centralized system. Given your constraints and workflow, why do you  think 
> git is better than SVN?
>
> -Kevin Ballard
>
> -- 
> Kevin Ballard
> http://kevin.sb.org
> kevin@sb.org
> http://www.tildesoft.com
>
>
> 
