From: "David E. Wheeler" <david@justatheory.com>
Subject: Wither --local
Date: Wed, 25 Apr 2012 11:09:33 -0700
Message-ID: <799127EF-097F-41DA-A331-E38968ED531D@justatheory.com>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 25 20:09:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SN6ey-0003oo-R2
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 20:09:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757272Ab2DYSJj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Apr 2012 14:09:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46802 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754243Ab2DYSJh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Apr 2012 14:09:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D41D87FB5
	for <git@vger.kernel.org>; Wed, 25 Apr 2012 14:09:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from
	:content-type:content-transfer-encoding:subject:date:message-id
	:to:mime-version; s=sasl; bh=kTxJ0bNRhUYp6jHpQm6leUYTzlg=; b=efr
	sZ74tFpqFzvWa7AV9gmwZyGj5eYUEbwkqdeE4geYD2Ck0yYtOxrMCswQlkFm0Y0K
	qU2n23ZNmUC4apcoUM7/kK/Q8yaw3QB3+GUQEe5qwZjCbk97gK8RJOEJiTKmgaAq
	D4ZALu8KQ1tuF6+s6VGq8CgTE3UmhUQ3Rn+sj31o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB2AB7FB4
	for <git@vger.kernel.org>; Wed, 25 Apr 2012 14:09:36 -0400 (EDT)
Received: from hydrogen.iovation.com (unknown [74.121.28.6]) (using TLSv1
 with cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E0D897FB1 for
 <git@vger.kernel.org>; Wed, 25 Apr 2012 14:09:34 -0400 (EDT)
X-Mailer: Apple Mail (2.1257)
X-Pobox-Relay-ID: D04A6A84-8F01-11E1-9FBF-FC762E706CDE-76319746!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196326>

Gitsters,

I notice that the usage statement displayed for `git config` mentions -=
-local, but `git help config` does not. Should it? It seems a bit under=
-documented=85

Thanks,

David
