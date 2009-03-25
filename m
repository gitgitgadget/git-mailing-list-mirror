From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: git-format-patch.txt rewordings and 
 cleanups
Date: Wed, 25 Mar 2009 00:26:42 -0700
Message-ID: <7vhc1i83m5.fsf@gitster.siamese.dyndns.org>
References: <1237803683-14939-1-git-send-email-bebarino@gmail.com>
 <20090324220913.GN19389@fieldses.org>
 <780e0a6b0903241636j4749daf3xddb6e4c200c00820@mail.gmail.com>
 <7vskl2tr00.fsf@gitster.siamese.dyndns.org>
 <780e0a6b0903242321q252c4b44k3909bd79003ded6b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 08:28:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmNXO-0001GU-MP
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 08:28:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756812AbZCYH0z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 03:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756655AbZCYH0z
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 03:26:55 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46958 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755168AbZCYH0y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 03:26:54 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CC1E7A401C;
	Wed, 25 Mar 2009 03:26:51 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1AD75A401B; Wed,
 25 Mar 2009 03:26:43 -0400 (EDT)
In-Reply-To: <780e0a6b0903242321q252c4b44k3909bd79003ded6b@mail.gmail.com>
 (Stephen Boyd's message of "Tue, 24 Mar 2009 23:21:22 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 4F48B0EC-190E-11DE-BDDB-32B0EBB1AA3C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114574>

Stephen Boyd <bebarino@gmail.com> writes:

> On Tue, Mar 24, 2009 at 4:55 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stephen Boyd <bebarino@gmail.com> writes:
>>
>>> How about a sentence with no negation?
>>>
>>> "Note that the leading dot is required if you want a dot between the
>>> patch name and the suffix."
>>
>> How about a sentence that does not sound requirement but freedom?
>>
>> "The leading character does not have to be a dot; for example, you
>> can use --suffix=-patch to get 0001-description-of-my-change-patch".
>
> Looks even better. Do we still want to start off by saying "Note that the..." ?

Perhaps; I wasn't paying much attention to the whole sentence, but was
primarily interested about giving the description less negative
connotation.
