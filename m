From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Effective difference between git-rebase and git-resolve
Date: Sat, 25 Mar 2006 10:37:09 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0603251034550.14457@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060325035423.GB31504@buici.com> <Pine.LNX.4.64.0603242014160.15714@g5.osdl.org>
 <20060325043507.GA14644@buici.com> <7v1wwrys07.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 25 10:37:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FN5Cy-0001sL-LP
	for gcvg-git@gmane.org; Sat, 25 Mar 2006 10:37:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbWCYJhQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 04:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbWCYJhQ
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 04:37:16 -0500
Received: from mail.gmx.de ([213.165.64.20]:25491 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751133AbWCYJhO (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Mar 2006 04:37:14 -0500
Received: (qmail invoked by alias); 25 Mar 2006 09:37:13 -0000
Received: from lxweb002.wuerzburg.citynet.de (EHLO localhost) [81.209.129.202]
  by mail.gmx.net (mp031) with SMTP; 25 Mar 2006 10:37:13 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v1wwrys07.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17968>

Hi,

On Fri, 24 Mar 2006, Junio C Hamano wrote:

> If nobody in the upper echelon of kernel people (meaning, longest-time 
> git users) use git-resolve anymore, I think we should mark it deprecated 
> and remove it eventually.

I am nowhere near kernel people, but I am using git on a machine where it 
is too cumbersome to install python. If git-resolve goes, I am without a 
merge strategy (at least until git-recursive is ported to C... was that 
not the plan with git-merge-tree? What happened on that front?).

Ciao,
Dscho
