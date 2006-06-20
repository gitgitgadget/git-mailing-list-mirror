From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Apologies for the 2 late-night bugs
Date: Tue, 20 Jun 2006 09:54:56 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606200952560.26329@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Jun 20 09:55:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fsb4e-0004V6-6U
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 09:55:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965016AbWFTHy5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Jun 2006 03:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965142AbWFTHy5
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jun 2006 03:54:57 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:222 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S965016AbWFTHy5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jun 2006 03:54:57 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 14A9920E0
	for <git@vger.kernel.org>; Tue, 20 Jun 2006 09:54:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 096A02120
	for <git@vger.kernel.org>; Tue, 20 Jun 2006 09:54:56 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id E2C142093
	for <git@vger.kernel.org>; Tue, 20 Jun 2006 09:54:55 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22178>

Hi,

with the recent patches to introduce $HOME/.gitconfig, I also introduced 
two bugs. They were not due to lacking of testing, but rather due to 
testing with an accidentally set GIT_CONFIG. And now I *know* why I did 
not want that thing in the first place. And I decided not to become a 
pilot, ever.

Ciao,
Dscho
