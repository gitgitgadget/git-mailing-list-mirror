From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Re: Git-aware HTTP transport
Date: Wed, 27 Aug 2008 08:51:20 +0600
Message-ID: <7bfdc29a0808261951t59af433bkefa77ef8c370ecbd@mail.gmail.com>
References: <20080826012643.GD26523@spearce.org> <48B36BCA.8060103@zytor.com>
	 <20080826145857.GF26523@spearce.org> <48B4303C.3080409@zytor.com>
	 <20080826172648.GK26523@spearce.org> <48B485F8.5030109@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 04:52:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYB90-00016v-8J
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 04:52:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752192AbYH0CvW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 22:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752147AbYH0CvW
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 22:51:22 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:52900 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752144AbYH0CvV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 22:51:21 -0400
Received: by yx-out-2324.google.com with SMTP id 8so1234729yxm.1
        for <git@vger.kernel.org>; Tue, 26 Aug 2008 19:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=OaDYdIOAt5Hz7rqJcyuwiskurP2os+oeQr+wEPr+gmQ=;
        b=t4N6dkm0ZiI0Qa6Ulhjpxu+fWiuLGfnjaoAZaAIGAAZ5xNNwaNhLTWqjmjfBleVM1J
         9r3ipDsq1lhxmyWYASA1ZldmjA3gJLzgWN0Te46rM9mv5kBOdN8Cl6S6J322OjjQvu8O
         T4DCdJ1neW97V2qv5zmWV4AssRaYBUS1mk57c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=FUNnIatTgV068gaZzJb/YNb3/yO1xVGm9iIUsRmwK/pr92MOJYTFWg+ZvqVvH+wXWv
         D2jmpY9u2KgI+4Y/HEKoaOk4GuJrgtIHH5LxhndR0JvcjnoUhEjrfPEX6qPG4gYPPeej
         jJPibR8Y0r7EDxUzaPntn0XTYI1eihP0DtRHQ=
Received: by 10.150.12.10 with SMTP id 10mr10293839ybl.214.1219805480338;
        Tue, 26 Aug 2008 19:51:20 -0700 (PDT)
Received: by 10.150.225.1 with HTTP; Tue, 26 Aug 2008 19:51:20 -0700 (PDT)
In-Reply-To: <48B485F8.5030109@zytor.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93846>

On Wed, Aug 27, 2008 at 4:38 AM, H. Peter Anvin <hpa@zytor.com> wrote:
> Shawn O. Pearce wrote:
>>
>> Discard my prior patch from today.
>>
>> This is a patch to last night's full document edition
>> (http://article.gmane.org/gmane.comp.version-control.git/93704)
>> and addresses only the issue of redirects.
>>
>
> Looks great to me.

This looks really good! The redirect idea just seems cool!

- Imran

>
>        -hpa
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

-- 
Imran M Yousuf
Email: imran@smartitengineering.com
Blog: http://imyousuf-tech.blogs.smartitengineering.com/
Mobile: +880-1711402557
