From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [RFC] Clean way to disable pager
Date: Sun, 19 Aug 2007 14:24:07 -0400
Message-ID: <819D2F58-960A-4DA4-8FAC-7DE69A78F971@silverinsanity.com>
References: <vpq1wdz307k.fsf@bauges.imag.fr>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sun Aug 19 20:24:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IMpS7-0001tl-14
	for gcvg-git@gmane.org; Sun, 19 Aug 2007 20:24:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751517AbXHSSYL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Aug 2007 14:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752249AbXHSSYK
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Aug 2007 14:24:10 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:50016 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991AbXHSSYJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Aug 2007 14:24:09 -0400
Received: from [192.168.1.2] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 8CADB1FFC231;
	Sun, 19 Aug 2007 18:24:07 +0000 (UTC)
In-Reply-To: <vpq1wdz307k.fsf@bauges.imag.fr>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56135>


On Aug 19, 2007, at 1:26 PM, Matthieu Moy wrote:

> I think that deserves an less-hacky, and documented way. I'd suggest a
> --no-pager, or --dont-paginate, that would do the opposite of -p as a
> global option for git.

ACK.  I was going to write this pretty soon myself.

~~ Brian
