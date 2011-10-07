From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Prompt for merge message?
Date: Thu, 06 Oct 2011 20:07:31 -0700
Message-ID: <7vy5wxwlcc.fsf@alter.siamese.dyndns.org>
References: <6eb7acc7-f4be-4b90-a2fa-a0c91ed9a5a8@t11g2000yqk.googlegroups.com>
 <7vsjn5ye0x.fsf@alter.siamese.dyndns.org>
 <403e37d1-bdd3-46fc-9a9a-e8aab3a2d3ba@f6g2000vbm.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Todd A. Jacobs" <nospam+listmail@codegnome.org>
X-From: git-owner@vger.kernel.org Fri Oct 07 05:07:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RC0mm-0002k7-9H
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 05:07:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965367Ab1JGDHg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 23:07:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64935 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965366Ab1JGDHe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 23:07:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 67E745B4E;
	Thu,  6 Oct 2011 23:07:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7newexWdQ0ApE8rHQkzi5AgvIrE=; b=VQarZ5
	jgaseplxMqmlySrCWVygMrs7IfAUufrXpIwznBBGPBax3zA+bW6CsM6e3uN+QVbM
	P06/v2GWU96eD85WD7IVvctp076jD87HJ3xlcrCQc1tyLKMREJK83grhtyvI9lFZ
	mjscJUaiZ4wTMXFNECbsqxbpy2ZAeM81rqtgQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GaKG7fSS5NYb8w819ZLR/JxTFnUWcSqa
	+uijMRkPaeFtHK4WSkES5C0NzqKYTJN8cOhvJnSNcmmfPufhn/ulrbXsNDgSOLml
	/xidl4i3X0YNfOEWN7mniSOSvJTTohWb8XhCwMndm3LPefZOPDscocxYnz9o9MGr
	cvTggnV1CjQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5FBF65B4D;
	Thu,  6 Oct 2011 23:07:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CFBF75B4C; Thu,  6 Oct 2011
 23:07:32 -0400 (EDT)
In-Reply-To: <403e37d1-bdd3-46fc-9a9a-e8aab3a2d3ba@f6g2000vbm.googlegroups.com> (Todd A.
 Jacobs's message of "Thu, 6 Oct 2011 18:15:11 -0700 (PDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7FF21CDA-F091-11E0-BABE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183056>

"Todd A. Jacobs" <nospam+listmail@codegnome.org> writes:

> On Oct 6, 6:02 pm, Junio C Hamano <gits...@pobox.com> wrote:
>> Others commented on the current practices and gave their own useful tips
>> already, but an additional hint is to name your branch more sensibly, so
>> that you do not feel it is useless to record it in the history.
> ...
> Ultimately, I guess what I'm really agitating for is just an editor
> option for merge commits. If you take work-flow out of the equation,
> isn't there still a case for easily-editable merge messages?

I do not see any reason for you to be agitated. All you need to do is to
read beyond what you chose to quote from my message, read that part before
omitting from your quote ;-).
