From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: How to host a github?
Date: Wed, 29 Jul 2009 09:59:30 +0200
Message-ID: <81b0412b0907290059j7ff346efu7fea3dbaef65e5eb@mail.gmail.com>
References: <24713161.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: jvsrvcs <jvsrvcs@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 10:00:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MW44c-0001gh-1t
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 09:59:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbZG2H7d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 29 Jul 2009 03:59:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbZG2H7d
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 03:59:33 -0400
Received: from mail-bw0-f221.google.com ([209.85.218.221]:64444 "EHLO
	mail-bw0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068AbZG2H7c convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jul 2009 03:59:32 -0400
Received: by bwz21 with SMTP id 21so523672bwz.37
        for <git@vger.kernel.org>; Wed, 29 Jul 2009 00:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+HJOQw6cRqbO90iCzjkMRGr4UcPw0yBjqnStgYrpXeQ=;
        b=cwW5B6hPTtJstQ7Z0WLSgaSvRl6aNzWuchV5sVjEWYgR7uYHC39LpAKWJ/jnoRXuws
         VsBH+TxWy3N5F9ilOBGz+G3VBPZkQXLRmW4e9WPLonHHGPA/HJtYUrIvEuAbLss3t8ai
         cuGMSjH8uOLewgbdQIpIH/RaqxLdrRbCA1U4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DNdRMlSuIFPn7JgGCM8f84xp4NCVEieLfNGP9BeFO5s44b7faQQENbLr85Udii2PCp
         e0ssxeTZN075qB/Z9YjNK/pD2uLGEpjb4VHkFpsRvl2wjxyzeZC4FGZHUTSZ76xwghyc
         z1An9YSD95189iPzR4lH910KoQsPv2rdQ9OrM=
Received: by 10.204.60.72 with SMTP id o8mr5273176bkh.210.1248854370959; Wed, 
	29 Jul 2009 00:59:30 -0700 (PDT)
In-Reply-To: <24713161.post@talk.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124316>

On Wed, Jul 29, 2009 at 08:25, jvsrvcs<jvsrvcs@gmail.com> wrote:
>
> I want to share code with a few co-workers and I want to use git.
>
> I installed git (cygwin), created a /project/ and then $cd project
> and then $git init

See also "git add" and "git commit" in the tutorials below.

> I have found so much documentation as to what to do next, that
> I'm confused.

Start here: http://www.git-scm.com/documentation ("Tutorials" section).
The recently published http://progit.org/book/ can be also recommended.

> Do I have to create an account on github in order to share code with
> a few local developers?

No.

> Could I run some sort of server on my laptop in order to share code?

Yes. You don't have to, though.

> (we only need to share during office hours). =C2=A0Basically I just
> want to share code but do not want to sign up for an account
> on github.

Look for fetch, push, and patches in the tutorials.

> How do I work this?

Patiently.
