From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/Fixed Wrap] Remove hyphen from "git-command" in two error
 messages
Date: Mon, 15 Feb 2010 18:20:57 -0800
Message-ID: <7vr5olor92.fsf@alter.siamese.dyndns.org>
References: <4B79D7F2.80207@pcharlan.com> <4B79D9BE.9000407@pcharlan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pete Harlan <pgit@pcharlan.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 03:21:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhD3p-0004yJ-Ri
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 03:21:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932517Ab0BPCVI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 21:21:08 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38702 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932512Ab0BPCVE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 21:21:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 475B39A320;
	Mon, 15 Feb 2010 21:21:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=rVxD22
	iX5CCxGTKSnEFZAjoXGMcDJrL6Oq9PyiGzRyC1+Y5rl02RgBZoTQQbNN/mHFUfVu
	weTt54UXnN6tyOQ5PByWxhrx6ybzD4TbT4aDDaq0zURE864oIThbYUlqaYFUdJyj
	2ISC55615aWKNJVI+eqmG4cob7Ms5qR91CwOU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZKUwhGNHo0wTNaDOsQd7RKoJzCqmXxpR
	8t5YrSHrtCbRmngkLSj11M009mWLDVzzlH/XwKH3kpVgMWV4q8T83r8UT7wMYHUb
	IQHoPYDv5DjRCCCWb5gKLC4COCItd+9JZ4Ok7X1qr2uI0TqsOBCeFjx6bIyc0vxt
	K75hfQV8/PQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2583F9A31E;
	Mon, 15 Feb 2010 21:21:02 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6B7239A31A; Mon, 15 Feb
 2010 21:20:59 -0500 (EST)
In-Reply-To: <4B79D9BE.9000407@pcharlan.com> (Pete Harlan's message of "Mon\,
 15 Feb 2010 15\:33\:18 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: ED82DC2A-1AA1-11DF-AD4C-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140060>

Thanks.
