From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] docs: fix some antique example output
Date: Thu, 26 May 2011 22:16:33 -0700
Message-ID: <7vr57ku3im.fsf@alter.siamese.dyndns.org>
References: <30543.1305828072@plover.com>
 <20110527023315.GD25362@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 27 07:16:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPpPk-0007D2-0f
	for gcvg-git-2@lo.gmane.org; Fri, 27 May 2011 07:16:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008Ab1E0FQn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2011 01:16:43 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57329 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804Ab1E0FQm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2011 01:16:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D435F5AE7;
	Fri, 27 May 2011 01:18:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=grgY7gdYsrPl+f5X3+xMicNwvEk=; b=Nv7FvQ
	FH+kzdCabGsvQop55Do2pdwMhlUi/oCoSPKrUt29qG1CPOOB6zvhlvlkdHmJA8dl
	VsrgqY5lZe8f/INXq7RGg4flftWSzH+Whd4hJZvTfS9HyCvdhYNx7xXW+WznvlCW
	x4jNKendse2j8USeFWPa2vp/13c1CNF7euF48=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r3l5ZCs+A95L+hkQUfcinjvzO1EvA+a5
	zTYkB2dJymAzUCfoc84lDuywoJijyvOGF5HDco6dZJvBlA17Q/GE/05h4OH3js1C
	tZianieXNLFNKxktboua87XSYEDOKdW6+QZYpqvJ/BUVUmjIaZYOJuH0zTzC5mMi
	4bzc9P3XQrI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B23B35AE4;
	Fri, 27 May 2011 01:18:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AD9E75AE1; Fri, 27 May 2011
 01:18:43 -0400 (EDT)
In-Reply-To: <20110527023315.GD25362@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 26 May 2011 22:33:15 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CCBE8D16-8820-11E0-8F6C-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174599>

Thanks. All patches look good.
