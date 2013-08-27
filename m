From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git v1.8.4
Date: Mon, 26 Aug 2013 20:42:19 -0700
Message-ID: <xmqq38pviyuc.fsf@gitster.dls.corp.google.com>
References: <xmqqfvu0nkim.fsf@gitster.dls.corp.google.com>
	<alpine.LFD.2.03.1308232242180.14472@syhkavp.arg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Aug 27 05:42:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEAAm-0003MY-DE
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 05:42:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752911Ab3H0DmX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 23:42:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50628 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752683Ab3H0DmW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 23:42:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DAAAF36E3B;
	Tue, 27 Aug 2013 03:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4n9T986w3E7ZKv4X2SCeLWQJOqk=; b=DBMYhs
	YvFoa8+VCqHUCp53Y52v9CXBxc1rzU5FrxHZJSvkotR+NTleZORCMIHpi+FNeEz8
	GdDUicMJW8b8/UFr8p9hjwYhlISKnaEdNlpD8vn/ZvaakhD9zGaYppJ/j6kLo4m0
	/jbH+OIAfxRi4hleIWYdEmJ5lAPXErGWx/6jA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BP76abY7BBkRDepEAoRL9D7rPlhtEOl5
	FKbho+P/RDOika6ToDMrj5UCsib5cONrj/e5ZoIAk39JpXHOHahTYjemL1NTzzOM
	VMfAaJKKn6qGyKyY2Ft7WOK5yQLzq3RbOtEd1ThBb0sTejS/nPsbCXJSJUQAP9rc
	5bB02bHl0Qs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CCF2936E3A;
	Tue, 27 Aug 2013 03:42:21 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 31CF736E37;
	Tue, 27 Aug 2013 03:42:21 +0000 (UTC)
In-Reply-To: <alpine.LFD.2.03.1308232242180.14472@syhkavp.arg> (Nicolas
	Pitre's message of "Mon, 26 Aug 2013 20:06:37 -0400 (EDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: ADBA93BE-0ECA-11E3-AC8F-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233043>

Nicolas Pitre <nico@fluxnic.net> writes:

> On Fri, 23 Aug 2013, Junio C Hamano wrote:
>
>> The latest feature release Git v1.8.4 is now available at the usual
>> places.  It contains 870+ changes from ~100 contributors (among
>> which 33 people are new) since v1.8.3.
>> 
>> We will have two more releases til the end of this year; the release
>> after that could be Git 2.0.
>
> May I land a big teaser for a possible Git 2.0 feature?

;-)

It is not even any remotely controversial feature that has to wait
until 2.0 boundary to potentially break established usage aka
inertia.

Happy.
