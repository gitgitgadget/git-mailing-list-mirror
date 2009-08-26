From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-bisect: call the found commit "*the* first bad
 commit"
Date: Wed, 26 Aug 2009 02:05:58 -0700
Message-ID: <7vfxbfeyh5.fsf@alter.siamese.dyndns.org>
References: <20090826173850.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Wed Aug 26 11:06:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgESM-0003oX-HC
	for gcvg-git-2@lo.gmane.org; Wed, 26 Aug 2009 11:06:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755532AbZHZJGF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2009 05:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753266AbZHZJGE
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Aug 2009 05:06:04 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56954 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751811AbZHZJGD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2009 05:06:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6D2D0373B0;
	Wed, 26 Aug 2009 05:06:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rgF3oyZ9yraXb8f/TgD6NEJ9zBY=; b=DRug42
	gCrZ2IYwD+cZ6u6DjY+kiQ3vlMX36LmNgCojgO7dPG5sjwcmOzorL0LyLVpKNG5J
	cVo/qJ4N4ftBBz51I7/KfyWd5lQ6GxVvakhkhRk03UGXG614nZCMrvZOa06qxCG5
	otr/OD4SpMsql4iMs+bAmrkFHDZtiJYXX37j4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ObOd1GfnKs/QCTDLO0Q5z587IIyJ48hw
	UY3DmX7aUvie5ZK5DBRmGB7QYjmAYrVSLL7kKUDUysO4yXKCN+8LOp+vAXkCmvnV
	gsIOy5w7XIzAiuxXd1e+X7oxKZMw3lCVDBIChLImkDdG2eibkxM6T07AI2Qmfhbz
	Q3AapYaFy+o=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4DAE4373AF;
	Wed, 26 Aug 2009 05:06:03 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2565D373AC; Wed, 26 Aug 2009
 05:05:59 -0400 (EDT)
In-Reply-To: <20090826173850.6117@nanako3.lavabit.com> (Nanako Shiraishi's
 message of "Wed\, 26 Aug 2009 17\:38\:50 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AE3F5E90-921F-11DE-8BBB-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127077>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> .. as we learned in the school ;-)

Thanks.

Is it "learned in school", or do you also need "*the*" there?

;-)
