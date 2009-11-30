From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Give the hunk comment its own color
Date: Sun, 29 Nov 2009 23:15:13 -0800
Message-ID: <7v4ooczdoe.fsf@alter.siamese.dyndns.org>
References: <7v4oogzo74.fsf@alter.siamese.dyndns.org>
 <1259304918-12600-1-git-send-email-bert.wesarg@googlemail.com>
 <7vhbsfi4bz.fsf@alter.siamese.dyndns.org>
 <36ca99e90911280408v186777f1h22254744fb61bf1f@mail.gmail.com>
 <36ca99e90911292307w769913fdn1f610eeb065b41e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Nov 30 08:15:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NF0Tt-0006Kk-Ek
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 08:15:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753574AbZK3HPU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2009 02:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753525AbZK3HPU
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 02:15:20 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53975 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753413AbZK3HPT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2009 02:15:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2C485A252C;
	Mon, 30 Nov 2009 02:15:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DmtVJBSTIFM03bZoXrFanfXf2to=; b=VGY8eC
	7wUtcF9DYj27nL3gDh8nCYJZyXSP13HrocEAxFug5TJE/optYDflmWbQtKZIc3Ga
	nervosWYs/es8HrZXKxQprG6QnZvZuH4hm3dncq4NzTNPR5GXDhrs2ZbvU7DTenc
	Dw3IUJL6IsyCVLkGH+iEErgCcVzDrE0Ng7Xwg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a9W+0ezh+iIQP4JTsBSdMUebzRYdGWx3
	uC0IHMCT5MI+g5p4p00qxdBS2DOWysUo/WV2pu4H6Yd1KT++uDUMQoafQLtMR+LF
	wb3m3IGlxTG5XWmGorqh06wmUpVtxAYW50jpVUYh5UgAcmPUy5shd2VKZVKy4ltR
	EhAX/+x+mqI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F0733A252B;
	Mon, 30 Nov 2009 02:15:20 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8884BA252A; Mon, 30 Nov 2009
 02:15:15 -0500 (EST)
In-Reply-To: <36ca99e90911292307w769913fdn1f610eeb065b41e@mail.gmail.com>
 (Bert Wesarg's message of "Mon\, 30 Nov 2009 08\:07\:22 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1EC3F382-DD80-11DE-BE8B-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134062>

Sorry, but I think the fix is already in 'next', no?
