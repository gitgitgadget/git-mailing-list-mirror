From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gittutorial: Add global color.ui
Date: Mon, 13 Apr 2009 00:29:01 -0700
Message-ID: <7vbpr1hv0i.fsf@gitster.siamese.dyndns.org>
References: <20090410141622.10e40448@paolo-desktop>
 <4d8e3fd30904130003m78dc7a81pf91ed6772b5c4f93@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 13 09:30:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtGcr-00028O-QE
	for gcvg-git-2@gmane.org; Mon, 13 Apr 2009 09:30:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753003AbZDMH3K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Apr 2009 03:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752923AbZDMH3I
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 03:29:08 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49240 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752297AbZDMH3I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2009 03:29:08 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E5C2DE02C;
	Mon, 13 Apr 2009 03:29:05 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 5C8ADE02A; Mon,
 13 Apr 2009 03:29:03 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C510490A-27FC-11DE-922A-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116415>

Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> writes:

> Should I just wait or does it means that is not considered usefull?

I didn't find it useful myself.  Even though it is not the final word
around here, I didn't see anybody else agreeing that having color.ui at
the begining would improve the tutorial.

Many other things are probably as useful to have as color.ui there, if not
more, and we obviously do not want to list all the things some random
person found useful and extend the initial part of the tutorial to 100
pages before showing how to create the very first repository to a new
person.

So you have to do much better than just saying that you like color.ui.
You need to justify that it should trump all the other potentially useful
configurations and added there.
