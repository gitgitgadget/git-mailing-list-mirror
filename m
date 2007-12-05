From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Cosmetic git-am interactive bug
Date: Wed, 05 Dec 2007 18:58:17 -0500
Message-ID: <47573B19.40502@garzik.org>
References: <4755A836.1050408@garzik.org> <7v8x491v79.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 06 00:58:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J048Z-0002Jp-UL
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 00:58:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751658AbXLEX6X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 18:58:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751755AbXLEX6X
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 18:58:23 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:53328 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751561AbXLEX6W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 18:58:22 -0500
Received: from cpe-069-134-071-233.nc.res.rr.com ([69.134.71.233] helo=core.yyz.us)
	by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1J048C-00037z-SC; Wed, 05 Dec 2007 23:58:21 +0000
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <7v8x491v79.fsf@gitster.siamese.dyndns.org>
X-Spam-Score: -4.4 (----)
X-Spam-Report: SpamAssassin version 3.1.9 on srv5.dvmed.net summary:
	Content analysis details:   (-4.4 points, 5.0 required)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67213>

Junio C Hamano wrote:
> Jeff Garzik <jeff@garzik.org> writes:
> 
>> The use of the older one-line summary led me to believe that it had
>> not committed my changelog edits.  Looking at the result, however,
>> proved that the commit changelog was my new, corrected version.
> 
> I knew about this for quite some time but it was a very low priority for
> me.  This should fix it.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Thanks!  :)
