From: Daniele Segato <daniele.bilug@gmail.com>
Subject: Re: Usability question
Date: Thu, 17 Sep 2009 15:25:29 +0200
Message-ID: <9accb4400909170625v35e112f6i66d79282d2433c49@mail.gmail.com>
References: <513ca40e0909170301s2b09184akb27acde76975c09b@mail.gmail.com>
	 <vpqy6odhn0d.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Rob Barrett <barrettboy@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Sep 17 15:25:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoGzO-0001jL-K7
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 15:25:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753038AbZIQNZ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2009 09:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752438AbZIQNZ1
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Sep 2009 09:25:27 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:57668 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753025AbZIQNZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2009 09:25:26 -0400
Received: by mail-fx0-f217.google.com with SMTP id 17so17863fxm.37
        for <git@vger.kernel.org>; Thu, 17 Sep 2009 06:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=Ymvf1/aJqpwY7jEPxsN/9qX1dZpy20XH7mBk/7Auisc=;
        b=u6eV1e1HuUNpAF6LnNzvAu0a0NEbmdh57jCCo18v1LLYqptYZeinGXuo4yCfxkPyW5
         xmTbHpEy8WFFaymrWUSUDkIM3EJDBGwTOkpllpAPKjOHWXD7c180De5+Bsj6Ygo1GWsn
         hwzbEIwV/tFp4dyij3f9SY79jbOHIfrTHWQDY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Vse9GHf7BWRt9xhzbnPsbm6j8XwUcyNQBaNwmVJx7VYwn2htGIb6E9PqfkjSCtBH4i
         FauJ6QUKnBLA2loiq1VIJZndVK2t92PI7bKCZZnj6ur9TvSpjvF3Tmw8KFL23szmyrpc
         dqycnsPjzKe7P9lwveaUmrQfvGd2o32SSygB4=
Received: by 10.204.154.147 with SMTP id o19mr385240bkw.159.1253193929848; 
	Thu, 17 Sep 2009 06:25:29 -0700 (PDT)
In-Reply-To: <vpqy6odhn0d.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128755>

On Thu, Sep 17, 2009 at 12:01 PM, Rob Barrett <barrettboy@gmail.com> wrote:
> When starting with git people almost always ask some variant of "how
> do I know whether this option should be prefixed with dashes or not?"
> i.e. git reset --hard vs. git stash save --patch, which coupled with
> other path, sha and treeish args make things a bit more confusing.

> And people stop asking the question after they get used to git - but
> that's not the same as being usable.

without speaking of usability I'll tell them to use autocompletion to
see which command / options they have until
they get used to them

regards,
Daniele
