From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Add submodule-support to git archive
Date: Sun, 25 Jan 2009 16:41:34 -0800
Message-ID: <7vmydedhkx.fsf@gitster.siamese.dyndns.org>
References: <1232844726-14902-1-git-send-email-hjemli@gmail.com>
 <20090125135340.6117@nanako3.lavabit.com>
 <8c5c35580901250018x6827291cj36e6bcb10afa9b27@mail.gmail.com>
 <7veiyrdszf.fsf@gitster.siamese.dyndns.org>
 <8c5c35580901251512q5058dde3rdfae81979c46c36a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 26 01:43:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRFZE-0007Fd-Kb
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 01:43:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbZAZAlm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Jan 2009 19:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750909AbZAZAlm
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jan 2009 19:41:42 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50063 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786AbZAZAlm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jan 2009 19:41:42 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C32261D426;
	Sun, 25 Jan 2009 19:41:40 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D37781D3EA; Sun,
 25 Jan 2009 19:41:35 -0500 (EST)
In-Reply-To: <8c5c35580901251512q5058dde3rdfae81979c46c36a@mail.gmail.com>
 (Lars Hjemli's message of "Mon, 26 Jan 2009 00:12:25 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 18CF9160-EB42-11DD-9927-BE78113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107147>

Lars Hjemli <hjemli@gmail.com> writes:

> If you want me to build on top of the series in next anyways, would it
> be acceptable if the first patch on top of ee306d2d59 reverts the
> previous attempt? I think the rest of the series will be easier to
> review that way.

Ok, then I'll simply revert and then queue the new ones on top of it.

Thanks.
