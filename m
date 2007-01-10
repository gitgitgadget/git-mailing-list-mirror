From: Juergen Ruehle <j.ruehle@bmiag.de>
Subject: Re: [PATCH] Provide better feedback for the untracked only case in status output
Date: Wed, 10 Jan 2007 08:29:10 +0100
Message-ID: <17828.38342.510000.691826@lapjr.intranet.kiel.bmiag.de>
References: <7vps9pwa3e.fsf@assigned-by-dhcp.cox.net>
	<1168412892113-git-send-email-j.ruehle@bmiag.de>
	<17828.37642.473000.296809@lapjr.intranet.kiel.bmiag.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Jan 10 08:29:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4Xtr-0005om-Ba
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 08:29:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932723AbXAJH31 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Jan 2007 02:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932729AbXAJH31
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jan 2007 02:29:27 -0500
Received: from meriadoc.bmiag.de ([62.154.210.133]:36433 "EHLO
	meriadoc.bmiag.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932723AbXAJH30 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jan 2007 02:29:26 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by meriadoc.bmiag.de (Postfix) with ESMTP id 9A7C33AEE2;
	Wed, 10 Jan 2007 08:29:24 +0100 (CET)
Received: from meriadoc.bmiag.de ([127.0.0.1])
	by localhost (meriadoc [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 05223-10; Wed, 10 Jan 2007 08:29:24 +0100 (CET)
Received: from eotheod.intranet.kiel.bmiag.de (eotheod.intranet.kiel.bmiag.de [10.130.2.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by meriadoc.bmiag.de (Postfix) with ESMTP id 38FCF3AEE0;
	Wed, 10 Jan 2007 08:29:21 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by eotheod.intranet.kiel.bmiag.de (Postfix) with ESMTP id 81DD63ADCA;
	Wed, 10 Jan 2007 08:29:21 +0100 (CET)
Received: from eotheod.intranet.kiel.bmiag.de ([127.0.0.1])
	by localhost (eotheod [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 13867-01; Wed, 10 Jan 2007 08:29:18 +0100 (CET)
Received: from LAPJR (dialin5.galadriel.bmiag.de [192.168.251.5])
	by eotheod.intranet.kiel.bmiag.de (Postfix) with ESMTP id 957963ADC8;
	Wed, 10 Jan 2007 08:29:12 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
In-Reply-To: <17828.37642.473000.296809@lapjr.intranet.kiel.bmiag.de>
X-Mailer: VM 7.19 under Emacs 22.0.92.1
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at eotheod.intranet.kiel.bmiag.de
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at meriadoc.bmiag.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36483>

Juergen Ruehle writes:
 > Juergen Ruehle writes:
 >  > [Corrupted patch deleted]

Actually the patch is ok as sent (somehow my MUA was adding CRs when
locally saving the patch). Sorry for the noise.
