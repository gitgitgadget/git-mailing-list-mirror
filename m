From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [bug?] checkout -m doesn't work without a base version
Date: Fri, 16 Dec 2011 22:38:21 +0000
Message-ID: <4EEBC85D.2040901@ramsay1.demon.co.uk>
References: <4EDBF4D5.6030908@pcharlan.com> <7vbormn8vk.fsf@alter.siamese.dyndns.org> <4EE8782A.9040507@elegosoft.com> <7vhb13qbs6.fsf@alter.siamese.dyndns.org> <m2vcpiw1z1.fsf@igel.home> <7v4nx1pwjg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Michael Schubert <mschub@elegosoft.com>,
	Pete Harlan <pgit@pcharlan.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 16 23:58:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rbgja-0001jg-FN
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 23:58:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760923Ab1LPW6a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Dec 2011 17:58:30 -0500
Received: from lon1-post-2.mail.demon.net ([195.173.77.149]:54134 "EHLO
	lon1-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760864Ab1LPW63 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Dec 2011 17:58:29 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1RbgjT-00064f-cL; Fri, 16 Dec 2011 22:58:28 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <7v4nx1pwjg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187330>

Junio C Hamano wrote:
> You could do the usual "unnecessary initialization" trick, though.

Yes, I wrote exactly this patch some days ago (when it first appeared
in pu), but haven't found the time to send it ... :-D

ATB,
Ramsay Jones
