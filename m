From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: [PATCH] Initial Italian translation of git-gui.pot
Date: Mon, 23 Jul 2007 00:30:59 +0200
Message-ID: <4d8e3fd30707221530v46989d88mcc65cacbc66a4e1c@mail.gmail.com>
References: <20070722124236.47baacb1@paolo-desktop>
	 <200707222128.05884.barra_cuda@katamail.com>
	 <Pine.LNX.4.64.0707222121500.14781@racer.site>
	 <4d8e3fd30707221510t8bfc3ecr2dbec5a817519212@mail.gmail.com>
	 <Pine.LNX.4.64.0707222315360.14781@racer.site>
	 <e5bfff550707221525w3234c5edte3c3d58b97d4d970@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	Michael <barra_cuda@katamail.com>, git@vger.kernel.org
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 00:31:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICjxF-0004KS-98
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 00:31:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760457AbXGVWbF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 18:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760288AbXGVWbE
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 18:31:04 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:2415 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759090AbXGVWbB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 18:31:01 -0400
Received: by py-out-1112.google.com with SMTP id d32so2989640pye
        for <git@vger.kernel.org>; Sun, 22 Jul 2007 15:31:00 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Zy0duU1WZe13JeYl0gUL14Ube0zEVqFiX9F/WtKOuajT+rXFMbasqHwYkCv/Rrlkc0jZ8qo4T1UfwAcH4+hPy0fNR3qhCryYxDmzcl9KGip/QoOPjFDBSiMu42/6eupGPmb8QgUIs15zQx7kaTQQbhVXEq2R/1M55js9TSbkqrM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Rql2oSdZhn/bwcM+I6CwfFFI8ELg/diD6mZ2zdS5Us0CymlxQCW8sGXjAg07MaoqdVI/3O5qZyJ12GbPdJTSq8MtajAI8mBDZZFUIk07ldzQDj7/WEYyk7+phEi6+65hjYmjCtN+KcecZHYfQq7ngUp5H4T5hKYYEiFkPJJOUO8=
Received: by 10.142.187.2 with SMTP id k2mr186655wff.1185143459902;
        Sun, 22 Jul 2007 15:30:59 -0700 (PDT)
Received: by 10.142.86.9 with HTTP; Sun, 22 Jul 2007 15:30:57 -0700 (PDT)
In-Reply-To: <e5bfff550707221525w3234c5edte3c3d58b97d4d970@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53356>

On 7/23/07, Marco Costalba <mcostalba@gmail.com> wrote:
> On 7/23/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >
> > Forse "parte" e troppo generale per dire "hunk"?
> >
>
> There are some words that in my opinion it would be better do not
> translate but to leave in english, expecially on computer stuff
> italian people it's already used to the original english word.

Agree. We just have to agree on which words keep in English.

> In our example "resettare" it's not italian, it's a italianized (very
> ugly) form of "to reset" and it would be really better to use "reset".

I agree, again.
"Resettare" was really too ugly, in my last patch I posted to the list
I changed it to "Reimposta".

Ciao,
-- 
Paolo
