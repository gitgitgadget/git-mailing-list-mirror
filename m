From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] two git-svn changes to help work with chromium.org
Date: Sun, 24 Jan 2010 11:29:05 -0800
Organization: 
Message-ID: <7vbpgj714u.fsf@alter.siamese.dyndns.org>
References: <1264235401-44051-1-git-send-email-jaysoffian@gmail.com>
 <20100123112626.GA21553@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jay Soffian <jaysoffian@gmail.com>,
	Andrew Myrick <amyrick@apple.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Jan 24 20:29:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZ89H-0002DO-BF
	for gcvg-git-2@lo.gmane.org; Sun, 24 Jan 2010 20:29:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752816Ab0AXT3U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2010 14:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752808Ab0AXT3U
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jan 2010 14:29:20 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36349 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752792Ab0AXT3T (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2010 14:29:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 58E9193610;
	Sun, 24 Jan 2010 14:29:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=8xnFxT+Nag4ZCnns452+IpA03g4=; b=XuEKt15+sgwe+YrHzm6Jslx
	LPFK3Upei9Q4tRCVJ/B/4/BqJaaUyRC1wECvKzKr/xHmdunPQrNeEt/nZV1NJ59J
	BOkCnBpMDTeDF1IbpmY6NVdDlocT29LtOJK2D2ngMr6LaHMwbEMCMSTJp1e9bHkN
	alFZ0nrdzsJc4YnhraYY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=Wtl7w/PZdZFvbBEx632aPiP3Og/jkbV+1rTp5i4zTUNl6Qkvd
	KX4cAm6BMyW5u/qSOJuIvXQ2tmMIpzYS4MaEs72Wcar1fOyRmCi5J8ZBG0Oa9qXQ
	NAo5907hU4cOqHVDS+ER+D6jBEWIZ81vvxWrZiefPPIj/wRlT3692GW0og=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1072F93609;
	Sun, 24 Jan 2010 14:29:12 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4896B93608; Sun, 24 Jan
 2010 14:29:07 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C010A1E4-091E-11DF-A256-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137914>

Thanks, pulled.
