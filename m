From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH 5/6] Refresh the main stg man page
Date: Mon, 6 Oct 2008 22:15:42 +0100
Message-ID: <b0943d9e0810061415n551acbc5r812bbd0e75eeb572@mail.gmail.com>
References: <20081005155450.19886.43748.stgit@yoghurt>
	 <20081005160157.19886.7137.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Mon Oct 06 23:16:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KmxRo-0006Fp-0O
	for gcvg-git-2@gmane.org; Mon, 06 Oct 2008 23:16:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752939AbYJFVPo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Oct 2008 17:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752938AbYJFVPn
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Oct 2008 17:15:43 -0400
Received: from rv-out-0506.google.com ([209.85.198.226]:41076 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752915AbYJFVPn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Oct 2008 17:15:43 -0400
Received: by rv-out-0506.google.com with SMTP id k40so3152656rvb.1
        for <git@vger.kernel.org>; Mon, 06 Oct 2008 14:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=26EwdsocqhAYGsOyOrgOQdu5E55fFN7G0OFXSPvyLjA=;
        b=ZF1eBDpVA9t91P6q+XbutsLOhezygzbv5LY9MArxsRLNtEcnEaqolYcVSokhq7RAAx
         k2v2cma+Cz4hu77GHtnf2JgMeBZy0jxHmD5agkGxXZ7hD5eQfBk6TapI7U4QKMGANuW9
         WlBGG9YeYxt7rYD3la6EgVr/qoyXlb6ZbbCnM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=xHbmd66a+QBj0dWD2bis2J7vMXc3eJmxuz5zTXZ6xvbvJ1IiLLt6MJAUK6bXh9cfu5
         T2GtfNqmNi7Mnb200PGviMbpWIdk6qfJS5oS2VYAt7w/S8tD5Bnaks5zWltn4gtyMoGp
         yrxepZ/g329JZAp97aO2lOA8PC7YElI0l9T9I=
Received: by 10.140.178.17 with SMTP id a17mr3375039rvf.156.1223327742577;
        Mon, 06 Oct 2008 14:15:42 -0700 (PDT)
Received: by 10.141.201.12 with HTTP; Mon, 6 Oct 2008 14:15:42 -0700 (PDT)
In-Reply-To: <20081005160157.19886.7137.stgit@yoghurt>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97631>

2008/10/5 Karl Hasselstr=F6m <kha@treskal.com>:
> +  * You can easily 'rebase' your patch stack on top of any other Git
> +    branch. (The 'base' of a patch stack is the most recent Git comm=
it
> +    that is not an StGit patch.) For example, if you started making

You may want to move the bracket before the dot.

--=20
Catalin
