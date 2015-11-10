From: Beat Bolli <dev+git@drbeat.li>
Subject: Re: gitk fails to start after upgrading to 2.6.3 (cannot load
 translation)
Date: Tue, 10 Nov 2015 20:38:52 +0100
Message-ID: <564247CC.5060702@drbeat.li>
References: <alpine.DEB.2.00.1511101040180.27599@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Peter Krefting <peter@softwolves.pp.se>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 10 20:49:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwEvL-0007vD-HE
	for gcvg-git-2@plane.gmane.org; Tue, 10 Nov 2015 20:49:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbbKJTtn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2015 14:49:43 -0500
Received: from mx1.2b3w.ch ([92.42.186.250]:51180 "EHLO mx1.2b3w.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750825AbbKJTtn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2015 14:49:43 -0500
X-Greylist: delayed 583 seconds by postgrey-1.27 at vger.kernel.org; Tue, 10 Nov 2015 14:49:42 EST
Received: from mx1.2b3w.ch (localhost [127.0.0.1])
	by mx1.2b3w.ch (Postfix) with ESMTP id A0C36C3445;
	Tue, 10 Nov 2015 20:39:45 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on dilbert.2b3w.ch
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.3.2
Received: from mcmini.bolli (178-241-153-5.dyn.cable.fcom.ch [5.153.241.178])
	by mx1.2b3w.ch (Postfix) with ESMTPSA id 77C93C3442;
	Tue, 10 Nov 2015 20:39:45 +0100 (CET)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:38.0)
 Gecko/20100101 Thunderbird/38.3.0
In-Reply-To: <alpine.DEB.2.00.1511101040180.27599@ds9.cixit.se>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281128>

On 10.11.15 10:48, Peter Krefting wrote:
> Hi!
> 
> After upgrading Git to 2.6.3 (from 2.5.0), gitk refuses to start when
> trying to load the Swedish translation if I pass it a commit range:

The patch can be found here:

http://article.gmane.org/gmane.comp.version-control.git/278863

Cheers,
Beat
