From: Aghiles <aghilesk@gmail.com>
Subject: Re: git pull opinion
Date: Tue, 6 Nov 2007 01:30:23 -0500
Message-ID: <3abd05a90711052230y4d6151c6o3e7985a0c8e18161@mail.gmail.com>
References: <3abd05a90711051352t2f6be00bsa862585abd370fb1@mail.gmail.com>
	 <7vd4uomfn8.fsf@gitster.siamese.dyndns.org>
	 <18223.46848.109961.552827@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Bill Lear" <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 07:30:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpHxQ-000619-Fg
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 07:30:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754410AbXKFGa1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 01:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754284AbXKFGa0
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 01:30:26 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:23103 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754390AbXKFGa0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 01:30:26 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1592364nfb
        for <git@vger.kernel.org>; Mon, 05 Nov 2007 22:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=0p9DL2s05yAQuAYqYLFQU/dMdv/QFNVEMUqOSlKCgNA=;
        b=E8nwR/CItwExIoVzY7Lrm5zqhnm8sYTvwV4L5cgqx17NEndNHsEG/pLbwrhYNXIA/f3RP3jQFElOuZ97yPdb67ikDv7tiUijMzNqAScvtxsEGrcmEgqaiFnjSYkl93XrwwdZxd9mGOoaqZ+jQyykh0j/MiOnsU7mtlmbo/TE02M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=czvMzkFBegDFQNYcicx87TLzQUwMQacgfx5iwQDaIXDv8W9UmMg1jUNK4inWvwhELtLPZ0O8hFZdpxfAC8ses7KfsZarMkzWazRYNkzN0OuYnta0SREzI37qj4iYuN9treex3Yl0bZBeIsoMHQVxxJAMIBxU4ltgwixXaST8BQ4=
Received: by 10.78.149.15 with SMTP id w15mr4490456hud.1194330623841;
        Mon, 05 Nov 2007 22:30:23 -0800 (PST)
Received: by 10.78.185.1 with HTTP; Mon, 5 Nov 2007 22:30:23 -0800 (PST)
In-Reply-To: <18223.46848.109961.552827@lisa.zopyra.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63629>

> I respectfully beg to differ.  I think it is entirely reasonable, and
> not a sign of "centralized" mindset, to want to pull changes others
> have made into your dirty repository with a single command.

BitKeeper, for example, does a merge with a "dirty" directory.
I am not saying that git should behave the same way but I think
that this argument strengthens the point that it is not a
"centralized repository" mindset.

- Aghiles.
