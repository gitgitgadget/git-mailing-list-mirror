From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Itches with the current rev spec
Date: Thu, 25 Apr 2013 14:43:32 +0530
Message-ID: <CALkWK0m-CKN6rW_rr4=M0J5Wf5g-ng6Z_rXM3q-DThY=H1+xVg@mail.gmail.com>
References: <CALkWK0n97VLtiR96VEy86645NVoDL2rS-g7LBuLb=JpncdH6VA@mail.gmail.com>
 <m2obd3ou34.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Thu Apr 25 11:14:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVIFt-0008NM-Q9
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 11:14:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755989Ab3DYJON (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 05:14:13 -0400
Received: from mail-ia0-f180.google.com ([209.85.210.180]:33836 "EHLO
	mail-ia0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753841Ab3DYJON (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 05:14:13 -0400
Received: by mail-ia0-f180.google.com with SMTP id t4so1505204iag.25
        for <git@vger.kernel.org>; Thu, 25 Apr 2013 02:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=dD0iyqRr1MaGqwc/V0vdHYkeG+AZpbeNfKIH2kc3hw8=;
        b=Ah0cJEMnKZR8jqiOcNkQLUTddYxFO5IvEoTV0db+TZlqmXCXbtUBdEeNhBdb6TTJS9
         ivEQDuLxY7bwhxnRf5CGP7ehkdH4iUf0DKSE0y9Ca/AKraU/I37XYWdfZxTYMWd0Rn8Q
         xY+KwT60puC/fA6Pt/l/vk4iXT3MuZwN1Ehkw6/fpffaVefhNezu72SGvpRtdfWkQdbM
         PJUySH04nSQoALcemai4QPKwALPsdqK50M4NN93BiyW81VfEU30o55pPgFgXNbhzWC6K
         +doIwMUIC91ZS4lsPEdPgeF4XSWi+A17ybwy0oZ01eaJzS2/a10gc3aGGCVOT5bmEuRq
         0neA==
X-Received: by 10.50.73.65 with SMTP id j1mr18308929igv.49.1366881252688; Thu,
 25 Apr 2013 02:14:12 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Thu, 25 Apr 2013 02:13:32 -0700 (PDT)
In-Reply-To: <m2obd3ou34.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222358>

Andreas Schwab wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> you might argue that ~<n> normally refers to a /home/<n>, but who uses
>> numbers in place of usernames?
>
> ~<n> expands to the <n>th element of the dir stack.

Oh, ouch.  And this is bash.

Have to think of something else.
