From: Junio C Hamano <gitster@pobox.com>
Subject: 1.7.7-rc0 tagged and pushed out
Date: Fri, 26 Aug 2011 16:03:50 -0700
Message-ID: <7vwrdzbwrt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 27 01:04:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qx5RO-0005bT-42
	for gcvg-git-2@lo.gmane.org; Sat, 27 Aug 2011 01:03:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752182Ab1HZXDx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Aug 2011 19:03:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56885 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751248Ab1HZXDx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2011 19:03:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4580B475C;
	Fri, 26 Aug 2011 19:03:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=Y
	abNFyK2/PGZP4I8ebqh6zxZYuU=; b=UCpuNMY7prr5/zSIdCj+LyQ9njQMdP724
	TCEzSZbGF5GO0x+qJISeW2ji+DwVaah7Lxsxum/kd0gjpbrtlvmsJPKmuTE4werK
	aEtvdh4PXoMe8BMr62y2AveqdGjNiO7RoNaSmZ3HyS8A0XZA6r/c0ckLjVW31aPi
	GNuzEEGJK4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=Uye
	qidtW/9JX4kJVr8w99liLZ4RbJpcXDRxGjmGz1WcOn7d1v02hah302TEBkkdmrpN
	75fZbKgF4nsnpPmL0HaywmIePnE5Ox+LUOLm67qfaki7saZJEDb2E3Ws8ZikR1i+
	Go6x/8WnYiip4jaq1N022h1p+ojVwRKCqh2oCknY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 399EC475B;
	Fri, 26 Aug 2011 19:03:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C5958475A; Fri, 26 Aug 2011
 19:03:51 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AA30AE0A-D037-11E0-B265-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180208>

... and I think I've collected all the recent leftover topics from the
list that are at least going in the right direction if not perfect and
queued them to update 'pu'.

Hopefully I can tag 1.7.7-rc1 by the end of the month. Please help find
regressions in the "master" branch, and the topics still in "next" that
are slated for 1.7.7 (see the latest "What's cooking").

Thanks.
