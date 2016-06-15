From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git vc-git.el versus Emacs vc-git.el versus Gits git.el
Date: Tue, 03 Feb 2009 09:46:14 -0800
Message-ID: <7v63jrbehl.fsf@gitster.siamese.dyndns.org>
References: <18823.47791.359047.560149@hungover.brentg.com>
 <87ab93yfjx.fsf@wine.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brent Goodrick <bgoodr@gmail.com>, git@vger.kernel.org
To: Alexandre Julliard <julliard@winehq.org>
X-From: git-owner@vger.kernel.org Tue Feb 03 18:48:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUPNL-0003EK-Lf
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 18:47:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753325AbZBCRq0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 12:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753154AbZBCRqZ
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 12:46:25 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56852 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753070AbZBCRqY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 12:46:24 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 4D5012A5C8;
	Tue,  3 Feb 2009 12:46:21 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 86A6C2A5C2; Tue, 
 3 Feb 2009 12:46:16 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 915F82E6-F21A-11DD-A232-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108227>

Alexandre Julliard <julliard@winehq.org> writes:

>>  2. There is a vc-git.el in the Emacs top-of-trunk sources, and
>>     another one in the git/contrib/emacs directory in the Git
>>     sources. Which one should I use?  If I should use the one in
>>     Emacs, then why is there one in the Git source tree?
>
> The most recent one is the one in the Emacs trunk, so you should use
> this if possible. The one in the Git tree is an older version that's no
> longer maintained, though it can still be useful if you are running an
> old Emacs version.

A patch to add contrib/emacs/README to hold this info would be nice.
