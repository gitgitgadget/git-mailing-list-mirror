From: "Sverre Hvammen Johansen" <hvammen@gmail.com>
Subject: Re: [RFC/PATCH Second draft] Fast forward strategies allow, never, and only
Date: Tue, 18 Mar 2008 07:58:29 -0800
Message-ID: <402c10cd0803180858v5d0e81bamfe86a1b4805eb631@mail.gmail.com>
References: <402c10cd0803101959q619efa86pbd501e5e2cc018c2@mail.gmail.com>
	 <402c10cd0803172127u480276c9s4f9d716b4912ad5e@mail.gmail.com>
	 <20080318135704.GA11922@kooxoo235>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Sverre Hvammen Johansen" <hvammen@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 19 20:26:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc3vg-0004Zq-Oa
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 20:26:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753370AbYCSTZh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 15:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752517AbYCSTZc
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 15:25:32 -0400
Received: from fk-out-0910.google.com ([209.85.128.189]:26054 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753348AbYCSTZ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 15:25:28 -0400
Received: by fk-out-0910.google.com with SMTP id 19so688078fkr.5
        for <git@vger.kernel.org>; Wed, 19 Mar 2008 12:25:26 -0700 (PDT)
Received: by 10.82.125.8 with SMTP id x8mr3207907buc.22.1205855909589;
        Tue, 18 Mar 2008 08:58:29 -0700 (PDT)
Received: by 10.82.172.14 with HTTP; Tue, 18 Mar 2008 08:58:29 -0700 (PDT)
In-Reply-To: <20080318135704.GA11922@kooxoo235>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77504>

On Tue, Mar 18, 2008 at 5:57 AM, Ping Yin <pkufranky@gmail.com> wrote:
> * Sverre Hvammen Johansen <hvammen@gmail.com> [2008-03-17 20:27:13 -0800]:
>
>
>  > New fast forward strategies, only, is introduced.  This new fast
>  > forward strategy prevents real merges.
>  >
>
> > +                               fast_forward=allow ;;
>  > +                       *)
>  > +                               die "Available fast-forward strategies
>  > are: allow, newer, and only" ;;
>
>  I fail to apply this patch. It seems wrapped here. Do you use "git send-email"?

I cut and pasted it into gmail.  I will resend the patch as an
attachment together with a few other changes in about 14 hours.

-- 
Sverre Hvammen Johansen
