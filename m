From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/5] Documentation/remote-helpers: Rewrite description
Date: Sun, 18 Apr 2010 11:11:54 +0530
Message-ID: <m2of3271551004172241s423ba152re466b18284d73158@mail.gmail.com>
References: <1271551934-sup-1118@kytes> <20100418022900.GA1669@progeny.tock> 
	<1271566331-sup-9608@kytes> <w2jbe6fef0d1004172223kd0d5de2hccf67badf817bd97@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 18 07:42:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3NH7-00038O-Jk
	for gcvg-git-2@lo.gmane.org; Sun, 18 Apr 2010 07:42:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752066Ab0DRFmQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Apr 2010 01:42:16 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:58700 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752017Ab0DRFmP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Apr 2010 01:42:15 -0400
Received: by gyg13 with SMTP id 13so2078471gyg.19
        for <git@vger.kernel.org>; Sat, 17 Apr 2010 22:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=pNrhtKSMJmTWjgi3pmPmqizIIh8e0/VMSU3CV6hipB8=;
        b=a5DOn1ktnDBTaOLioMPorULwdRBwVIFPeUEYf4J5xcz9tT6HckyI6Laf5wNM2+H/qD
         5gS//A76xB14rZNVLrskTNNJO1tJ1YvqCiNQBIbmwIVSB86TIUt6A08C0+LoCzRtlElN
         Q5T1qiLKASzzuY08TAJCeOys++f2v6cdSJnnE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=o8iutr/2n9yCN0UldtY5R+WeoDTJd1b9fn3Gbvempc6XLA0n3lXSlLGGC9pcgbYCgl
         GDzjG4fC/VuFbJyN7Sok5GHpSVSphSVwb1VDF5OXfO//iEaVULDwFs0nYo+z5OY4aLG+
         H/c0NQAUmjSVQXgd7tznoRlkT+zMqzKVoRNlw=
Received: by 10.90.69.14 with HTTP; Sat, 17 Apr 2010 22:41:54 -0700 (PDT)
In-Reply-To: <w2jbe6fef0d1004172223kd0d5de2hccf67badf817bd97@mail.gmail.com>
Received: by 10.91.183.7 with SMTP id k7mr2101218agp.32.1271569334128; Sat, 17 
	Apr 2010 22:42:14 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145214>

Hi,

> barring any comment from Junio, I think a fixup is probably more
> onerous than a resend with the fixup squashed in; that is, assuming
> the old iteration is already git-am'ed in, and the fixup applies onto
> a new iteration.

I'll clarify. The fixup applies to `d8e255cb385365` in `pu`. The
thread begins with a patch generated from this commit: the commit is
stalled in `pu` due to lack of acks.

-- Ram
