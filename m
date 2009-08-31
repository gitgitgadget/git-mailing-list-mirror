From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: What IDEs are you using to develop git?
Date: Mon, 31 Aug 2009 12:21:00 +0200
Message-ID: <46a038f90908310321p4e709969o749eea69310e947b@mail.gmail.com>
References: <000001ca257d$b60326c0$22097440$@com>
	 <43d8ce650908250547t17b76c95qb9931983e0a4b232@mail.gmail.com>
	 <1251655664.31273.4.camel@localhost>
	 <26ae428a0908301206s38b36901y6027486f0d780ebc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Daniele Segato <daniele.bilug@gmail.com>,
	John Tapsell <johnflux@gmail.com>,
	=?ISO-8859-1?Q?Frank_M=FCnnich?= <git@frank-muennich.com>,
	git@vger.kernel.org
To: Howard Miller <howard@e-learndesign.co.uk>
X-From: git-owner@vger.kernel.org Mon Aug 31 12:21:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mi40f-0000xU-3Z
	for gcvg-git-2@lo.gmane.org; Mon, 31 Aug 2009 12:21:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbZHaKVC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2009 06:21:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbZHaKVB
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Aug 2009 06:21:01 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:50195 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191AbZHaKVA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2009 06:21:00 -0400
Received: by ewy2 with SMTP id 2so158755ewy.17
        for <git@vger.kernel.org>; Mon, 31 Aug 2009 03:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=n0W/bbH4xPjUl0sDwJf1WlF6cZheo/+37DWs/ixMBf4=;
        b=L2P4czHo4RYzokc5u6Mtefw8foi+Z0Ht7p38GNPqT8TcAHoPfFIzK4LOztnuNKUNHf
         vcWgGfL0b/4MWOfZufVb0RoGVw2BNYAHa+HHs7UkLTfhIIF+AmD736qm/MqVkZdYes39
         4cZe2noJTgYJzCpMpzOZnaHoXgoPnP4/1Ow7k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=TfCebWuBG97ixvddJZUx+RyYAXlL2Z0slaFYWiE2OuDobPU/695TGSLJHM2K1t1XL2
         ljVsTrt6Hx1VF0DPj7o1ghdU5UtyX8McJj/oFpsYCYpoT8lBMUvfe3rG5ITtlIKDSOtq
         xXcKuMwbkKrDdzTfnZsKcC/v9f1U/pgzZ+V70=
Received: by 10.210.3.14 with SMTP id 14mr5066255ebc.80.1251714060437; Mon, 31 
	Aug 2009 03:21:00 -0700 (PDT)
In-Reply-To: <26ae428a0908301206s38b36901y6027486f0d780ebc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127475>

On Sun, Aug 30, 2009 at 9:06 PM, Howard
Miller<howard@e-learndesign.co.uk> wrote:
> With a bit of learning
> can can do most of the stuff that an IDE does, usually faster and with
> less fuss.

Ditto. And with a very modest screen size. Modern IDEs need a huge
monitor, and then more, just to show what they want to show you.

Not what you need.

So when working on webapps, I normally keep my editor (usually an
emacs variant) window small, and have lots of terminal windows tracing
relevant logs (webserver, db server) and 3~4 webbrowsers logged in as
different users.

When working on git itself, it's much easier -- as all you need is
your editor and your terminal to compile & debug so for a simple task
like git itself, an IDE might even work ;-)

cheers,



m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
