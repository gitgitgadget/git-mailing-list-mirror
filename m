From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: What's cooking in git.git (Jul 2010, #01; Wed, 7)
Date: Thu, 8 Jul 2010 00:22:37 +0000
Message-ID: <AANLkTilieTlod_GRCzyVz01JRvn73GH2cnz5EnqLgqyv@mail.gmail.com>
References: <7vlj9msve4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 08 02:22:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWet2-00009e-5K
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 02:22:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758179Ab0GHAWi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Jul 2010 20:22:38 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:46809 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757260Ab0GHAWh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Jul 2010 20:22:37 -0400
Received: by iwn7 with SMTP id 7so273818iwn.19
        for <git@vger.kernel.org>; Wed, 07 Jul 2010 17:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+bc7+HmoklB8f9saS0zgvHpkVOdAwEaij/vWZGuKtq0=;
        b=HZWrEdXHk2Kydvk+NBWx0QtQSWZQMykk/MI9CRiffFBjeHxJgfLN+zL3ZP8p4jMPTf
         kb4S+bUBD9wpolwRbkP1x57YAU08SGaW1sNwByMo+a61uYOheV+6u47FvIKR3li7SSnR
         QeB0mUMmwFnXHlKl2L+UKRnhoaD8jmx8+dba8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=waCWzuLlMIWQN7gcgRRcArayX5t0iR/7gfaUiJF7rtWh3d+XY2DHipL3vqpjz7L3Iu
         siZJLih9Uf723lpnIel7zQfmklkOh5OnbJIVeQx71byhBjTG+7axh4iO6LK7nNOhom6O
         pYfSMqZjUp+vWAsoR01EXBXbBqymb/2G9w0tQ=
Received: by 10.231.37.136 with SMTP id x8mr7528298ibd.25.1278548557058; Wed, 
	07 Jul 2010 17:22:37 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Wed, 7 Jul 2010 17:22:37 -0700 (PDT)
In-Reply-To: <7vlj9msve4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150517>

On Wed, Jul 7, 2010 at 23:51, Junio C Hamano <gitster@pobox.com> wrote:

> [Graduated to "master"]
>
> * ab/tap (2010-06-28) 7 commits

Yay, I can prove master now :)

> * ab/i18n (2010-06-23) 1 commit
> =C2=A0- Add infrastructure for translating Git with gettext

Is there anything I can do to help this along, or is it OK and just
needs to cook a bit more?

I don't know if you missed it but as a follow-up to "What's cooking in
git.git (Jun 2010, #04; Wed, 23)" I asked [1] what the status of a few
patches I've submitted are that have seemingly been forgotten.

It'd be nice to know if they were rejected, forgotten or if you just
didn't have time to check them out yet, so I can act appropriately on
my end. And what I should in general do in situations like those
(SubmittingPatches doesn't say), i.e. should I just wait or keep
re-submitting them?

Thanks.

1. (in <AANLkTil8zpoBSOih2sVQV33_GxPao4why3EOGGvPxE-u@mail.gmail.com>
   / http://www.spinics.net/lists/git/msg133946.html)
