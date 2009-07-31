From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 2/2] Documentation: git-send-email: correct statement
 about standard ports
Date: Fri, 31 Jul 2009 11:19:32 -0700
Message-ID: <7vbpn0r9zf.fsf@alter.siamese.dyndns.org>
References: <1248995334-28545-1-git-send-email-wjl@icecavern.net>
 <1248995334-28545-2-git-send-email-wjl@icecavern.net>
 <7vzlaku9d4.fsf@alter.siamese.dyndns.org>
 <200907311145.01759.wjl@icecavern.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Wesley J. Landaker" <wjl@icecavern.net>
X-From: git-owner@vger.kernel.org Fri Jul 31 20:19:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWwhp-0003Qm-L9
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 20:19:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141AbZGaSTl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2009 14:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751897AbZGaSTl
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 14:19:41 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49453 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300AbZGaSTk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2009 14:19:40 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D9474187E4;
	Fri, 31 Jul 2009 14:19:39 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B562D187E3; Fri, 31 Jul 2009
 14:19:34 -0400 (EDT)
In-Reply-To: <200907311145.01759.wjl@icecavern.net> (Wesley J. Landaker's
 message of "Fri\, 31 Jul 2009 11\:45\:00 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B6227172-7DFE-11DE-9FCB-AEF1826986A2-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124588>

"Wesley J. Landaker" <wjl@icecavern.net> writes:

> On Friday 31 July 2009 10:04:39 Junio C Hamano wrote:
>> As you noted, port 465 has been used as a well-known de-facto port to run
>> SMTP over SSL at many places.  I do not think it would help anybody by
>> clarifying that it is a "non-standard" port here.  This is not a place to
>> educate people on which port they should run their SMTP servers.
>>
>> But I do not care deeply enough, and I can let it pass.
>>
>> I have much more trouble with that "like 465" than I have with "non
>> standard".
>
> If you don't like the phrasing, how about this revised patch? I call it a
> "common SSL smtp port", and refer directly to 465. I think should make everyone
> happy:

Looks really good.  Thanks.
