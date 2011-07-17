From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: Re: [PATCH] Documentation/Notes: Remove 'footnote:' warning
Date: Sun, 17 Jul 2011 19:16:46 +0530
Message-ID: <CAK9CXBWfTiD6fQxptQ_W7PbKN7x+SpPy3d44=4YrO4xwc8o5Xg@mail.gmail.com>
References: <1310855420-21183-1-git-send-email-pavan.sss1991@gmail.com>
 <1310908271.21563.17.camel@drew-northup.unet.maine.edu> <CAK9CXBUAX42gCuRLWUpuvK6SSZXv1Cn4YNoFAfjRhouzd+thcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Sun Jul 17 15:55:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QiRoc-000250-Uz
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jul 2011 15:55:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755851Ab1GQNzW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jul 2011 09:55:22 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:50627 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755818Ab1GQNzV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2011 09:55:21 -0400
Received: by ewy4 with SMTP id 4so1179867ewy.19
        for <git@vger.kernel.org>; Sun, 17 Jul 2011 06:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Fq9g0BvwimEhVRNNiPhdGZXtmKq0NbFO6PdysYEyugg=;
        b=aNBVzm7LlDgY+4EfF++Ug8Q/e+LIKJrC7KDOD9CRYyov38XFh3K3DIUuAJy2yNLYpG
         pZBeBYZW3OgAJ0PdQrvuH/0tR9YN1vzVowbYPKjiGxYAbdiXR5FTVAstYcJ7xq6hc7zF
         Pp0utkpep8QKXJeUItfDTEiNx6p5xMJaLl4ws=
Received: by 10.14.127.200 with SMTP id d48mr1685579eei.7.1310910426323; Sun,
 17 Jul 2011 06:47:06 -0700 (PDT)
Received: by 10.14.53.70 with HTTP; Sun, 17 Jul 2011 06:46:46 -0700 (PDT)
In-Reply-To: <CAK9CXBUAX42gCuRLWUpuvK6SSZXv1Cn4YNoFAfjRhouzd+thcw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177300>

I am using asciidoc 8.6.3. It is the newest available in ubuntu repository.

On Sun, Jul 17, 2011 at 6:41 PM, Drew Northup <drew.northup@maine.edu> wrote:
>
> On Sun, 2011-07-17 at 04:00 +0530, Pavan Kumar Sunkara wrote:
> > Remove 'footnote:' from git-notes.txt which is responsible
> > for the warnings surfacing during the generation of git
> > documentation.
> > ---
>
> What version of asciidoc are you using? Perhaps that works just fine
> with newer versions?
> --
> -Drew Northup
> ________________________________________________
> "As opposed to vegetable or mineral error?"
> -John Pescatore, SANS NewsBites Vol. 12 Num. 59
>
