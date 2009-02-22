From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] Add more tests of cvsimport
Date: Sun, 22 Feb 2009 08:49:04 -0800
Message-ID: <7vbpsu2z9b.fsf@gitster.siamese.dyndns.org>
References: <1235107093-32605-1-git-send-email-mhagger@alum.mit.edu>
 <56112.77.61.241.211.1235118428.squirrel@hupie.xs4all.nl>
 <499FFC1C.5080801@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>,
	git@vger.kernel.org, peff@peff.net,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Feb 22 17:50:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbHXM-0004ky-DW
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 17:50:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754066AbZBVQtO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Feb 2009 11:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754049AbZBVQtO
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 11:49:14 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:57878 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754059AbZBVQtN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Feb 2009 11:49:13 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CE8709CAD1;
	Sun, 22 Feb 2009 11:49:12 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 280D09CACE; Sun,
 22 Feb 2009 11:49:05 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BBB07E16-0100-11DE-BAEE-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111015>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Ferry Huberts (Pelagic) wrote:
>> I'm actually working on coming up with a patch for a bug I hit that
>> has to to do with safecrlf=true. Maybe now I should coordinate with you?
>
> I am only adding some tests of "git cvsimport"; I definitely don't plan
> to become a "git cvsimport" hacker.  But we can certainly work together
> on the test infrastructure if it will help you.

Thanks, both.  I generally am not very fond of adding tests without
intention to look into fixes, but if they make outstanding bugs more
visible, they may have the effect of shaming the original authors badly
enough to step in in the effort of fixing them ;-)
