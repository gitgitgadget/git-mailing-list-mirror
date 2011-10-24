From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v0] fast-import: Add drop command
Date: Mon, 24 Oct 2011 20:01:56 +0200
Message-ID: <CAGdFq_heamPfKpK2sQ1RUvceaeGRVAwkv=KAn-ByPyPkNtoZBA@mail.gmail.com>
References: <1316878065-11782-1-git-send-email-vitor.hda@gmail.com>
 <1316878065-11782-2-git-send-email-vitor.hda@gmail.com> <20110924193733.GB10955@elie>
 <CA+gfSn8Z7Xn1hdpqNHiP3bd2KGRqcAc6O683Z4O+G=jNNYJtBA@mail.gmail.com>
 <CAOpHH-WSyD23GKtZ2nLiSsJfLU-+7ibyGhGccyvtAhKQ-jffBw@mail.gmail.com> <CAOpHH-WxhvEP58KkGhnJbATbzU6PDBeQB1_fhbQ+0fzDXznaYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Dmitry Ivankov <divanorama@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	David Barr <davidbarr@google.com>
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 24 20:02:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIOrH-0004Dj-OI
	for gcvg-git-2@lo.gmane.org; Mon, 24 Oct 2011 20:02:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755864Ab1JXSCh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Oct 2011 14:02:37 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:37606 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755823Ab1JXSCg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Oct 2011 14:02:36 -0400
Received: by qyk27 with SMTP id 27so5808312qyk.19
        for <git@vger.kernel.org>; Mon, 24 Oct 2011 11:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=FapW5Psaq7oKUqWULeRPkeTuPvgC2p3KvULmOE7xCDw=;
        b=AvEh1uARkOEZwcG1riQULWx/z9u7W/g7KVdXkCSGt87kuH/EN30I4LXk500fguOcTd
         nyDauVoHsyWq8bvzSV1gA92p7tJuv6oRE/rdcJe6+B4AJsDNIpokvcdmXUd0IcnAIkp+
         dSxskviTFC/kBui+m3AflaSZeWPGafybBAihM=
Received: by 10.182.7.10 with SMTP id f10mr3535238oba.56.1319479356093; Mon,
 24 Oct 2011 11:02:36 -0700 (PDT)
Received: by 10.182.52.3 with HTTP; Mon, 24 Oct 2011 11:01:56 -0700 (PDT)
In-Reply-To: <CAOpHH-WxhvEP58KkGhnJbATbzU6PDBeQB1_fhbQ+0fzDXznaYw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184183>

Heya,

On Mon, Oct 24, 2011 at 18:37, Vitor Antunes <vitor.hda@gmail.com> wrote:
> This thread did not receive any updates for a long time.
> Could someone provide some feedback?
>
> Is this feasible? Does it make sense to add this command? If not, why?

I for one welcome our new branch deleting overlords :).

You mention that checkpointing solves some of the concerns raised by
others in this thread, would automatic checkpointing be way to make
sure everything is as it should be?

-- 
Cheers,

Sverre Rabbelier
