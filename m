From: "Nikolai Weibull" <now@bitwi.se>
Subject: Re: [PATCH] Document how to tell git to not launch a pager
Date: Thu, 19 Jul 2007 20:51:14 +0200
Message-ID: <dbfc82860707191151w3e9571fcu60d113cba6c2f6dd@mail.gmail.com>
References: <20070719104351.GA17182@midwinter.com>
	 <20070719110224.GA4293@piper.oerlikon.madduck.net>
	 <Pine.LNX.4.64.0707191211010.14781@racer.site>
	 <Pine.LNX.4.64.0707191235490.32611@reaper.quantumfyre.co.uk>
	 <86ir8gbo0a.fsf@lola.quinscape.zz>
	 <alpine.LFD.0.999.0707191128040.27353@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "David Kastrup" <dak@gnu.org>, git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jul 19 20:51:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBb5z-0002Ac-S2
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 20:51:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752180AbXGSSvQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 14:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbXGSSvQ
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 14:51:16 -0400
Received: from wa-out-1112.google.com ([209.85.146.176]:4276 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750867AbXGSSvP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 14:51:15 -0400
Received: by wa-out-1112.google.com with SMTP id v27so730319wah
        for <git@vger.kernel.org>; Thu, 19 Jul 2007 11:51:14 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=YoF7zNhGd9seG0zc1Q4rx2vDPc036Dpg+sy0SFeAgj8LTkun17s+tQtbvPYRWkZPMyJ8b8Ww1AMdghykfq0g91OpoaKc2fJCqZXtPN6G7V1OcH9wEXD0XAYOfgIVdCj00Pd8Zrz0qBVP4F+yxENgglTuBe3xVkvMkaegB933d/E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=cPsuaso7WOXAiISFsdb+AgmiJNMGeEjH5Afblcxtz/Ub0TzKlmvef+DrPOo8sqDPOh7D08MGew6MMEtLEjLJZhZIxDLklzqPF0IPrz3ziWFkqpCZQA7x9UoDccsvvEKDx3LgO4U+p0En5HePC0nKtHFsKiW2XJgXPx3Mrvlkd+M=
Received: by 10.114.175.16 with SMTP id x16mr2823975wae.1184871074598;
        Thu, 19 Jul 2007 11:51:14 -0700 (PDT)
Received: by 10.114.196.8 with HTTP; Thu, 19 Jul 2007 11:51:14 -0700 (PDT)
In-Reply-To: <alpine.LFD.0.999.0707191128040.27353@woody.linux-foundation.org>
Content-Disposition: inline
X-Google-Sender-Auth: 92c2a9cc0a3e3c40
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53018>

On 7/19/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:

> In fact, I'd suggest not using screen at all (what a piece of horrid crap),
> but some people have trouble letting go.

I don't want to start a holy war here, but what's wrong with screen?

And what should we be embracing instead?

  nikolai
