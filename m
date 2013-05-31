From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v7] Add new git-related helper to contrib
Date: Fri, 31 May 2013 13:58:28 +0530
Message-ID: <CALkWK0=N85vBSOxSh87Z6vKiu7JZFDzrxTQurn3dE4o6N2gbRw@mail.gmail.com>
References: <1369884777-7227-1-git-send-email-felipe.contreras@gmail.com>
 <CALkWK0=ZbOy6sXOvnTNAqz_UBsUymY1CR_WczT-O3Q+18HJjzQ@mail.gmail.com>
 <CAMP44s25vX1p1Np7yqc9_AqVBme+MCTY88hjhfWdL6KZkxgs7Q@mail.gmail.com>
 <CAMP44s0peXDtFB31pEqF49xM8z5OtDKAWaOR65aZSkCndL2bhQ@mail.gmail.com>
 <CALkWK0nVDBv9bfFpAJ+pzON-uD_4HQ0Bcg=CN32fgFvNJnnjgA@mail.gmail.com> <CAMP44s1z8CvF_K4uTn=p2c2pbjv8TKRyMo7QXR2CAqopOnyg_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 31 10:29:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiKi2-0001lT-Kh
	for gcvg-git-2@plane.gmane.org; Fri, 31 May 2013 10:29:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753971Ab3EaI3K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 May 2013 04:29:10 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:40492 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791Ab3EaI3J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 May 2013 04:29:09 -0400
Received: by mail-ie0-f173.google.com with SMTP id k13so3267289iea.4
        for <git@vger.kernel.org>; Fri, 31 May 2013 01:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=SBugXGN42yKfDaJrImFWtLXGJ0EGovqtPsXqrr1BA6o=;
        b=rBg+6ql8X0haJ35VYvXvBkdWYQfunbZMG6vNiorjf5Wd4ilWpMpzWyuBeGL2r6sUYb
         GKG9V8TGuWgwhCW1qDHo5PdO4qbCMj+vm7bhjQIjJIEi5qdgHXPSyH6kM7OvZrR2jjx+
         3KocYpy9eVZ33tCNuR4Zx6fWSKc3Fdl+TaJLAkNvHnBUtsEXPxc4/7PXmlPLGQt/Fr26
         U4EvciOykvKgdHLsuAaAylCZpefgaLTpnZsOi3Nt1QxvgXODvbu4T7ANb716p/w/0B1l
         eIkrO/L+ijWl4TlxANnXlOjrC1YaPzzgue33nyFUE6t2rEmaNHmtV4ELVaJkWcioS2wn
         6fTw==
X-Received: by 10.50.32.8 with SMTP id e8mr1161844igi.89.1369988949008; Fri,
 31 May 2013 01:29:09 -0700 (PDT)
Received: by 10.64.226.135 with HTTP; Fri, 31 May 2013 01:28:28 -0700 (PDT)
In-Reply-To: <CAMP44s1z8CvF_K4uTn=p2c2pbjv8TKRyMo7QXR2CAqopOnyg_g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226079>

Felipe Contreras wrote:
> When a reviewer reaches that point, (s)he usually says: other than
> cosmetic preferences: Reviewed-by: me.

Yes, you can have a Reviewed-by from me if you want.

And yes, it is appropriate not to CC me on v8 and v9, since I have no
further comments.
