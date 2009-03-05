From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2009, #02; Thu, 05)
Date: Thu, 05 Mar 2009 02:22:29 -0800
Message-ID: <7vzlg01d7e.fsf@gitster.siamese.dyndns.org>
References: <7vbpsg2sgx.fsf@gitster.siamese.dyndns.org>
 <20090305191221.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Thu Mar 05 11:24:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfAkF-0003eb-7J
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 11:24:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754028AbZCEKWg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 05:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752949AbZCEKWf
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 05:22:35 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36628 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752600AbZCEKWf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 05:22:35 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 8E2BF3B2F;
	Thu,  5 Mar 2009 05:22:33 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0FF103B2E; Thu, 
 5 Mar 2009 05:22:30 -0500 (EST)
In-Reply-To: <20090305191221.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Thu, 05 Mar 2009 19:12:21 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8A67277A-096F-11DE-B1AB-CBE7E3B37BAC-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112288>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Quoting Junio C Hamano <gitster@pobox.com>:
>
>> * jk/sane-relative-time (Tue Feb 24 00:42:16 2009 -0500) 1 commit
>>  + never fallback relative times to absolute
>>
>> I think I sent out a "here is how" patch for something related to
>> --date=<format> option that may be related to this topic; I seem to have
>> lost it.
>
> Do you mean this one?
>
> 	http://article.gmane.org/gmane.comp.version-control.git/112033

Yup, that's the one.  Thanks.
