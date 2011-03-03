From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Google Summer of Code 2011
Date: Thu, 03 Mar 2011 13:25:16 -0800 (PST)
Message-ID: <m3bp1r7v94.fsf@localhost.localdomain>
References: <AANLkTinpVKBjcqxaCGH0vp82kpKsO2uCBPdMoMKco6Ex@mail.gmail.com>
	<20110303185918.GA18503@sigill.intra.peff.net>
	<AANLkTinXZDq5FJxMmxUuWpCGgMYb3HH774eLJCojmnOz@mail.gmail.com>
	<20110303203323.GA21102@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 03 22:25:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvG1W-00021i-GV
	for gcvg-git-2@lo.gmane.org; Thu, 03 Mar 2011 22:25:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758859Ab1CCVZV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2011 16:25:21 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:43851 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758699Ab1CCVZU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2011 16:25:20 -0500
Received: by fxm17 with SMTP id 17so1554170fxm.19
        for <git@vger.kernel.org>; Thu, 03 Mar 2011 13:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=7ZdXBTzFO1hyUv9YI3kdrk0FDo9Jsv3k3ew51lHZR3w=;
        b=vwWSPV/eFJfCZibZBMVZxIYlLCF81FvItzjcr1heL/ldogfuAPtNWn1RI5Q8Tx5L3a
         TMhPylbQrvfmQPqdRqjmorlUh/xnobWazXASkxRJY5GAVen0krPQkokNKaJ9ITqtRC1n
         3HveBkkHfc7v7E2W0Zfe/be3eGYuefJcOZvH0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=MWJa3GpExGOPxcHdtPJ1sls9AF5U+Dfww6arubi4bg+fuEReOjhmALlHaifrmNKnyv
         2p5zlJkztRd7EQbe8zdfNEqfPMrLp+ekur0nemDcIz4NAXOyrro31/zcNNn3cBJf3XOK
         l/kvOW5I0qH7nVnab3lVSyyMK/5/Yda9MEyfw=
Received: by 10.223.4.203 with SMTP id 11mr1699068fas.44.1299187518596;
        Thu, 03 Mar 2011 13:25:18 -0800 (PST)
Received: from localhost.localdomain (abwg77.neoplus.adsl.tpnet.pl [83.8.230.77])
        by mx.google.com with ESMTPS id b7sm846588faa.42.2011.03.03.13.25.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 03 Mar 2011 13:25:16 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p23LOkrH000483;
	Thu, 3 Mar 2011 22:24:56 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p23LOOfT000478;
	Thu, 3 Mar 2011 22:24:24 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20110303203323.GA21102@sigill.intra.peff.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168411>

Jeff King <peff@peff.net> writes:

> On Thu, Mar 03, 2011 at 11:04:51AM -0800, Shawn O. Pearce wrote:
> 
> > > I'd be happy to. I can also act as org admin this year if you want. I
> > > bowed out last year due to impending baby, but have no such excuse this
> > > year. :)
> > 
> > I would appreciate that, I'm too busy this year. :-(
> 
> OK, there is now:
> 
>   https://git.wiki.kernel.org/index.php/SoC2011Application

Quote:

 "In 2010, we had three projects: native svn support, libgit2, and a
  line level history browser.

  All three projects were successful. [...]"

What about 'integrated web client for git', aka. "Splitting gitweb and
developing write functionalities" project wit Pavan Kumar Sankara
(pkumar), which failed midterm evaluations?

See https://git.wiki.kernel.org/index.php/SoC2010Projects#Splitting_gitweb_and_developing_write_functionalities_.28Integrated_web_client_for_git.29

-- 
Jakub Narebski
Poland
ShadeHawk on #git
