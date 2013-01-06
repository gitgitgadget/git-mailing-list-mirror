From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] docs: manpage XML depends on asciidoc.conf
Date: Sun, 06 Jan 2013 15:19:43 -0800
Message-ID: <7vtxqtlx0w.fsf@alter.siamese.dyndns.org>
References: <20130105160017.GD6440@serenity.lan>
 <20130105232800.GF3247@elie.Belkin> <7vbod2pzxd.fsf@alter.siamese.dyndns.org>
 <20130106120153.GB22081@elie.Belkin> <20130106123326.GF6440@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Sergey Vlasov <vsu@altlinux.ru>,
	Thomas Ackermann <th.acker66@arcor.de>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Jan 07 00:20:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrzVd-0006hw-Bi
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jan 2013 00:20:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753292Ab3AFXTr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 18:19:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47075 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753228Ab3AFXTq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 18:19:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B98E3AAD7;
	Sun,  6 Jan 2013 18:19:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=bHLiQWQJnxREWyApbs3T
	3Crt5/MrsLNNRA6OCRxIDzbcsyIfe57Xm3Bz8Btbyr/9LrrX10BJNkXxMlEWDI+b
	6idBTUN4GV4Uvmyfzh7rdzBBw6Ku1aUvLxcNmSe3N4gcDIkEXsKdMzTRVm31eHCI
	gzQeBe96QIpL3xvuFlfDfOY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=H/+dy3SfedaR1YEQcxch4SUneq6/Siuq9kOoXH6pDOGagr
	yLjJ2eaa3j7y8U5lg8aajh+/XvnA/JUyozVLLKa2maOInLlLFGh9KglH5t3U9UO4
	jgv0ss9UZ3vkjjI2W/HErw5Zl+7wvgznib3fVmWYU7wqkcxzzGCXmYJnloBg8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A9661AAD6;
	Sun,  6 Jan 2013 18:19:45 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 26658AAD3; Sun,  6 Jan 2013
 18:19:45 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8E92C288-5857-11E2-AA7C-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212858>

Thanks.
