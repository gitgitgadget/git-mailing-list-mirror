From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Avoid using dc in git-count-objects
Date: Thu, 27 Oct 2005 11:56:50 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510271149110.16500@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0510260120260.28994@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vd5ltcf05.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0510261031400.7424@wbgn013.biozentrum.uni-wuerzburg.de>
 <20051026083658.GE30889@pasky.or.cz> <pan.2005.10.27.08.49.59.849081@smurf.noris.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Thu Oct 27 11:59:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EV4VD-0005gI-Jl
	for gcvg-git@gmane.org; Thu, 27 Oct 2005 11:56:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932634AbVJ0J4x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Oct 2005 05:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932632AbVJ0J4w
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Oct 2005 05:56:52 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:41182 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932630AbVJ0J4w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2005 05:56:52 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id 3FAE613F53A
	for <git@vger.kernel.org>; Thu, 27 Oct 2005 11:56:51 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP id 2A4EB9EFA5
	for <git@vger.kernel.org>; Thu, 27 Oct 2005 11:56:51 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP id F0B639EFAE
	for <git@vger.kernel.org>; Thu, 27 Oct 2005 11:56:50 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP id C0DAD13F53A
	for <git@vger.kernel.org>; Thu, 27 Oct 2005 11:56:50 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
In-Reply-To: <pan.2005.10.27.08.49.59.849081@smurf.noris.de>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10707>

Hi,

On Thu, 27 Oct 2005, Matthias Urlichs wrote:

> That being said, "echo $((1 + 2 + $((3 + 4))))" will not even fork.

<germanenglish>
But zats not troo. It forks fine for mee: ze result is 10.
</germanenglish>

;-)

Ciao,
Dscho
