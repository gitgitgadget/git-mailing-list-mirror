From: David Aguilar <davvid@gmail.com>
Subject: Re: [RFC] Questions for "Git User's Survey 2011"
Date: Sat, 3 Sep 2011 16:41:12 -0700
Message-ID: <93869719-D3B6-4D82-824E-1801B9422C3D@gmail.com>
References: <201107252233.02088.jnareb@gmail.com> <4E2DE708.8050805@cisco.com> <20110903084530.GA20905@gmail.com> <201109031100.54775.jnareb@gmail.com>
Mime-Version: 1.0 (iPhone Mail 8C148a)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Phil Hord <hordp@cisco.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 04 01:41:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzzqB-0005Ue-Vl
	for gcvg-git-2@lo.gmane.org; Sun, 04 Sep 2011 01:41:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752307Ab1ICXl2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Sep 2011 19:41:28 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:36479 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751107Ab1ICXl1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Sep 2011 19:41:27 -0400
Received: by vws1 with SMTP id 1so3113911vws.19
        for <git@vger.kernel.org>; Sat, 03 Sep 2011 16:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=references:in-reply-to:mime-version:content-transfer-encoding
         :content-type:message-id:cc:x-mailer:from:subject:date:to;
        bh=rieMkBf1foA1p0JL+LdQ8YsvojJyBGUjDeD0nZbH8rU=;
        b=Wn/K++zxKL7Pafce0fMfUiYsjwUsYm/PIduH9DzxQ9UFXD6NRaE4wKyve42JGrBfCC
         bYhZLpEXPVzpTAZ5ydQq3JC49R5sey1If5l/BTu6UAKseBRq74dOtI4SzEGogn2fAz3H
         97sqMaPrK6xx5GYuGAHG+PiWgnEL4mixub5f8=
Received: by 10.52.22.130 with SMTP id d2mr624374vdf.223.1315093286394;
        Sat, 03 Sep 2011 16:41:26 -0700 (PDT)
Received: from [10.54.203.33] ([166.205.139.80])
        by mx.google.com with ESMTPS id t6sm2303837vdf.16.2011.09.03.16.41.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 03 Sep 2011 16:41:24 -0700 (PDT)
In-Reply-To: <201109031100.54775.jnareb@gmail.com>
X-Mailer: iPhone Mail (8C148a)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180667>

On Sep 3, 2011, at 2:00 AM, Jakub Narebski <jnareb@gmail.com> wrote:

> On Sat, 3 Sep 2011, David Aguilar wrote:
>> On Mon, Jul 25, 2011 at 05:58:32PM -0400, Phil Hord wrote:
>>> On 07/25/2011 04:33 PM, Jakub Narebski wrote:
>>>> === 11. What Git interfaces, implementations and frontends do you use? ===
>>>> (multiple choice, with other)
> [...]
> 
>>> Looking at the 2010 results, I would add these GUIs to the main list:
>>> git-gui (core)
>>> gitk (core)
>>> gitX
>>> gitg
>>> git-cola
>>> TortoiseGit
>>> SmartGit
>>> Git Extensions
>>> Giggle
>> 
>> This is a better list ;-)
> 
> Because of huge number of Git GUIs and tools instead of providing a long
> list of tools to choose from, I went for free-form question:

okay, that makes sense.

nevertheless, we are advertising cogito (deprecated) and pyrite (never made it past pre-alpha in 2008).  why? these should be removed. if you need a replacement, might I suggest git-cola? ;-)I think removing (and thus not advertising) dead tools is more important than coming up with replacements. this is on page 4/10 on the survs.com link you sent elsewhere in this thread.


>  === 13. List git tools that you use (optional) ===
>  (free form, essay)
> 
>  Description:
>  ~~~~~~~~~~~~
>  Please include only frontends, interfaces and tools that have support
>  for Git (so e.g. EGit applies, but Eclipse doesn't).
> 
>  Please either use comma separated list of tools, or put each tool in a
>  separate line.  That would make analysis of answers simpler.  Thanks
>  in advance.
> 
> Even though it is free-form question, it shouldn't be hard to analyse,
> though it wouldn't be completely automatical.
> -- 
> Jakub Narebski
> Poland
