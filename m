From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/9] Documentation tweaks
Date: Fri, 09 Oct 2009 17:58:29 -0700
Message-ID: <7vzl80cbey.fsf@alter.siamese.dyndns.org>
References: <20091009101400.GA16549@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 10 03:02:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwQLi-0005GI-3V
	for gcvg-git-2@lo.gmane.org; Sat, 10 Oct 2009 03:02:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964827AbZJJA7m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 20:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934640AbZJJA7m
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 20:59:42 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38521 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934562AbZJJA7m (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 20:59:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 748CE52C31;
	Fri,  9 Oct 2009 20:58:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ULUpwoLFYwtg1IN+b4JEo4Ps/l0=; b=voVtCr
	7wKg7BhBFI0l3MvhBM+Wh3vjFQtouBEIRDFO2ia+fFUfsNejiCQ33J3TMjwdcwWH
	eyK4fXenKj4RuJ89vbrY7e1bsuXk+20Kfikqn4Mo1/wctTlEMn4Mh6YKhSQbkghj
	/kNqfnqjj5e3ZTHiQS3Ini1+ZZ30WbI7VoKoA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DTQBm6HgqZ+gX+MpUANeCkMKln/mOSy/
	6UuFljmIOrxEEqrX++wF2ojOQQGPsQBinwl1kmgC68rXGfKjEVEu0zblRnSsCdYj
	iUVg+7XB1E2Ah7syWQ/DrS+zdIijTvVOcvtS2mUOL72yYDTruwCrR6JNY7PCroYD
	9cNKgobKZnQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 57DAC52C30;
	Fri,  9 Oct 2009 20:58:33 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C283352C2F; Fri,  9 Oct
 2009 20:58:30 -0400 (EDT)
In-Reply-To: <20091009101400.GA16549@progeny.tock> (Jonathan Nieder's message
 of "Fri\, 9 Oct 2009 05\:14\:00 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0882FF8E-B538-11DE-8586-E80E3AD9C332-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129867>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Here are some small documentation patches that have been sitting in
> my tree for a while.  Most important is the first one, which makes it
> easier to find the appropriate options for building documentation
> from source on a new machine.

Thanks.
