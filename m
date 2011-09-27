From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2011, #06; Wed, 21)
Date: Mon, 26 Sep 2011 22:08:14 -0400
Message-ID: <CAG+J_DxNVJPNw3XfLyZVkU9tbwgyLdUD2g7UGK7+dHm3m00UBw@mail.gmail.com>
References: <7vaa9xyxpf.fsf@alter.siamese.dyndns.org>
	<CAP2yMaL3rewYZSXQFxkSLkiNbaBAP8r707x2dScVK1zeVr8hXQ@mail.gmail.com>
	<7vvcsjuojp.fsf@alter.siamese.dyndns.org>
	<7vsjnnt5vg.fsf@alter.siamese.dyndns.org>
	<CAP2yMaL=Ox7mFQSA8yyOB9CoBaa_pQQ3bE4B9FugOnfJCT6XeA@mail.gmail.com>
	<7vmxdr2l16.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Scott Chacon <schacon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 27 04:08:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8N5o-00065X-1r
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 04:08:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751589Ab1I0CIP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 22:08:15 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:36472 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751399Ab1I0CIP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 22:08:15 -0400
Received: by gyg10 with SMTP id 10so4726887gyg.19
        for <git@vger.kernel.org>; Mon, 26 Sep 2011 19:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=0V5yLEE5foZChyVhreMpnOPDIH90hluQHZf0NI1muMs=;
        b=nYqL8L99paqfkSPuJMUPSmOL6wXQMgOqzR3YCvdhWffcYP//LZ+1+gsdLTUQPJgiha
         L68pZaBjnUzdtzH3zIm5GkA9eekLBSSaGVqaqChj6xu+Cxfy3J1TtF7jFTbwJIcW4NsJ
         ukxfRZJo4M4sldkuZlMfrWaSeUF9BIcdSUeaw=
Received: by 10.147.154.12 with SMTP id g12mr6619961yao.36.1317089294508; Mon,
 26 Sep 2011 19:08:14 -0700 (PDT)
Received: by 10.147.32.18 with HTTP; Mon, 26 Sep 2011 19:08:14 -0700 (PDT)
In-Reply-To: <7vmxdr2l16.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182202>

On Mon, Sep 26, 2011 at 2:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I haven't figured out how the preformatted documentation branches will be
> managed in the longer term, as it seems likely that I no longer would have
> the post-update hook access to update them upon pushing into my k.org
> repository. I might end up dropping these branches altogether if it gets
> too cumbersome for me to maintain, but I do not know yet.

Building the documentation on OS X is a huge pain. OS X users
definitely appreciate the preformatted documentation. I know that
Homebrew uses it, and I think the git-osx-installer recently discussed
on this list uses it as well.

So, uh, maybe a way can be found to make it less cumbersome for you?

j.
