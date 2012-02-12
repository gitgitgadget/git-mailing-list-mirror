From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: 1.7.9, libcharset missing from EXTLIBS
Date: Sun, 12 Feb 2012 02:03:42 +0100
Message-ID: <CACBZZX4QB4yU5XKKSzUgrx-Q_-ehjjGQ-mdFLh0CNYZ2mx3siA@mail.gmail.com>
References: <4F3472F4.4060605@aegee.org> <7v1uq3toyq.fsf@alter.siamese.dyndns.org>
 <CACBZZX45=mr=FMqFF+Pw4KPaDAtvs-ePLbFATpyFA93vSfZatw@mail.gmail.com>
 <4F34EF9D.8030509@aegee.org> <7vipjer0yn.fsf@alter.siamese.dyndns.org>
 <7vd39mph9x.fsf@alter.siamese.dyndns.org> <4F370DE5.70400@aegee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= 
	<dilyan.palauzov@aegee.org>
X-From: git-owner@vger.kernel.org Sun Feb 12 02:04:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwNrP-0005iG-35
	for gcvg-git-2@plane.gmane.org; Sun, 12 Feb 2012 02:04:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754448Ab2BLBEF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Feb 2012 20:04:05 -0500
Received: from mail-lpp01m020-f174.google.com ([209.85.217.174]:36724 "EHLO
	mail-lpp01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753616Ab2BLBED convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2012 20:04:03 -0500
Received: by lbom4 with SMTP id m4so1862041lbo.19
        for <git@vger.kernel.org>; Sat, 11 Feb 2012 17:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=lW56AJrYOeJh2qcGTtpeGXtBcxOH3TDBMqx+84aQwRA=;
        b=KAyZnodImI6gUKihZKc6wbbug6KMzfII0gn9zzEIybdO6XskJ0O5DtFbpOlsOAtPRc
         WGZOkoIPkJT4d29aCaVOkfp2b+dAIGs0vJH0618hEhoGgAteZNnYO2R9rJ0/kQuJzMm+
         Pb2FuomQZ1cqHfktxpcmDl6fibpbCYRyjSIZQ=
Received: by 10.152.130.98 with SMTP id od2mr7993334lab.3.1329008642206; Sat,
 11 Feb 2012 17:04:02 -0800 (PST)
Received: by 10.112.1.230 with HTTP; Sat, 11 Feb 2012 17:03:42 -0800 (PST)
In-Reply-To: <4F370DE5.70400@aegee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190556>

2012/2/12 =D0=94=D0=B8=D0=BB=D1=8F=D0=BD =D0=9F=D0=B0=D0=BB=D0=B0=D1=83=
=D0=B7=D0=BE=D0=B2 <dilyan.palauzov@aegee.org>:


This looks good to me, could you please re-submit it as described in
Documentation/SubmittingPatches? I.e. with a signed-off-by etc.
