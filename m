From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: Re: git gui does not open bare repositories
Date: Fri, 28 Sep 2012 20:22:25 +0200
Message-ID: <CAB9Jk9AAg3+JVxp1NVbAbZd00EfsWGMKBhZ1R-i0ZYeUZcEaYg@mail.gmail.com>
References: <CAB9Jk9CA+e8xR9sz7cW+5+990FmTeYN3pjxs4ZKFpkzb6OL35Q@mail.gmail.com>
	<CAH6sp9N1cFH7orPNmfbhgHq6oUNtQNe=-5f5jkYNXzr+6Xp_pQ@mail.gmail.com>
	<CAB9Jk9BivVrH7daMR=u5Y6Ut=pZGRBcgKNZ_afZ53XFxhFBnZw@mail.gmail.com>
	<CAH6sp9ME0og0E-=oW6MBFMBv8hD0y8PpmdpyaV4qqr7Mb7c5VA@mail.gmail.com>
	<50656388.3050400@atlas-elektronik.com>
	<CAB9Jk9C=ndfO37YWS5mg4anu91N4O__iA_msmxU+X2_Nakv-tQ@mail.gmail.com>
	<CAJ_tm-Q2=ZpUQVHG1om5cfhqoLpCwo2fNoqcWOa-n00-h0raOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: =?ISO-8859-1?Q?Stefan_N=E4we?= <stefan.naewe@atlas-elektronik.com>,
	Frans Klaver <fransklaver@gmail.com>, git <git@vger.kernel.org>
To: Ben Smith-Mannschott <bsmith.occs@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 28 20:22:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THfD1-0001Gg-6B
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 20:22:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758649Ab2I1SW1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2012 14:22:27 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:60067 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751420Ab2I1SW0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 14:22:26 -0400
Received: by vcbfo13 with SMTP id fo13so3678689vcb.19
        for <git@vger.kernel.org>; Fri, 28 Sep 2012 11:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=z26hyvhuORuMfaIccYXKRQ3zAtxSfd3EWfj7/+0wubQ=;
        b=N9nZd0GQCcGhcd5RqttnawqAFCC69lJCXtnGKzo9ks/BFnTHh79+fNko9bgLC0/LGa
         133ibYYMG4fFA+U2hk7Dm5IugXmOrnobMFqrbqtbsr6LChUdhX3FK289Of7zsF+Lnft5
         GP/Bcwd4QlTG6xkU44PEnhfVUNd/iek22/L45vYVXCH8XEt5oKYP10fZObHeU6N/Jl/F
         4Ix15uW8Yd3CtsZhsmc3Z0MuAIPmi9boWGSJPORzVt4+gfNjT2IADVdBI3sFhWKE1ru+
         POqP3tNol6fuZSVmreLFInzjCeQT2badoOstGlVhPqXNvNEEUf3gFA9+KR9zite20IZG
         nbTA==
Received: by 10.58.29.166 with SMTP id l6mr4654915veh.41.1348856545746; Fri,
 28 Sep 2012 11:22:25 -0700 (PDT)
Received: by 10.58.68.40 with HTTP; Fri, 28 Sep 2012 11:22:25 -0700 (PDT)
In-Reply-To: <CAJ_tm-Q2=ZpUQVHG1om5cfhqoLpCwo2fNoqcWOa-n00-h0raOQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206593>

Hi Ben,

I run the same test on Linux, and have got the same results as you did.
So the problem is only on Windows.

-Angelo
