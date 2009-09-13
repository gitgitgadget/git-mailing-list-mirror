From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2009, #03; Sun, 13)
Date: Sun, 13 Sep 2009 16:54:42 +0200
Message-ID: <fabb9a1e0909130754s575c603chdd90f66ccdcf3bd9@mail.gmail.com>
References: <7v63bnw3wy.fsf@alter.siamese.dyndns.org> <200909131653.12743.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Sep 13 16:55:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmqTt-00071e-Qa
	for gcvg-git-2@lo.gmane.org; Sun, 13 Sep 2009 16:55:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754551AbZIMOzB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 10:55:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754544AbZIMOzA
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 10:55:00 -0400
Received: from mail-ew0-f206.google.com ([209.85.219.206]:56671 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754529AbZIMOy7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 10:54:59 -0400
Received: by ewy2 with SMTP id 2so81413ewy.17
        for <git@vger.kernel.org>; Sun, 13 Sep 2009 07:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=uyl8jC/Y+YDvmwjG2V1DnJeJ/nrdcMbzXpruQjdqU7U=;
        b=n60EGzL8VMW7S3thWp9C4oBfvzsIcWrH5U0QZ70LLOFoC2WbdmqnE5Fa4BYyu0fL4M
         FvDdqv5WiffPbCysDGPtHddW0LxgrvsquWFOeejZxc7Pt0zB7TkunHf5nScUoFJliKvO
         m4v0Cg0XBcedafOdEHwhnozeI8fmoMTCzgjzg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=g+syZgha4HRURbk9AvanCBG/U5nC0GnguAYZNlHPeM9W8vudi2sDe519+/12ZaaWJc
         sJjUkvBubyumv9pPHaGmTUugzD+76Rg6zWu5UEyhER2OAuFG/VoH73mlGb5ZIHg46OPJ
         jAoFBiuYxrDHWGNGQiex/7Ibt+i9upeDGFNOU=
Received: by 10.216.51.129 with SMTP id b1mr557322wec.109.1252853702126; Sun, 
	13 Sep 2009 07:55:02 -0700 (PDT)
In-Reply-To: <200909131653.12743.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128367>

Heya,

On Sun, Sep 13, 2009 at 16:53, Johan Herland <johan@herland.net> wrote:
> The next iteration of this topic will use sr/gfi-options, however, I'm
> holding off on submitting the re-roll until Shawn's comments on sr/gfi-
> options have been adressed by Sverre.

I might have some time to do that today, but I'm not sure how Shawn
wants me to do the options part (drop it out and replace it with
specific features, or keep it in).

-- 
Cheers,

Sverre Rabbelier
