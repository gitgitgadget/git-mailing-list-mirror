From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: split up a repository
Date: Wed, 3 Mar 2010 14:19:12 -0500
Message-ID: <32541b131003031119i5f7baefelc2784ccca90eca41@mail.gmail.com>
References: <20100302011226.76fda85d@gmail.com> <fabb9a1e1003020240h81f3e99wea1185c080a03b0@mail.gmail.com> 
	<20100303002132.5df20326@gmail.com> <32541b131003021740n32535fbbh802af418ea0898aa@mail.gmail.com> 
	<19342.27760.544227.835077@blake.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Levente Kovacs <leventelist@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Mar 03 20:19:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nmu6e-0007kj-La
	for gcvg-git-2@lo.gmane.org; Wed, 03 Mar 2010 20:19:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756117Ab0CCTTe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Mar 2010 14:19:34 -0500
Received: from mail-yx0-f204.google.com ([209.85.210.204]:47768 "EHLO
	mail-yx0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753330Ab0CCTTd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Mar 2010 14:19:33 -0500
Received: by yxe42 with SMTP id 42so806421yxe.4
        for <git@vger.kernel.org>; Wed, 03 Mar 2010 11:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=HUpeJzo0k2zTlCxUGiXC7C8HvM438s8yxKr5epxHFlc=;
        b=U+g/pcVLtijSH0N06CIREiO0XewSZGWedGQFHRqIdTsm5GMn2+0xpxIQZfoPqdbJsu
         RTnYzlf7uVU0Lj1oY8Ud9n/QZiTDwOS1EYsCvygMvTK1OW0VGvVOvovY8WEd/7ZXmmhY
         7KsHSibpiQZnPLrdEXi7cgzB73WZQ4hz8ii+k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=dk+xteiAUl/quFeRO0K5gGkQ2Q2NG0DzeSS7PSFhfCY3qPO2vI1KeCKZkvdUDI11Ke
         ErTAnP+PKw+pbFnj7Z6W/hLqX50L8dgwczojU09hzk05lfzEM0OINf37Idv1bEK7fYlT
         HGZB+/2WO8qAF43NCGnAcTq31J1gElxCjO1Mk=
Received: by 10.151.88.11 with SMTP id q11mr1348170ybl.20.1267643972211; Wed, 
	03 Mar 2010 11:19:32 -0800 (PST)
In-Reply-To: <19342.27760.544227.835077@blake.zopyra.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141461>

On Wed, Mar 3, 2010 at 9:04 AM, Bill Lear <rael@zopyra.com> wrote:
> Does git-subtree support branching of the "main" repository and
> sub-trees in coordinated (one step) fashion?

Yes.

Avery
