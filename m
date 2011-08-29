From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 0/4] git-p4: Improve branch support
Date: Sun, 28 Aug 2011 23:07:17 -0700
Message-ID: <7vmxes7nu2.fsf@alter.siamese.dyndns.org>
References: <1314568710-6472-1-git-send-email-vitor.hda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pete Wyckoff <pw@padd.com>,
	Tor Arvid Lund <torarvid@gmail.com>
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 29 08:07:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qxv0H-0006OF-54
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 08:07:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752804Ab1H2GHV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 02:07:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62188 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750738Ab1H2GHT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 02:07:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 803162057;
	Mon, 29 Aug 2011 02:07:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=Ve/zJcRwwMDwQB3qwTuTwUSqLHo=; b=P1Q8y6ObqSlk+uBTJnY5
	pzuZWY1gu9pWZ8xqXNKgssFOdReMm/Cp7BI1GxYWGMU56QiPr4IOrFBUA8cv3bnt
	C2GMK1WE8VNPD4V69ayh4t81QpKLfVLSmtwdg/Fx6U2xIBCC7hSykqgnHqSKZYED
	cb7yP8d3txq+5BHDFHLnEtA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=QwjBStreotOZ2CnIEzEmUNm6FbAgtAsw5mD+TmT6NSbvqv
	B4VYIGwTJJ79I3aNOsBKi8fw/DesZMxPIAaWzyRmE9FihZFEfCGz45BETH9kryEB
	3bbgZvCJd8X0K4ji/tp6tujgGQZCpr3rYCg2VXhXINZfa6JOrOSTZsuemDELQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 762F22056;
	Mon, 29 Aug 2011 02:07:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0D34E2055; Mon, 29 Aug 2011
 02:07:18 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 26E9EC3A-D205-11E0-9DB5-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180300>

Could you make this an incremental patch relative to what is already in
next?


	
