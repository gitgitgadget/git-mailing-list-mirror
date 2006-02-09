From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's in git.git
Date: Thu, 9 Feb 2006 12:24:59 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0602091224080.24971@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vslqtf2p1.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0602091055540.24701@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vfymsddqo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 09 12:25:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F79v8-0004v5-NH
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 12:25:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422888AbWBILZD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Feb 2006 06:25:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422893AbWBILZC
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Feb 2006 06:25:02 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:36737 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1422888AbWBILZA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2006 06:25:00 -0500
Received: from virusscan.mail (amavis2.rz.uni-wuerzburg.de [132.187.3.47])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D521E1467CE; Thu,  9 Feb 2006 12:24:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id C463A1510;
	Thu,  9 Feb 2006 12:24:59 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 9D1A01467CE; Thu,  9 Feb 2006 12:24:59 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfymsddqo.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15807>

Hi,

On Thu, 9 Feb 2006, Junio C Hamano wrote:

> Branches are cheap from the storage point of view (not really,
> one inode and a filesystem block wasted to store only 41-bytes
> ;-)), [...]

Not really. I use reiserfs which is quite efficient on these small files.

Hth,
Dscho
