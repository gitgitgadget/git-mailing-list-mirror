From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Using libgit2 code in git.git as a Google Summer of Code project?
Date: Thu, 10 Mar 2011 18:39:21 +0700
Message-ID: <AANLkTi=q6mxGQcdb-Gx9t3TZWDRbNpiZV-iyjgd=NrXj@mail.gmail.com>
References: <AANLkTinqem5e0+vxzR64s1Y9o7B8RgEFXcm0HV_jeZ4Y@mail.gmail.com>
 <AANLkTikkFDLKn5KMaSTwUABBVX_vYDj8pW1kqmsm1_vy@mail.gmail.com>
 <20110310101332.GC26851@elie> <AANLkTikQ3x9A6v3y698_om_4_qB87Zpi_kG3u3=d+Dur@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, libgit2@librelist.com,
	git@vger.kernel.org
To: Vicent Marti <tanoku@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 12:40:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxeDo-0007eH-2h
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 12:40:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752050Ab1CJLjx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2011 06:39:53 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:53361 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751421Ab1CJLjw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2011 06:39:52 -0500
Received: by wya21 with SMTP id 21so1347565wya.19
        for <git@vger.kernel.org>; Thu, 10 Mar 2011 03:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=wgwfP9UMSMJ9hSTZVD5DOP8EQMkx1LAOog6q1mJKVcU=;
        b=KPULaR1Ah/iPD2OhUetJ0wLexhvf+WKTMlplHYO/jDD++v/oGu/64RYw7ZFPOjBewK
         a7YlK7JZORGU3ipzPw9e4auct7sp4XdoV8VFxkR90URQ7BG3QlmA+97hLUZ5heIIlHIy
         Z5BpGdB2W6Y1FprWyPqn/8dPlkCudqAqCN2gI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=HIDnKSOgVxCdwj/dhFp+JPol/Ejyi0HjLjd8cp/h1Iyqgr2CRzJ1UUXJzqRhm1DmXd
         gFE54/0lURtRxggzZ21EklJpMn4XgAOj2TkMiy0OYANbqI33J/R0Vwb3rGuhxE1s1lnl
         vECcIOvVUT56LMMjh6nKX6h19493oUHpifQJI=
Received: by 10.216.35.82 with SMTP id t60mr5829019wea.46.1299757191141; Thu,
 10 Mar 2011 03:39:51 -0800 (PST)
Received: by 10.216.239.5 with HTTP; Thu, 10 Mar 2011 03:39:21 -0800 (PST)
In-Reply-To: <AANLkTikQ3x9A6v3y698_om_4_qB87Zpi_kG3u3=d+Dur@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168810>

On Thu, Mar 10, 2011 at 6:33 PM, Vicent Marti <tanoku@gmail.com> wrote:
> So, personally, I don't know anybody interested on mentoring *that*
> specific task, but I'm certainly interested on mentoring a "help
> complete libgit2" task: the earlier we stabilize the library, the
> earlier tasks like this one will be viable. Maybe on the next SoC? :)

Speaking of which, how complete is libgit2 compared to git? What are
the significant missing pieces?
-- 
Duy
