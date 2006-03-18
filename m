From: "Nikolai Weibull" <now@bitwi.se>
Subject: Re: [PATCH] Basic Zsh completion support
Date: Sat, 18 Mar 2006 16:25:04 +0100
Message-ID: <dbfc82860603180725w2eb3057ey17fa8d9dc746127@mail.gmail.com>
References: <20060318145347.15128.85902.stgit@c165>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Sat Mar 18 16:25:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FKdIj-0000lP-UB
	for gcvg-git@gmane.org; Sat, 18 Mar 2006 16:25:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932385AbWCRPZG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Mar 2006 10:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932790AbWCRPZG
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Mar 2006 10:25:06 -0500
Received: from xproxy.gmail.com ([66.249.82.192]:63318 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932385AbWCRPZE convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Mar 2006 10:25:04 -0500
Received: by xproxy.gmail.com with SMTP id s18so572856wxc
        for <git@vger.kernel.org>; Sat, 18 Mar 2006 07:25:04 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CIdLAxLtzxzoSUuuoo5fD8MFpjANfJp9ogJ5ChnFTN3RLnaOoWaHE0OAgkbnMbzHsoL3jo+4jFqGhVP4Ant3ZZ/jRlUY8Xg3t+DGVuSzg3JuJoeJi0hbccdMaM1OXf9e0UGou/m/wrXN/+nykbgfYh9HUtui2d0SUwlDzDX079k=
Received: by 10.70.52.1 with SMTP id z1mr307911wxz;
        Sat, 18 Mar 2006 07:25:04 -0800 (PST)
Received: by 10.70.39.9 with HTTP; Sat, 18 Mar 2006 07:25:04 -0800 (PST)
To: "Fredrik Kuivinen" <freku045@student.liu.se>
In-Reply-To: <20060318145347.15128.85902.stgit@c165>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17697>

On 3/18/06, Fredrik Kuivinen <freku045@student.liu.se> wrote:
>
> Based on the completion code for quilt in the Zsh distribution.

Actually, there's an almost-complete implementation in 4.3 already. 
Written by me nonetheless.  You can take a look and make suggestions
if you like :-).  I have an updated version to deal with post
1.0-changes locally that I'm going to put in Zsh's CVS soon enough.

  nikolai
