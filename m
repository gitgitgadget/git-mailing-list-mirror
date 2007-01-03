From: Juergen Ruehle <j.ruehle@bmiag.de>
Subject: Re: [PATCH/RFC] Assorted small changes to runstatus
Date: Wed, 3 Jan 2007 06:34:29 +0100
Message-ID: <17819.16485.756000.15186@lapjr.intranet.kiel.bmiag.de>
References: <1167765983316-git-send-email-j.ruehle@bmiag.de>
	<7v8xgkstzt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 03 06:34:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1ym5-0005eg-LX
	for gcvg-git@gmane.org; Wed, 03 Jan 2007 06:34:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753662AbXACFeu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Jan 2007 00:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754065AbXACFet
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jan 2007 00:34:49 -0500
Received: from meriadoc.bmiag.de ([62.154.210.133]:33348 "EHLO
	meriadoc.bmiag.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753662AbXACFet (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jan 2007 00:34:49 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by meriadoc.bmiag.de (Postfix) with ESMTP id 651253AED8;
	Wed,  3 Jan 2007 06:15:40 +0100 (CET)
Received: from meriadoc.bmiag.de ([127.0.0.1])
	by localhost (meriadoc [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 05905-02; Wed, 3 Jan 2007 06:15:40 +0100 (CET)
Received: from eorl.intranet.kiel.bmiag.de (eorl.intranet.kiel.bmiag.de [10.131.2.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by meriadoc.bmiag.de (Postfix) with ESMTP id 174923AED7;
	Wed,  3 Jan 2007 06:15:38 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by eorl.intranet.kiel.bmiag.de (Postfix) with ESMTP id 490923ADC8;
	Wed,  3 Jan 2007 06:34:44 +0100 (CET)
Received: from eorl.intranet.kiel.bmiag.de ([127.0.0.1])
	by localhost (eorl [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 26732-05; Wed, 3 Jan 2007 06:34:38 +0100 (CET)
Received: from LAPJR (dialin5.galadriel.bmiag.de [192.168.251.5])
	by eorl.intranet.kiel.bmiag.de (Postfix) with ESMTP id 5FC413ADC6;
	Wed,  3 Jan 2007 06:34:31 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8xgkstzt.fsf@assigned-by-dhcp.cox.net>
X-Mailer: VM 7.19 under Emacs 21.3.1
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at eorl.intranet.kiel.bmiag.de
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at meriadoc.bmiag.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35843>

Junio C Hamano writes:
 > Thanks.  3 and 4 are obviously good, 1 is probably good although
 > I do not have much preference either way myself.  The part that
 > adds helpful messages of 2 is nice but I am not sure about the
 > wording "Cached changes".
 > 
 > Maybe people who were in the update-index and git-add discussion
 > have better input than I can give.

Yes, that was the intention. Thanks for looking at the proposal.
