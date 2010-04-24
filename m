From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git 1.7.1
Date: Fri, 23 Apr 2010 20:49:39 -0700
Message-ID: <7vpr1pqzl8.fsf@alter.siamese.dyndns.org>
References: <7vtyr1qzp4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 24 05:49:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5WNJ-0007Vj-Ni
	for gcvg-git-2@lo.gmane.org; Sat, 24 Apr 2010 05:49:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752644Ab0DXDto (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Apr 2010 23:49:44 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48607 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752050Ab0DXDtn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Apr 2010 23:49:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 085D3AD41C;
	Fri, 23 Apr 2010 23:49:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LCmbBzGT9tuVaH1V3Nqdknsc/zM=; b=daR7jU
	y1gBsLOtMNatt3JP5fq2WISqKVfb7APP/G0uY1iCeujsqSsdGce9Y2kP2XkpteAC
	GMzB4aEx3qiI20u9tcFHmvY+ebnWP+FB55+74DRC6LmcoDL4wSwjhqX4k3HV/9pd
	auUV+DFnH4aknGb3W7cVbuYJUViTI5mI/vuso=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=c/ZVr7oiBNxnZD34rR5f/x6QHgjmfFd/
	Oj9t7atwVCnxei+Vz1demF5hSUAlInJHYMPl3OSZ0PIiVXUclMO27EGxouR6oXMW
	k5a4dUf+hAVkzN8lJWazcKiWFrqDkajwIErrEHv8s1fI7Q0gGXkiaQGeSN7A5llQ
	3xYJtxh8yKY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E9C4CAD41A;
	Fri, 23 Apr 2010 23:49:41 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 77553AD419; Fri, 23 Apr
 2010 23:49:40 -0400 (EDT)
In-Reply-To: <7vtyr1qzp4.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri\, 23 Apr 2010 20\:47\:19 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6A09E4FA-4F54-11DF-942F-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145655>

Just FYI, I'll likely to be only sparsely online until mid next week.
