From: Arthur Debert <arthur@stimuli.com.br>
Subject: Re: Commit hashes differ from local and remote
Date: Fri, 15 Apr 2011 12:41:52 -0300
Message-ID: <BANLkTikoaKbxBT=E1sXKV6ScLa7eFh8TWw@mail.gmail.com>
References: <BANLkTimhx1tN7EzU94bpKK64P1F8P7MG0g@mail.gmail.com>
	<BANLkTinEJkLbZRc+=wMUaBRKq=xpxYhk3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 17:42:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAl9j-0007UI-Ve
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 17:42:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756369Ab1DOPly (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2011 11:41:54 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50217 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756355Ab1DOPly (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2011 11:41:54 -0400
Received: by wya21 with SMTP id 21so2351543wya.19
        for <git@vger.kernel.org>; Fri, 15 Apr 2011 08:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=Euamp1se7Po6CPwrwLIlrrQTQTQbEK/gTudNf+Pdqko=;
        b=ZLlse6AqwSzgHFkDc02ey46QlwSbsaksZ0hByJzkSzMuUr2+xhyCIX6j21DJujTezf
         DPYjmS1u5fZAonZqaLJ6tnqF/ZkrP27bzIvHoxwKS639pbaOhKbbfp1FSXyyUFDSonvV
         LRCvjllFB680G6+l4izNHJq6Dl5ZSmDLNoTAY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=n1j5KzBhpA5y30T2xCh3Rv1mrv0ZN0UXdr4VXNjkrGUn63mMIxcqNoAH5QiLAL4no5
         NJs3zNbFk6bckBchNkRjosCx8VjTGuH1c57a99Lay0e0fFfB8lr0PMRCZteiZkJ3hhCA
         BURsc4tQjcQCen76ZgbX0bqLTe/fTqx6KahA0=
Received: by 10.216.62.130 with SMTP id y2mr7954996wec.20.1302882112748; Fri,
 15 Apr 2011 08:41:52 -0700 (PDT)
Received: by 10.216.22.143 with HTTP; Fri, 15 Apr 2011 08:41:52 -0700 (PDT)
In-Reply-To: <BANLkTinEJkLbZRc+=wMUaBRKq=xpxYhk3Q@mail.gmail.com>
X-Google-Sender-Auth: KhABfEc7yAl0G-L4zg013Ezg0uY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171614>

Thanks Alex and John, this makes sense.

Cheers
-- 
Arthur Debert
www.stimuli.com.br
