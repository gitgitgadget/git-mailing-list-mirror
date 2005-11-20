From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: what is "rebase"?
Date: Sun, 20 Nov 2005 02:15:15 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511200214280.11653@wbgn013.biozentrum.uni-wuerzburg.de>
References: <86fyps8bl1.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 20 02:15:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eddne-0007XO-I0
	for gcvg-git@gmane.org; Sun, 20 Nov 2005 02:15:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbVKTBPU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Nov 2005 20:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbVKTBPU
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Nov 2005 20:15:20 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:47597 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751116AbVKTBPT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Nov 2005 20:15:19 -0500
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 6EE9A13FDDE; Sun, 20 Nov 2005 02:15:16 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 4D472B526B; Sun, 20 Nov 2005 02:15:16 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 2F88BB34DF; Sun, 20 Nov 2005 02:15:16 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 979B713FDDE; Sun, 20 Nov 2005 02:15:15 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
In-Reply-To: <86fyps8bl1.fsf@blue.stonehenge.com>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12359>

Hi,

On Sun, 19 Nov 2005, Randal L. Schwartz wrote:

> Can someone point me to a simple explanation of what "rebase" is?

How about the definition in Documentation/glossary.txt?

> rebase::
>         To clean a branch by starting from the head of the main line of
>         development ("master"), and reapply the (possibly cherry-picked)
>         changes from that branch.

Hth,
Dscho
