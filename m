From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Snipping on this list
Date: Mon, 28 Feb 2011 10:18:39 -0800
Message-ID: <7vtyfohvk0.fsf@alter.siamese.dyndns.org>
References: <cover.1298821535.git.git@drmicha.warpmail.net>
 <4D68D630.9000608@drmicha.warpmail.net>
 <711e34a5f4761ccd1056a992df21e3389db7add7.1298821535.git.git@drmicha.warpmail.net> <AANLkTintuaM+p7XKmTy+hOa80nkbph7MP00cvEA+oHZJ@mail.gmail.com> <7v39n8ll0s.fsf@alter.siamese.dyndns.org> <4D6B5D09.8010806@drmicha.warpmail.net> <buomxlg35zq.fsf@dhlpc061.dev.necel.com> <4D6B6101.9090504@drmicha.warpmail.net> <buohbbo35g8.fsf@dhlpc061.dev.necel.com> <4D6B6544.2040404@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miles Bader <miles@gnu.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Feb 28 19:18:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pu7gQ-0000VI-9X
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 19:18:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753083Ab1B1SSx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 13:18:53 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39657 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377Ab1B1SSx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 13:18:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 56AA14CD3;
	Mon, 28 Feb 2011 13:20:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aYjzVGLKgmXrYxzl4ZW1gwkK+4U=; b=IPDEm6
	Lvut/0XAVfuV4zjO1YkBNhMQuYCOOrKEMWiBLIU8hEADURW97qkoOWU/n7OKy0XW
	Ttfrj2AFb6u+DK338XpAxjPMz3eNTfOiIfAwlYo3DEOvBMWmPhP7SUsMtMeLW+Is
	p6mIASdWtgcMMuzWv8R+jDvyTZ/2pMv2na5QI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Wc/5tm51w3tlrRxMMGUcTWBvYC6pQ8bU
	9a02rF5TvX08roTHvJGUnj2GhI7pAqvOD6ebwfN0u30rDMR5HH9fV7bHzUsYW3bt
	KndGGSbJK936xpMwHQt2bkgcduuiecWE1JXf1DOdHIKER5z16Y6QZHQmm6qWY0qi
	pZbGrC6OaA8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F06E94CD0;
	Mon, 28 Feb 2011 13:20:05 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6ADEB4CCF; Mon, 28 Feb 2011
 13:19:59 -0500 (EST)
In-Reply-To: <4D6B6544.2040404@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Mon\, 28 Feb 2011 10\:05\:08 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5E088E92-4367-11E0-8117-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168129>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> As a general guideline, a reader should be able to understand the
> response without looking up the post you are responding to (but may have

A reader should be able to remember which original the response is about,
so that s/he can look it up if s/he doesn't.  If in doubt, I'd rather see
people discard irrelevent bits more not less.

> And don't cull cc, don't break the thread. (You haven don't that here, I
> do appreciate that, thanks!).

That is true.
