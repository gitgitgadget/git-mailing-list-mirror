From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: inted problems when upgrading to 1.6.0.4
Date: Tue, 25 Nov 2008 12:04:04 +0100
Message-ID: <492BDBA4.2020202@viscovery.net>
References: <492BC56A.6040506@xmos.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Luis Gutierrez <luis.gutierrez@xmos.com>
X-From: git-owner@vger.kernel.org Tue Nov 25 12:06:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L4vjz-0001ND-2z
	for gcvg-git-2@gmane.org; Tue, 25 Nov 2008 12:05:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752770AbYKYLEJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2008 06:04:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752765AbYKYLEH
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Nov 2008 06:04:07 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:30507 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752761AbYKYLEG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2008 06:04:06 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1L4vi8-0008Fw-Cj; Tue, 25 Nov 2008 12:04:04 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 2D47669F; Tue, 25 Nov 2008 12:04:04 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <492BC56A.6040506@xmos.com>
X-Spam-Score: -1.4 (-)
X-Spam-Report: Spam detection software, running on the system "lilzmailsa03.liwest.at", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Luis Gutierrez schrieb: > This is my current xinetd config:
	> service git > { > disable = yes Remove this line. -- Hannes [...] 
	Content analysis details:   (-1.4 points, 7.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-1.4 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101659>

Luis Gutierrez schrieb:
> This is my current xinetd config:
> service git
> {
>    disable      = yes

Remove this line.

-- Hannes
