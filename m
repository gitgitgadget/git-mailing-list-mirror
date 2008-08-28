From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: What's cooking in git.git (Aug 2008, #08; Wed, 27)
Date: Thu, 28 Aug 2008 13:07:49 +0200
Message-ID: <48B68705.5050606@viscovery.net>
References: <7v3akpkfwf.fsf@gitster.siamese.dyndns.org> <48B650F4.3090404@viscovery.net> <20080828105646.GA12494@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Thu Aug 28 13:09:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYfNA-0007vF-4R
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 13:09:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752144AbYH1LHy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 07:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752135AbYH1LHy
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 07:07:54 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:44374 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752118AbYH1LHx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 07:07:53 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KYfLy-0002Iq-3J; Thu, 28 Aug 2008 13:07:50 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id CE0AD69F; Thu, 28 Aug 2008 13:07:49 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20080828105646.GA12494@cuci.nl>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 3.0 (+++)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5, INFO_TLD=1.273
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stephen R. van den Berg schrieb:
> Johannes Sixt wrote:
>> I have a repo to split that *requires* this. But I failed to complete the
>> task because there's a problem with rev-list --parents --full-history
>> --reverse that lists a commit without parent where there should be a
>> parent (it lists it correctly if --reverse is dropped). A test repository
>> is available in this messaged:
> 
>> http://thread.gmane.org/gmane.comp.version-control.git/93171
> 
> Not Found
> 
> The requested URL //gmane/comp/version-control/git/93171-001.bin was not
> found on this server.

Here is an alternate location:

 http://marc.info/?l=git&m=121933614321872

 Message-ID: <48AD9786.80707@viscovery.net>

-- Hannes
