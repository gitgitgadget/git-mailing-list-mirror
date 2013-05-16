From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC] New kind of upstream branch: base branch
Date: Wed, 15 May 2013 22:46:58 -0500
Message-ID: <CAMP44s13Q6DMX+QNteqO8D-J7bDcNyp7OkRVqj6B1Qhp0OSB+Q@mail.gmail.com>
References: <CAMP44s3LQ0GN4rrXdpb8Fe0iLeAEm2VjkH6BHK64pmX-xpc7+Q@mail.gmail.com>
	<AE3E8FA3205F42C5B11F3617987BEA05@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Thu May 16 05:47:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ucp9l-0008P5-Gu
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 05:47:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754091Ab3EPDrA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 23:47:00 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:63762 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753646Ab3EPDrA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 23:47:00 -0400
Received: by mail-la0-f51.google.com with SMTP id lx15so582839lab.38
        for <git@vger.kernel.org>; Wed, 15 May 2013 20:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=d+ye795I/HgiMx7Tr0z19zuFboXHSguIU2KIpUTbyI4=;
        b=n9gK0wD4j+tR3KJj3UFQXTc5bkKjkII7pOD42gdmrlPVtQNN9pH6SOL1gwGME2ga7M
         rsRGwyrGWfS+uHsdS9RUvN4Mk8zH4IY9riS08dfulnE0AlsDmInHWn1GAUWZ9j2GeLnj
         BAEcCmrcyUw75bNKi4lPj/9DhunTyc3JlLjTr88pzvqvRaGy/IOzAjZl50Psg9J4Mnd9
         C50VA9anxGf8XDp01lxDn7djsROGAIMvkpOrdN/dpliXvF8u7L9MEQJwtE5uV8Xfm9oS
         0OsQfyzMD1BtEcXpnEsvEhbHyrQOOFURP64FT+vquWaiq6iduMoPE+gMbDxv3jYe0ACR
         NBbw==
X-Received: by 10.112.63.169 with SMTP id h9mr4241788lbs.135.1368676018858;
 Wed, 15 May 2013 20:46:58 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Wed, 15 May 2013 20:46:58 -0700 (PDT)
In-Reply-To: <AE3E8FA3205F42C5B11F3617987BEA05@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224475>

On Wed, May 15, 2013 at 5:22 PM, Philip Oakley <philipoakley@iee.org> wrote:

> Sound a reasonable idea. On some patches I was working on I had to [chose
> to] add a tag for the base which made it easier to rebase later.

And was the 'upstream' branch somehow not appropriate for some reason?

-- 
Felipe Contreras
