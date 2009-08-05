From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6] Teach --id/-d to "git status"
Date: Wed, 05 Aug 2009 11:27:34 -0700
Message-ID: <7vtz0m5d61.fsf@alter.siamese.dyndns.org>
References: <1249465906-3940-1-git-send-email-ayiehere@gmail.com>
 <1249465906-3940-2-git-send-email-ayiehere@gmail.com>
 <81b0412b0908051111g4433e12epa540e0a2f07b62b@mail.gmail.com>
 <fabb9a1e0908051125m3eecb065m5fb4ea2b55f69b91@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Nazri Ramliy <ayiehere@gmail.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 20:28:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYlDT-0005xo-Vm
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 20:28:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751750AbZHES1q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2009 14:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751730AbZHES1q
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 14:27:46 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33495 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751661AbZHES1p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2009 14:27:45 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 25C2421C34;
	Wed,  5 Aug 2009 14:27:46 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 6BD7421C2D; Wed, 
 5 Aug 2009 14:27:41 -0400 (EDT)
In-Reply-To: <fabb9a1e0908051125m3eecb065m5fb4ea2b55f69b91@mail.gmail.com>
 (Sverre Rabbelier's message of "Wed\, 5 Aug 2009 11\:25\:43 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AC0C7F28-81ED-11DE-A2CF-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124944>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> On Wed, Aug 5, 2009 at 11:11, Alex Riesen<raa.lkml@gmail.com> wrote:
>> What is it for?
>
> See [PATCH 0/6].

Sounds useless.
