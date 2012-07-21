From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: pushing branches
Date: Fri, 20 Jul 2012 22:40:20 -0300
Message-ID: <CACnwZYe03VzR0=m6oCo8X6y=iiLkZXi+xQpvW9goya0roU+PFQ@mail.gmail.com>
References: <CACnwZYdqP_ptj0++dj5NkCoKWKHiLEj+c0t7zrmNidkHsyzMgw@mail.gmail.com>
	<7vhat2toz8.fsf@alter.siamese.dyndns.org>
	<CACnwZYchBpSsvfY_-cu33dmPateNPgYaPr822Ri=Xn6=V0OOnA@mail.gmail.com>
	<CAJsNXTkH6wRgH9g4BCZVxKz9ntf0P_Y81kc+bAhcchkQM3+3Bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: PJ Weisberg <pj@irregularexpressions.net>
X-From: git-owner@vger.kernel.org Sat Jul 21 03:41:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SsOgs-0002dK-0W
	for gcvg-git-2@plane.gmane.org; Sat, 21 Jul 2012 03:41:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753113Ab2GUBkW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jul 2012 21:40:22 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:47031 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753043Ab2GUBkV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2012 21:40:21 -0400
Received: by obbuo13 with SMTP id uo13so5657349obb.19
        for <git@vger.kernel.org>; Fri, 20 Jul 2012 18:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=PNBuQQHSQy9U5HnJYekPcRbW6dFt4uUGuJL5mKyt2gg=;
        b=IlLiVl2JMjQ+amIg2JhlCygoNWH5vbhIs9iQrp4JrxUioaBreKvPwkn/mJZheByjXT
         0zdb9j2wH3/Dkw2nBjUlPy+S9GhA1IOK7+D0m8c0nTDkMLqqpxjoSNkzlqIRSsN4bWLK
         SWSYMki0yXvE28Bktg/YQnegMU9hahOvrPOHy7N/5GCGsFbRfDSWYTfKT1TKZJcnCTY4
         hF/MljoGMMqO+5ZIi8iqT5uh2cFSyPrkuBa2zkiOWrsgtbQgMfUqbyjQb9u67/xj2MKV
         mv5oLl8ysntSZQCARVKQA8sQGtThQRKhmUuL6jBSKTwSqeXoIVdRshqeT8JLmkEbYDyH
         gbLQ==
Received: by 10.60.30.35 with SMTP id p3mr9805770oeh.16.1342834820563; Fri, 20
 Jul 2012 18:40:20 -0700 (PDT)
Received: by 10.182.212.67 with HTTP; Fri, 20 Jul 2012 18:40:20 -0700 (PDT)
In-Reply-To: <CAJsNXTkH6wRgH9g4BCZVxKz9ntf0P_Y81kc+bAhcchkQM3+3Bw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201799>

On Fri, Jul 20, 2012 at 4:19 PM, PJ Weisberg
<pj@irregularexpressions.net> wrote:
> On Fri, Jul 20, 2012 at 8:49 AM, Thiago Farina <tfransosi@gmail.com> wrote:
>
>> What I'm looking for is to upload/create the remote branch in github
>> from inside my local branch, without having to checkout master in
>> order to do so.
>
> In that case, do exactly what you did, except don't checkout master.
>
Why you suggest that? If I demonstrated that origin master or just
origin in the current branch doesn't do what I want, i.e, push it to
github.
