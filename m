From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 0/3] revisions.txt improvements
Date: Mon, 04 Apr 2011 11:18:50 -0700
Message-ID: <7voc4l98xh.fsf@alter.siamese.dyndns.org>
References: <cover.1301649867.git.git@drmicha.warpmail.net>
 <cover.1301930700.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Apr 04 20:19:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6oMn-00067u-7A
	for gcvg-git-2@lo.gmane.org; Mon, 04 Apr 2011 20:19:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755167Ab1DDSTC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2011 14:19:02 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51343 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754891Ab1DDSTB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2011 14:19:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5623F4A71;
	Mon,  4 Apr 2011 14:20:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=wHp1Aj
	0aVxOdRpCx6ZZjdLmBPcURA9uLZCZvg3vUOA9YrWWFTthFfk7FNyf1Sj8qVUshEW
	VNotz5qFXIibAdYUA0UsQvqFLguOBf9fQldJ5u0I9qbzf05OrkqfLlcfQZ4pj9wQ
	SffgUfuCE0xb8O7F3OpSjxSbfE/5buPQfJSfk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=csg0rcunM7oteFz593As9ADV3vUvuqFE
	YPqtBAY3gOAi0lMhsCVjLPnpZAz4wNwsqq7NF5+8sT2PdGGTKF9gbAKfTs4IuCFy
	HXOEAPKO9TCXRZvU6BtJc0HNg5BDGf7vVp6ZHPFBoj7QhJYu+fq9lYwQ4LAOBLcU
	XYC2ShGx+mk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 313874A70;
	Mon,  4 Apr 2011 14:20:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4FADD4A6A; Mon,  4 Apr 2011
 14:20:46 -0400 (EDT)
In-Reply-To: <cover.1301930700.git.git@drmicha.warpmail.net> (Michael J.
 Gruber's message of "Mon, 4 Apr 2011 17:27:02 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 44398CFE-5EE8-11E0-9988-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170831>

Thanks.
