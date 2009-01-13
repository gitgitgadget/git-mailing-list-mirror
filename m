From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] Purest update to bash completions to prevent
 unbounded variable errors.
Date: Tue, 13 Jan 2009 11:43:53 -0800
Message-ID: <7vvdsj6lfq.fsf@gitster.siamese.dyndns.org>
References: <496CBC98.7090101@tedpavlic.com>
 <20090113163421.GQ10179@spearce.org> <496CC3E7.8060805@tedpavlic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git <git@vger.kernel.org>
To: Ted Pavlic <ted@tedpavlic.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 20:45:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMpCZ-0001Jf-Qv
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 20:45:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753117AbZAMToG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 14:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752980AbZAMToD
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 14:44:03 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:37091 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752751AbZAMToB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 14:44:01 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B99DA1C675;
	Tue, 13 Jan 2009 14:43:59 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E4D4F1C641; Tue,
 13 Jan 2009 14:43:54 -0500 (EST)
In-Reply-To: <496CC3E7.8060805@tedpavlic.com> (Ted Pavlic's message of "Tue,
 13 Jan 2009 11:40:07 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 85DC2436-E1AA-11DD-88E8-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105523>

Ted Pavlic <ted@tedpavlic.com> writes:

>> Your commit message leaves a lot to be desired.  I would instead
>> have written something like this:
>
> I agree completely. Sorry about that. stg fired off vim to edit the
> commit message, and I just wasn't thinking.
>
> Would you like me to modify the commit message and resubmit?

Luckily or unluckily, you need to do that anyway, as your patches are
whitespace damaged.

Please don't send "format=flowed".
