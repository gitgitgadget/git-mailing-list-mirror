From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] git-revert is one of the most misunderstood command in
 git, help users out.
Date: Tue, 06 Nov 2007 12:51:18 +0100
Message-ID: <47305536.5010308@viscovery.net>
References: <1194289301-7800-1-git-send-email-madcoder@debian.org>	<CD2E6759-9E7E-41E6-8B58-AB6CA9604111@midwinter.com>	<7vlk9cmiyq.fsf@gitster.siamese.dyndns.org>	<Pine.LNX.4.64.0711052325090.4362@racer.site>	<7vsl3kjdct.fsf@gitster.siamese.dyndns.org> <7vk5oviqbe.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Steven Grimm <koreth@midwinter.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 12:51:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpMy6-0005BY-5P
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 12:51:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755187AbXKFLvZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 06:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755711AbXKFLvZ
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 06:51:25 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:46136 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755187AbXKFLvY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 06:51:24 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IpMxI-0006gw-4s; Tue, 06 Nov 2007 12:50:52 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 95EC154D; Tue,  6 Nov 2007 12:51:18 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7vk5oviqbe.fsf@gitster.siamese.dyndns.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63662>

Junio C Hamano schrieb:
> I am wondering what "git cherry-pick -- <paths>" should do.  My
> current thinking is that it would not make any sense at all.

IMO, at least "git cherry-pick -n -- <paths>" makes tons of sense.

-- Hannes
