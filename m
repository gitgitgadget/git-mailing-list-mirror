From: Junio C Hamano <gitster@pobox.com>
Subject: Re: gitk: Turn short SHA1 names into links too
Date: Tue, 21 Oct 2008 12:09:00 -0700
Message-ID: <7vzlkxyddf.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.1.10.0809251657080.3265@nehalem.linux-foundation.org>
 <18685.4652.287143.717452@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Oct 21 21:10:41 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsMcg-0001vU-3O
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 21:10:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751548AbYJUTJR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2008 15:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbYJUTJR
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Oct 2008 15:09:17 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:65192 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750746AbYJUTJQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2008 15:09:16 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5E3BE725E1;
	Tue, 21 Oct 2008 15:09:14 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 4C59B725E0; Tue, 21 Oct 2008 15:09:08 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C02E00DA-9FA3-11DD-B94A-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98804>

Paul Mackerras <paulus@samba.org> writes:

> Linus Torvalds writes:
>
>> And the thing I wanted to work was to have the abbreviated SHA1's that 
>> have started to get more common in the kernel commit logs work as links in 
>> gitk too, just the way a full 40-character SHA1 link works.
>
> I just pushed out a commit to gitk that makes this work, and fixes the
> other bugs you mentioned.

FWIW, pulled and pushed out.  Thanks.
