From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] git-p4: paths for p4
Date: Sun, 11 Dec 2011 21:14:11 -0800
Message-ID: <7vaa6y6vl5.fsf@alter.siamese.dyndns.org>
References: <1323474497-14339-1-git-send-email-pw@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Gary Gibbons <ggibbons@perforce.com>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 09:30:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ra1HD-0004Ya-HD
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 09:30:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856Ab1LLIaT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 03:30:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54838 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750748Ab1LLIaS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 03:30:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 98DF32890;
	Mon, 12 Dec 2011 03:30:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=AZVpluGtZAZeWMPWxYfNelyH0xI=; b=GVjqtCdda3Oajb4EGK4N
	/pWlWwZZGBARMe1CssrA16gump7OLUug6P2nTH+SSolPL1xMJVeLeKwq2a6men40
	8Lbc/kT4i/njTDNEB2I9dnusnSCmZ0Ij2tgWFOxrVBQ724SNAe+kKyn8+6HEsLiF
	t8cTOO6hdmsihc/wpU2X8sY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=dNAS03J9aEk2yvTXuRPQla9F40jzSv/Hd4mmo4tbFf3OAh
	G5iGS0lm6S+lMWINHpugVk2Ron+mKWanwfUrpZhtdfGLfd5j0uxAllGgchdeCVU+
	aNZC8S2ky58v01iOSK6gDdbKddPgwiJEVervFrgGJKCgGhUBMSJf8LcVO+Eyg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8DAF9288A;
	Mon, 12 Dec 2011 03:30:17 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2B4792882; Mon, 12 Dec 2011
 03:30:16 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 84A6D71E-249B-11E1-99D2-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186891>

Thanks; will queue directly to 'master'.
