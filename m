From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Questions on gitosis
Date: Tue, 21 Sep 2010 16:39:01 +0530
Message-ID: <AANLkTikEhAHe+7G72t_1HFMF=3WoD7n30QvcoWCZd=gy@mail.gmail.com>
References: <ActZEUVcIhksov+hSeqmo+xw77FAzA==>
	<26E9B811E137AB4B95200FD4C950886BA3AC1997@orsmsx507.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Olsen, Alan R" <alan.r.olsen@intel.com>
X-From: git-owner@vger.kernel.org Tue Sep 21 13:09:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oy0io-0004VU-7a
	for gcvg-git-2@lo.gmane.org; Tue, 21 Sep 2010 13:09:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756231Ab0IULJI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Sep 2010 07:09:08 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:49246 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753085Ab0IULJH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Sep 2010 07:09:07 -0400
Received: by gyd8 with SMTP id 8so1579226gyd.19
        for <git@vger.kernel.org>; Tue, 21 Sep 2010 04:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=vtBujB2yrnwWQPN/X6EHeyd25NyMEbYoH9HBozyfB3Y=;
        b=QJ3S8apQ17lv3goUSOK1WPIX8qmmyec5qiaBkLPsHUTfWVftX0tzO6YFu9E/b3Vu1N
         bp1FQ6/xSFrk5EpJTJZiGBu4xJMq1sDqp4JSablEBJsxMovjDt4WTUWvadZGd3FvJyAd
         zQ5b6C11MJgIw58vB/Ex21HqscDm8sbnVODdM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=swuNunB3M6AOnprpuEjhQxa7OHmJss2oW90+KIV/ailddZB4iYD9J0Z8EUKWFyjlug
         rho7+aZP/d3r4ZwRaQFrk+GcAbATSAC0dc2D2Tz6HL/CMVuMjikyRHLkH0+ExR1Axdy1
         HDMBHcpubjfQKfJ+vz0XAEUzMhqLy2Sn5XZXQ=
Received: by 10.90.84.1 with SMTP id h1mr6578772agb.78.1285067341368; Tue, 21
 Sep 2010 04:09:01 -0700 (PDT)
Received: by 10.90.83.17 with HTTP; Tue, 21 Sep 2010 04:09:01 -0700 (PDT)
In-Reply-To: <26E9B811E137AB4B95200FD4C950886BA3AC1997@orsmsx507.amr.corp.intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156711>

On Tue, Sep 21, 2010 at 3:45 AM, Olsen, Alan R <alan.r.olsen@intel.com> wrote:
> Is gitosis currently maintained? Who do I contact?
>
> I have a list of bugs in the current version that I would like to see fixed. I can post them here if needed. (It will at least get them picked up by the usual search engines.)

Could you post (or email if you prefer) those bugs anyway so I can see
if they apply to gitolite?  At the very least I can tell you how far
gitolite will be able to meet your needs.

Gitosis itself has not seen a significant commit for more than 2 years
now (there were a couple of minor ones a year ago I think).

-- 
Sitaram
