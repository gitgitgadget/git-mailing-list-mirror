From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix typos in the documentation
Date: Tue, 04 Jan 2011 11:18:20 -0800
Message-ID: <7vr5csfpfn.fsf@alter.siamese.dyndns.org>
References: <20110102055653.GI19818@gmx.de>
 <1294077450.12519.15.camel@drew-northup.unet.maine.edu>
 <20110103190334.GA3767@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Drew Northup <drew.northup@maine.edu>, git@vger.kernel.org
To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 04 20:18:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaCOw-0002yu-TV
	for gcvg-git-2@lo.gmane.org; Tue, 04 Jan 2011 20:18:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751970Ab1ADTSa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jan 2011 14:18:30 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33283 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751856Ab1ADTS3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jan 2011 14:18:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7936E2FA0;
	Tue,  4 Jan 2011 14:19:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=HItwR1VwL+b5RqVyhbRaCyh10ns=; b=vq55mROok5RVuCk7FmkLf2o
	1pZlLTmbvkixb0d/FwLNEywBDhd7f5F7qun4UvvPhmcrMk2eFzokHqAqao/Ut0F1
	Wup/dbvefmXnYObCFyd38bIoIeCq7cWrxNiri0RxAhG74wT0H6GJd76FKevbZFCR
	ezfGzu+ZisfNtdW7MH6I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=wEMv5qsg8zn25JUTjVPU5Q6jrkCjrCJ+f/umqh5DWzD9M4O6F
	thoxP6HJt3n7+2+hEx4+dUZpGxtU3v0viD7YAd7Y9HUTLMuUi5N7+sglIpJlN3cP
	GsgsOkin4BzJYzN1NvJlVS/TOf7eZSDnon4u9MzXMS/3Hth8WCkQ+UDgiI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 481752F9E;
	Tue,  4 Jan 2011 14:19:02 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2D72E2F9D; Tue,  4 Jan 2011
 14:18:57 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7D1EE124-1837-11E0-8EA1-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164508>

Ralf Wildenhues <Ralf.Wildenhues@gmx.de> writes:

> Signed-off-by: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
> ---
>
> ...
> As far as I can see, the only difference between my and your change is
> "burn" vs. "burning" (ignoring trailing white space).  I don't see what
> your version is consistent to that mine isn't, but I think that yours
> is the grammatically correct way.  I'm not a native speaker though.
> Anyway, here's the updated patch.

Thanks for your attention to the details.  Will apply.
