From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Documentation/Makefile: add *.pdf to `clean' target
Date: Mon, 08 Aug 2011 10:14:27 -0700
Message-ID: <7vty9rwvui.fsf@alter.siamese.dyndns.org>
References: <1312792385-19149-1-git-send-email-cota@braap.org>
 <1312792385-19149-2-git-send-email-cota@braap.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Emilio G. Cota" <cota@braap.org>
X-From: git-owner@vger.kernel.org Mon Aug 08 21:23:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqVQZ-000557-4O
	for gcvg-git-2@lo.gmane.org; Mon, 08 Aug 2011 21:23:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752694Ab1HHTXw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Aug 2011 15:23:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63644 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751408Ab1HHTXv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2011 15:23:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E17E53AD0;
	Mon,  8 Aug 2011 15:23:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=3yPV1KSAH6/jjBrHt/H9rJO91DQ=; b=FZTttO1+LHmDIr4sMnTo
	lvfFZPZoneVHimDFsbUNUfTcMSd4HU7AMH5562L0YcDZQ/1duRGuMVg1JUEVeCaK
	yfzKUQwBF6xLG9eidNwlOl/UHaxf++WKJT1oeh564YlDC0sWYryg2TMmNlBjE2Zw
	WS99VkLJE1co/gV+WpgECpU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=NcBBsWkYCGx039/Ne2ClC95o/XM2rcyaxyzzNMYmckRxIQ
	FeaHvKq/W/bCYFDLGmEYSTA7S5jSDr9BVDl94DqumkRJ5RT0zY8f6VtNNaXhxc0N
	lwm2UxffsUtY3fosviAvnn7EKq2nVLjMra5yiqovq+dB+Fe+ZvOSw3QULYh18=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D93EC3ACF;
	Mon,  8 Aug 2011 15:23:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6E9AE3ACE; Mon,  8 Aug 2011
 15:23:50 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F221C2FA-C1F3-11E0-9A65-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178976>

Makes sense; thanks.
