From: Dov Grobgeld <dov.grobgeld@gmail.com>
Subject: Re: Git beginner - Need help understanding
Date: Wed, 28 Dec 2011 10:05:07 +0200
Message-ID: <CA++fsGHWrc12G9rHTYOuM0yVpKn_NY9tF3oiKCkXUk0vCgHauQ@mail.gmail.com>
References: <1324955537875-7129186.post@n2.nabble.com>
	<CA++fsGHPKhzfd7-KohOZ4WpYatx_-EW0bjq46zwswbu8TomHCg@mail.gmail.com>
	<1324969372444-7129429.post@n2.nabble.com>
	<7vr4zp7q15.fsf@alter.siamese.dyndns.org>
	<1325036313909-7131536.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: chirin <takonatto@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 28 09:05:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RfoVf-0005pI-CN
	for gcvg-git-2@lo.gmane.org; Wed, 28 Dec 2011 09:05:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813Ab1L1IFJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Dec 2011 03:05:09 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:39428 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750760Ab1L1IFI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Dec 2011 03:05:08 -0500
Received: by iaeh11 with SMTP id h11so21664318iae.19
        for <git@vger.kernel.org>; Wed, 28 Dec 2011 00:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=XcT3kQOBShWaGv1RPe0QexApSCbEY18WFKMOyUQXTU0=;
        b=tdHPTB4QFtYJ5cxBoynhOBA0MhOAsewQQR7NMwSvI2KjirerdQ3PnkqQTkUdGX0tm7
         /XLJMzxvE3CNfxadzNxPFkc7XO0uKLGUxNUTfTnobuiysCs14+1qgs5hsjBnyzCgGKH2
         CnYWxue3O3p591CGiBj4Nm7KEDCf3125CuQMU=
Received: by 10.50.214.42 with SMTP id nx10mr16951558igc.0.1325059507603; Wed,
 28 Dec 2011 00:05:07 -0800 (PST)
Received: by 10.231.149.194 with HTTP; Wed, 28 Dec 2011 00:05:07 -0800 (PST)
In-Reply-To: <1325036313909-7131536.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187744>

I'm glad to hear that your problem was solved.

On Wed, Dec 28, 2011 at 03:38, chirin <takonatto@gmail.com> wrote:
> [stuff deleted]
> What should I know about the 'states of A, B and the repository A and=
 B
> interact with'?

The state of a repository are most easily described by the sequence of
commands done to it from its creation.  The best way of learning and
solving problems is trying to reproduce them with the minimum amount
of steps. I.e. even if you are using a GUI tool for your convenience,
you should be familiar with the command line tools, since that is the
best way of conveying what you have done. My motto is: "Don't describe
in human language what you have done, but show me the exact
commands!". And there is no language better for such than the exact
command line.

Regards,
Dov
>
> --
> View this message in context: http://git.661346.n2.nabble.com/Git-beg=
inner-Need-help-understanding-tp7129186p7131536.html
> Sent from the git mailing list archive at Nabble.com.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
