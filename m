From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Survey] Signed push
Date: Tue, 13 Sep 2011 16:50:55 -0700
Message-ID: <7v1uvkvw68.fsf@alter.siamese.dyndns.org>
References: <7vaaa8xufi.fsf@alter.siamese.dyndns.org>
 <20110913232640.GA4189@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Guenter Roeck <guenter.roeck@ericsson.com>
X-From: git-owner@vger.kernel.org Wed Sep 14 01:51:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3cky-0005HU-JM
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 01:51:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933099Ab1IMXu6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Sep 2011 19:50:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43097 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933075Ab1IMXu6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Sep 2011 19:50:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CDF0B52E6;
	Tue, 13 Sep 2011 19:50:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fIltHg9sQNOWLaCE/ZbpUZq5Y9c=; b=U4/j6u
	hSu0bn+42DnGK6ncolb8/q8Y+l40mzgtGda9kAHXo/fqGAK6osI3ihnogbCM8Z8+
	mH/bLZ3jwXzldDycBWAXyEv3MQ+lKC/mdI3aRUWDTniaDAGMGnWes0ug2bcUR3Rd
	cM26QrBtVjwLRQ6gLxGkzRRD9EmNZ0+RdGqGc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kVcNrOzaS4b/p9kxGcZD9eit4ex+0l7m
	d/ZoHqIUaz7Xvs4n8iGq1sWWhOYMLCuw2hCGBRTMHPxwUJLYU/U2Q3hBhay9kew2
	iLPuNvQlQaA1OQYE1p0RQDrCZ5FPc03ukHZEM1gm+oisQEKlao6VUveHHTY51iIa
	2EDLtSnpK+Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C5CE552E5;
	Tue, 13 Sep 2011 19:50:57 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5AE6652E4; Tue, 13 Sep 2011
 19:50:57 -0400 (EDT)
In-Reply-To: <20110913232640.GA4189@ericsson.com> (Guenter Roeck's message of
 "Tue, 13 Sep 2011 16:26:40 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 39CAAEEC-DE63-11E0-A79E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181329>

Guenter Roeck <guenter.roeck@ericsson.com> writes:

> On Tue, Sep 13, 2011 at 12:45:37PM -0400, Junio C Hamano wrote:
> [ ... ]
>
>> 1. Improved pull requests.
>> 
> noise for me

Are you among the ones who respond to pull requests?
