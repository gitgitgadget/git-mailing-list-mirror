From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v6] Improve remote-helpers documentation
Date: Sun, 28 Mar 2010 22:02:10 +0530
Message-ID: <f3271551003280932l6fde201fpf2096dd368c13c84@mail.gmail.com>
References: <f3271551003230045v523d2088v18b21a4a5c424ff0@mail.gmail.com> 
	<f3271551003230238y6143d770h4e23686d41fce667@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 28 18:32:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvvPg-0006BU-RR
	for gcvg-git-2@lo.gmane.org; Sun, 28 Mar 2010 18:32:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754783Ab0C1Qcc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Mar 2010 12:32:32 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:34196 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754506Ab0C1Qcb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Mar 2010 12:32:31 -0400
Received: by gwaa18 with SMTP id a18so3574884gwa.19
        for <git@vger.kernel.org>; Sun, 28 Mar 2010 09:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=Z7W2Nm42G/BSzCz7wblsSb80/ZlmYE+Df3MZUhdb1us=;
        b=TGDfL2IR9YJLs3s2rBkA27O84cE/Os0J55sgwFyDgkXGx0uDzNDYeE5UhEakoWuj+p
         oWe+Wb70FHuZCoi/3BgwOzRK6Ifp3qtyVHD0uXFwWugjy3bbrk3S78dv+nrvEgbvFB/M
         zmV9QRNsBRPuLb46g6MO7XcsvstrB/Vxwi+vI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=OIQ4KxZFbb9qKhLDdHUsa8d5zg3Qx0/W20aFdUrzimYcrs+GHoxwCwcS4yXMjIGxcu
         ht80l733bGP2JAoT7KdeHLV/OuRuynS55kwVHBKNECnjSDovmVXxOAI3iXDR16YgBMEW
         pwdkemS4GCvzII+gAtEk9JNBHaUkkpi2aFfsM=
Received: by 10.90.69.14 with HTTP; Sun, 28 Mar 2010 09:32:10 -0700 (PDT)
In-Reply-To: <f3271551003230238y6143d770h4e23686d41fce667@mail.gmail.com>
Received: by 10.90.57.15 with SMTP id f15mr2735708aga.107.1269793950239; Sun, 
	28 Mar 2010 09:32:30 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143399>

On Tue, Mar 23, 2010 at 3:08 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Rewrote the description section to describe what exactly remote
> helpers are and the need for them. Mentioned the curl family of remote
> helpers as an example. Fixed minor typos in the rest of the document.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>

Junio: So is this patch alright?

-- Ram
