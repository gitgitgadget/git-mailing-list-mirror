From: Chris Packham <judge.packham@gmail.com>
Subject: Off-topic Thunderbird wrapping (was Re: GIT cloning(or pull/push)
 doesn't work properly if you have a sub-folder as its own GIT repo)
Date: Sun, 24 Apr 2011 23:25:58 +1200
Message-ID: <4DB408C6.3080400@gmail.com>
References: <BANLkTi=YsEr9hOz7-u_t3BJUiMt+34P+ZA@mail.gmail.com> <4DB3D863.4080500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 13:25:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QDxQv-0004w4-B3
	for gcvg-git-2@lo.gmane.org; Sun, 24 Apr 2011 13:24:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756837Ab1DXLYj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2011 07:24:39 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:61792 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756597Ab1DXLYi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2011 07:24:38 -0400
Received: by pvg12 with SMTP id 12so861260pvg.19
        for <git@vger.kernel.org>; Sun, 24 Apr 2011 04:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=munmhk04rSHqa5druNG9K84HkUbGHkTs0tZ0sZ/bQ2U=;
        b=Y+lOlVvTuetI1iG9k7j6mzRnbPsy+cavR16LmYRvuCM6jkS0DMH7B/vCyaN8aiKUOZ
         Jf6c+v/yh1gQ/i9bPrKXzKp17pgxS11/MQ4Ab8KFx5B426bGFJrdc5HOgZt27zxBFual
         RMceHKc4EInnMPics0/Ie4yG+Arf5icZskrLs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        b=inBNa7i16OqEtC+HIe19N97lBDDiayMpfoPy6GOCgE+PWGgbhpz26PHH6JWRM/LC89
         bqTrIczO175jTgH7whbF1q+1J6S1wgdCfUa0R2T1C9jpxXdQ/vsXHW6CRXWLJopmqAFW
         /LWH26vrbDuQyBk6NsS1Cs6hBJ5lyH8CE0or8=
Received: by 10.142.61.18 with SMTP id j18mr1925839wfa.75.1303644278261;
        Sun, 24 Apr 2011 04:24:38 -0700 (PDT)
Received: from laptop.site (115-188-15-163.jetstream.xtra.co.nz [115.188.15.163])
        by mx.google.com with ESMTPS id w11sm6364011wfh.18.2011.04.24.04.24.36
        (version=SSLv3 cipher=OTHER);
        Sun, 24 Apr 2011 04:24:37 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.9.2.14) Gecko/20110221 SUSE/3.1.8 Thunderbird/3.1.8
In-Reply-To: <4DB3D863.4080500@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171991>

On 24/04/11 19:59, Chris Packham wrote:
>
> That's expected behaviour as far as I'm concerned (based on your
> example). ParentGITRepo and Child1Repo are completely independent at
> this point. Cloning ParentGITRepo won't get you any untracked files that
> happen to be in the work-tree of the repository you're cloning.

So this is the 2nd response I've sent recently that Thunderbird didn't 
wrap correctly (yet it looks fine in the composer). Can anybody tell me 
(or point me at a webpage) how to set it up to post to mailing lists nicely?
