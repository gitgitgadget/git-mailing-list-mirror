From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH 1/8] CodingGuidelines: typofix
Date: Thu, 01 May 2014 16:09:38 +0200
Organization: Organization?!?
Message-ID: <87tx99zj31.fsf@fencepost.gnu.org>
References: <1398894312-30763-1-git-send-email-gitster@pobox.com>
	<1398894312-30763-2-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 01 16:10:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfrgU-0000gO-LQ
	for gcvg-git-2@plane.gmane.org; Thu, 01 May 2014 16:09:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755127AbaEAOJy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 10:09:54 -0400
Received: from plane.gmane.org ([80.91.229.3]:42048 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751468AbaEAOJy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 10:09:54 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1WfrgN-0000XU-0c
	for git@vger.kernel.org; Thu, 01 May 2014 16:09:51 +0200
Received: from x2f52453.dyn.telefonica.de ([2.245.36.83])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 01 May 2014 16:09:51 +0200
Received: from dak by x2f52453.dyn.telefonica.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 01 May 2014 16:09:51 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: x2f52453.dyn.telefonica.de
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4.50 (gnu/linux)
Cancel-Lock: sha1:0XF7cPUvDR4fEqCUt+BTVm3C/Bs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247811>

Junio C Hamano <gitster@pobox.com> writes:

> The sentence lacked the necessary verb.

No, it didn't.

> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/CodingGuidelines | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> index f424dbd..fdf6269 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -15,7 +15,7 @@ code.  For Git in general, three rough rules are:
>     let's use it".
>  
>     Again, we live in the real world, and it is sometimes a
                                               ^^
> -   judgement call, the decision based more on real world
> +   judgement call, the decision is based more on real world
>     constraints people face than what the paper standard says.

There is one common "is" for original statement and paraphrase.  Adding
another one turns this into two sentences which cannot sensibly be
connected with a comma.

If you want to fix something here, do s/judgement/judgment/ instead.

-- 
David Kastrup
