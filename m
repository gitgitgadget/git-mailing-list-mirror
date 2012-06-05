From: Rafael Reinoldes <rafareino@gmail.com>
Subject: Re: integrate latexdiff within git
Date: Tue, 5 Jun 2012 11:33:53 -0300
Message-ID: <CAOZB5GEAYab=YV8i-gAT36aSD2gJFUMiZUcqYe_ePJUb72vGFA@mail.gmail.com>
References: <CAOZB5GFMA8-rE+MXLgZDYGN6GGEVJ0j2vBVtpPXK0pRCyEfYsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 05 16:34:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sbuq6-0004t0-DW
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 16:34:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757210Ab2FEOe0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 10:34:26 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:47237 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755888Ab2FEOeZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 10:34:25 -0400
Received: by yenm10 with SMTP id m10so4025747yen.19
        for <git@vger.kernel.org>; Tue, 05 Jun 2012 07:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=BsY2OgT19mnAR+r079E+5AiqSpVYsNxL/sJVb5UTewg=;
        b=XgrjnkQSlYQPyKDRY//iQHbGTDCx/piA9dEZJ6k4eEhtdTmLlLrlbdvyhbKBgMP1KJ
         QpOk17NvxZK0bkoPJIa1HXl6y11j3zKSxLevi9vQJlddsTgX0KEqXK8vvJ7cE2nwoL3H
         BiowHx9eZMuYXZDYzEH5X9PallNJkVvP6T4DFvOqVj+hFsB0QoZaN56nOrKr6m8GNk1O
         Uv/8clOW+x3L3HOEueHRF2WcrazP+aXwBECAaWGK5TwKTigVI3Qdm4wvC7YJo3drz1kI
         8Htkg+V2RnUfGP12w5Imm6Oh85yZn4lXtbBbKdB7BSzkxSD0NzS5MFXazxYUXJ9/aWyM
         T9Xw==
Received: by 10.60.9.193 with SMTP id c1mr16213683oeb.47.1338906863748; Tue,
 05 Jun 2012 07:34:23 -0700 (PDT)
Received: by 10.60.60.167 with HTTP; Tue, 5 Jun 2012 07:33:53 -0700 (PDT)
In-Reply-To: <CAOZB5GFMA8-rE+MXLgZDYGN6GGEVJ0j2vBVtpPXK0pRCyEfYsA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199247>

Hi folks,

I'd to suggest a better integration of latesdiff as an alternative to
simple diff for latex/tex files.

I've wroten a simple function in bash to acomplish this and I'm using
it im my system. I think that it would work better in perl, but a
d'ont have time to recode it now. So it's my implementation
http://stackoverflow.com/a/10858993/955143, take a look and see if you
can appropriate it.

Thanks, and sorry to cant help more.

Att.

--
Rafael Reinoldes
rafareino@gmail.com

"Experience is not what happens to a man; it is what a man does with
what happens to him." (Aldous Huxley, Texts and Pretexts - 1932)
