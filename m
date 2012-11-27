From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: improve phrasing in git-push.txt
Date: Tue, 27 Nov 2012 09:09:07 -0800
Message-ID: <7vfw3vnfbg.fsf@alter.siamese.dyndns.org>
References: <1353980254-8033-1-git-send-email-mszepien@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Szepieniec <mszepien@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 27 18:09:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdOf1-0007yn-Fz
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 18:09:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754356Ab2K0RJM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 12:09:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37643 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752526Ab2K0RJK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 12:09:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 36409904A;
	Tue, 27 Nov 2012 12:09:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ez1dw+ab6GiMF1QUE9rZiwKqC2I=; b=L8gwjZ
	/ytTG+BjMoexEHoHkzDUkNtg+n5KBFaWas8NApvGo5mG/6WV2pROsry5UrD5MWuL
	U005DAB/WYlaWBYDVIrAklcmRA7zDLoR5UuJ1Vc4fSmQVjxXyEK5cIF7T1cgcfy8
	HdV2oh47bY98BnnwAfG3vLO5vocUYtOdIsxc8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pxb0ZwffgisEcllFVpWuf/vLWX2drqnI
	Z6L1cpfQ9qvTkAv+K0fjFHG2mk0e2Iq+88IcuSg1rAyKFtF6Z1chWn+YVD+YoGlf
	VrvN+W6oNBTTr+zpW9A6FB2cLtIJQ14o/A8qo7jdnelWA3BWxe54VGtUZWIE9VZX
	uDh8xhuvrpg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 221DE9049;
	Tue, 27 Nov 2012 12:09:10 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 97CC29048; Tue, 27 Nov 2012
 12:09:09 -0500 (EST)
In-Reply-To: <1353980254-8033-1-git-send-email-mszepien@gmail.com> (Mark
 Szepieniec's message of "Tue, 27 Nov 2012 01:37:34 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 289F3554-38B5-11E2-A283-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210564>

Sounds better; thanks.
