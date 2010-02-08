From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: A Visual Git Reference
Date: Tue, 9 Feb 2010 07:34:53 +1100
Message-ID: <2cfc40321002081234t2e8585bxfbcae41b18804e70@mail.gmail.com>
References: <ca433831002081134m698f531bwa22f0474db0cdcb@mail.gmail.com>
	 <20100208195141.GF30877@m62s10.vlinux.de>
	 <ca433831002081221o660ff882o703381c5f066512e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Baumann <waste.manager@gmx.de>,
	git list <git@vger.kernel.org>
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 08 21:43:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeaS6-0001Dk-Qh
	for gcvg-git-2@lo.gmane.org; Mon, 08 Feb 2010 21:43:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080Ab0BHUnQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Feb 2010 15:43:16 -0500
Received: from mail-pz0-f172.google.com ([209.85.222.172]:57859 "EHLO
	mail-pz0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780Ab0BHUnO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Feb 2010 15:43:14 -0500
Received: by pzk2 with SMTP id 2so278012pzk.21
        for <git@vger.kernel.org>; Mon, 08 Feb 2010 12:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=sQtIyOajvXWZU4XjiXw0mfHplJeK1ALk48JcCbSL7zs=;
        b=K2p/yEMaRvTENL7YTiATa654A/aNewEPFtpBV99KgwNkm7c8pyXGaaaeFw8/Flr85s
         kurQHcAIKwySQUJUwcy4+x9ULlJQQeNLAFUOKnw5IHLbgEy32mkdf4V8TuTfnQQqQ9ge
         ZypyFYfyUuWE+ioEJ80IE1WEALMtDYuUwPKxM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pDv7N4/KLgYP0S/JbvIBD2Nt2QvwiWbY+nftoDre405XZ/3x0FifwocHOtSx2xZYDs
         jpXVI14tmQzQq+wYnQ1+QWwBhTT5dggMasdULZRz7n1fjkqlahFzYEQrSLQWqK4PqjEg
         bRx6522hSb4f4yPlr9wqGtPMeDr/06h1TmXPY=
Received: by 10.115.64.5 with SMTP id r5mr2016126wak.183.1265661293702; Mon, 
	08 Feb 2010 12:34:53 -0800 (PST)
In-Reply-To: <ca433831002081221o660ff882o703381c5f066512e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139315>

G'day Mark,

Nice diagrams. You might want to change the arrows on the diffs to be
consistently in direction of the forward diff.

jon.

On Tue, Feb 9, 2010 at 7:21 AM, Mark Lodato <lodatom@gmail.com> wrote:
> On Mon, Feb 8, 2010 at 2:51 PM, Peter Baumann <waste.manager@gmx.de> =
wrote:
>> I have only glanced over the page, but it seems you have made the ti=
me
>> flow from right to left. Is this intentional? I find it not very int=
uitive.
>
> Good call. =A0I don't know why I did that. =A0I just pushed a new ver=
sion
> that goes left-to-right.
>
> Thanks,
> Mark
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
