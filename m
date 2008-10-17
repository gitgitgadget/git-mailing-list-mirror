From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's in git.git (Oct 2008, #03; Tue, 14)
Date: Fri, 17 Oct 2008 16:58:01 -0700
Message-ID: <7vmyh2g4fq.fsf@gitster.siamese.dyndns.org>
References: <7vej2i7rt9.fsf@gitster.siamese.dyndns.org>
 <20081017095357.GA5563@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Oct 18 01:59:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqzEG-0003HF-Fk
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 01:59:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754857AbYJQX6O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Oct 2008 19:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754809AbYJQX6N
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Oct 2008 19:58:13 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64132 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754142AbYJQX6M (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Oct 2008 19:58:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 9A5BB8B68A;
	Fri, 17 Oct 2008 19:58:07 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id DA8848B688; Fri, 17 Oct 2008 19:58:03 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 71EF3E06-9CA7-11DD-907C-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98502>

Jeff King <peff@peff.net> writes:

> On Tue, Oct 14, 2008 at 03:08:50PM -0700, Junio C Hamano wrote:
>
>> * The 'master' branch has these since the last announcement
>>   in addition to the above.
>> 
>> Jeff King (1):
>>   tests: shell negation portability fix
>
> Can you cherry-pick this into maint? The problem it fixes was caused by
> 969c877, which is in maint (IOW, master is fixed, but maint is still
> broken).

Thanks, will do.
