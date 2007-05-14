From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH] Use $Id$ as the ident attribute keyword rather than $ident$  to be consistent with other VCSs
Date: Mon, 14 May 2007 15:39:06 +0100
Message-ID: <200705141539.08641.andyparkins@gmail.com>
References: <200705141429.58412.andyparkins@gmail.com> <200705141437.25528.andyparkins@gmail.com> <46486FE6.16A82D9A@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: Johannes Sixt <J.Sixt@eudaptics.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 14 16:39:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hnbht-000472-7e
	for gcvg-git@gmane.org; Mon, 14 May 2007 16:39:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754540AbXENOjQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 10:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754558AbXENOjQ
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 10:39:16 -0400
Received: from mu-out-0910.google.com ([209.85.134.184]:35673 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754540AbXENOjQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 10:39:16 -0400
Received: by mu-out-0910.google.com with SMTP id w1so1136657mue
        for <git@vger.kernel.org>; Mon, 14 May 2007 07:39:14 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=GmcGoQ4uR9ra8SmA9fMWmVepiDDFckSZfJQNgnCo+Ao5+b8JX6+G3sO2Pf47ng//6WOUQBO2oXU8/myp4ErCWKqKUIdyYIYMWBgo0O8kbeUEVJdKHG6SY7JKX8PL2S0kxwPJ0N0PVmQ2HHdr3oeq79QuEItsue1MWnirf4O4G2M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=oWozb+eGhRAY/AmzhCk8GXCtmvUps2YToDS5WbUb6UcNJZuE1I8x6XDHNOzFm7yBsel3ae6csaynNnqsVYoMhsiAFmsr5pD0SbQLCvPcAy2xhnqK4cGgYjqNY0V09fQPh3kQ9hApMDRiZa973fyzSULtUkKe8iSjXM3QHMDxzWo=
Received: by 10.82.185.12 with SMTP id i12mr1838666buf.1179153553898;
        Mon, 14 May 2007 07:39:13 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id z40sm15735106ikz.2007.05.14.07.39.12;
        Mon, 14 May 2007 07:39:13 -0700 (PDT)
User-Agent: KMail/1.9.6
In-Reply-To: <46486FE6.16A82D9A@eudaptics.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47243>

On Monday 2007 May 14, Johannes Sixt wrote:

Oops: response via private email, obviously intended for git mailing list.

> Andy Parkins wrote:
> > I think that bzr uses $Id$; Mercurial has examples hooks for $Id$;
> > monotone has $Id$ on its wishlist.  I can't think of a good reason not
> > to stick with the de-facto standard and call ours $Id$ instead of
> > $ident$.
>
> I very much agree. I wondered why it was named $ident$ in the first
> place. Now that I'm not alone, I thought I'd throw my 2 cents in...

-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
