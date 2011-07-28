From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 18/18] revert: Introduce --continue to continue the operation
Date: Thu, 28 Jul 2011 18:46:07 +0530
Message-ID: <CALkWK0nD+u21Bw9dLm_QJ1r6exw=QW2MYUUxbqrhYgqkp-bEFw@mail.gmail.com>
References: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
 <1311736755-24205-19-git-send-email-artagnon@gmail.com> <7vk4b3mj4r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 28 15:16:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmQS1-0000ZR-5z
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 15:16:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754013Ab1G1NQ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 09:16:29 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59421 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753622Ab1G1NQ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 09:16:28 -0400
Received: by wyg8 with SMTP id 8so102145wyg.19
        for <git@vger.kernel.org>; Thu, 28 Jul 2011 06:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=/RyX81xNCmiUB0zUM0w4rldhP1JNbMpTjlGwRh0c7ZA=;
        b=fSD9Zo9tgXG3JnJfH7TaPTGwjuIOv1C9FR+C+9Ya9uyLQxkDKAPy4y9DpAEpg/lnaf
         9sE8fEw+bWCeVNazpRtpNN7pWGnRMViBGPJ351D9WppZ0gSUocO7reHyjLzG5WSlhz4k
         N1Lh+0heAFdJFH6I+m9HhMuBOpitNIa9T6XKk=
Received: by 10.227.5.199 with SMTP id 7mr1374079wbw.64.1311858987060; Thu, 28
 Jul 2011 06:16:27 -0700 (PDT)
Received: by 10.216.137.134 with HTTP; Thu, 28 Jul 2011 06:16:07 -0700 (PDT)
In-Reply-To: <7vk4b3mj4r.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178066>

Hi,

Junio C Hamano writes:
> (style)
> Many lines indented with SP thoughout the patch.

Fixed.  I really should use the kernel's checkpatch.pl before sending
out patches.

-- Ram
