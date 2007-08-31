From: Junio C Hamano <gitster@pobox.com>
Subject: Re: CVS-$Id:$ replacement in git?
Date: Fri, 31 Aug 2007 11:45:02 -0700
Message-ID: <7v4pif1r2p.fsf@gitster.siamese.dyndns.org>
References: <46D82DC3.2030203@bioinf.uni-sb.de>
	<Pine.LNX.4.64.0708311732580.28586@racer.site>
	<7v8x7r1wyy.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0708311812000.28586@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Hildebrandt <anhi@bioinf.uni-sb.de>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 31 20:45:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRBUc-00025V-Cv
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 20:45:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965914AbXHaSpO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 14:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965906AbXHaSpO
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 14:45:14 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:41432 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965847AbXHaSpN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 14:45:13 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 7EA2312BC52;
	Fri, 31 Aug 2007 14:45:31 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0708311812000.28586@racer.site> (Johannes
	Schindelin's message of "Fri, 31 Aug 2007 18:12:33 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57193>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Fri, 31 Aug 2007, Junio C Hamano wrote:
> ...
>> Please do _not_ see that.  ident is about blob object name and
>> does not have anything to do with the commit, pathname,
>> committer, nor date, and this is deliberately so.
>
> But this is what I was suggesting...  To change the ways for the better.  

The thing is that it is not "for the better".  See earlier
discussion and please do not beat the dead horse.
