From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: What's cooking in git.git (Jun 2010, #04; Wed, 23)
Date: Fri, 25 Jun 2010 04:27:09 +0200
Message-ID: <201006250427.10060.chriscool@tuxfamily.org>
References: <7viq59e6zn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 25 04:27:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORyda-00083s-TS
	for gcvg-git-2@lo.gmane.org; Fri, 25 Jun 2010 04:27:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754676Ab0FYC1S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jun 2010 22:27:18 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:45235 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754284Ab0FYC1S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 22:27:18 -0400
Received: from style.localnet (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 8CC49818044;
	Fri, 25 Jun 2010 04:27:11 +0200 (CEST)
User-Agent: KMail/1.13.2 (Linux/2.6.32-22-generic; KDE/4.4.2; x86_64; ; )
In-Reply-To: <7viq59e6zn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149664>

On Thursday 24 June 2010 00:09:32 Junio C Hamano wrote:
> 
> * cc/cherry-pick-stdin (2010-06-14) 3 commits
>  - revert: do not rebuild argv on heap
>  - revert: accept arbitrary rev-list options
>  - t3508 (cherry-pick): futureproof against unmerged files
> 
> What's the doneness of this one?

With the documentation fix I just posted, I think it is finished.

Thanks,
Christian.
