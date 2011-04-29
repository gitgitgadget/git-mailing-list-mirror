From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] t/test-lib.sh: minor readability improvements
Date: Fri, 29 Apr 2011 09:28:21 -0700
Message-ID: <7vpqo5xbru.fsf@alter.siamese.dyndns.org>
References: <4DBA8C43.4040804@debugon.org>
 <1304080230-11670-1-git-send-email-misfire@debugon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Mathias Lafeldt <misfire@debugon.org>
X-From: git-owner@vger.kernel.org Fri Apr 29 18:28:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFqYZ-00065Y-7U
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 18:28:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760055Ab1D2Q2a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 12:28:30 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33740 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760153Ab1D2Q23 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 12:28:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8DA00519E;
	Fri, 29 Apr 2011 12:30:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=Nugx3bg0VsKdj2+KNK1r
	E4yu0zeJuZvdWaq8swUJqdkcNVMN1tdohbPfaVhzUe+nUiyWr1VWauZ6Q3WYi+11
	NWcYcYk5iJoLZV+nmbUgwukjCkrcn/vSAOpo3KwEsxSnzccZRPlXLcyg1pveVcZu
	JRc2wuBsGspQgpbSnga3U5I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=wLQe7rrkBt+6bYEXpp1CtcGVEdoa7buYJPAq1o3zXCzHPT
	E8mwul+wkvff7RY0rON/7c4dVX25HnWjN61+p9anJn63+zDeGf2bhITHLpDA+dPC
	E+ZyBcz8WRMeKVzbk3yDLiv03wVI4xiuu450Gz5HYlpA6OjNJsdAHxj4N2wL8=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 687BE519B;
	Fri, 29 Apr 2011 12:30:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 8DCC35199; Fri, 29 Apr 2011
 12:30:25 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FE449988-727D-11E0-9A02-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172466>

Thanks.
