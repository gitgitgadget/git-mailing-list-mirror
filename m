From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Please default to 'commit -a' when no changes were added
Date: Fri, 23 Apr 2010 12:00:51 -0500
Message-ID: <m2kb4087cc51004231000l5dba7fb9u8d41dc58109a264c@mail.gmail.com>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain> 
	<20100422155806.GC4801@progeny.tock> <87wrvzs590.fsf@frosties.localdomain> 
	<alpine.LFD.2.00.1004221445310.7232@xanadu.home> <87sk6n4426.fsf@frosties.localdomain> 
	<7vsk6n2n48.fsf@alter.siamese.dyndns.org> <vpq7hnzcgjq.fsf@bauges.imag.fr> 
	<87r5m6tu0l.fsf@frosties.localdomain> <4BD166DA.1010803@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Tomas Carnecky <tom@dbservice.com>
X-From: git-owner@vger.kernel.org Fri Apr 23 19:01:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5MFn-0001Sd-Id
	for gcvg-git-2@lo.gmane.org; Fri, 23 Apr 2010 19:01:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758266Ab0DWRBN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Apr 2010 13:01:13 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:37786 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754687Ab0DWRBM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Apr 2010 13:01:12 -0400
Received: by bwz25 with SMTP id 25so11467810bwz.28
        for <git@vger.kernel.org>; Fri, 23 Apr 2010 10:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=oT6SnDVb+JDkWwNE7+FrpJDEPSAqookcUT15wlmr5Vc=;
        b=MjNey+O1WiWNjK44XimO4KthhB6I93ZiPoB9NoEKJ3fNdLl/Ug9j/mkNwV2xtZg+li
         PGOL56o5QI8V2hXdv6IwiOOIGGU4JTgKnbQ2BmtPH4EjAtJ6LUrC7XbdTZWmphi7oL6Y
         qJ24XtF+KQF+WWbzc6EdNRF32SocIW4hzbz30=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=qGxQmnKBv55YxmBuHRNikWwzeMBq2enraB3txQ9PBE/+yTMPmgw89QosVVW3GlDwCh
         aAHuxfipyi9cbv5h26u5clwOVnjxAFeQdgl3pzQnERcvi3NuCDiFOF9YM/1dXFAkl2t9
         cHou05USg8T5g7wOtptAsm4zmVHj7Pdv9antU=
Received: by 10.239.181.73 with SMTP id l9mr25429hbg.55.1272042071135; Fri, 23 
	Apr 2010 10:01:11 -0700 (PDT)
Received: by 10.239.189.143 with HTTP; Fri, 23 Apr 2010 10:00:51 -0700 (PDT)
In-Reply-To: <4BD166DA.1010803@dbservice.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145628>

On Fri, Apr 23, 2010 at 04:22, Tomas Carnecky <tom@dbservice.com> wrote:
> But is compatibility with the SVN interface really what we want to aim for?
> Just because their interface works that way doesn't mean it's the correct
> way.

You--like a lot of others--didn't read the proposal and have not read
Goswin's replies.
