From: "Geoff Russell" <geoffrey.russell@gmail.com>
Subject: Re: tags and patches
Date: Thu, 14 Jun 2007 09:45:42 +0930
Message-ID: <93c3eada0706131715oa84eff7kc0b477a3b80e9d66@mail.gmail.com>
References: <93c3eada0706130352h3ad6857eie01e1171fdda3991@mail.gmail.com>
	 <Pine.LNX.4.64.0706131313550.4059@racer.site>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 14 02:16:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hyd0X-000653-Lm
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 02:16:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756668AbXFNAPo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 20:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756645AbXFNAPo
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 20:15:44 -0400
Received: from mu-out-0910.google.com ([209.85.134.184]:24035 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756643AbXFNAPn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 20:15:43 -0400
Received: by mu-out-0910.google.com with SMTP id i10so505629mue
        for <git@vger.kernel.org>; Wed, 13 Jun 2007 17:15:42 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eX30+npm5P3Y2XWZ2puFb/H408ItbatdfwCu4YZ6ZCzyHMUGVr40P5IovyqA+qIPEHKUlpQpzn1lEcXPVuGNOH4LvQ9eQGw0UqD/oBgTadZfh4fYG0gn8M0VkUmvKL7lDqb3P2RgCKTpgwKXKWghybs5ZDAlvxwvSTFZkwh40j0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Wsg6Yi1kfAaJcXktj6EOhZHIrCI3hp8VMWnz0pv42kPkxBKBqr2SrewP7WWQ2BxtQZh5elg86X+8RxZLAeearyrOvzEj6YFlQc7AYF3jNKs72iEq6cyssI5imeCGmniAT8gW0PPejho7POUrAyI+FIc8zG1hEVS96pjMJHutKUw=
Received: by 10.82.116.15 with SMTP id o15mr2272411buc.1181780142088;
        Wed, 13 Jun 2007 17:15:42 -0700 (PDT)
Received: by 10.82.141.14 with HTTP; Wed, 13 Jun 2007 17:15:42 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0706131313550.4059@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50149>

On 6/13/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Wed, 13 Jun 2007, Geoff Russell wrote:
>
> > Dear gits,
>
> ;-)
>
> > [...]
> >
> >        git tag v1.1
> >        git format-patch v1.0
> >        cd /tmp/newmyrepo
> >        git am ~/myrepo/THEPATCHNAME
> >
> > Where is tag v1.1 ?
>
> Tags are not propagated with patches. Sorry.

Is this considered to be a bug to be eventually fixed or a feature?

Geoff


>
> Ciao,
> Dscho
>
>
