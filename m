From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] t5541: use configured port number
Date: Mon, 13 Feb 2012 13:23:36 -0800
Message-ID: <7vd39ictrb.fsf@alter.siamese.dyndns.org>
References: <7vhazobto3.fsf@alter.siamese.dyndns.org>
 <1329164235-29955-1-git-send-email-drizzd@aon.at>
 <1329164235-29955-5-git-send-email-drizzd@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Feb 13 22:23:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rx3NA-0001bG-3U
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 22:23:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756010Ab2BMVXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Feb 2012 16:23:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61562 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755973Ab2BMVXj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2012 16:23:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AFDB477E2;
	Mon, 13 Feb 2012 16:23:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=q4yhZPbkJh5gr6jKrfnzPiaixK4=; b=on76o2
	pkfN0Ybp3efrqkkzSUY8E8xuSaOTKNCYUW+hjSJQNso2TFSfqGzYtK163hlNeeu7
	z/JLLNLbt1ws9Fx4RApks0lsVaf0JY4zbZdmX35Z6vDhpG33Gdak5BHMJP0+yUq/
	dbRO9bgt5DpPQdLGIpNw2bThtItLUt/oY8b7U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aumZ7bOOgw6vo4+im+wLhyn5UPGUTRQS
	L3UQ4HEKBBLc3VYZmV7Kt5P64rofwAmuSICBYhduuFgWFOIJMxfOraIcwrxVqa/j
	rtU/VNvr1pfb7l1XO+tTCDGZQsRdC6sLQ7lzHCAm2cNWrWeLLzY2dML4pEkHP21k
	s57rmz1g6Jk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A7B1177E1;
	Mon, 13 Feb 2012 16:23:38 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 37E7177DF; Mon, 13 Feb 2012
 16:23:38 -0500 (EST)
In-Reply-To: <1329164235-29955-5-git-send-email-drizzd@aon.at> (Clemens
 Buchacher's message of "Mon, 13 Feb 2012 21:17:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FE7425E6-5688-11E1-8E3E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190674>

Good eyes. Thanks.
