From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Can git pull from a mercurial repository?
Date: Tue, 25 Sep 2012 10:39:47 -0400
Message-ID: <CACPiFC+ZV=_7dHyfr=25JYdHi5nmZct1-N8J67893xub6EPfyA@mail.gmail.com>
References: <k39lir$gpm$1@ger.gmane.org> <50585F10.3080307@op5.se>
 <000a01cd959a$d8cd0730$8a671590$@schmitz-digital.de> <k3rnak$qp$1@ger.gmane.org>
 <k3sepn$f1e$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Joachim Schmitz <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Tue Sep 25 16:40:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGWJA-0000D8-4x
	for gcvg-git-2@plane.gmane.org; Tue, 25 Sep 2012 16:40:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754963Ab2IYOkJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2012 10:40:09 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:46920 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753743Ab2IYOkH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2012 10:40:07 -0400
Received: by pbbrr4 with SMTP id rr4so213607pbb.19
        for <git@vger.kernel.org>; Tue, 25 Sep 2012 07:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=TyTaJW4J1+nuvlHR09XWNXjzLCj4ZUsSfpw2lAv//Is=;
        b=TtUFsSM8BGVTRD4Dvqs07YoGAXBmkVZDLBEUe98/mI4XyboxgD6YZyxysvDa2n2IUK
         6d/cMnxxU39DQU1+KWziRshReK1igq3Sn+wrelTBFESI5kR8Je/BahCkLS8RhU710UFa
         smjdcNi1UNGTFdu0gsy8bQ041yddm6tMsPPiwoBUzBsPbJ6bQAZ2MEi0xHndtssRSBpp
         0wDtFedw1/Cs6jUORBcZ3QVWV2kFCJ9fyKtJWZh+4ymZw+tikzKIs+YTDQ4BsK7/eVuc
         Y8ScP3kSQ/VLvmyp4/lM4zC4mEIPFnfyFqhN8AQ3PIEdZnq9R+Vn4f0hdYsyhAO8jVOZ
         Bhwg==
Received: by 10.68.189.164 with SMTP id gj4mr46528749pbc.48.1348584007484;
 Tue, 25 Sep 2012 07:40:07 -0700 (PDT)
Received: by 10.66.48.74 with HTTP; Tue, 25 Sep 2012 07:39:47 -0700 (PDT)
In-Reply-To: <k3sepn$f1e$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206359>

On Tue, Sep 25, 2012 at 8:56 AM, Joachim Schmitz
<jojo@schmitz-digital.de> wrote:
> For this platform (HP NonStop) basically nothing is available from any
> repository on the web but ITUGLIB (http://ituglib.connect-community.org) and
> that's the machine I'm working on/for ;-)

Use a more modern machine as an interim point. You can do the import
to git there, then pull from that intermediate repo from pure git.

hth,



m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- Software Architect - OLPC
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
