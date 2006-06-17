From: Juergen Ruehle <j.ruehle@bmiag.de>
Subject: Re: Cygwin git and windows network shares
Date: Sat, 17 Jun 2006 03:02:06 +0200
Message-ID: <17555.21646.398000.619804@lapjr.intranet.kiel.bmiag.de>
References: <4492AAFA.20807@grin.se>
	<17554.48926.852000.679014@lapjr.intranet.kiel.bmiag.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Jun 17 03:02:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrPCq-00032z-E3
	for gcvg-git@gmane.org; Sat, 17 Jun 2006 03:02:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578AbWFQBCW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Jun 2006 21:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751557AbWFQBCW
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jun 2006 21:02:22 -0400
Received: from meriadoc.bmiag.de ([62.154.210.133]:13697 "EHLO
	meriadoc.bmiag.de") by vger.kernel.org with ESMTP id S1751139AbWFQBCV
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jun 2006 21:02:21 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by meriadoc.bmiag.de (Postfix) with ESMTP id 976813AED7
	for <git@vger.kernel.org>; Sat, 17 Jun 2006 03:02:18 +0200 (CEST)
Received: from meriadoc.bmiag.de ([127.0.0.1])
	by localhost (meriadoc [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 01679-08 for <git@vger.kernel.org>;
	Sat, 17 Jun 2006 03:02:18 +0200 (CEST)
Received: from eotheod.intranet.kiel.bmiag.de (eotheod.intranet.kiel.bmiag.de [10.130.2.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by meriadoc.bmiag.de (Postfix) with ESMTP id 5F9BC3AED2
	for <git@vger.kernel.org>; Sat, 17 Jun 2006 03:02:18 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by eotheod.intranet.kiel.bmiag.de (Postfix) with ESMTP id 8F07A3BB4D
	for <git@vger.kernel.org>; Sat, 17 Jun 2006 03:02:17 +0200 (CEST)
Received: from eotheod.intranet.kiel.bmiag.de ([127.0.0.1])
	by localhost (eotheod [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 00678-10 for <git@vger.kernel.org>;
	Sat, 17 Jun 2006 03:02:11 +0200 (CEST)
Received: from bmiag.de (elros.intranet.kiel.bmiag.de [10.132.1.1])
	by eotheod.intranet.kiel.bmiag.de (Postfix) with SMTP id 4F40D3AF51
	for <git@vger.kernel.org>; Sat, 17 Jun 2006 03:02:11 +0200 (CEST)
Received: (qmail 18023 invoked by uid 5002); 17 Jun 2006 01:02:11 -0000
Received: from dialin5.galadriel.bmiag.de (HELO LAPJR) (192.168.251.5)
  by elros.intranet.kiel.bmiag.de with SMTP; 17 Jun 2006 01:02:11 -0000
To: Niklas Frykholm <niklas@grin.se>, git@vger.kernel.org
In-Reply-To: <17554.48926.852000.679014@lapjr.intranet.kiel.bmiag.de>
X-Mailer: VM 7.19 under Emacs 21.3.1
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at eotheod.intranet.kiel.bmiag.de
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at meriadoc.bmiag.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21991>

Juergen Ruehle writes:
 > The following hack is a workaround, but is probably not safe.

Please just ignore it, it only helps on FAT32 partitions. Sorry for
the confusion.

  jr
