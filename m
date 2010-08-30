From: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
Subject: Re: git peer-to-peer project: info needed
Date: Mon, 30 Aug 2010 22:22:03 +0100
Message-ID: <AANLkTinjow-aRmNB7rSgq17ww00csN82tWBM+6Nv350k@mail.gmail.com>
References: <AANLkTi=xLJ4w1D4=p40f8nUQfLu5hpEfNORnjroffM1v@mail.gmail.com>
	<20100830173905.GA9955@fearengine.rdu.redhat.com>
	<20100830174506.GB9955@fearengine.rdu.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Casey Dahlin <cdahlin@redhat.com>
X-From: git-owner@vger.kernel.org Mon Aug 30 23:22:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqBny-0004C5-Bn
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 23:22:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754458Ab0H3VWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Aug 2010 17:22:06 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:60713 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754422Ab0H3VWE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Aug 2010 17:22:04 -0400
Received: by ywh1 with SMTP id 1so1831685ywh.19
        for <git@vger.kernel.org>; Mon, 30 Aug 2010 14:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=fVnDbu+CA5NsH4qTcsxqr83tr/KfLkNL3p5BQH6D86A=;
        b=WtSy1D4ORTMn9D6Jk1s/mG2NnOML+jKaqN1STiX/Y2jGjvUQeaxemJXYPqJ/nEOxu+
         cYljObuHMs8c75u9IG2Q3E9gg7xncauAtmL81sM9pvUi6/u9N+PI+qQ/nI3qcHkzt/EV
         JiovtHOrl9kZc2biKpBAMI2jKBbn6wjHDEcUE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=jRBCZtj62YlmWM36DghvdeML3DhISchaWUtkBNahGYlq5PjJS0M4tQAiJuI+FyVB78
         QjSthHLastSF/PtPWyYxHGFkKI9pSp/4Jo4gqelTIZ95DfgkOgwglJ8pfmEnEGV0nmdE
         eJmggB+lrRIEqY1U6QUdOVKzYaMfgtahi2w7w=
Received: by 10.220.89.68 with SMTP id d4mr3195556vcm.98.1283203323982; Mon,
 30 Aug 2010 14:22:03 -0700 (PDT)
Received: by 10.220.98.14 with HTTP; Mon, 30 Aug 2010 14:22:03 -0700 (PDT)
In-Reply-To: <20100830174506.GB9955@fearengine.rdu.redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154848>

On Mon, Aug 30, 2010 at 6:45 PM, Casey Dahlin <cdahlin@redhat.com> wrote:

> On further review you seem to be talking more about making fetch itself
> peer-to-peer,

 only on the basis that that's what i believed would be a good start,
lacking any experience or advice :)

> where my patchset is more of a peer-to-peer branch-sharing
> mechanism.

 what's the difference?  i did look at making "blobs / trees"
available but i figured that that would just get you a snapshot (not
helpful).  i'm afraid i don't actually know the difference between
fetch sharing and branch sharing, as my knowledge of git internals is
a bit "swiss cheese".


> Complementary but not necessarily conflicting. Still I'll
> hurry up and get it online :)

 commented already.  was a bit of a bit message in the inbox, with an
inline thingy rather than attachment, but i'll cope.

l.
