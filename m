From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Questions for "Git User's Survey 2011"
Date: Sat, 3 Sep 2011 11:00:53 +0200
Message-ID: <201109031100.54775.jnareb@gmail.com>
References: <201107252233.02088.jnareb@gmail.com> <4E2DE708.8050805@cisco.com> <20110903084530.GA20905@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Phil Hord <hordp@cisco.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 03 11:01:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qzm6N-0003ym-An
	for gcvg-git-2@lo.gmane.org; Sat, 03 Sep 2011 11:01:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753550Ab1ICJBK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Sep 2011 05:01:10 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:54014 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752925Ab1ICJBG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Sep 2011 05:01:06 -0400
Received: by fxh19 with SMTP id 19so2338412fxh.19
        for <git@vger.kernel.org>; Sat, 03 Sep 2011 02:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=cDTiiZw31VaNpADksHm3y+7Gqzuikl0qK58Jdi5K2Pw=;
        b=Huony3lY5uo7mGZ/4ml3h5GWnpm4Q2RuVeJJennfTxVf0bf8qq2PQZ2dcSov5B18y4
         CdbpOKfs0PknrhQywOGLY1bd2fcR+0WjXO43oX6nzDASqXGCOnvtbPUwL9cBLmYwcyCE
         SlLnFZ4OIuvquZvOw8qAJCabrgr8CmwHrtaR0=
Received: by 10.223.97.214 with SMTP id m22mr3396422fan.29.1315040465066;
        Sat, 03 Sep 2011 02:01:05 -0700 (PDT)
Received: from [192.168.1.13] (abwo246.neoplus.adsl.tpnet.pl [83.8.238.246])
        by mx.google.com with ESMTPS id f1sm894910fah.9.2011.09.03.02.01.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 03 Sep 2011 02:01:03 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20110903084530.GA20905@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180648>

On Sat, 3 Sep 2011, David Aguilar wrote:
> On Mon, Jul 25, 2011 at 05:58:32PM -0400, Phil Hord wrote:
> > On 07/25/2011 04:33 PM, Jakub Narebski wrote:
> > > === 11. What Git interfaces, implementations and frontends do you use? ===
> > > (multiple choice, with other)
[...]
 
> > Looking at the 2010 results, I would add these GUIs to the main list:
> > git-gui (core)
> > gitk (core)
> > gitX
> > gitg
> > git-cola
> > TortoiseGit
> > SmartGit
> > Git Extensions
> > Giggle
> 
> This is a better list ;-)

Because of huge number of Git GUIs and tools instead of providing a long
list of tools to choose from, I went for free-form question:

  === 13. List git tools that you use (optional) ===
  (free form, essay)

  Description:
  ~~~~~~~~~~~~
  Please include only frontends, interfaces and tools that have support
  for Git (so e.g. EGit applies, but Eclipse doesn't).

  Please either use comma separated list of tools, or put each tool in a
  separate line.  That would make analysis of answers simpler.  Thanks
  in advance.

Even though it is free-form question, it shouldn't be hard to analyse,
though it wouldn't be completely automatical.
-- 
Jakub Narebski
Poland
