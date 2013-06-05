From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: What's cooking in git.git (Jun 2013, #02; Tue, 4)
Date: Wed, 05 Jun 2013 08:59:15 +0200
Message-ID: <51AEE1C3.9020507@viscovery.net>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 05 08:59:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uk7gp-0002NE-LM
	for gcvg-git-2@plane.gmane.org; Wed, 05 Jun 2013 08:59:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752279Ab3FEG7U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jun 2013 02:59:20 -0400
Received: from so.liwest.at ([212.33.55.13]:18333 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751969Ab3FEG7U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jun 2013 02:59:20 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Uk7gi-0007v8-67; Wed, 05 Jun 2013 08:59:16 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id D5A3F1660F;
	Wed,  5 Jun 2013 08:59:15 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
In-Reply-To: <7vtxld30f2.fsf@alter.siamese.dyndns.org>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226435>

Am 6/5/2013 1:45, schrieb Junio C Hamano:
> * jk/test-exit-code-by-signal (2013-06-02) 1 commit
>   (merged to 'next' on 2013-06-03 at 25af892)
>  + t0005: test git exit code from signal death
> 
>  Will merge to 'master'.

I haven't gotten around to run this new test on Windows. I've reason to
believe that it won't pass as is. Please don't let it graduate, yet.

-- Hannes
