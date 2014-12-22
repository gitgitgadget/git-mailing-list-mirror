From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Documentation/SubmittingPatches: unify whitespace/tabs for the DCO
Date: Mon, 22 Dec 2014 09:55:59 -0800
Message-ID: <xmqqsig7a7rk.fsf@gitster.dls.corp.google.com>
References: <xmqq1tnx961q.fsf@gitster.dls.corp.google.com>
	<1418864895-18583-1-git-send-email-sbeller@google.com>
	<1418864895-18583-3-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Dec 22 18:56:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y37DH-0006Yw-V5
	for gcvg-git-2@plane.gmane.org; Mon, 22 Dec 2014 18:56:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755555AbaLVR4H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 12:56:07 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61750 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755224AbaLVR4F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 12:56:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EE51E2876C;
	Mon, 22 Dec 2014 12:56:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=R0D0p7it59gYohf0mSqbcU0q1dI=; b=RocVMU
	S0M6+mh/xldIUS7hq9jUIizgTPCqd1qThpoc/nX7HPgDf+42H8Zo+K7mPNwlxfdz
	INNLqPuO2AwIu+KRxhpuJHuJ3CGZQuIzbFRzUNQHAWxJ7Py36dPnRKnM2tlriJNH
	lGBHcrnDCjqu4rPatev1zds91OvJdt0j+EfIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JLFy0h+/cQgar462oqLn4ZKbEdiVJtuV
	k3fCaE5lUpIPT5YwRAOBWtWzmlsrlJsaE5ezKc0UHrNgf34Y3F55X/hb0UaQRRWO
	YVjAihaau0wD4lDa5GKkaesJiZNJRYWMRcBl2BPvFlpdw/ipMEj1/yNgT4bwTUu7
	9bIjrAn+8as=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DD5772876B;
	Mon, 22 Dec 2014 12:56:04 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2A13B28769;
	Mon, 22 Dec 2014 12:56:01 -0500 (EST)
In-Reply-To: <1418864895-18583-3-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Wed, 17 Dec 2014 17:08:15 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CA51D216-8A03-11E4-9243-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261658>

Stefan Beller <sbeller@google.com> writes:

> The Developers Certificate of Origin has a mixture of tabs and white
> spaces which is annoying to view if your editor explicitly views white
> space characters.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
> Notes:
>     I'll also try to send it upstream to linux.

Thanks.

>
>  Documentation/SubmittingPatches | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index 16b5d65..6124f34 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -258,15 +258,15 @@ pretty simple: if you can certify the below:
>              person who certified (a), (b) or (c) and I have not modified
>              it.
>  
> -	(d) I understand and agree that this project and the contribution
> -	    are public and that a record of the contribution (including all
> -	    personal information I submit with it, including my sign-off) is
> -	    maintained indefinitely and may be redistributed consistent with
> -	    this project or the open source license(s) involved.
> +        (d) I understand and agree that this project and the contribution
> +            are public and that a record of the contribution (including all
> +            personal information I submit with it, including my sign-off) is
> +            maintained indefinitely and may be redistributed consistent with
> +            this project or the open source license(s) involved.
>  
>  then you just add a line saying
>  
> -	Signed-off-by: Random J Developer <random@developer.example.org>
> +        Signed-off-by: Random J Developer <random@developer.example.org>
>  
>  This line can be automatically added by Git if you run the git-commit
>  command with the -s option.
