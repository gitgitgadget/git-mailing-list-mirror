From: =?UTF-8?Q?Vicent_Mart=C3=AD?= <tanoku@gmail.com>
Subject: Re: Git in GSoC 2014
Date: Wed, 26 Feb 2014 12:25:36 +0100
Message-ID: <CAFFjANTCU-OkydggYGy9tTJqx=TkWoVi2gJge4LUUkKcdB-eZQ@mail.gmail.com>
References: <20140225154158.GA9038@sigill.intra.peff.net> <530CCFB0.5050406@alum.mit.edu>
 <20140226102350.GB25711@sigill.intra.peff.net> <530DC4D1.4060301@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Feb 26 12:26:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIccl-00072d-PP
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 12:26:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbaBZLZ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 06:25:59 -0500
Received: from mail-vc0-f178.google.com ([209.85.220.178]:49427 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751100AbaBZLZ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 06:25:58 -0500
Received: by mail-vc0-f178.google.com with SMTP id ik5so764886vcb.37
        for <git@vger.kernel.org>; Wed, 26 Feb 2014 03:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=66yP6ES6Hh/s/RzrAn8A/0G/AQFX+pMkC71pB5oGLQg=;
        b=rTx5L8qDJ/lY/P+SiitvjcZIgzqwULuyaqQ0XmyrehP4t7aZHxBp6IePIPUoxxkTup
         IogcvIR++3U6//aqb4qX5ROlz7QRyyvQhzqKHYLZD1jC1+NZf6t0Fk/cEDpuXdR8xxiU
         Lc9oHIbPxaSIicRzb+ppBdRNyLwnQWYd32xaqsfXJCbdKUGQ+DwrtrSJtsjO1HRtHLAU
         6lhbMZSqjacCMPgZyyt7Kv3KSky3xiKNppWMQS07p/6uzevy4/HwNs0mm3xFbngmTR8k
         9Oo5DmnumQ8f5s5pEi4AwImp0qbAyLegxmKJFOPM7bP0FpLsoVOrtxG9Rrsr/lmMuUWo
         Rh6g==
X-Received: by 10.58.170.69 with SMTP id ak5mr5664310vec.28.1393413957809;
 Wed, 26 Feb 2014 03:25:57 -0800 (PST)
Received: by 10.220.133.73 with HTTP; Wed, 26 Feb 2014 03:25:36 -0800 (PST)
In-Reply-To: <530DC4D1.4060301@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242724>

On Wed, Feb 26, 2014 at 11:41 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Since time is short, I already started on this.  I wrote a first draft
> of an introduction for the students.  I also started looking for
> microprojects.  I started going through our source files alphabetically,
> and have already found six suggestions by "bundle.c", so I don't think
> there will be a problem finding enough tiny things to do.

Note that for projects that are either libgit2-centric or mix Core Git
and libgit2, it would be worth it to the students to submit a pull
request on libgit2 (or ideally, on both projects, although that's
going to be hard) in order to make themselves familiar with the code
base.
