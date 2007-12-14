From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Authentication support for pserver
Date: Fri, 14 Dec 2007 00:13:47 -0800
Message-ID: <7vir31u210.fsf@gitster.siamese.dyndns.org>
References: <87wsrhex4c.fsf@cpan.org>
	<7vd4t9x2lw.fsf@gitster.siamese.dyndns.org> <87mysdepeh.fsf@cpan.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, martyn@catalyst.net.nz, martin@catalyst.net.nz
To: avar@cpan.org (=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason)
X-From: git-owner@vger.kernel.org Fri Dec 14 09:15:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J35i2-0002Fj-66
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 09:15:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756418AbXLNIOG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Dec 2007 03:14:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757704AbXLNIOF
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 03:14:05 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34477 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755523AbXLNIOE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Dec 2007 03:14:04 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B664E7FA4;
	Fri, 14 Dec 2007 03:13:54 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 368397FA3;
	Fri, 14 Dec 2007 03:13:50 -0500 (EST)
In-Reply-To: <87mysdepeh.fsf@cpan.org> (=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?=
 Bjarmason's message of
	"Fri, 14 Dec 2007 06:55:34 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68261>

avar@cpan.org (=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason) writes:

> diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvss=
erver.txt
> index 258a62f..5ca84fc 100644
> --- a/Documentation/git-cvsserver.txt
> +++ b/Documentation/git-cvsserver.txt

Looks good.  I'll queue only so that I won't lose it and wait for Acks
from Mart[iy]ns.  Please sign off your patch.

Thanks.
