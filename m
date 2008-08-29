From: "Francis Moreau" <francis.moro@gmail.com>
Subject: Re: How to create a branch without any links to the others branches
Date: Fri, 29 Aug 2008 14:17:36 +0200
Message-ID: <38b2ab8a0808290517l75296521rf99f724cb1594f69@mail.gmail.com>
References: <38b2ab8a0808290127o32621d09vac07e7811e6e8139@mail.gmail.com>
	 <81b0412b0808290227g328b793cl58a606e718b4b3ff@mail.gmail.com>
	 <38b2ab8a0808290237l703b0394rad8f42c091d7143f@mail.gmail.com>
	 <81b0412b0808290246j299371b0k7895308368266a01@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 29 14:25:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZ32Y-0006gl-5h
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 14:25:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbYH2MYR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Aug 2008 08:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbYH2MYR
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Aug 2008 08:24:17 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:33734 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750847AbYH2MYR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Aug 2008 08:24:17 -0400
Received: by ug-out-1314.google.com with SMTP id c2so1308905ugf.37
        for <git@vger.kernel.org>; Fri, 29 Aug 2008 05:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=iYPic8iSGN7f+vZ4RB1FLcwfU0vn7+uaUmsW1Vy9/kI=;
        b=SnNTCpdA4rsW7xxwpGPO6RG9ePVy4k2cGqcGgzOrwxH3QzaF7P33xXxZeLvg2po01g
         1ooxWZrZuYDtd0Gi6K7WugNWGXzT1jalGsgg76Xj8uVIRInup0Fsm0HQocbiAY4xsMQV
         10OEtXLRqXa+glpp5PFW+Q39cdO9GR19tfum0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=V5kgE/Mo3n80NCjPud3eSUgsU7kSfwIOX4JKsbdwkZIgV3cGAzamkBYRfSsi+lHwTp
         RfT+n+agujKk4G4MQvbKp88+/EjKDihiTCcMlTvQL4XbwGwO5XNzeJfOCPLSIg/Fx4g6
         PL/mLd6qWckwTolP3pEWVQKR+TKUtBQNGaypk=
Received: by 10.67.115.3 with SMTP id s3mr4488378ugm.68.1220012256786;
        Fri, 29 Aug 2008 05:17:36 -0700 (PDT)
Received: by 10.67.22.17 with HTTP; Fri, 29 Aug 2008 05:17:36 -0700 (PDT)
In-Reply-To: <81b0412b0808290246j299371b0k7895308368266a01@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 29, 2008 at 11:46 AM, Alex Riesen <raa.lkml@gmail.com> wrote:
>
> Dunno. I never needed that explicitly. What do you want to do with it?
>

I'd like to create branches as Junio did for html, man and todo ones.

Thanks
-- 
Francis
