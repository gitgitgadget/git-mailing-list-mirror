From: Stefan Beller <sbeller@google.com>
Subject: Re: [ANNOUNCE] Git Merge Contributors Summit, April 8th, Paris
Date: Tue, 24 Feb 2015 16:47:40 -0800
Message-ID: <CAGZ79kZrZhg1bQZxRdjKgkvzwB582tiJcFabViX28mxLVeL0xw@mail.gmail.com>
References: <20150224220923.GA23344@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 25 01:47:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQQ8g-0007qV-UX
	for gcvg-git-2@plane.gmane.org; Wed, 25 Feb 2015 01:47:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752769AbbBYArm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2015 19:47:42 -0500
Received: from mail-ie0-f177.google.com ([209.85.223.177]:35865 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752108AbbBYArm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2015 19:47:42 -0500
Received: by ierx19 with SMTP id x19so859996ier.3
        for <git@vger.kernel.org>; Tue, 24 Feb 2015 16:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=n32ChSkZeFSX4dM58Xd29uallrv1b5Nc+ea7F57SOUU=;
        b=e/CkKGkvUrJj4CqrXfE+GC1CmqHskZQYHoJJdizChsWr9od9OtoKhrIJzhmzN87+A7
         Z2SwCHEfAd40ACDMD5h5oXbAlwJyMHbvTwU9SxPCBWtXcG/Cob/cUPLSRe+1jCt7TB8e
         EnV9z9G592r9sp8WUKf4a8BBjsHpxFjltGvgJV+4TOBMftLto2kjcaoT0JrAbfNiaq2L
         GYLRNS+TGowJrVdcm8q+4ZGZzEwZiJxVjejGA2UvofVcKFdgPpCYlhWhhABGEkKSs4c1
         uieywC1KqKc2RDWH1hKq6g1BYXkAjAkSYocmDzxM1sAPpTL7oWUseF990GimvjQDbap6
         fVwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=n32ChSkZeFSX4dM58Xd29uallrv1b5Nc+ea7F57SOUU=;
        b=RVC4zRjEqeFGYJEry38L05R9WmJKYhfVkL9jBQWRY4yJ9tT6prcm5MhMEe9R3deTJ5
         Z1HMJXR35hxlAV09vEkKoa61VCzzTVGfF/ee7DDY1GpGvOhRa7e8Gdb/GzdKNboFe8cS
         Z9sU+ZQiJszELS07M4W+/6u13/a82EZ8oav+hiH65uAMlnGktEa+6l9ZpZH/amir57Oc
         PoxbE44bV/+Bam16azJVYiczqWeUx2r6NvdNjeJqJsMMnBuDd6D7cJ1D9G5QgmyT9wC+
         THph9Wc+eVRh4sMJrMlFYDr/v2sQCnZaFNCLzPvOn8PCYX1kUEvomSEkYgd+ocaph/w1
         6kwQ==
X-Gm-Message-State: ALoCoQkIiZoX/IlEyVg6WSjca6FcyOzul3KmprMfsbEAtG/e3ERQWat9z3DbNMRxh3nhIGTsI/nT
X-Received: by 10.42.83.147 with SMTP id h19mr946132icl.95.1424825260432; Tue,
 24 Feb 2015 16:47:40 -0800 (PST)
Received: by 10.107.46.31 with HTTP; Tue, 24 Feb 2015 16:47:40 -0800 (PST)
In-Reply-To: <20150224220923.GA23344@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264364>

On Tue, Feb 24, 2015 at 2:09 PM, Jeff King <peff@peff.net> wrote:
>
>   2. Get people thinking about what they would like to talk about.  In
>      past GitTogethers, it's been a mix of people with prepared things
>      to talk about, group discussions of areas, and general kibitzing.
>      We can be spontaneous on the day of the event, but if you have a
>      topic you want to bring up, you may want to give it some thought
>      beforehand.

I am planning to discuss the next git version protocol(s?) which can handle lots
of refs with anybody interested.
