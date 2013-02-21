From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 4/4] t7800: "defaults" is no longer a builtin tool
 name
Date: Thu, 21 Feb 2013 15:49:15 -0800
Message-ID: <7vy5ehrzwk.fsf@alter.siamese.dyndns.org>
References: <1361489572-25403-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 22 00:49:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8ftX-0005A3-4q
	for gcvg-git-2@plane.gmane.org; Fri, 22 Feb 2013 00:49:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754618Ab3BUXtS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2013 18:49:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36156 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753834Ab3BUXtR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2013 18:49:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 24D5DBA9F;
	Thu, 21 Feb 2013 18:49:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=EjnFZE
	o7aBccK5Wd3jCbYuooKM+6+8zpIYOljOo15iw3FxfBAEMmsr7l/4Gee/SR7nzeXl
	Gy+eR9nfcCgmB9IY5l91twvfa3cHeasu7tcPOt8aUv4cfBe247pSatK7Pjx0vzFt
	s8yjJ7QkmVs7lSLu21hF97qH/0pT5RmWjo540=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nvtfDx+PhWSjmLC9EDgW63NUD8PyKBpJ
	7hKfzU0rooSuhGfZBMqtzVGzeHfg64XuZSW8nmzFDQR8CWl3K5fEvXAngrFNNcLy
	ncTsa5/sycxCKOdqUqCxl/8A0Z6Fb9PabYeVz62/GXOQxkdfJCfEU4WTaTKufg/w
	ylhIKHbVex4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 18F64BA9E;
	Thu, 21 Feb 2013 18:49:17 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 89EDDBA9D; Thu, 21 Feb 2013
 18:49:16 -0500 (EST)
In-Reply-To: <1361489572-25403-1-git-send-email-davvid@gmail.com> (David
 Aguilar's message of "Thu, 21 Feb 2013 15:32:52 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4D669C32-7C81-11E2-80D4-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216812>

Thanks.
