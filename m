From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t/t9010-svn-fe.sh: add an +x bit to this test
Date: Thu, 19 Aug 2010 13:09:33 -0700
Message-ID: <7vpqxe74aq.fsf@alter.siamese.dyndns.org>
References: <1282233230-17323-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 19 22:09:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmBQs-0002lW-Ud
	for gcvg-git-2@lo.gmane.org; Thu, 19 Aug 2010 22:09:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752370Ab0HSUJq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Aug 2010 16:09:46 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50503 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752225Ab0HSUJo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Aug 2010 16:09:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 512D0CFE43;
	Thu, 19 Aug 2010 16:09:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1S70l+WQS6zuyQSHU7VSjlMG1fs=; b=MSIk/V
	Ty5fkNUPKnPYv9hZLqKQm7kslaZW/nJdIfmHLD22i4epkcxJ53XpZQ2dlJR8W2Uc
	j+S7b4GXIbYUf7K+YiQgwM01tGujUq/dpn7XBywVoPSBkC34WJRrAkw/kxcGaTK4
	UlVpv+Q1WdA+qax2mh0C37AUDhmy7snvMAa5g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RqY7pzKmAlyuxiqr54UVp65Uo1koq2pR
	J9YoXQjGCItCig15x1WwaY0lql6ye3G1yBgJDDDDM4yhDErj1jgCcfqh4G2nmf35
	N4dWVaBp2+vnTNYS6fGK4XVN7cb0X7Jzx/YSfZRfbiz+IC9/sQFlHpxTjbBCcofg
	johmiwyR9b4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0B170CFE3A;
	Thu, 19 Aug 2010 16:09:40 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2952CCFE30; Thu, 19 Aug
 2010 16:09:35 -0400 (EDT)
In-Reply-To: <1282233230-17323-1-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu\, 19 Aug
 2010 15\:53\:50 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B2C3115A-ABCD-11DF-9200-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153955>

Heh, why does a topic need to be merged to 'next' before this kind of
trivial bug in it gets discovered X-<.

Thanks.
