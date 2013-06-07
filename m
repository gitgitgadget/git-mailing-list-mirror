From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/3] sequencer: trivial fix
Date: Fri, 7 Jun 2013 17:59:00 -0500
Message-ID: <CAMP44s12BjNTeoei-+PZQcd0uBRCLPsfMyA79zuBwcxTpAnRFQ@mail.gmail.com>
References: <1370637143-21336-1-git-send-email-felipe.contreras@gmail.com>
	<1370637143-21336-2-git-send-email-felipe.contreras@gmail.com>
	<7vsj0tr0y7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stephen Boyd <bebarino@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 08 00:59:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul5cp-0004rR-Cw
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 00:59:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754898Ab3FGW7D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 18:59:03 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:46093 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752956Ab3FGW7C (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 18:59:02 -0400
Received: by mail-la0-f52.google.com with SMTP id fo12so2271038lab.25
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 15:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=n+WHIwyIXWESr7BGbFQPhaBBKOocNwoAFZCatYgaphw=;
        b=bHcPUyynajjA22No4B1bL5YtQJDsGKWBMxlTWomLBQ8gICZJHBFlcSqxC0QiBxQBR3
         EXvyiDqGlDILCiidYx4eYdwOUK6HDgYVuj0xpzPJy/xsQJiPlQ3WJrHIt2knd7oxk6l+
         elVRLG1RBEXz5o6mxDkYHITnF4jGECQSmnD5oJ/UGsqoiQbCe2qyFAstB3aUQDz4zYxD
         PgQ5PCHPsLeGWpxn7XnlDnjgvOjyhn89+PSf/2TZThc6w4A6h3hZ7v+bIoRsnvFVa5xQ
         DeZVj35XnOSTLj58Hu56rCiViWxjipWNMG7Uod654Gr28lSNJ7KwoRUmfhY+Ue4Mc1zJ
         vuBA==
X-Received: by 10.112.52.97 with SMTP id s1mr2172360lbo.8.1370645940252; Fri,
 07 Jun 2013 15:59:00 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Fri, 7 Jun 2013 15:59:00 -0700 (PDT)
In-Reply-To: <7vsj0tr0y7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226763>

On Fri, Jun 7, 2013 at 5:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I thought the conclusion was that combination of c8d1351 and 706728a
> we already queued was the right change.  Is this meant to replace
> them?

Yes, those would do, but I'm not going to work on that series any more.

-- 
Felipe Contreras
