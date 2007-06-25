From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH] config: add support for --bool and --int while setting 
 values
Date: Mon, 25 Jun 2007 16:06:34 +0200
Organization: eudaptics software gmbh
Message-ID: <467FCBEA.906B14@eudaptics.com>
References: <1182780024442-git-send-email-frank@lichtenheld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 25 16:13:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2pKD-00059d-6K
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 16:13:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753934AbXFYONw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 10:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753123AbXFYONw
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 10:13:52 -0400
Received: from main.gmane.org ([80.91.229.2]:33109 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751324AbXFYONv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 10:13:51 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1I2pGd-0006EY-KY
	for git@vger.kernel.org; Mon, 25 Jun 2007 16:10:13 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 25 Jun 2007 16:10:11 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 25 Jun 2007 16:10:11 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50900>

Frank Lichtenheld wrote:
> 
> Signed-off-by: Frank Lichtenheld <frank@lichtenheld.de>

Please excuse if I'm missing the big picture, but why do we need this
change?

-- Hannes
