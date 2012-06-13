From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] gitk: avoid Meta1-F5
Date: Wed, 13 Jun 2012 17:00:30 +0200
Message-ID: <CAMP44s34CAKbSKd=xKT_zS7sDOQCH-=9gXswdhmYhjFCTYPA8g@mail.gmail.com>
References: <1333758578-9334-1-git-send-email-felipe.contreras@gmail.com>
	<20120425034544.GA9660@bloggs.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	"Daniel A. Steffen" <das@users.sourceforge.net>,
	Alexander Gavrilov <angavrilov@gmail.com>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Jun 13 17:00:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sep3u-000810-Nu
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 17:00:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754483Ab2FMPAe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jun 2012 11:00:34 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:38241 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754447Ab2FMPAc (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jun 2012 11:00:32 -0400
Received: by lahd3 with SMTP id d3so495152lah.19
        for <git@vger.kernel.org>; Wed, 13 Jun 2012 08:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=PkXSZKBtBS6Syfa1/eUSeYmVco1P6SDUUhXksMa1zkU=;
        b=UcXXYPjxbqyMOedq+wO217HnFKg/CSi5P95BYAnVaJAIjjfqPgEkTA7kVKIH5Ayo3g
         U8jm8r0BPTunZhM2EjXurJ1IO2J6HMK2lw+Tc7ZLtn8bedQwuZcUoQrx52jBLOKU5X2y
         BVTtQMkJcpchpPKrV87HATKl/F17AxGAI8qAzdFs3XK9ATlR/xRSDoUtLWCJubDLPerD
         3wn6DmMGCJwV1zfFZwp0xvcgJpFxqt6c4buNqWyXybw6lSul2QtjPiVqoa7qngezQh63
         LxSMbF2xM6a7Q8mbVg9DzaStbev2mya2LjIS0oW5EtZQPgvNQWAZnvvrxaX9wYMUmSZp
         ZQVQ==
Received: by 10.112.83.136 with SMTP id q8mr6336529lby.60.1339599631105; Wed,
 13 Jun 2012 08:00:31 -0700 (PDT)
Received: by 10.112.107.65 with HTTP; Wed, 13 Jun 2012 08:00:30 -0700 (PDT)
In-Reply-To: <20120425034544.GA9660@bloggs.ozlabs.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199895>

On Wed, Apr 25, 2012 at 5:45 AM, Paul Mackerras <paulus@samba.org> wrote:
> On Sat, Apr 07, 2012 at 03:29:38AM +0300, Felipe Contreras wrote:
>> This is commonly mapped by window managers and what not. Use Shift-F5
>> instead.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>
> Thanks, applied.

Does this translate into some action? I still don't see this change in
Junio's tree.

Cheers.

-- 
Felipe Contreras
