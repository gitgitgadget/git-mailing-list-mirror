From: Douglas Mencken <dougmencken@gmail.com>
Subject: Re: [regression] Newer gits cannot clone any remote repos
Date: Mon, 12 Nov 2012 14:35:22 -0500
Message-ID: <CACYvZ7jVRcnR0WQmc3P+WNEterEHFkUkVGH_mDXdHK-rbCvGbA@mail.gmail.com>
References: <CACYvZ7jPd0_XD6YVdfJ2AnKRnKewmzX4uu7w3zt+_gK+qU49gQ@mail.gmail.com>
	<CAO54GHC9ibTwxqLnk1vGSo9R011HE05JOL1mgpTGzeWX7cCcwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Kevin <ikke@ikke.info>
X-From: git-owner@vger.kernel.org Mon Nov 12 20:35:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXznF-0007TP-Cc
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 20:35:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752276Ab2KLTfY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 14:35:24 -0500
Received: from mail-la0-f46.google.com ([209.85.215.46]:43058 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752021Ab2KLTfX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 14:35:23 -0500
Received: by mail-la0-f46.google.com with SMTP id h6so4861662lag.19
        for <git@vger.kernel.org>; Mon, 12 Nov 2012 11:35:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=/sfZhnaHAYqjqMj47B7Lzd9EO81Q4hMrBmHQeR+87iA=;
        b=O13H1Aat5izLZEaQ6BbhrcXczLjCDldbdPWYufsRceKW8q1aHhPtwB4zMuaaFZ2uhS
         O4/tXYHBHn2cbUKohwRC30jXSBlOhb/Z1qTHw3VQiI3Xa5+asi1IDd+TEd6xR0FoQ3YY
         bbS1ELF5h4nE0D8caxRlR373qmiShYRNpOIT6ONMeoxypKJ5B/OfBfzbxzlzVf88CU5+
         uyxkAHTjYlD9cWEHnmJXxTLbNIa/bwyNmW073agoOwFAd8eA0jLLK2XdU5f53oqnd5Sp
         c8FZHZb/jBmXyrFmkpNsReRImTUgs0OG5dLkfSbiJORwcaWLCtNFMsqGSHYDv3a11+BH
         s4kQ==
Received: by 10.152.106.79 with SMTP id gs15mr19358113lab.31.1352748922045;
 Mon, 12 Nov 2012 11:35:22 -0800 (PST)
Received: by 10.112.22.6 with HTTP; Mon, 12 Nov 2012 11:35:22 -0800 (PST)
In-Reply-To: <CAO54GHC9ibTwxqLnk1vGSo9R011HE05JOL1mgpTGzeWX7cCcwQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209511>

> On Mon, Nov 12, 2012 at 12:12 PM, Kevin <ikke@ikke.info> wrote:
> > Maybe handy to say that you're on a Powerpc platform.

Oh, and yes, I'm on 2 x 2-core ("4-core") machine.
