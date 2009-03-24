From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/9] fprintf(stderr, "warning: ") -> warning() patches
Date: Tue, 24 Mar 2009 01:01:33 -0700
Message-ID: <7vr60n2vtu.fsf@gitster.siamese.dyndns.org>
References: <7v3ad5dxt5.fsf@gitster.siamese.dyndns.org>
 <cover.1237856682.git.vmiklos@frugalware.org>
 <20090324073513.GA32400@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	John Tapsell <johnflux@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 24 09:03:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lm1bQ-0005jA-NX
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 09:03:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753929AbZCXIBr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 04:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753807AbZCXIBq
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 04:01:46 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:63241 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753234AbZCXIBq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 04:01:46 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id ACE9DA4B93;
	Tue, 24 Mar 2009 04:01:43 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id BAC3BA4B90; Tue,
 24 Mar 2009 04:01:37 -0400 (EDT)
In-Reply-To: <20090324073513.GA32400@coredump.intra.peff.net> (Jeff King's
 message of "Tue, 24 Mar 2009 03:35:13 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 03B9CC8E-184A-11DE-BE4E-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114411>

Jeff King <peff@peff.net> writes:

> On Tue, Mar 24, 2009 at 02:09:08AM +0100, Miklos Vajna wrote:
>
>> Okay, here it is, applies on top of master. All, except the http-push
>> one, applies cleanly on top of next as well here.
>
> I manually scanned the patches and they all look sane to me.
> Thanks.

Thanks; I've done the same and three sets of eyeballs give me a warm fuzzy
feeling ;-)

Applied.
