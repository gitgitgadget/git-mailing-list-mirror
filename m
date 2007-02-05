From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Deprecation/Removal schedule
Date: Mon, 5 Feb 2007 16:53:12 +0100
Message-ID: <81b0412b0702050753q5146838bp75faf8681f1f6d56@mail.gmail.com>
References: <7v8xfdnlqm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 05 16:53:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HE69g-0001LZ-Sd
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 16:53:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbXBEPxR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Feb 2007 10:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751409AbXBEPxR
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 10:53:17 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:53776 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751194AbXBEPxQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Feb 2007 10:53:16 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1332102uga
        for <git@vger.kernel.org>; Mon, 05 Feb 2007 07:53:13 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hmJEUUS8ADW3Ys1gB7mGZf86b4Vx7nwel9D59gWL3amJhN8P0XI2n0JNEC8W85uSim44qU180rP6DcS+jnLbb/yTsiwtXV8H2TTITJgNFDRfioWc/bxAWr+l2VlpAEb4BsMMO0yKnFEkf6DQDkznl8VQuVAHEg9VcIjBlEPzbS0=
Received: by 10.78.106.3 with SMTP id e3mr1109646huc.1170690792942;
        Mon, 05 Feb 2007 07:53:12 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Mon, 5 Feb 2007 07:53:12 -0800 (PST)
In-Reply-To: <7v8xfdnlqm.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38756>

On 2/5/07, Junio C Hamano <junkio@cox.net> wrote:
> * git-p4import, git-quiltimport and contrib/gitview
>
>   These have seen almost no activity since their appearance.  It
>   could be that they are already perfect and many people are
>   using them happily, but I find it a bit hard to believe.

Why not leave the importers as examples?
They could be useful to someone.
