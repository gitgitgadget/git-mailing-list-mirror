From: Thomas Ferris Nicolaisen <tfnico@gmail.com>
Subject: Re: [ANNOUNCE] Git Rev News edition 7
Date: Thu, 10 Sep 2015 11:46:14 +0200
Message-ID: <CAEcj5uUE7vsR5K7VdSrpG03Ovk6h26fKcZiU24RWGxoHFm8VuA@mail.gmail.com>
References: <CAP8UFD2ozoCjV6HzszmB03bCPRMb3aoegObUAkMYfMRvcu0v_A@mail.gmail.com>
	<20150910091354.GA4007@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>,
	Nicola Paolucci <npaolucci@atlassian.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 10 11:46:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZyQv-00079O-Do
	for gcvg-git-2@plane.gmane.org; Thu, 10 Sep 2015 11:46:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752766AbbIJJqR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2015 05:46:17 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:34452 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752195AbbIJJqQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2015 05:46:16 -0400
Received: by wicfx3 with SMTP id fx3so20978250wic.1
        for <git@vger.kernel.org>; Thu, 10 Sep 2015 02:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=uDr7PgPUAOeyGUOLL5GSeroKK7igfLff6OJ5SyaHxaI=;
        b=HZsRqRrtcjVdFudAk2o72wadUT4sPYW4pqeEd8z1NfYcxidvQivOiG1rN0jIQaXzAt
         +gPj+RC6zbZVQpAy4yzCcSXTq0Vq1CkM3TuBlMqt5D760iAKFtQhY4jG3zvJw0+yFBRn
         c+Sg0tOnGM2SGeqWCn1klqdcM3LrRK84d+LtFOGQynXUAkZSIOpIn6omSeBiFtRhjzjo
         THkZNJaocp8bN+PgutnGNZt5pxjfuphM/a4tBr3Be33+SrdFzF9kPHox0uUhFToipv/W
         wmFNu3TtdNc7H+DoRJ/50joKJaLZZzHhuRMsZ1O3RduF2c309ZVaqJljtw90nD6w4SMC
         eJ8A==
X-Received: by 10.180.108.175 with SMTP id hl15mr4595178wib.1.1441878375027;
 Thu, 10 Sep 2015 02:46:15 -0700 (PDT)
Received: by 10.27.12.32 with HTTP; Thu, 10 Sep 2015 02:46:14 -0700 (PDT)
In-Reply-To: <20150910091354.GA4007@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277578>

On Thu, Sep 10, 2015 at 11:13 AM, Jeff King <peff@peff.net> wrote:
> In more technical matters, you may be interested in:
>
>   https://github.com/blog/2053-easier-feeds-for-github-pages
>
> I don't know of any problems with the current RSS solution, but 1 line
> of code maintained by somebody else is perhaps better than many lines of
> custom code. :)
>

Thanks, Peff! I've added an issue reminding us to try this out some time.
