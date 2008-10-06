From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH 4/6] Add 1.0 TODO items from recent discussion by private mail
Date: Mon, 6 Oct 2008 21:50:32 +0100
Message-ID: <b0943d9e0810061350k6b90328cqe49db4b0d3f6c87e@mail.gmail.com>
References: <20081005155450.19886.43748.stgit@yoghurt>
	 <20081005160151.19886.30979.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Mon Oct 06 22:52:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kmx3R-00050U-JD
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 22:51:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754337AbYJFUue convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Oct 2008 16:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754279AbYJFUue
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 16:50:34 -0400
Received: from wf-out-1314.google.com ([209.85.200.175]:36610 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753855AbYJFUud convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Oct 2008 16:50:33 -0400
Received: by wf-out-1314.google.com with SMTP id 27so2956555wfd.4
        for <git@vger.kernel.org>; Mon, 06 Oct 2008 13:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ZeRO/Ib49DmaT9HXkE+HkI15/GOdjD6dpVXCO0824hs=;
        b=gvM75TMgrRTNKU5jhjc2/KvBGEJ3EaHz6ZjPPi+WtDdj6E5yAkw5+8vPv6iNevhUt5
         TfkFhHW9SCkfHDpV52udGAi1dq0pCRRxb35hMviyzWUKHPJXm0Ru1lBwy87ByZDzJ+FF
         SSkzS2D8514ZHrTJoVPtleQXe7wQrRzcVFctQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=TttsIKM/L+YevyP8CyZL5Ma3/Gu6dDI0oS91v+cjtqCnHZz405noEroqbQpYA5JvqE
         1EAqwhWBp86bEKSbXVCI1U8Zvc/bSI5j2fFoH/EKgEVluXFNpLjnSYGvIfesvvwAdfqN
         7ZB+kvtECn8l3A9RmORvYu1TuYC01TrtK/ZlI=
Received: by 10.140.201.21 with SMTP id y21mr3346794rvf.259.1223326233063;
        Mon, 06 Oct 2008 13:50:33 -0700 (PDT)
Received: by 10.141.201.12 with HTTP; Mon, 6 Oct 2008 13:50:32 -0700 (PDT)
In-Reply-To: <20081005160151.19886.30979.stgit@yoghurt>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97628>

2008/10/5 Karl Hasselstr=F6m <kha@treskal.com>:
> +- Convert the remaining commands to the new infrastructure.
> +
> +- Go through the design of the UI and make sure there's nothing hard
> +  to change in there that we'll regret later.
> +
> +- Write a user guide. I'm thinking a document on the order of 10-30
> +  pages that'll explain why one would want to use StGit, and how.
> +
> +- Make sure the rest of the documentation is in good shape.

Actually, at least for these kind of things we should still keep this
file. We could drop it after 1.0.

--=20
Catalin
