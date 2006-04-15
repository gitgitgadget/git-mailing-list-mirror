From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [WISH] prepend diffstat in front of the patch
Date: Sat, 15 Apr 2006 13:48:49 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0604151346270.25269@wbgn013.biozentrum.uni-wuerzburg.de>
References: <e5bfff550604150207h6fdb0042x3a9bbfa63269a8c8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 15 13:48:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUjGo-0004lL-Jr
	for gcvg-git@gmane.org; Sat, 15 Apr 2006 13:48:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932495AbWDOLsv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Apr 2006 07:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932496AbWDOLsv
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Apr 2006 07:48:51 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:63136 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932495AbWDOLsu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Apr 2006 07:48:50 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 7E8ED1886;
	Sat, 15 Apr 2006 13:48:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 723C81847;
	Sat, 15 Apr 2006 13:48:49 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id 45779BED;
	Sat, 15 Apr 2006 13:48:49 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Marco Costalba <mcostalba@gmail.com>
In-Reply-To: <e5bfff550604150207h6fdb0042x3a9bbfa63269a8c8@mail.gmail.com>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18739>

Hi,

On Sat, 15 Apr 2006, Marco Costalba wrote:

> Perhaps I missed something, but I would like to see --stat and -p as 
> _cumulative_ options .
> 
> Would be great if git-diff-tree -r -c --stat -p 84981f9 prepends
> diffstat in front of the patch as Junio suggested some days ago.
> 
> Is it already planned?

We are a little impatient, aren't we?

Anyway, as you probably saw already, I sent out a patch which does that. I 
wanted to wait a little to introduce it, because I had the feeling that 
the option parsing would be volatile for a few days.

Ciao,
Dscho
