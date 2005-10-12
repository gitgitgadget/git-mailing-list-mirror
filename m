From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Adapt tutorial to cygwin and add test case
Date: Wed, 12 Oct 2005 13:08:54 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510121306030.30679@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0510111333160.27109@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vu0fnsu6f.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 12 13:10:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPeTl-00074Q-4E
	for gcvg-git@gmane.org; Wed, 12 Oct 2005 13:09:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbVJLLI5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Oct 2005 07:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751437AbVJLLI5
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Oct 2005 07:08:57 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:29420 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751401AbVJLLI4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2005 07:08:56 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 6482913EC57; Wed, 12 Oct 2005 13:08:55 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 495579ECA6; Wed, 12 Oct 2005 13:08:55 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 21E319EC7E; Wed, 12 Oct 2005 13:08:55 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 07C7513EC57; Wed, 12 Oct 2005 13:08:55 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vu0fnsu6f.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10019>

Hi,

On Tue, 11 Oct 2005, Junio C Hamano wrote:

> The original was both ugly and did not use boxquote.  There is
> no excuse for ugliness, but not using boxquote was for a
> reason.

I am no expert in non-ugliness, and neither in asciidoc. My first version 
of the patch removed the single "+" on a line, because I thought they were 
remnants of a corrupted patch... By using git-whatchanged I found out that 
this is not so, and finally I found that it means "continuation" in 
asciidoc syntax.

So: Sorry, can't help here.

Ciao,
Dscho
