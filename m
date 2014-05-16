From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Subject: Re: [PATCH] remote-helpers: point at their upstream repositories
Date: Fri, 16 May 2014 10:55:54 +0200
Message-ID: <CAHVLzc=FcT6BcwX=kx7WKNqod4S0ePmvh5p+sgnQfWTPQ=7yTA@mail.gmail.com>
References: <xmqqa9aid52a.fsf@gitster.dls.corp.google.com> <20140516084126.GB21468@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 16 10:56:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlDwE-0000O1-1C
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 10:56:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756139AbaEPI4Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 04:56:16 -0400
Received: from mail-qc0-f178.google.com ([209.85.216.178]:45164 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756014AbaEPI4P (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 04:56:15 -0400
Received: by mail-qc0-f178.google.com with SMTP id l6so3745545qcy.23
        for <git@vger.kernel.org>; Fri, 16 May 2014 01:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=jWWsM9oHPDsFeiRfY+8LvZaf10RTaOTnop57NDH8IA4=;
        b=hIAeuXYTSkB80K+AiBocXXX/RcM44ET3s/pjvIY2iKIVM1itUcKEnqbGpj8KpOE5OO
         lwzAIf0TAO4nUCgIGN6nyqnCcGvclNKQud8FyK2K02S4FGsjgmax2JqMqtylgSHfItQZ
         MNzLqPZ995KkdOWJ9dq9k7JwpGYJENq5ZJroCd3avUDKr+XDjlym/j7olzXbEH2/GT7Y
         RTA1hJgDOq4yHZiqb+5dKE5kbbn4oS6rd3yFP/MKZMPmbbmD2dvKtkFIfcHhGBiQ74c/
         Nib5VDBb4Gada4gBRX0MSczhu3bhF9ZqwbTYQtw4k+BnPs8LHcVXMqQ5v3EtREs+FPXh
         NKNg==
X-Received: by 10.140.107.67 with SMTP id g61mr21781242qgf.100.1400230574323;
 Fri, 16 May 2014 01:56:14 -0700 (PDT)
Received: by 10.140.94.171 with HTTP; Fri, 16 May 2014 01:55:54 -0700 (PDT)
In-Reply-To: <20140516084126.GB21468@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249282>

On Fri, May 16, 2014 at 10:41 AM, Jeff King <peff@peff.net> wrote:
> But that being said, this is Felipe's code. While we have a legal right
> to distribute it in v2.0, if he would really prefer it out for v2.0, I
> would respect that.

My understanding is that Felipe would prefer to keep it _in_ the git.git
repository and eventually get it included in the core.

Regards,
-- 
Paolo
