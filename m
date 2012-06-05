From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] api-credentials.txt: add "see also" section
Date: Tue, 05 Jun 2012 10:28:53 -0700
Message-ID: <7v1ultpt0q.fsf@alter.siamese.dyndns.org>
References: <1338739804-32167-1-git-send-email-Matthieu.Moy@imag.fr>
 <1338739804-32167-4-git-send-email-Matthieu.Moy@imag.fr>
 <7vsjecvxmc.fsf@alter.siamese.dyndns.org> <vpq1ulvuxd9.fsf@bauges.imag.fr>
 <20120604115630.GC27676@sigill.intra.peff.net>
 <vpqpq9en8ol.fsf@bauges.imag.fr>
 <20120605065955.GB25809@sigill.intra.peff.net>
 <20120605073403.GC25809@sigill.intra.peff.net>
 <7v1ultrdwi.fsf@alter.siamese.dyndns.org>
 <20120605153512.GA20148@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 05 19:29:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbxYy-00014l-9Y
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 19:29:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754430Ab2FER24 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 13:28:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48845 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753663Ab2FER24 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 13:28:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AF2D68002;
	Tue,  5 Jun 2012 13:28:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=K9wlaQFFJIkFs6vgPQn3pJuhVTs=; b=fVn+ZP
	KmWmG9jnM0y9Bjig8Un3eIpb3mkx1dn/WZchn8YcI8+Rgye5NOK8Ki73EvvDINAy
	5SXbbcVPQHKpKYGDsXkautt2/a4htTQF6VHfkEg7HICKFO42efi59xm+b9xEd29g
	fUNHqyrfvcfrcJf0NmhgT+UUlHyL0EoVmBdD4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y8Ru0VngxMKsvTe6WUaej0C1I7+gJBVq
	WxSlmkYYoQYk7pezyDWdqhOQz1e/EeM0myCuMnckklmpSsNH7LPAsp2zvc2CXE29
	F5c6FlwFjpsXNo1zJ2w4beE/AesKq23VUEMC7GhiUaPRpSxbZtJIAmUTXlmS/2O1
	xrXa+ZToSHo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A755A8001;
	Tue,  5 Jun 2012 13:28:55 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3A928A000; Tue,  5 Jun 2012
 13:28:55 -0400 (EDT)
In-Reply-To: <20120605153512.GA20148@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 5 Jun 2012 11:35:12 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ED04382E-AF33-11E1-9B92-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199270>

Jeff King <peff@peff.net> writes:

> No, but it should not use linkgit to do so

Ah, of course, because linkgit is about manual pages with sections.

Thanks.
