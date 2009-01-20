From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jan 2009, #04; Mon, 19)
Date: Mon, 19 Jan 2009 23:04:55 -0800
Message-ID: <7vfxjelap4.fsf@gitster.siamese.dyndns.org>
References: <7vbpu3r745.fsf@gitster.siamese.dyndns.org>
 <20090120044021.GE30714@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 20 08:06:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPAgy-0007Lj-Ao
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 08:06:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754231AbZATHFD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 02:05:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754189AbZATHFB
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 02:05:01 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:51423 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754133AbZATHFA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 02:05:00 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1D5D31CD89;
	Tue, 20 Jan 2009 02:05:00 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1CAE61CD8B; Tue,
 20 Jan 2009 02:04:56 -0500 (EST)
In-Reply-To: <20090120044021.GE30714@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 19 Jan 2009 23:40:21 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A7030696-E6C0-11DD-BAC9-BE78113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106449>

Jeff King <peff@peff.net> writes:

> On Mon, Jan 19, 2009 at 01:13:30AM -0800, Junio C Hamano wrote:
>
>> * jk/signal-cleanup (Sun Jan 11 06:36:49 2009 -0500) 3 commits
>>  - pager: do wait_for_pager on signal death
>>  - refactor signal handling for cleanup functions
>>  - chain kill signals for cleanup functions
>> 
>> Sorry, I lost track.  What is the status of this one?
>
> I need to clean up and re-send. The three improvements needed are:
> ...

Thanks.
