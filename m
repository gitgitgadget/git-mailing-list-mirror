From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v0 3/3] Build in git-rebase.sh
Date: Fri, 22 May 2009 17:30:31 +1000
Message-ID: <fcaeb9bf0905220030l45e1b7dfqd30f35b7c8e43b51@mail.gmail.com>
References: <1242899229-27603-1-git-send-email-pclouds@gmail.com> 
	<1242899229-27603-2-git-send-email-pclouds@gmail.com> <1242899229-27603-3-git-send-email-pclouds@gmail.com> 
	<4A164C85.3000703@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri May 22 09:31:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7PDY-0003Un-Ee
	for gcvg-git-2@gmane.org; Fri, 22 May 2009 09:31:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752290AbZEVHay convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 22 May 2009 03:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752448AbZEVHax
	(ORCPT <rfc822;git-outgoing>); Fri, 22 May 2009 03:30:53 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:14718 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751791AbZEVHau convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 May 2009 03:30:50 -0400
Received: by yw-out-2324.google.com with SMTP id 5so950810ywb.1
        for <git@vger.kernel.org>; Fri, 22 May 2009 00:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=roTWma3Se6QYPEQJdzpvUnI+42WD+8G7EddFBJj5l7Q=;
        b=pp2lGt57C04526X5wRJSoQiOXgW02fj3au/cKR/PZBbs2s0SHen4Qx8jpayONnPB6d
         4BDZm4R9Mex0rajFs2BguT1yuTTOKRf8/2lH7wCqTeezuQhQlwpvqeYR4kYl0zjl8I6G
         8qHs8QChgijHvePeWgXQQHrSPUQc4xFkqDWcI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=sOA44FFjKqiH97WZRGFZMP/oDVfsYMmcgBqmgXe/z2ru35iubvpX/kZQmr5fDXmldn
         e4Hfepl7mPxj8b92Jd6Lkq3KP5FSmREInqOWZ4mkFuB13ByVhFd/UGXfKjxm3U9aPmUn
         JF8S844lmkcM2yn1ur/aRtHBAP83Pep92ehqM=
Received: by 10.100.133.2 with SMTP id g2mr6932967and.23.1242977451113; Fri, 
	22 May 2009 00:30:51 -0700 (PDT)
In-Reply-To: <4A164C85.3000703@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119716>

2009/5/22 Johannes Sixt <j.sixt@viscovery.net>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy schrieb:
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>
> Is it possible for you to test this series on Windows? Many rebase te=
sts
> fail, but I haven't investigated why.

I'll try it this weekend.
--=20
Duy
