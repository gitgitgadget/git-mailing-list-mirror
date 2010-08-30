From: Tim Mazid <timmazid@hotmail.com>
Subject: Detection of relocations within a file
Date: Tue, 31 Aug 2010 01:04:56 +1000
Message-ID: <SNT124-W57C91CBC3A362218ACA23DC4890@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 30 17:11:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oq61f-0005Jt-08
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 17:11:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755369Ab0H3PLL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Aug 2010 11:11:11 -0400
Received: from snt0-omc3-s1.snt0.hotmail.com ([65.55.90.140]:52135 "EHLO
	snt0-omc3-s1.snt0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753657Ab0H3PLK convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 11:11:10 -0400
X-Greylist: delayed 372 seconds by postgrey-1.27 at vger.kernel.org; Mon, 30 Aug 2010 11:11:10 EDT
Received: from SNT124-W57 ([65.55.90.136]) by snt0-omc3-s1.snt0.hotmail.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Mon, 30 Aug 2010 08:04:58 -0700
X-Originating-IP: [60.241.190.75]
Importance: Normal
X-OriginalArrivalTime: 30 Aug 2010 15:04:58.0552 (UTC) FILETIME=[B6714380:01CB4854]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154822>


Hi git-list,

I was just wondering if git can/does detect relocations of sections of code/text within a file.

For example, moving a function from the top of a file to the end.

If git does not currently do this, would it be a good/bad idea, and how hard would it be to implement?

Regards,
Tim.
 		 	   		  