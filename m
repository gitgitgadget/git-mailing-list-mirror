From: Philippe Vaucher <philippe.vaucher@gmail.com>
Subject: Re: [PATCH] Clean weird documentation for 'git var' and 'git
Date: Thu, 10 May 2012 22:15:40 +0200
Message-ID: <CAGK7Mr46-btS3gZvw4UUeiZEFn6cxH+BuYV02heWSbLbavpwvA@mail.gmail.com>
References: <CAGK7Mr7QWrddaRLkr=1h=GYUNtNVOatQF1sj+p11mejzs65u8A@mail.gmail.com>
 <7vzk9gm0wa.fsf@alter.siamese.dyndns.org> <F89882854A7D45E2843F6F1F7CB21DB4@PhilipOakley>
 <CAGK7Mr6AjSY-D9p1vzs=xCg-TMCPiBJDOSxMVYtykeCZCPW2FA@mail.gmail.com>
 <CAGK7Mr7rzuPVmGsnx+uhmVgBepAav734uh6hHeqn25BC0_+0Lw@mail.gmail.com>
 <7vvck3najc.fsf@alter.siamese.dyndns.org> <CAGK7Mr4GJw4zZ5Qwab+co07JG5kBn-EFsfmU+Yzpm6LoD8j-Rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Philip Oakley <philipoakley@iee.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 10 22:16:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSZmd-00056P-01
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 22:16:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752884Ab2EJUQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 16:16:12 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:51606 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751462Ab2EJUQL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 16:16:11 -0400
Received: by yhmm54 with SMTP id m54so1883950yhm.19
        for <git@vger.kernel.org>; Thu, 10 May 2012 13:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=hYcxUDjLKNl/cz7cWVQs8n+lW6l2XZKLmT4y8neqtss=;
        b=Vh/RUNcxm02NdhY6v/Tsu/zXpAN6+1dSxs+74yoV1Ai1MHlQhHL/sRC63NSWjglqn4
         ejEq93Y1v9UMA87HfHsatOctg+HgazGrgUoag90xZtsE5yzp+FQ3nBr5RV96JfggSPOw
         9JmsezWyh2wfwKdDMv8y3oiaEi+kGOjkeSJt3hAjwaZOqPo7uO2bTLo6RghvNfz+UIeM
         8pzOYnnJl/DRz3+qnIh1b+8sN2Tm0+m5oZMztdadTv1CcoThOaDpU3jkjotwV+IJjSPU
         wNT/CGUOaq5aKz4hg1g2CHtMjXTbkrvoFwezEqO1lZthZ/xxSVrN5jnxjp9KNOI2Bag4
         xdNw==
Received: by 10.50.168.106 with SMTP id zv10mr164605igb.55.1336680970290; Thu,
 10 May 2012 13:16:10 -0700 (PDT)
Received: by 10.50.65.101 with HTTP; Thu, 10 May 2012 13:15:40 -0700 (PDT)
In-Reply-To: <CAGK7Mr4GJw4zZ5Qwab+co07JG5kBn-EFsfmU+Yzpm6LoD8j-Rw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197626>

Oh, I see there's already a patch for it :) Nice!

Philippe
