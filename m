From: Jens Neuhalfen <JensNeuhalfen@gmx.de>
Subject: Re: SeLinux integration
Date: Mon, 18 Aug 2008 14:02:39 +0200
Message-ID: <1219060960.13808.20.camel@desktop.local.neuhalfen.name>
References: <6341D084-1A83-4C0F-8C45-943916612D48@gmx.de>
	 <48A93696.6010500@jaeger.mine.nu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Christian Jaeger <christian@jaeger.mine.nu>
X-From: git-owner@vger.kernel.org Mon Aug 18 14:04:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KV3Sy-0007Vt-Qi
	for gcvg-git-2@gmane.org; Mon, 18 Aug 2008 14:04:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752086AbYHRMCo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 08:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752062AbYHRMCo
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 08:02:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:49056 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751811AbYHRMCn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 08:02:43 -0400
Received: (qmail invoked by alias); 18 Aug 2008 12:02:41 -0000
Received: from static-87-79-238-78.netcologne.de (EHLO [172.20.0.23]) [87.79.238.78]
  by mail.gmx.net (mp050) with SMTP; 18 Aug 2008 14:02:41 +0200
X-Authenticated: #1271396
X-Provags-ID: V01U2FsdGVkX1+6niE+9La6Lj9+VAIriW6T5dI4s14OM+oJZJSDe6
	f77M0/H1VvRq+n
In-Reply-To: <48A93696.6010500@jaeger.mine.nu>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.2) 
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.71
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92701>

> Jens Neuhalfen wrote:
> > git://www.neuhalfen.name/git-selinux.git
> 


Hi Christian,

> I'm just an end user, too, so this isn't representing any official 
...

first, thank you for your taking your time! I am relatively new to git (I've been poking git for three or four weeks now), so your advice on how-to (and how-not-to) is much appreciated.

The repository is my current development repository which, naturally (?), is based on the 'blessed' repository. My understanding of git was, that anyone with a copy of the blessed git repository can 'pull' from my repository and gets my branches with git transmitting just my changes over the net. Then he/she/it can switch to 'my' branch and test the policy/init-script.

Did I get something wrong there? I thought that this is a/the normal way of using git. 

You are right with the commits and their rather terse messages, though the code are not ready for release or an integration review. The plan was: Get some feedback on the current state, refine the code and then send the patches to the list. 

Christian, have you been able to test the policy? I am very curious, how it works on other machines (say, gentoo) or with other setups (strict-policy is completely untested, although I don't think that anyone really uses it).

Jens


> Christian.
