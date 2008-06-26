From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Ship sample hooks with .sample suffix
Date: Thu, 26 Jun 2008 09:19:20 +0200
Message-ID: <486342F8.2060406@viscovery.net>
References: <53A5AFCF-94C7-465E-A181-1DA69F251F5B@gmail.com> <alpine.LFD.1.10.0806241418360.32759@sys-0.hiltweb.site> <39C2861E-F800-40AE-8C15-4FC3BB51EF16@gmail.com> <7v3an2bh3b.fsf@gitster.siamese.dyndns.org> <930163B6-4A7E-49C7-B9D5-F7B37699C2A9@gmail.com> <7v4p7i9ygd.fsf@gitster.siamese.dyndns.org> <7vtzfi8dvk.fsf_-_@gitster.siamese.dyndns.org> <7vod5q8c25.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 09:20:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBlmF-00040t-U7
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 09:20:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755975AbYFZHTZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 03:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752114AbYFZHTZ
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 03:19:25 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:38472 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755956AbYFZHTY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 03:19:24 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KBllI-0007U1-Mb; Thu, 26 Jun 2008 09:19:20 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 5F3CC4FB; Thu, 26 Jun 2008 09:19:20 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7vod5q8c25.fsf@gitster.siamese.dyndns.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86407>

Junio C Hamano schrieb:
> I'll queue the patch to 'master' and I suspect that this will make 31d6632
> (Windows: Change the name of hook scripts to make them not executable.,
> 2007-11-30) unnecessary.

I've updated

git://repo.or.cz/git/mingw/j6t.git for-junio

and the interdiff to the previous version is merely the reverse of
31d6632. For your convenience I've merged it into current next:

git://repo.or.cz/git/mingw/j6t.git merge-mingw-into-next

-- Hannes
