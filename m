From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [ANNOUNCE] tig-0.14
Date: Sat, 21 Feb 2009 00:31:34 +0100
Message-ID: <2c6b72b30902201531n12243e2cv7bb671048ca6cf76@mail.gmail.com>
References: <20090205204436.GA6072@diku.dk> <4991814A.6050803@tedpavlic.com>
	 <2c6b72b30902101029s72628a88n16473ee30f853198@mail.gmail.com>
	 <6BA2725C-2127-48BE-871E-7449A507CCD8@silverinsanity.com>
	 <d4bc1a2a0902101129y22224c89y144b223e7d7dd463@mail.gmail.com>
	 <2c6b72b30902101241p67a0e1e9u60c8033c4a03260c@mail.gmail.com>
	 <499EE761.2010902@tedpavlic.com>
	 <2c6b72b30902201034r47850c8aq248b673ee96bdf3a@mail.gmail.com>
	 <499F143B.7080708@tedpavlic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Ted Pavlic <ted@tedpavlic.com>
X-From: git-owner@vger.kernel.org Sat Feb 21 00:33:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Laes8-0002Ka-Gu
	for gcvg-git-2@gmane.org; Sat, 21 Feb 2009 00:33:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753774AbZBTXbg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 18:31:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755758AbZBTXbg
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 18:31:36 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:34269 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753249AbZBTXbf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 18:31:35 -0500
Received: by mail-bw0-f161.google.com with SMTP id 5so3122394bwz.13
        for <git@vger.kernel.org>; Fri, 20 Feb 2009 15:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=EJAUESwceYHpPWFGpGBOyf7eHn45Ewm2K3LZzjkY6Vg=;
        b=LY6UHVW6RABewKNIXJoKtiuJ3FTqr6jjgB2hgmPF4LlVAECyJvsGRpXbmXKPdYICVB
         g1etmsrRgeJsmlN2BklN1uiaTnR1ffgHJ7YYahCMb2JY4nqTxJ3cJvLhNjxdBdwUdhpD
         vx9swk/zlhAE1JMX0tQ/jPTHNTdxtu4+ySjTc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=cWyZsSEhP4Idv04wf3SZcLz638cUW3XhCFWwzPX2SVzCIMp43jGu5An8qilIbmHwLM
         HIC48svI1vezbkvHj/9PXUZ6HPAMOmw9N4P2L5UK71kfQniG9GuyvXM5c0ZXe1NQd/+a
         p2biX/cEqvgjTu1WcXPv1a9hFlrMODTa7drhw=
Received: by 10.181.158.16 with SMTP id k16mr447117bko.208.1235172694123; Fri, 
	20 Feb 2009 15:31:34 -0800 (PST)
In-Reply-To: <499F143B.7080708@tedpavlic.com>
X-Google-Sender-Auth: eb35fc8038dee108
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110905>

On Fri, Feb 20, 2009 at 21:36, Ted Pavlic <ted@tedpavlic.com> wrote:
> Both patches (the new and the old) seem to fix the original problem.
>
> However, I now notice that both patches introduces a new problem. From the
> tig repo (with no .tigrc), I run tig to view the single-line changelog. I
> then hit "Enter" to view the first commit (which is your fix). I then hit
> "j" and "k" to scroll through it.

Hmm. I probably won't be able to look at this before sometime in April. Sorry.

-- 
Jonas Fonseca
