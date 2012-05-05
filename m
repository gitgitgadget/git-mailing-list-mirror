From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Feature idea: git rebase --exec $CMD
Date: Sat, 5 May 2012 13:54:13 +0200
Message-ID: <CAMP44s2pj2dVeOp39d8TgaTv5a5ox74k29QpxB_YStWtQ6HPVw@mail.gmail.com>
References: <20120505132650.637c4e06086654e0dbf641fc@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>
To: Antonio Ospite <ospite@studenti.unina.it>
X-From: git-owner@vger.kernel.org Sat May 05 13:54:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQdZ6-0004rr-32
	for gcvg-git-2@plane.gmane.org; Sat, 05 May 2012 13:54:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755165Ab2EELyP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 May 2012 07:54:15 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:33837 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754774Ab2EELyP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 May 2012 07:54:15 -0400
Received: by werb10 with SMTP id b10so407404wer.19
        for <git@vger.kernel.org>; Sat, 05 May 2012 04:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=17fLuFyFl/I+X2GCKaXktJQ2oygTCULJiKlfGtBA9x0=;
        b=vXDXgB8uDaxehIydan2lks6rflerwfrPIg1hLwg0ahD7zpBB4wd/jE4EeJEx6k0Lqx
         w2wltpQjpya/0AI3gEYJ9Z+BJg635ostFgfy8+ejguY4VsE+meMZHAywN8eJcAj0gE1d
         cg/878cd1bjOANmNbhXcD3l/F3h/QLSPlKbYM7wp0QHei+KZQ50FcN5zuJ7yi6PMaClO
         GujmGROYzo88WvHTJ9PSww7fOmzEbnoNs7B/Lh3yU8YxDyk4w267LnNUzKYJi08aHAGq
         RC3KM4XwbYJdEZt4qpgedwnq+B+hw0DKJ4B8ayHqX8DNME+a0WZiFLrF+5yPzz4cX6v+
         669Q==
Received: by 10.180.78.164 with SMTP id c4mr20821724wix.10.1336218853954; Sat,
 05 May 2012 04:54:13 -0700 (PDT)
Received: by 10.216.124.197 with HTTP; Sat, 5 May 2012 04:54:13 -0700 (PDT)
In-Reply-To: <20120505132650.637c4e06086654e0dbf641fc@studenti.unina.it>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197107>

On Sat, May 5, 2012 at 1:26 PM, Antonio Ospite <ospite@studenti.unina.it> wrote:
> I find the x/exec function in "git rebase -i" very useful, but it may
> be tedious to edit the commit list to add something like "make test"
> after each commit.

FWIW I have had the need for this, I think it's a good idea.

> P.S. I am not subscribed to the list, please CC me.

No need for this; this is a sane mailing list that doesn't munge
Reply-To, so everybody has to 'reply to all'. To be sure you can add
yourself in the CC list, but I think most clients would do the right
thing regardless.

Cheers.

[1] http://felipec.wordpress.com/2010/08/03/avoid-reply-to-munging-mail-as-mail-was-meant-to-be/

-- 
Felipe Contreras
