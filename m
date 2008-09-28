From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH] bash completion: Add --[no-]-validate to "git send-email"
Date: Sun, 28 Sep 2008 15:55:00 +0300
Message-ID: <20080928125500.GB3208@mithlond.arda.local>
References: <1222564196-84202-1-git-send-email-mfwitten@mit.edu> <1222564196-84202-2-git-send-email-mfwitten@mit.edu> <1222564196-84202-3-git-send-email-mfwitten@mit.edu> <1222564196-84202-4-git-send-email-mfwitten@mit.edu> <20080928045121.GA3208@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org, spearce@spearce.org
To: Michael Witten <mfwitten@MIT.EDU>
X-From: git-owner@vger.kernel.org Sun Sep 28 14:56:56 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjvpX-0005WK-5Z
	for gcvg-git-2@gmane.org; Sun, 28 Sep 2008 14:56:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbYI1Mzb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Sep 2008 08:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbYI1Mzb
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Sep 2008 08:55:31 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:60072 "EHLO kirsi1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750926AbYI1Mza (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Sep 2008 08:55:30 -0400
Received: from mithlond.arda.local (80.220.180.181) by kirsi1.inet.fi (8.5.014)
        id 48DA2F89002F49E2; Sun, 28 Sep 2008 15:55:01 +0300
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1Kjvng-0002BS-3b; Sun, 28 Sep 2008 15:55:00 +0300
Content-Disposition: inline
In-Reply-To: <20080928045121.GA3208@mithlond.arda.local>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96963>

Teemu Likonen wrote (2008-09-28 07:51 +0300):

> Signed-off-by: Teemu Likonen <tlikonen@iki.fi>
> ---
> 
>     If your patch is to be applied let's also add the options to bash 
>     completion.

One extra hyphen in the subject of my commit message. This is better:

    bash completion: Add --[no-]validate to "git send-email"
