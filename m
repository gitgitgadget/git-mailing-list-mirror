From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: What's cooking in git.git (Feb 2010, #06; Tue, 23)
Date: Thu, 25 Feb 2010 22:39:56 +0100
Message-ID: <fabb9a1e1002251339y7ed76fq13af6a7a7a0e957e@mail.gmail.com>
References: <7v635nsa37.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 22:40:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NklRY-0008SA-6q
	for gcvg-git-2@lo.gmane.org; Thu, 25 Feb 2010 22:40:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933935Ab0BYVkS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2010 16:40:18 -0500
Received: from mail-px0-f204.google.com ([209.85.216.204]:59766 "EHLO
	mail-px0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933848Ab0BYVkR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2010 16:40:17 -0500
Received: by pxi42 with SMTP id 42so267315pxi.19
        for <git@vger.kernel.org>; Thu, 25 Feb 2010 13:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=+bH4vXRGrVATv9ojjK0CsE9MVpPLpj+wY7AgJO67aVw=;
        b=EEwSceM6BqLHcvGoZjNTg4X7xvoEd6wz5SCMOhptrBv3f1OrQhi5CyRAP4mOV1yiEZ
         j0GL8IR2hGet/KbEfTF6qnj9XJcCAS1mrIS8mzGT5tgin3dmh+UAsO4m7A/T4gM0JNnA
         pF2Sm3dE7Kuc/zEPdby+ul+RchCaM7pBjTsSY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=ICaoLqO4anp+NyzU2eHLpl4TA7nF9R2iqM31fckc9wckOsdYfPlRoTNv+yhUg07Ib6
         FwD9PShBegu2bwmch5XgOc/AFFJnvgVEJMqNHnlf0CeXUWC+asJWksbL7DkbrvoS3PFq
         AioNDe8E7I2VctLKQQPQ3zTRWIGrWvB4vfSmc=
Received: by 10.142.195.19 with SMTP id s19mr929141wff.312.1267134016077; Thu, 
	25 Feb 2010 13:40:16 -0800 (PST)
In-Reply-To: <7v635nsa37.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141072>

Heya,

On Wed, Feb 24, 2010 at 02:20, Junio C Hamano <junio@pobox.com> wrote:
> I am not a big fan of GPLv3 and do not
> see a compelling reason to switch to v3 for the sake of v3 license per-se,

There is one...

> but helping others that want to use our code might tip the balance.

... the GPLv3 is compatible with the Apache license, which GPLv2 is
not. I don't care much for the GPLv3 either, but I think it'd be
rather nice to be compatible with the Apache license?

-- 
Cheers,

Sverre Rabbelier
