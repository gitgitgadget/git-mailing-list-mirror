From: Andreas Ericsson <ae@op5.se>
Subject: Re: git-patches list?
Date: Tue, 13 Jan 2009 09:26:18 +0100
Message-ID: <496C502A.3070908@op5.se>
References: <90bb445a0901121543q29d30d49yaa723b4b913a4b31@mail.gmail.com> <7vr638f5ch.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Akira Kitada <akitada@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 09:27:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMecv-0008MH-Pr
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 09:27:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755913AbZAMI0X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 03:26:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755655AbZAMI0X
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 03:26:23 -0500
Received: from mail.op5.se ([193.201.96.20]:51355 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753754AbZAMI0W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 03:26:22 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id BB2D11B81863;
	Tue, 13 Jan 2009 09:27:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lLtZBzQDMR9q; Tue, 13 Jan 2009 09:27:17 +0100 (CET)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id AA5471B81512;
	Tue, 13 Jan 2009 09:27:17 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <7vr638f5ch.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105472>

Junio C Hamano wrote:
> Akira Kitada <akitada@gmail.com> writes:
> 
>> Can I propose having another mailing list for posting patches to avoid
>> daily mail flood to this list?
>>
>> Yes, I can filter out the emails but still...
> 
> This list has always been the only place where git development happens.
> It would make the development very awkward to set up another list only for
> patches, forbid patches to be sent to anywhere but that new list, but
> still discuss the patches on this list.
> 
> It does not make much sense to me.
> 

I agree.

If any new list is to be introduced, it would only make sense to make it
a read-only "what's new" list, for the various people that want to know
what might break/be fixed in new versions but really don't care about the
discussion that lead to that decision.

Is that what you were after, Akira?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
