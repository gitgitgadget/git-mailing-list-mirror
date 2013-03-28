From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git help config: s/insn/instruction/
Date: Wed, 27 Mar 2013 22:59:13 -0700
Message-ID: <7vboa4jc9a.fsf@alter.siamese.dyndns.org>
References: <1364424830-17108-1-git-send-email-matthias.krueger@famsik.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, kumbayo84@arcor.de
To: Matthias =?utf-8?Q?Kr=C3=BCger?= <matthias.krueger@famsik.de>
X-From: git-owner@vger.kernel.org Thu Mar 28 07:00:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UL5sP-0003cG-GA
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 06:59:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753251Ab3C1F7W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Mar 2013 01:59:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36809 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753195Ab3C1F7Q convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Mar 2013 01:59:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BC66A7341;
	Thu, 28 Mar 2013 01:59:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ASGFcTl/ZpWM
	6KRRgDn2SKWXAVM=; b=I6aWa5B3CXwvqZC9fg5DpbekMotXe53m3ftGnNryChvA
	G556/KuPYeZdILThbCfIOfgyAJeFcNlNjQ04s2J25pZgo6xYmv2ki20f2fwV4vqk
	BTUPgXs26OwRwuVO+VhvYf1jkCY4FRO/HCovAbmIJwq02udeqKHZiYNqUD+PUgU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=wkRClw
	udKtECHOFjf1MHu7H+85Yxe9mdu1bn5x2ta/i2/FYv9IwNSEXCG2EKZwnqyjtdNE
	g37endfc+l+zgX9grwQxyanZBDnAxQ/xLUAWzgaEm/ROjO9DyYnTWumSVyCrxbm3
	3nw9aP6D+V2+FgZlCY42IcgB23fer3DGutLaE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ABF8F7340;
	Thu, 28 Mar 2013 01:59:15 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 33327733F; Thu, 28 Mar 2013
 01:59:15 -0400 (EDT)
In-Reply-To: <1364424830-17108-1-git-send-email-matthias.krueger@famsik.de>
 ("Matthias =?utf-8?Q?Kr=C3=BCger=22's?= message of "Wed, 27 Mar 2013 23:53:50
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9EDE8024-976C-11E2-93E4-CBA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219367>

Matthias Kr=C3=BCger <matthias.krueger@famsik.de> writes:

> "insn" appears to be an in-code abbreviation and should not appear in=
 manual/help pages.
> ---

Thanks; sign-off?
