From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Advertising the prebuilt htmldocs and manpages
Date: Sat, 19 Feb 2011 22:52:53 -0800
Message-ID: <7v4o7zmc3e.fsf@alter.siamese.dyndns.org>
References: <7vmxm4onwk.fsf@alter.siamese.dyndns.org>
 <1297304069-14764-1-git-send-email-pclouds@gmail.com>
 <20110218022701.GA23435@elie>
 <AANLkTik8wUrUnjTiUxUZbg3paaQEc7UERQ6J6jUzA2u5@mail.gmail.com>
 <20110218092518.GB30648@elie> <4D5F0A7C.1080507@gmail.com>
 <7v39nkooem.fsf@alter.siamese.dyndns.org>
 <AANLkTikb0W-yLihPtvm5LDUKgxgRg_a5Rsq7pjnpZLCt@mail.gmail.com>
 <20110219094104.GA31980@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 20 07:53:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pr3AU-0003ac-G5
	for gcvg-git-2@lo.gmane.org; Sun, 20 Feb 2011 07:53:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751731Ab1BTGxO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Feb 2011 01:53:14 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43741 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677Ab1BTGxN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Feb 2011 01:53:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7E4624A5A;
	Sun, 20 Feb 2011 01:54:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+HYXAegJzfDvhJ+gJSRMUrX9cis=; b=x/AC8n
	scKjH0Nva6Lwy7ZPTua6YjdEOLIPSHk8UZ3T+beAPBc4hehG1251Y85DOZxcHIH/
	f1CUgFuJ1da6dWP8Q1CbvUer8ujhB6FvIgnFS1vHwNBqVqFlG9067NIwTbiJvZom
	4GMlXTeWpWVrcnH3U6BA/uqW5Kz0Es85KnqLw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=S+KONAJC8KopYgULFKMEBhdoIhp9tKFj
	+7U6j0yVBoSdn121UD32E5POl0jdA1lGqAqMJ/lwCJeeKCoGlzC5n7Anac4SgY+U
	nydqGH6yFUR7yUqIXm1qGPyz+kFi3Kn+x627RPYvszr4WxNTOkT9/+gagUyn2nr9
	DqzjAHjP+K8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1DDC14A54;
	Sun, 20 Feb 2011 01:54:16 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6EE4B4A4F; Sun, 20 Feb 2011
 01:54:08 -0500 (EST)
In-Reply-To: <20110219094104.GA31980@elie> (Jonathan Nieder's message of
 "Sat\, 19 Feb 2011 03\:41\:04 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3B803A50-3CBE-11E0-860C-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167403>

Jonathan Nieder <jrnieder@gmail.com> writes:

> The INSTALL file explains:
> ...
> The README file says:
> ...
> Maybe this (especially quick-install-doc) can be made more
> discoverable somehow.

If all-caps INSTALL and README are not discoverable, there is not much
hope that anything can be made more discoverable, is there?
