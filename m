From: Alangi Derick <alangiderick@gmail.com>
Subject: Re: [Patch] Nice help Output - SmallProjectIdea[1]
Date: Sat, 2 May 2015 08:04:02 +0100
Message-ID: <CAKB+oNtwJtW3h22W_8hEhhYnxAiynM1B839_WO7Yp=eJF_7PpQ@mail.gmail.com>
References: <CAKB+oNvZxueR9PqysPn3khQZL+8tt3NNrgFzNjHnVuBVtyeZ4w@mail.gmail.com>
	<87wq0sw1tb.fsf@hank.tgummerer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 02 09:04:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoRT6-0002OG-R7
	for gcvg-git-2@plane.gmane.org; Sat, 02 May 2015 09:04:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751276AbbEBHEE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 May 2015 03:04:04 -0400
Received: from mail-qc0-f180.google.com ([209.85.216.180]:36251 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934AbbEBHED (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 May 2015 03:04:03 -0400
Received: by qcbdu2 with SMTP id du2so10648233qcb.3
        for <git@vger.kernel.org>; Sat, 02 May 2015 00:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=nxpGq9/uF7/xm/mub0d+KKeOh7EFDgH9mxThE1lsrLM=;
        b=adXDM1oKVas4XyaH5f24iWopbVEVJMXAZtN+/RMH88tLyYlKU2WajoEZTgbkcrKhBG
         ky8WLvcsx0xSv1goTIiDXmVgUfVbn5m6JaxaXv/EG5Q+IGzNFxV1gwmpjn4iFOORk2gk
         l4y7uPcV/hTDJa33hM3Rm0oc+g7ucfS5FiA7NILTscGfxVsQlOhkD3fAnwoy16tTXmVH
         u6KZ/y//1mqgvjpQ5ylOpWux+y+456FXUumLGcva+hiI7/Tgl0CTsgmTd7L+7t17fgbu
         hlDqMrsVIa+xeCDL8dOPDOfrucnIpFMtAl0u4A8tNivRmhKkTvAV8ezsTvHjv8vm5gGM
         uL/Q==
X-Received: by 10.140.192.73 with SMTP id n70mr16385174qha.91.1430550242598;
 Sat, 02 May 2015 00:04:02 -0700 (PDT)
Received: by 10.229.45.71 with HTTP; Sat, 2 May 2015 00:04:02 -0700 (PDT)
In-Reply-To: <87wq0sw1tb.fsf@hank.tgummerer.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268221>

Thanks for the correction. I will work on that and see if i can solve
the problem. With respect to my git send-email, it is not working so i
don't know whether i have a problem with my smtp. I don't know how to
configure it.
