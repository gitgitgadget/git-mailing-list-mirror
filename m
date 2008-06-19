From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Authentication support for pserver
Date: Thu, 19 Jun 2008 13:14:35 -0700
Message-ID: <7v3an9tc5w.fsf@gitster.siamese.dyndns.org>
References: <87wsrhex4c.fsf@cpan.org>
 <7vd4t9x2lw.fsf@gitster.siamese.dyndns.org> <87mysdepeh.fsf@cpan.org>
 <7vir31u210.fsf@gitster.siamese.dyndns.org> <877ijhm1b5.fsf@cpan.org>
 <46a038f90712180141x2f27e6cei5ef53339fd3f90dc@mail.gmail.com>
 <86r6ens6k5.fsf@cpan.org> <86iqzyse9u.fsf@cpan.org> <861w2tjpev.fsf@cpan.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Martin Langhoff" <martin.langhoff@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	martyn@catalyst.net.nz, martin@catalyst.net.nz
To: avar@cpan.org (=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason)
X-From: git-owner@vger.kernel.org Thu Jun 19 22:16:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9QYB-0000UG-Dk
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 22:16:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbYFSUPK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Jun 2008 16:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbYFSUPK
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 16:15:10 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55367 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823AbYFSUPJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jun 2008 16:15:09 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AF9DF1B09F;
	Thu, 19 Jun 2008 16:14:52 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 348341B097; Thu, 19 Jun 2008 16:14:38 -0400 (EDT)
In-Reply-To: <861w2tjpev.fsf@cpan.org> (=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?=
 Bjarmason's message of "Thu, 19 Jun 2008 17:38:32 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6056E398-3E3C-11DD-8EEB-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85521>

avar@cpan.org (=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason) writes:

> ...
> It has been over 3 months since I submitted this patch without anyone
> acting on it. In absence of comment from the Mart[yi]ns could this
> please applied anyway?

Can you send a patch that can be applied (cf. Documentation/SubmittingP=
atches)?
