From: Elijah Newren <newren@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2010, #02; Wed, 11)
Date: Thu, 12 Aug 2010 15:12:34 -0600
Message-ID: <AANLkTikLLrb0rBHXuMvfZGqdoTja1Nz+zVvkY2Njv=4F@mail.gmail.com>
References: <7vlj8cvi2e.fsf@alter.siamese.dyndns.org>
	<AANLkTinvWO_OakFbuHWrRWYCg4bvHuVPu8=d0_y5o0Ws@mail.gmail.com>
	<7vsk2ju8yi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 23:12:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ojf4s-0000MG-N6
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 23:12:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760419Ab0HLVMh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Aug 2010 17:12:37 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39292 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755207Ab0HLVMg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Aug 2010 17:12:36 -0400
Received: by fxm13 with SMTP id 13so1008842fxm.19
        for <git@vger.kernel.org>; Thu, 12 Aug 2010 14:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=QKqgQnVkYgftFSJNLgco4bnTmVwU+zb0f+Z7I6tnai8=;
        b=xWeHEmoVVC6sQlQlRRH9zFwuQRpshasHDBlEeSR/H2B6v7aK9IrUrNWVU0TsSwq2Rr
         ey1XxS2ZuN2trLNacAF8ZXAlOlrLTjy/I5VAvhNCy/qlseKqWY6h6Eo1NCDMH40b+ppL
         JulAYjEP45VJQrLb0/KkkI6wRkssM9Do5tKP0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=E7N0vufQ466+GlZVSBsnijACeFAkHRqsiYHiRWNTOIaSBE5rePrH7hwuhFuZ3UnnJz
         MNDcb7JBsW0aoN7B/teKYmyDg0RPyFWM8mlOJS3WfYtARPHu+S76ZM0uk2PSrq6Htdtv
         mesupfZZiJ4X8+jQCcHCLyyvXMzWXIcq2NNtc=
Received: by 10.223.113.13 with SMTP id y13mr851142fap.37.1281647554996; Thu,
 12 Aug 2010 14:12:34 -0700 (PDT)
Received: by 10.223.149.82 with HTTP; Thu, 12 Aug 2010 14:12:34 -0700 (PDT)
In-Reply-To: <7vsk2ju8yi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153419>

Hi,

On Thu, Aug 12, 2010 at 9:49 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Elijah Newren <newren@gmail.com> writes:
>> Out of curiosity, is there anything preventing these two series from
>> advancing?
>
> Nothing other than that we have been in pre-release freeze to 1.7.2 t=
il
> late last month, then immediately after the release I got bogged down=
 in
> unpacking cardboard boxes, moving between apartments, during which pe=
riod
> I started slowly re-reading pent-up topics and merging ones that look=
ed Ok
> to 'next'. =C2=A0And then I got sick and haven't been productive for =
the past
> few days...
>
> Sorry.

No worries -- I was just curious if there were any technical issues
that needed resolving.  I hope your recent activity means you're
feeling better.
