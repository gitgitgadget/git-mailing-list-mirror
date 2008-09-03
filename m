From: "Felipe Contreras" <felipe.contreras@gmail.com>
Subject: Re: Git User's Survey 2008 partial summary
Date: Wed, 3 Sep 2008 19:25:17 +0300
Message-ID: <94a0d4530809030925t33d4260bof169372d65717af4@mail.gmail.com>
References: <200809031607.19722.jnareb@gmail.com>
	 <20080903144552.GA27682@spearce.org>
	 <20080903172050.61d510d6@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Wed Sep 03 18:26:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KavBb-0004YG-Bk
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 18:26:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751691AbYICQZT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 12:25:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751962AbYICQZT
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 12:25:19 -0400
Received: from rv-out-0506.google.com ([209.85.198.236]:11870 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751662AbYICQZS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 12:25:18 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2833649rvb.1
        for <git@vger.kernel.org>; Wed, 03 Sep 2008 09:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=bYEmTYvfEt3vgqJESpsjTKY2VhDTmgaj1x7hrtNX254=;
        b=dtKjVmw6bV68kSPVRDReqQlFalEzQ8g6kAblvqtSjKz3V1GkfqR5sTQRVQRBWC1uX9
         N22vQDDj7LxKRq8FGxsKFoqRQpBCYOC8JPBKXJ4kK1WrsxSPe1JjRXBeCTSDPPel5eTy
         lMzZ/s/+IrYJy6K44CTrHU3h0EQzh7I6/NrlY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=A62E2Ppk+fDQfuLKY9pJD72XORzOwaHT/tZxSNjboUGxRnYfdAdAotTE2/nw5enkcY
         OSHC0mStjg7jdypjBgTJFZIfMHvep1U6LnkJM5T5Oc00UFOewXLAETCcxnm6r9Dv8F9W
         D3pR4jK1mnLvMdcOOCaLMG75T6R2M1jTIWeE4=
Received: by 10.141.185.3 with SMTP id m3mr5037822rvp.40.1220459117512;
        Wed, 03 Sep 2008 09:25:17 -0700 (PDT)
Received: by 10.140.166.19 with HTTP; Wed, 3 Sep 2008 09:25:17 -0700 (PDT)
In-Reply-To: <20080903172050.61d510d6@pc09.procura.nl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94809>

On Wed, Sep 3, 2008 at 6:20 PM, H.Merijn Brand <h.m.brand@xs4all.nl> wrote:
> On Wed, 3 Sep 2008 07:45:52 -0700, "Shawn O. Pearce"
> <spearce@spearce.org> wrote:
>
>> Jakub Narebski <jnareb@gmail.com> wrote:
>> > This is partial summary of Git User's Survey 2008 [...]
>> >
>> > 03. With which programming languages are you proficient?
>> >
>> > Around 939 people answered this question.  C is most popular with 59%;
>> > Ruby and surprisingly a bit shell script programming have around second
>> > place, with about 52-53%.  More people are proficient with Python than
>> > in Perl by about 1/3-1/4.  Very few people (25 responses, around 3%)
>> > feel proficient in Tcl/Tk, which means shallow pool of possible git-gui
>> > and gitk contributors.
>
> Rewrite them in perl or python and get more patches?
> The fact that it is not perl withheld me from finding solutions to
> problems I still have with the git-gui gitk combination

Ruby!

-- 
Felipe Contreras
