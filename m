From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Makefile: do not set setgid bit on directories on GNU/kFreeBSD
Date: Mon, 3 Oct 2011 21:19:11 +0200
Message-ID: <CAGdFq_hQ-qoktgHB6ACF8H2AmeMyfo-bW4VBxfL-CPw5kDMFQw@mail.gmail.com>
References: <20111003064120.GA24396@elie> <20111003071949.GC17289@elie> <7vlit1ga2l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Petr Salinger <Petr.Salinger@seznam.cz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 03 21:19:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAo3R-0004tv-4e
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 21:19:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757342Ab1JCTTx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Oct 2011 15:19:53 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:46479 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756895Ab1JCTTw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 15:19:52 -0400
Received: by vcbfk10 with SMTP id fk10so3040281vcb.19
        for <git@vger.kernel.org>; Mon, 03 Oct 2011 12:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=z/D+WeSi7oNOIQ6cbZfYtfVuF8oHOaSSIuPsyC0xj9U=;
        b=Ff8IsMybuz3yYW8q4YNGuzdM5bNsUt6v5fA8j5jBFnYSCVYxhK9uiZyIhWd4njk6e9
         3nQg7YQu73p9qa6G3iZPjY8Y1hD+pINMzjnefbaE9GmxGcW8zCE1Y1jWssohyapKFN+2
         atm4XvCzLOXrN24VhBU4d74FBkjDcR4tavXgI=
Received: by 10.68.32.133 with SMTP id j5mr3432388pbi.68.1317669591065; Mon,
 03 Oct 2011 12:19:51 -0700 (PDT)
Received: by 10.68.62.3 with HTTP; Mon, 3 Oct 2011 12:19:11 -0700 (PDT)
In-Reply-To: <7vlit1ga2l.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182700>

Heya,

On Mon, Oct 3, 2011 at 21:16, Junio C Hamano <gitster@pobox.com> wrote:
> Sorry, this is very confusing. Are JN and PS one and the same person?

I would assume PS mailed JN off list?

-- 
Cheers,

Sverre Rabbelier
