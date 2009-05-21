From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 0/2] Re: user-manual: general improvements
Date: Thu, 21 May 2009 19:00:17 +0300
Message-ID: <94a0d4530905210900xa464f75se2bd2bf3d8103b10@mail.gmail.com>
References: <1241650416-12224-1-git-send-email-felipe.contreras@gmail.com>
	 <20090507072326.GA13123@vidovic>
	 <7veiv0cvdt.fsf@alter.siamese.dyndns.org>
	 <20090508042814.GA30031@vidovic>
	 <94a0d4530905131430q2250a43ei692265c3f32b5715@mail.gmail.com>
	 <20090514160609.GA12910@vidovic>
	 <7vvdnvtf2n.fsf@alter.siamese.dyndns.org>
	 <20090521041529.GD8091@sigill.intra.peff.net>
	 <94a0d4530905210017x1ce3e32bk3b1fbf9044377763@mail.gmail.com>
	 <7vvdnubl1x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 21 18:00:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7Ah2-0001yr-Qt
	for gcvg-git-2@gmane.org; Thu, 21 May 2009 18:00:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754247AbZEUQAT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2009 12:00:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754181AbZEUQAS
	(ORCPT <rfc822;git-outgoing>); Thu, 21 May 2009 12:00:18 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:25870 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754044AbZEUQAR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2009 12:00:17 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1355256fga.17
        for <git@vger.kernel.org>; Thu, 21 May 2009 09:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=iV9JCfrW/b1uGW7iPS1WBf9mvCstnJTO8SvjNmaJgD4=;
        b=pv9jo3SQsi9N8sWY1HoBisIVNenUttLtAmnVxQolanteizoTFJ7N4NIsBVkR4ABMBD
         Ld65jSwgESDH7HH/B8522jIXoHWuFipWPrsMn1+AwkWUP//34GX6Sl6siMPqs7nmFqFW
         37hB3nS0dNt1eoXuvCSkKhGAostTXSkm2+gYQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Qei3LUe66p4YdBhvwoQVgpiJpb7JCtnpyncUodpCDWMeVE9SyXtjiAB9MZ+Bpz6Ll8
         LhDQe6YOMBkV006kn0f4S8DrBzBryVglILHd59j8uxVtBopryHP8W1dooIfFg2kBqcgY
         4s0SyDKYJikCw7yBF+MoAfAMm4A7LH1xoTw1Y=
Received: by 10.86.4.7 with SMTP id 7mr2316701fgd.46.1242921617152; Thu, 21 
	May 2009 09:00:17 -0700 (PDT)
In-Reply-To: <7vvdnubl1x.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119695>

On Thu, May 21, 2009 at 5:14 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>>> Maybe this was even discussed earlier in the thread (I didn't go back to
>>> look), but it should definitely be part of the commit message.
>>
>> The rule I followed is: change it to whatever looks best.
>
> "Looks best to me" is not something other people can follow to replicate
> the examples you set here to further "clean up" other parts of the
> documentation set or writing new sections to the document you touched up
> with this patch.
>
> I suspect that you would not deny the possibility of saying "The result
> looked better when I last looked at it, but now I think about it I do not
> know why I thought it looked better" three months down the line.
>
> It is not a rule.

The "guidelines" (not rules) I followed are a bit hard to explain,
I'll try to do that, but in the meantime would you deny that the patch
actually makes things a bit more consistent?

-- 
Felipe Contreras
