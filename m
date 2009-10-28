From: Junio C Hamano <gitster@pobox.com>
Subject: Re: vl/git-gui topic
Date: Wed, 28 Oct 2009 00:17:56 -0700
Message-ID: <7v4opkuguz.fsf@alter.siamese.dyndns.org>
References: <7veiovly35.fsf@alter.siamese.dyndns.org>
 <20091027182710.GF10505@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 28 08:18:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N32nK-0007qY-R8
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 08:18:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757532AbZJ1HR7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 03:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757506AbZJ1HR7
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 03:17:59 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47290 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757504AbZJ1HR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 03:17:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3452D69DCB;
	Wed, 28 Oct 2009 03:18:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=sHoqakFoaNQvlluQAU3yDvzSDT8=; b=jKSQ4L6C06FPGAm0lf8Evkz
	V6CKDzw+XSTb1Wrxj1q9Og6RLpRJpfsck93sZ50hk7wYoZlgKOwmxEsIA13J4yok
	JwNgONm0D+V1byD+MRwn8oOpP8huKURjMVr5PRXf/CvInAFyMSqp61iTjp2WulJc
	4OYOd6hpnLdmyD4hcPwQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=nGLDlWHmmTwj5p2zjSaIMm5/gAY3u3Rd6lLBJV+KGWN/1xFWk
	wcHVXshOoSJaOZjGNjYGMYiY8sOhK3XB2A5Q3IuZx3hCI0YRJE8hwtM0gLDeKZqp
	94DOOYV1J0NNPz6+Ga4/pYxVJIk0ksRBWH65sx6iMEuS+olNmnMUgjzZx8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 11EFC69DCA;
	Wed, 28 Oct 2009 03:18:00 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7DA6C69DC6; Wed, 28 Oct
 2009 03:17:57 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 05F7D0B0-C392-11DE-9DF8-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131414>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>> * vl/git-gui (2009-10-16) 1 commit.
>>  - git-gui: adjust the minimum height of diff pane for shorter screen height
>> 
>> Shawn?
>
> Applied to git-gui tree.

Thanks, pulled together with bunch of other changes that looked sensible.
