From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Better cooperation between checkouts and stashing
Date: Sun, 28 Feb 2010 16:57:25 -0600
Message-ID: <b4087cc51002281457id4e4de6l98ade122312602a2@mail.gmail.com>
References: <4B67227A.7030908@web.de> <7vhbq0wuy6.fsf@alter.siamese.dyndns.org> 
	<4B898F97.90706@web.de> <7vr5o6s5xf.fsf@alter.siamese.dyndns.org> 
	<4B8A75D9.2090702@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>
X-From: git-owner@vger.kernel.org Sun Feb 28 23:57:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nls5A-00038z-9f
	for gcvg-git-2@lo.gmane.org; Sun, 28 Feb 2010 23:57:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754326Ab0B1W5r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2010 17:57:47 -0500
Received: from mail-ew0-f220.google.com ([209.85.219.220]:41464 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762Ab0B1W5q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2010 17:57:46 -0500
Received: by ewy20 with SMTP id 20so963705ewy.21
        for <git@vger.kernel.org>; Sun, 28 Feb 2010 14:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=CsG/kvuM1qsRFY6n7d5eJt5sJa5IRzttt/NZ/LOW7kM=;
        b=sFsv/2PyggZffJ8k3hr+ku7okLhwJmURrMlwJIkV/lYkZu7jKbRZ45UZKn1FTIDj2I
         WlmGCZNIRz3Y/BN083/RBfTICAI/XNx+V6BXpCCvzwdUMmHSoZLEDeM6s0wHhXZBVDhg
         xkUYE9jlI3tC3jY99S/NAxR9uk0kgwxL8igcE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=ogZG2dr9nzgq/j2wkFfCb3CQzWHcsJldlOUbhBK9q440PtVzokF85ICsxwXLPbE2k2
         KqrfIfSyPyrTh4SsAG2wWHl3ViJwdviIZESBMm9chSpC3nDEC2JXNz0DLxbSGBmqwzbV
         AJJiUFIDp6i3f59SzGKK22MvDJpBALBxxRHIU=
Received: by 10.213.97.67 with SMTP id k3mr2470678ebn.18.1267397865195; Sun, 
	28 Feb 2010 14:57:45 -0800 (PST)
In-Reply-To: <4B8A75D9.2090702@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141292>

On Sun, Feb 28, 2010 at 07:55, Markus Elfring <Markus.Elfring@web.de> wrote:
>
> I would prefer to return to the unchanged work tree because I made an adjustment
> for a source file with the intention that this update should only belong to the
> new topic branch. The switch did not provide a clean state from my view.

I don't think you're properly reading what Junio has been saying. I
suggest you look
over this thread again from the beginning.
