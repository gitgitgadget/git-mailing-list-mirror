From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] contrib/examples/README: warn of obsolescence
Date: Mon, 12 Jan 2009 17:05:44 -0800
Message-ID: <7viqokf21j.fsf@gitster.siamese.dyndns.org>
References: <87fxjoowyp.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Tue Jan 13 02:07:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMXkZ-0004SY-4Y
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 02:07:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757453AbZAMBFz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 20:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757424AbZAMBFz
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 20:05:55 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58472 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757367AbZAMBFy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 20:05:54 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6C74B903A4;
	Mon, 12 Jan 2009 20:05:53 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 0B42E903A3; Mon,
 12 Jan 2009 20:05:45 -0500 (EST)
In-Reply-To: <87fxjoowyp.fsf@jidanni.org> (jidanni@jidanni.org's message of
 "Tue, 13 Jan 2009 08:45:18 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 534CD7BE-E10E-11DD-BBD4-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105433>

jidanni@jidanni.org writes:

> We attempt to give an explanation of the status of the files in this
> directory.

Yeah, that is a good discipline.

They are original scripted implementations, kept primarily for their
reference value to any aspiring plumbing users who want to learn how
pieces can be fit together.
