From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [RFC] branch: list branches by single remote
Date: Wed, 24 Aug 2011 23:31:57 -0300
Message-ID: <CACnwZYd=pM+fRNy0pqv+jR9bb0AWC89nkgHq3m1nMw9cUfHOQw@mail.gmail.com>
References: <4E383132.3040907@elegosoft.com>
	<20110804040646.GA5104@sigill.intra.peff.net>
	<4E4A729D.9030906@drmicha.warpmail.net>
	<20110816151448.GA5152@sigill.intra.peff.net>
	<4E551548.9090807@elegosoft.com>
	<4E551AD0.7050702@drmicha.warpmail.net>
	<7vei0apsj9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Michael Schubert <mschub@elegosoft.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 25 04:32:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwPje-0004Eh-M2
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 04:32:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753159Ab1HYCb6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Aug 2011 22:31:58 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:45170 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752935Ab1HYCb5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2011 22:31:57 -0400
Received: by yxj19 with SMTP id 19so1363472yxj.19
        for <git@vger.kernel.org>; Wed, 24 Aug 2011 19:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=3sv23AOUOsY88khiwp3EigtuvLUoIAk0JHFo0oH8gr8=;
        b=PTujru4Q5kn4KF8Y6dTv9ofpywHYdwgvZelBZATerx/+F7WqzECJvfOA74GftBVRRj
         PAcpVE2ftkHDq4OG3bXwWJ/z0/gIEeF15Hc1iebxNWqLT1JbkhAYoz0W6HZ8tuQQcKqI
         dq9nNMKf2eHvMzG9ZCHEd/VC5qApbPhdFWGUU=
Received: by 10.150.213.20 with SMTP id l20mr241577ybg.232.1314239517231; Wed,
 24 Aug 2011 19:31:57 -0700 (PDT)
Received: by 10.151.83.19 with HTTP; Wed, 24 Aug 2011 19:31:57 -0700 (PDT)
In-Reply-To: <7vei0apsj9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180057>

On Wed, Aug 24, 2011 at 3:34 PM, Junio C Hamano <gitster@pobox.com> wrote:
> [Footnote]
>
> *1* It does not have to be a weekly _posting_ on the list but can be a
> well-known Wiki page or even a bug tracker. Whatever medium is used for
> this purpose, there _must_ be a built-in mechanism to expire entries away
> that are inactive for more than some reasonable limit (say two to three
> weeks).

Host the project on Google Code for bug tracking? Use rietveld for
code reviews (ike codereview.chromium.org and codereview.appspot.com)?
