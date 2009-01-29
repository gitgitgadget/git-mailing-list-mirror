From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jan 2009, #07; Wed, 28)
Date: Thu, 29 Jan 2009 00:26:39 -0800
Message-ID: <7vbptqh60w.fsf@gitster.siamese.dyndns.org>
References: <7vwscej26i.fsf@gitster.siamese.dyndns.org>
 <20090129081438.GA10490@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Thu Jan 29 09:28:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSSG4-0001PN-9B
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 09:28:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752611AbZA2I0u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 03:26:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752417AbZA2I0t
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 03:26:49 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:37346 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752269AbZA2I0t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 03:26:49 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 0E6341D85E;
	Thu, 29 Jan 2009 03:26:46 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 757FD1D85C; Thu,
 29 Jan 2009 03:26:41 -0500 (EST)
In-Reply-To: <20090129081438.GA10490@hashpling.org> (Charles Bailey's message
 of "Thu, 29 Jan 2009 08:14:38 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 90E57FE0-EDDE-11DD-A2AB-F63E8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107645>

Charles Bailey <charles@hashpling.org> writes:

> On Wed, Jan 28, 2009 at 06:06:45PM -0800, Junio C Hamano wrote:
>> * cb/mergetool (Wed Jan 21 22:57:48 2009 +0000) 1 commit
>>  + mergetool: respect autocrlf by using checkout-index
>> 
>
> Can you hold off on merging this one? I now think that there's a
> cleaner way of doing this and I would like the opportunity for a
> rethink.

Sure, it is not in 'master' yet.

But it's in 'next', so incremental updates from now on, please.
