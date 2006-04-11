From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: t5501-old-fetch-and-upload.sh fails with NO_PYTHON=1
Date: Tue, 11 Apr 2006 23:31:42 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0604112329030.26779@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060411170508.G14ba7e47@leonov.stosberg.net>
 <7vlkuc56m9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 11 23:32:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FTQSj-0000nm-Hb
	for gcvg-git@gmane.org; Tue, 11 Apr 2006 23:31:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbWDKVbq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Apr 2006 17:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbWDKVbq
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Apr 2006 17:31:46 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:34474 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751120AbWDKVbp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Apr 2006 17:31:45 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 7C9621BB9;
	Tue, 11 Apr 2006 23:31:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 70D291A76;
	Tue, 11 Apr 2006 23:31:42 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 53FB712D4;
	Tue, 11 Apr 2006 23:31:42 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vlkuc56m9.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18619>

Hi,

On Tue, 11 Apr 2006, Junio C Hamano wrote:

> [...] so keeping this particular test would be somewhat useful as 
> reference and perhaps a starting point for such new test, but otherwise 
> not very much.  And for that kind of usage, "the Net never forgets".

Not only that. Git itself never forgets. "git-cat-file blob 596c88b" will 
probably work virtually forever.

> I'd vote for its removal.  Thoughts?

Yeah.

Ciao,
Dscho
