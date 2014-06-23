From: Stephen Kelly <steveire@gmail.com>
Subject: Re: gitk with submodules does not show new commits on other branches
Date: Mon, 23 Jun 2014 15:25:39 +0200
Message-ID: <lo99sj$e2$1@ger.gmane.org>
References: <lo6o2h$vva$1@ger.gmane.org> <53A6F978.4010005@web.de> <lo6tnh$p3c$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 23 15:26:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wz4GF-0005CE-Dr
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jun 2014 15:26:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755037AbaFWN0J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2014 09:26:09 -0400
Received: from plane.gmane.org ([80.91.229.3]:45786 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754147AbaFWN0G (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2014 09:26:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Wz4Fx-00051Q-OB
	for git@vger.kernel.org; Mon, 23 Jun 2014 15:25:57 +0200
Received: from 188.111.54.34 ([188.111.54.34])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 23 Jun 2014 15:25:57 +0200
Received: from steveire by 188.111.54.34 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 23 Jun 2014 15:25:57 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 188.111.54.34
User-Agent: KNode/4.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252346>

Stephen Kelly wrote:

>> But I agree that this is suboptimal for your workflow. What about adding
>> a "Visualize These Changes In The Submodule" menu entry for the context
>> menu of a change in gitk just like the one git gui already has?
> 
> Can you tell me how to find and try that out in git gui?

In particular, I don't see it in my git gui. Is it only in master?

My versions:

 git-gui version 0.18.0.14.g1b2c7
 git version 1.9.1

 Tcl/Tk version 8.6.1
 Aspell 0.60.7-20110707, en_US

Thanks,

Steve.
