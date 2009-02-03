From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] t3411: Fix test 1 for case-insensitive file systems
Date: Tue, 3 Feb 2009 14:12:47 -0500
Message-ID: <DB993E35-9F82-4451-B681-D1BFE3E9BD45@silverinsanity.com>
References: <1233244816-67565-1-git-send-email-benji@silverinsanity.com> <7vocxqf2sf.fsf@gitster.siamese.dyndns.org> <673CE949-5DF9-4970-A739-AA09FCD26D24@silverinsanity.com> <1E104E1B-BFCC-4CFC-9D53-CE89299C9600@silverinsanity.com> <alpine.DEB.1.00.0902031752230.6573@intel-tinevez-2-302> <2D4586A6-ADAC-4B6E-8B42-2CBD76E0304C@silverinsanity.com> <alpine.DEB.1.00.0902031817260.6573@intel-tinevez-2-302> <5FE034E8-422F-4692-AD37-5633C91A4B98@silverinsanity.com> <alpine.DEB.1.00.0902031918520.9822@pacific.mpi-cbg.de> <34FE2049-0A81-4615-AE3D-46DE35A44011@silverinsanity.com> <7vy6wn9wdj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 03 20:14:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUQiu-0004Gm-8E
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 20:14:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752057AbZBCTMw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 14:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751932AbZBCTMv
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 14:12:51 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:59952 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751234AbZBCTMu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 14:12:50 -0500
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 6B3021FFC27F; Tue,  3 Feb 2009 19:12:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb3 (2006-10-05) on 
	silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=4.0 tests=AWL,BAYES_00 autolearn=ham 
	version=3.1.7-deb3
Received: from [192.168.5.44] (nmd.sbx07360.rocheny.wayport.net [98.98.50.102])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 807E21FFC271;
	Tue,  3 Feb 2009 19:12:43 +0000 (UTC)
In-Reply-To: <7vy6wn9wdj.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108242>


On Feb 3, 2009, at 2:02 PM, Junio C Hamano wrote:

> Brian Gernhardt <benji@silverinsanity.com> writes:
>
>> I was irritated by your statement that I "did not look far" because  
>> _I
>> read all those files_.  I gave you the result of reading them which
>> you seem to have completely ignored, as it was the part of my last e-
>> mail that you did not quote.
>>
>> If you want to double-check me, fine.  But do not claim I did not do
>> the work.
>
> Thanks, both, and let's not be unnecessarily un-nice to each other.
>
> I agree that Dscho's "far enough" comment was not the best way to  
> say "I
> really want to make sure you did verify the way I would myself", but
> please just let it pass, pretend that he just expressed frustration  
> on his
> lack of time to do the verification himself with that comment.  Ok?

Fair enough.  My own word choice wasn't exactly wise, either.  This  
has been an especially frustrating day for me in many other respects  
and it's affected my commentary here.

Dscho, my apologies.

~~ Brian
