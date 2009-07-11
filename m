From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH FYI 0/5] How I compile on IRIX 6.5 with the MIPSpro
 compiler and ksh
Date: Fri, 10 Jul 2009 23:44:54 -0700
Message-ID: <7v4otjoh09.fsf@alter.siamese.dyndns.org>
References: <39niBtmtFs5Sy_fjtaztVh4dAZGS3bCbUWv-xJglfvb9KPJ_qQhUB4GiCpcoxguAgbDPS36AjnI@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Sat Jul 11 08:45:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPWKq-0005rK-SH
	for gcvg-git-2@gmane.org; Sat, 11 Jul 2009 08:45:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbZGKGpC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jul 2009 02:45:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751506AbZGKGpB
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Jul 2009 02:45:01 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38774 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751403AbZGKGpA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jul 2009 02:45:00 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 561CB268D2;
	Sat, 11 Jul 2009 02:44:59 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A8B78268D0; Sat,
 11 Jul 2009 02:44:55 -0400 (EDT)
In-Reply-To: <39niBtmtFs5Sy_fjtaztVh4dAZGS3bCbUWv-xJglfvb9KPJ_qQhUB4GiCpcoxguAgbDPS36AjnI@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Fri\, 10 Jul 2009 12\:10\:42 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5A597EE4-6DE6-11DE-9D5C-424D1A496417-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123101>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> Otherwise, I've been using this executable somewhat and have not experienced
> any problems.  Maybe it will be useful to others.
>
> Are there actually any IRIX users out there?

I thought at some point Dscho was suffering from IRIX but perhaps he got
out of it?

> These patches are all submitted For-Your-Information only.  Junio, feel free
> to apply any of them or none, and to add my Signed-off-by.

Except for 5/5 all of them looked trivially safe and none of them looked
iffy.  Will queue, possibly with minor tweaks.
