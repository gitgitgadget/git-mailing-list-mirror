From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: What's cooking in git.git (Jun 2011, #02; Sat, 11)
Date: Mon, 13 Jun 2011 18:07:40 +0200
Message-ID: <BANLkTik7iKe0n8Biyg0-nfLRyA5VJHsL4Q@mail.gmail.com>
References: <7voc23sfxd.fsf@alter.siamese.dyndns.org> <BANLkTimHhaLu2ZGFG4ev_jWMu8szH8r=+g@mail.gmail.com>
 <7vr56xpxbu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 13 18:08:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QW9gg-0006To-5Q
	for gcvg-git-2@lo.gmane.org; Mon, 13 Jun 2011 18:08:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141Ab1FMQIV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2011 12:08:21 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:35243 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083Ab1FMQIV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2011 12:08:21 -0400
Received: by qwk3 with SMTP id 3so2236704qwk.19
        for <git@vger.kernel.org>; Mon, 13 Jun 2011 09:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=x3XKEhe3sJJ9ILyF8r2jLuEB/VgQSjHVSNDBQze8KWg=;
        b=mvSxrzWJa8MHzVMN4v4L1IjnO66iVn6vp/u60kjhWHLL0nwXfY2VB3ZXg5463fgArl
         ZEBDZmd3kL4fbBmJSMLUaIXp5Faw8iiuqiELVsBiJNI/vYu1I5jGnwJi/RGbrnUUqxPc
         wbqXaXEPrzXOqGuhO6zU2XzXlMk2PdjDPNZnw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=YAcaiyBqQIYau9U3eohysTzCQqO8EzJvQNRSlM4UnSrDsw+4NleYVH0tdkHcEbgRxq
         vDmbdibNr7kSNVzeBcsDsjvM+ljE0CpcU/zzu24g3IWPaILPdTFWIZUhiTBj0jUABXRM
         uOnAihdzY39bLhu6LfBq+2GS8Xyp7Xgo+N/vM=
Received: by 10.229.127.99 with SMTP id f35mr4310304qcs.91.1307981300174; Mon,
 13 Jun 2011 09:08:20 -0700 (PDT)
Received: by 10.229.83.203 with HTTP; Mon, 13 Jun 2011 09:07:40 -0700 (PDT)
In-Reply-To: <7vr56xpxbu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175718>

Heya,

On Mon, Jun 13, 2011 at 17:25, Junio C Hamano <gitster@pobox.com> wrote:
> Yeah, I know about the series (didn't I have some comments in the
> discussion thread?)

Yes you did, I'd forgotten, sorry about that.

> and also I think I saw you talk about a re-roll during
> the discussion before I wrote the What's cooking summary you are
> responding to, which is why it does not appear in the list.

Ok, :)

-- 
Cheers,

Sverre Rabbelier
