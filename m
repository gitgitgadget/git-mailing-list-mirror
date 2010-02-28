From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 0/4] Using git-mailsplit in mixed line ending
 environment
Date: Sun, 28 Feb 2010 13:18:07 -0800
Message-ID: <7vvddhukj4.fsf@alter.siamese.dyndns.org>
References: <1266080362-24760-1-git-send-email-stefan.hahn@s-hahn.de>
 <1267280428-18223-1-git-send-email-stefan.hahn@s-hahn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
X-From: git-owner@vger.kernel.org Sun Feb 28 22:18:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlqWt-0002IL-58
	for gcvg-git-2@lo.gmane.org; Sun, 28 Feb 2010 22:18:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032082Ab0B1VSP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2010 16:18:15 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41196 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032041Ab0B1VSO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2010 16:18:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BF3F09DBF5;
	Sun, 28 Feb 2010 16:18:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=d8SN2ftBLo8S+nEqUgWPPSiFfoY=; b=lAppGqU6uIMtfV5B/gJ87G1
	ZurOEqxhRh4C3Yh+yP3SmoyG4AgQSf1oJMtMKZ2t2rQH5XtWnqBak9CMMNbOcsVs
	dhc46NbPi2UjG3uNI9AdSuuSCatldMfk3U91jqKOWbSxTqcKgHZsWJDXd/Gysh4o
	3aZ9qxhh/Cj38IEKfpUk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=eRlBx+CSokorH+7EnsoOIcfIpRuErlMlGkN4/hfa5kwrgsi2G
	kT6ehq7mW8tOJzSrxAyOw+QiGoz0JIzAjWYGLANO+GEpLu8z04E2R1YhRLIQqIfS
	w1Bg2144opMiFWOTVBJkCItSPC6CXK9RjfsELakak8ife2ZYCnxszs1K9o=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D34D9DBF4;
	Sun, 28 Feb 2010 16:18:11 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 160779DBF3; Sun, 28 Feb
 2010 16:18:08 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C66A0F02-24AE-11DF-83E6-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141275>

Thanks, will queue.
