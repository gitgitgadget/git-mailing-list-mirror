From: Hiroshi Miura <miurahr@linux.com>
Subject: Re: [PATCH] Update japanese translation
Date: Fri, 6 Nov 2015 23:36:19 +0900
Message-ID: <20151106143618.GA5118@miurahr-note>
References: <1446554860-2539-1-git-send-email-miurahr@linux.com>
 <xmqqio5iddf6.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 06 15:36:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zui7x-00072T-W5
	for gcvg-git-2@plane.gmane.org; Fri, 06 Nov 2015 15:36:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932921AbbKFOgZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2015 09:36:25 -0500
Received: from nm10-vm0.bullet.mail.bf1.yahoo.com ([98.139.213.147]:36430 "EHLO
	nm10-vm0.bullet.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751354AbbKFOgY (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Nov 2015 09:36:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1446820584; bh=XjolXDDW6sQBcdwkTqn+YoDGZ1TUThpolO01G0cmgaw=; h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject; b=e/ykjo7zy12apdJDymTaXdUb5e8HUNXJx/feQPe2FkuM0/jDNSqqyelJraaOpZykyWE6ypqj9vRhIREh8doAlHY5ZdFc0ixL7Csogsmg7jeFrYOcR01AELghWoXQQdIT4823LlUGPGkEvURSzWr3W2Zejb3yeV7IvjkUjBKywUaY3EtMbgBwwaWoVVeL+iPpQ459GX8XfyB+gDrFVIPALdJ5e8uvhpXe7BjBvzo9ZjtBMoY+gx3AsGRjrQSjpIxaJq2z1idBlSlidxXNWgE0I0HItDW2E8YXm+e/VsIaTxecni3TkpZI5d7gu5KE9cPGXHdy8yA6V/0aWT50Igefgg==
Received: from [98.139.170.181] by nm10.bullet.mail.bf1.yahoo.com with NNFMP; 06 Nov 2015 14:36:24 -0000
Received: from [98.139.211.197] by tm24.bullet.mail.bf1.yahoo.com with NNFMP; 06 Nov 2015 14:36:24 -0000
Received: from [127.0.0.1] by smtp206.mail.bf1.yahoo.com with NNFMP; 06 Nov 2015 14:36:24 -0000
X-Yahoo-Newman-Id: 32980.6872.bm@smtp206.mail.bf1.yahoo.com
X-Yahoo-Newman-Property: ymail-3
X-YMail-OSG: 4z.L1TYVM1lG.iw9rGWAgeLv5qkgT4T6zs3e7DzhS2y_J9o
 aB.znsoLhdSULBOmF.CsC54AjylI6RltuFQDPJ0DbSjyrVotOmjYbitvsmzK
 jxwqVbF80x44ClvHyap.KV1oFlYpwzsQTwqo.igKRpv03kVNsF2yGGbRgCrk
 8yKJxWTsIEuQQaAILe6v7ZGJ4l4os1BKzt8.DcCB2ReN1KKcPtJuwRek12IP
 bEQKyOjBVxBO61ckZv2Wf5Z5890iZaLrBNKwxYcCJgzbMgYIi6nR2hGNKtOa
 eNQ6ujcnHrVsU.U_SETSO.FkINMCCm8hEWvVAwNyZD6c0WbeOGeVzaGs_y0l
 n6ZwHnaNMCkTlaW5.pW9tz_gF2dcz1sxH.R2ac3XbUopLmdf6PbiGylCbSk1
 goDQmwnX40CJrbb3mMvHP912L7duRYWmTpaQGPNSSUa_5yuTGqrfll4A.Pk9
 UDv1H0YbqKws3vLuXBY026lhwmT6fsnSvxmV8NPYuPZKOBdPJR1af5co9Ce_
 69rXNzgsZJVEcm_SjrWqxG5ycOzSfBNoWTVMv
X-Yahoo-SMTP: TFiWS.GswBDcwJZc5VAEj6aHk.w-
Content-Disposition: inline
In-Reply-To: <xmqqio5iddf6.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280986>

On Tue, Nov 03, 2015 at 12:40:45PM -0800, Junio C Hamano wrote:
> Could you redo this change against Paul Mackerras's tree, which is
> our upstream "gitk" project, that is found here:
> 
>     git://git.kernel.org/pub/scm/gitk/gitk.git
> 
> and Cc Paul Mackerras <paulus@samba.org>  when you post your patch?
 
 Thank you for advise. I tried again.

-- 
Hiroshi Miura
