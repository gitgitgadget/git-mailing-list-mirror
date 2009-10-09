From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 1/8] imap-send: remove useless uid code
Date: Fri, 9 Oct 2009 17:21:59 +0200
Message-ID: <fabb9a1e0910090821n67c86d0kb4eef1b9ff4bdff1@mail.gmail.com>
References: <1255100682-13952-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, gitster@pobox.com, Jeff King <peff@peff.net>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Oct 09 17:29:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwHOv-0000ET-Mx
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 17:29:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933352AbZJIPXA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 11:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933351AbZJIPXA
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 11:23:00 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:49712 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933343AbZJIPW7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 11:22:59 -0400
Received: by ewy4 with SMTP id 4so712988ewy.37
        for <git@vger.kernel.org>; Fri, 09 Oct 2009 08:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=5Mwsg8Pd5s1WOsQpeP4k04d1iCggo/RWcFcrHMAqwjs=;
        b=DzJq0cIgYl0LZ+gU52yYnLp6jJ+bCKXaDz9Fjt3YYEfXKZacI5jF89tXi2FifESkre
         N0KS0EU4PBJWp/abOkvJhfOlZiKhVwDG4JXfbrX9w0GMXv4XkT5GIGGSTLlRTMtQ5gPT
         oyoISAmYbV8KGJ6euKDAaQ55nSyM7J4Q15NnI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=HNl9IsgA64cJ9aTTSPgKLRffh1vGjNHuvk3bzC05Gp8lDxcuic1wi36aF1qqWmrwTv
         NtL4hddh7TrueH/CPl9mkKi6woYfCky+PxZwhOwnznegPWASbK5ojYTg++B9MLmTjSHU
         qJZK2y+Y6wsSWq+ExKaGJ3853yMR40DZwn2MM=
Received: by 10.216.88.67 with SMTP id z45mr967121wee.112.1255101739242; Fri, 
	09 Oct 2009 08:22:19 -0700 (PDT)
In-Reply-To: <1255100682-13952-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129816>

Heya,

On Fri, Oct 9, 2009 at 17:04, Erik Faye-Lund <kusmabite@googlemail.com> wrote:

Please include a cover letter for series as long as these (anything
larger than 4 should have a cover letter IMHO). Doing so makes it
easier for those that follow the series to see what changed (assuming
you write down what changed in the cover letter). Also, it makes it
easier for those that were not following the series to drop in at the
current version (assuming you provide a short summary of what the
series is about in the cover letter)..

-- 
Cheers,

Sverre Rabbelier
