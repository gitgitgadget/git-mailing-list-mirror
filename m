From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: About refs refs/heads/+...
Date: Mon, 22 Dec 2014 09:15:25 +0700
Message-ID: <CACsJy8ABRpXv1ec14jxi7jnnZ9u2sNav8GnJCV01rFrUQ8nBSw@mail.gmail.com>
References: <CACsJy8B8wVKAoqaKJxuyWbyDbFEofwctyfQoU=A0S_yUMc8bgA@mail.gmail.com>
 <xmqqy4q0c0df.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 22 03:16:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y2sXQ-0004Jd-Sx
	for gcvg-git-2@plane.gmane.org; Mon, 22 Dec 2014 03:16:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753733AbaLVCP5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2014 21:15:57 -0500
Received: from mail-ie0-f181.google.com ([209.85.223.181]:57359 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753552AbaLVCP4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2014 21:15:56 -0500
Received: by mail-ie0-f181.google.com with SMTP id rl12so1862373iec.40
        for <git@vger.kernel.org>; Sun, 21 Dec 2014 18:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=AlLl45vd1rpVYpSup67NZcgVs69HoCdiGJEW3blgc80=;
        b=g57yg2IiW1r5iDN94XWhvYj7lQFzcbRKScWPOs1HC37aY/Jd4098/EwU06FrWvRBJJ
         2mitd6yDIFVt7xw4vngcBsM1rY1uiSFi1V2VZ/mVakqb1UqEqzECsERcir5GDf4sx1+n
         rYhflz+nhxTnUdhtSJ+KQsdUsvphPUQ0Hwmtei0qE/Cm4YoBv9vvYLuSQb+6nkTLWlEx
         YNxzUaU3XPN2BhKvuRV/P8UVaQgW5IvPz3eqcjvPSUDVVI20HVoq8etjIWo1y1Pvucd3
         Rq/QPPr64Whp0OCluzpL2Y4l66/H7lIW5e9yJXCI5+VqGGsLzdmfbaxi0cjGY7gBjRDH
         82zQ==
X-Received: by 10.50.171.168 with SMTP id av8mr14169338igc.2.1419214555453;
 Sun, 21 Dec 2014 18:15:55 -0800 (PST)
Received: by 10.107.176.3 with HTTP; Sun, 21 Dec 2014 18:15:25 -0800 (PST)
In-Reply-To: <xmqqy4q0c0df.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261636>

On Mon, Dec 22, 2014 at 1:40 AM, Junio C Hamano <gitster@pobox.com> wrote:
> What is a push refspec with an empty right-hand-side supposed to do in
> the first place anyway?

Error out. My bad.
-- 
Duy
