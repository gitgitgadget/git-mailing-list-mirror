From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Teach "approxidate" about weekday syntax
Date: Fri, 18 Nov 2005 14:20:10 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511181419340.28109@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.64.0511171223110.13959@g5.osdl.org>
 <7v1x1eubpr.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511171505080.13959@g5.osdl.org>
 <Pine.LNX.4.64.0511171520390.13959@g5.osdl.org> <20051118121210.GA19714@abridgegame.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 14:20:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ed6AA-0001BJ-Fz
	for gcvg-git@gmane.org; Fri, 18 Nov 2005 14:20:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbVKRNUQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 08:20:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbVKRNUQ
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 08:20:16 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:8148 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751157AbVKRNUN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 08:20:13 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 1AC8213FF7B; Fri, 18 Nov 2005 14:20:13 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id EDD479F352; Fri, 18 Nov 2005 14:20:12 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 429F29F34E; Fri, 18 Nov 2005 14:20:11 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id C06E213FEE6; Fri, 18 Nov 2005 14:20:10 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: David Roundy <droundy@abridgegame.org>
In-Reply-To: <20051118121210.GA19714@abridgegame.org>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12230>

Hi,

On Fri, 18 Nov 2005, David Roundy wrote:

> Don't forget "high noon"!  (and perhaps "tea time"?)  :)

How about "dooms day"? I would like to do this:

	git-whatchanged -p --until="dooms day"

Hmm?

Ciao,
Dscho
