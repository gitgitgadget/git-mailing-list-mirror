From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/git-gc.txt: change "references" to
 "reference"
Date: Tue, 20 Oct 2009 00:23:50 -0700
Message-ID: <7vskder0jd.fsf@alter.siamese.dyndns.org>
References: <1256016145-21680-1-git-send-email-kraai@ftbfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matt Kraai <kraai@ftbfs.org>
X-From: git-owner@vger.kernel.org Tue Oct 20 09:24:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N094d-0002Vr-RO
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 09:24:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755582AbZJTHXx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 03:23:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755536AbZJTHXx
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 03:23:53 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33794 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755404AbZJTHXx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 03:23:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E4A35FC81;
	Tue, 20 Oct 2009 03:23:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=58TUtX7PRKuYWjlTJ473tDInOi0=; b=FM+/8mK35VPk6S8hEw0LJ4F
	Np9BWaGPSd7W24z3U6n8AxD37WEKqnHVkYJ+iYfICpUEnKa34E86nc9KDj5u04Cj
	0QODRKx1MsrHqn4s3nSV2iQuI80FkFuNNz5gotR0cVrC2e296jt1PGZO55rl3Q/S
	27VLoK/lc9C1ZvDurlTA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=JvNHk0ocD1wGSXk9Q3TKOX+mVHrDhyOBP5w5rHstcmMgRdHCV
	Vhrq9ysX08mExhQ/NxmdJJsDJe+S9aLBMrmOsjYao1ohwIKEMseqqd2ajHiGWY7I
	688gTCiy2ETTtBw3msgz3JssgO9/ZCCFEyEsMARtN10w7qcmfVB745aTj4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C5D35FC7F;
	Tue, 20 Oct 2009 03:23:55 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 634145FC7E; Tue, 20 Oct
 2009 03:23:52 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 864205D2-BD49-11DE-A3B3-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130770>

Thanks.
