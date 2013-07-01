From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 0/5] allow more sources for config values
Date: Mon, 01 Jul 2013 15:09:40 -0700
Message-ID: <7vvc4u9bfe.fsf@alter.siamese.dyndns.org>
References: <20130511131721.GA17991@book-mint>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Jul 02 00:13:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtmLM-0005ln-6H
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 00:13:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755758Ab3GAWM5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jul 2013 18:12:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38571 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755747Ab3GAWM4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jul 2013 18:12:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D62362D38E;
	Mon,  1 Jul 2013 22:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=9u3aJoHt/0m2uFO8m0ISTTdwNhw=; b=sofdu05/f6wRGHF9Qsg8
	mu7fSVf7J9wf1ZaEzVZI9Ga8pyM6c+Av3dpa6yJ6/yvNq4bpr1bdvXRnjcNuCPBq
	bPTLCoCukcol2rx8TtUBT9tWsjRzvAnWif4gBKie00MYCBA6E6Ulf07Eohy+yUDW
	X6iUojgO6n8MB0iK2Ihmszs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=DQnBbMUvpb3w8ZFvMs15Jx7GvJspXc+BbyDTvyOJKMM56/
	XnJ8riAxGgUZoM72i2gZbPWv5VecFa0Q5h8L3hxfBN4Ee4mMrN/GqA28PiOWKvOB
	bsVQ/8iiPrEHNkB4CsBPe8f9yMg2w9B9HCNB+GFZGLM/p9W+evou7ifc8TR0Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CDC2F2D38C;
	Mon,  1 Jul 2013 22:12:55 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4A90E2D38A;
	Mon,  1 Jul 2013 22:12:55 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6133D56A-E29B-11E2-AA8B-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229339>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> This is only for review. I will resubmit this once 1.8.3 is out.

Ping?

No need to hurry, but just to make sure this didn't disappear from
everybody's radar.

Thanks.
