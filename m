From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] merge-one-file: remove empty directories
Date: Mon, 21 Nov 2005 01:00:26 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511210059190.24828@wbgn013.biozentrum.uni-wuerzburg.de>
References: <17279.1674.22992.607091@cargo.ozlabs.ibm.com> <20051119140736.GA24901@lst.de>
 <Pine.LNX.4.64.0511190957320.13959@g5.osdl.org> <7v4q683qhe.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0511200901450.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 21 01:00:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Edz6x-0001Yj-Px
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 01:00:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbVKUAA3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 Nov 2005 19:00:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbVKUAA3
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Nov 2005 19:00:29 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:8590 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932139AbVKUAA1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Nov 2005 19:00:27 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3C0A71401B8; Mon, 21 Nov 2005 01:00:26 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 241959F399; Mon, 21 Nov 2005 01:00:26 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 125969C78A; Mon, 21 Nov 2005 01:00:26 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id EB3401401B8; Mon, 21 Nov 2005 01:00:25 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511200901450.13959@g5.osdl.org>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12414>

On Sun, 20 Nov 2005, Linus Torvalds wrote:

> [...] although if git is ever ported to VMS, I'll just have to shoot 
> myself. I used VMS in -88, and the scars are _still_ fresh.

Does that mean you are opposed to my plans on porting git to C64? Hmm?
