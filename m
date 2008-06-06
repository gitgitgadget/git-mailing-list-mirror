From: "Robert Anderson" <rwa000@gmail.com>
Subject: Re: General question about minimal documentation patches
Date: Fri, 6 Jun 2008 15:39:14 -0700
Message-ID: <9af502e50806061539j3962e63oe1124bbe4d76716@mail.gmail.com>
References: <4849B8E8.1090506@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "=?ISO-8859-1?Q?Dirk_S=FCsserott?=" <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Sat Jun 07 00:40:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4kbw-0007uO-L3
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 00:40:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754410AbYFFWjT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Jun 2008 18:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752087AbYFFWjS
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 18:39:18 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:50505 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751871AbYFFWjS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Jun 2008 18:39:18 -0400
Received: by fg-out-1718.google.com with SMTP id 19so801484fgg.17
        for <git@vger.kernel.org>; Fri, 06 Jun 2008 15:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=yjdiD9VP5O4H9d6NNFAMTsJ22MssVYIunrxaoeh4PYI=;
        b=QzHznth3lWV/CUIv0bTKsGpzzRxr/mtYkyxOLKiy4NO8nV0YXFEEqneRkPBE+JSWPc
         LiNRsVcQ/u0tPjUKbyZNgGHX4T5JanZuX+hWAp1LYBWnR+zchHIMHiwY62SgC/9912mZ
         RBZO2do4sjoD4h6wgH8a9j06YPoeknplMJQPU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=J9BjHQl2W8TIAVkH4YMqhtZf2sFUSIVGwkAMAKb/h3VJQo833Zc/HklR1hTHj4UL1y
         J1pxvAmf79HFGIm2oSbsbXgCjB4tZOczhGMYckA+LZ6lEEH8jLuMIKEkTdhm1of0OITm
         sPzNPVV44bFumysW2gSbnA6cI5dzYU96XaI7I=
Received: by 10.86.90.2 with SMTP id n2mr1106032fgb.51.1212791954547;
        Fri, 06 Jun 2008 15:39:14 -0700 (PDT)
Received: by 10.86.95.16 with HTTP; Fri, 6 Jun 2008 15:39:14 -0700 (PDT)
In-Reply-To: <4849B8E8.1090506@dirk.my1.cc>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84126>

On Fri, Jun 6, 2008 at 3:23 PM, Dirk S=FCsserott <newsletter@dirk.my1.c=
c> wrote:
> OTOH, I really don't want to bother you with such patches
> that don't bring forward the "real Git" and only marginally
> contribute to Git itself.

As a new-ish user of git who spends a lot of time in the docs:  please
do it.  These problems range from distracting to downright confusing.

Bob
