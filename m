From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Dec 2008, #04; Mon, 29)
Date: Tue, 30 Dec 2008 16:22:09 -0800
Message-ID: <7vwsdhyz0u.fsf@gitster.siamese.dyndns.org>
References: <7vocyt1is2.fsf@gitster.siamese.dyndns.org>
 <m3fxk5b6di.fsf@localhost.localdomain>
 <20081231001036.GW21154@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Dec 31 01:23:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHos8-0006Q1-5H
	for gcvg-git-2@gmane.org; Wed, 31 Dec 2008 01:23:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752230AbYLaAWS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 19:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752194AbYLaAWS
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 19:22:18 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59525 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752117AbYLaAWR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 19:22:17 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 59E7B1B6A4;
	Tue, 30 Dec 2008 19:22:16 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 471111B6A3; Tue,
 30 Dec 2008 19:22:10 -0500 (EST)
In-Reply-To: <20081231001036.GW21154@genesis.frugalware.org> (Miklos Vajna's
 message of "Wed, 31 Dec 2008 01:10:36 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1407E6D0-D6D1-11DD-955D-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104233>

Miklos Vajna <vmiklos@frugalware.org> writes:

> On Tue, Dec 30, 2008 at 03:15:43PM -0800, Jakub Narebski <jnareb@gmail.com> wrote:
>> P.S. BTW. what is the status on using parse_options among git
>> commands?
>
> You mean the C or the shell commands?
>
> I sent the third version of the builtin-apply migration ($gmane/104029),
> but I got no answer so far, probably it was dropped on the floor by
> accident. ;-)

No, just I can be slow during a week like everybody else.
