From: "Sverre Hvammen Johansen" <hvammen@gmail.com>
Subject: Re: [PATCH 2/5] Introduce -ff=<fast forward option>
Date: Sat, 3 May 2008 15:04:08 -0700
Message-ID: <402c10cd0805031504t276e95ffx662004a25c85957f@mail.gmail.com>
References: <402c10cd0804232246i6f7cd946h955b75832cf32876@mail.gmail.com>
	 <46dff0320805020533u179e16cej2c4db3105252d0bd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Ping Yin" <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 04 00:05:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsPqm-0002Jv-P3
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 00:05:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753925AbYECWEN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2008 18:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754176AbYECWEN
	(ORCPT <rfc822;git-outgoing>); Sat, 3 May 2008 18:04:13 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:3262 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753608AbYECWEM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2008 18:04:12 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1434693fgg.17
        for <git@vger.kernel.org>; Sat, 03 May 2008 15:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=YqmeMDet9EtjIjwTKy1yJTCCP3KQ00W0IMIuVluzUc8=;
        b=bF9K1/JLGwdVQ65ryf6fUt7uOYOOeV3RSXnv3KXqty3mGz7+2QU6vZqVqLCwbjAHwQ25mWletPj/IsK+3sjnM60GubFqA++ztXCYMYmgjqMe5efii81C1NqIgAYH6+eq90t+gr8Gfgdc48OKTiq0AOVOyJXWaTWRtfC6MiHf0/I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HICtOUH5QKcR33YYLaEhbjhZ1FheVH3z1u2c1kyub+8iXtHI5WutoK5c9pkJQzVFUmo0Ad5tnDMc+1nfQoUb49e0tKLoV9IMsAxb29npKS2v+anz8fLOjrHlFnX9UwDQ3q2GjxE5Q4xGH0VuQSTkG2Zhh5PzeUPoXTjm5hv2foc=
Received: by 10.82.155.5 with SMTP id c5mr435817bue.14.1209852248902;
        Sat, 03 May 2008 15:04:08 -0700 (PDT)
Received: by 10.82.172.1 with HTTP; Sat, 3 May 2008 15:04:08 -0700 (PDT)
In-Reply-To: <46dff0320805020533u179e16cej2c4db3105252d0bd@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81119>

On Fri, May 2, 2008 at 5:33 AM, Ping Yin <pkufranky@gmail.com> wrote:
>  only and never are both adverb，but allow is a verb. So how about using
>  auto instead of allow?

I don;t intend to change this this late.  I think we are fine with the
current names.

-- 
Sverre Hvammen Johansen
