From: Marcel Koeppen <lists@marzelpan.de>
Subject: Re: What's cooking in git.git (Jan 2009, #02; Sun, 11)
Date: Mon, 12 Jan 2009 02:58:11 +0100
Message-ID: <A40F4753-A81B-43FD-B1A5-B28B627F8BBD@marzelpan.de>
References: <7v63kmtbk6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 03:04:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMCAb-0004Qe-3D
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 03:04:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752069AbZALCDZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 21:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751527AbZALCDZ
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 21:03:25 -0500
Received: from smtprelay11.ispgateway.de ([80.67.29.28]:36434 "EHLO
	smtprelay11.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751459AbZALCDY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 21:03:24 -0500
X-Greylist: delayed 307 seconds by postgrey-1.27 at vger.kernel.org; Sun, 11 Jan 2009 21:03:24 EST
Received: from [80.145.248.185] (helo=[192.168.1.5])
	by smtprelay11.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <lists@marzelpan.de>)
	id 1LMC4C-0006Fd-Eq; Mon, 12 Jan 2009 02:58:12 +0100
In-Reply-To: <7v63kmtbk6.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.930.3)
X-Df-Sender: 012269
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105276>

Hi,

Am 11.01.2009 um 10:51 schrieb Junio C Hamano:

> ----------------------------------------------------------------
> [Will merge to "master" soon]

> * mc/cd-p-pwd (Tue Dec 30 07:10:24 2008 -0800) 1 commit
> + git-sh-setup: Fix scripts whose PWD is a symlink to a work-dir on
>   OS X

I think this belongs into maint - without it the testsuite fails on OSX.


	Marcel
