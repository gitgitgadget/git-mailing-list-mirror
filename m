From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jul 2009, #01; Mon, 06)
Date: Mon, 06 Jul 2009 15:34:01 -0700
Message-ID: <7vd48djvae.fsf@alter.siamese.dyndns.org>
References: <7vk52l4q7k.fsf@alter.siamese.dyndns.org>
 <200907062229.11763.mcamen@mcamen.de>
 <7vk52l1oht.fsf@alter.siamese.dyndns.org>
 <200907070003.25788.mcamen@mcamen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Lodato <lodatom@gmail.com>, git@vger.kernel.org
To: Marcus Camen <mcamen@mcamen.de>
X-From: git-owner@vger.kernel.org Tue Jul 07 00:34:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNwlN-0001RM-9p
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 00:34:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753535AbZGFWeG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2009 18:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753213AbZGFWeF
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jul 2009 18:34:05 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:44149 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753193AbZGFWeE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2009 18:34:04 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 53BC9252D6;
	Mon,  6 Jul 2009 18:34:06 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id A2EC7252D3; Mon, 
 6 Jul 2009 18:34:02 -0400 (EDT)
In-Reply-To: <200907070003.25788.mcamen@mcamen.de> (Marcus Camen's message of
 "Tue\, 7 Jul 2009 00\:03\:25 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1D55E2A6-6A7D-11DE-AF7B-DC021A496417-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122807>

Marcus Camen <mcamen@mcamen.de> writes:

>>  - On a protected key/cert, with configuration, it asks the question
>> once.
>>  - On an unprotected key/cert, without configuration, it never asks the
>>    question.
>>  - On an unprotected key/cert, with configuration, it asks an useless
>>    question but it does so only once.
>>
>> You tested all of the above?
>
> Yes, all three tests run exactly as you described.

Wonderful; thanks.
