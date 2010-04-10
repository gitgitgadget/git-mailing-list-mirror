From: Junio C Hamano <gitster@pobox.com>
Subject: rfs: mr/gitweb-jsmin topic
Date: Fri, 09 Apr 2010 23:06:19 -0700
Message-ID: <7vvdbzyh7o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>, Mark Rada <marada@uwaterloo.ca>
X-From: git-owner@vger.kernel.org Sat Apr 10 08:06:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0Tq0-0001Na-J0
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 08:06:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120Ab0DJGGb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 02:06:31 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47214 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750861Ab0DJGGa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 02:06:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 435D2A9BD4;
	Sat, 10 Apr 2010 02:06:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=Yqsb
	cAISfo4EW4IU5lPRMBLL9yM=; b=xMapWUCGj8oZy60B38lb/mKKPFq1/zK6riUj
	1rT1erPCSs4GpDtvHcmoJgyXMdpCkCbQtAO/5GPwNeya2qmZvE+2XK+knnJwW91j
	T4kPMjNssOjb5yp2AznXamlCfAe7NAJm3HIaVTizC6jmy6m3Gz7ovd/mp7/pHPA6
	kVnN2Y8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:from:date:message-id:mime-version:content-type; q=dns; s=sasl; b=
	DukyxMfjFouJmU4yCaYcbev8V9fWymgzSdZjPyLPhJUa2YmT/xi67QLeODvZXVlo
	GQEez8/dl1qkaOVjX1hRpIIOdLWdkB/WW+FNShC+eR4Ybpfh5zgd/ORrWB+hAM3k
	vS4JvbKigCFwW5Ji5kMy3ems2/XCFqI5XAKjBZfVxaw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0FE98A9BD3;
	Sat, 10 Apr 2010 02:06:25 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 687B3A9BD2; Sat, 10 Apr
 2010 02:06:21 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 31AF7D42-4467-11DF-BE89-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144516>

We've had this topic for a few days in 'next', and I think this is safe
enough to merge before 1.7.1.  Any additional comments, worries and/or
objections?
