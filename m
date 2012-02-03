From: Valerie Aurora <valerie.aurora@gmail.com>
Subject: Re: How best to handle multiple-authorship commits in GIT?
Date: Fri, 3 Feb 2012 11:49:43 -0800
Message-ID: <CAD-XujnmX=GzJ0+otT4EZaG+qRJ=ohzp4Ctr7hqjtur_thPPRA@mail.gmail.com>
References: <21056.1328185509@redhat.com>
	<9B990DDC-858D-43BA-BF9E-E0C3435354AF@gmail.com>
	<15281.1328207789@redhat.com>
	<CAD-XujkVK=tOtmVS90U0KAutFZ55jxsHMKuuMppXOi-H6ZY=RQ@mail.gmail.com>
	<4681.1328276820@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Rusty Russell <rusty@rustcorp.com.au>
To: David Howells <dhowells@redhat.com>
X-From: git-owner@vger.kernel.org Fri Feb 03 20:49:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtP8p-0000Ak-6V
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 20:49:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755565Ab2BCTtq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Feb 2012 14:49:46 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:59372 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754059Ab2BCTtp convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Feb 2012 14:49:45 -0500
Received: by lagu2 with SMTP id u2so2029216lag.19
        for <git@vger.kernel.org>; Fri, 03 Feb 2012 11:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=jZdPmnLrBfsM9EUKoYhJskrQcoSM4x8mRnDAfyeE7Vc=;
        b=JDJmW57AFVmt2dkNfc/+dR923o73FP2OZ6pQTSYtCLQxXt1SY1tJPPWEk7pVMSEzzJ
         cI0PefCrxyxz12wFS04QrImZ5aZxF/p2Pk/kzgLOQtafkzZ6HwQK4RRRebsGLi8/RuAY
         hUDOXxFSdMC05OsCvFDXqIXCYlG1PSNernaUE=
Received: by 10.152.130.98 with SMTP id od2mr3839949lab.3.1328298583801; Fri,
 03 Feb 2012 11:49:43 -0800 (PST)
Received: by 10.112.98.102 with HTTP; Fri, 3 Feb 2012 11:49:43 -0800 (PST)
In-Reply-To: <4681.1328276820@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189794>

On Fri, Feb 3, 2012 at 5:47 AM, David Howells <dhowells@redhat.com> wro=
te:
> Valerie Aurora <valerie.aurora@gmail.com> wrote:
>
>> And for a complete (meaningful) rewrite such as David has done, he
>> changes the commit authorship and adds a Signed-off-by for the
>> original author.
>
> Val[*] hasn't signed off all her patches, and indeed I've merged toge=
ther some
> patches that she has signed off and some she hasn't. =A0I can't simpl=
y add
> Signed-off-by her without her permission. =A0However, if she's willin=
g for me to
> add such lines, then I can do so.

Cc me on the next posting and I'll review and add my Signed-off-by if
it's missing anywhere it should be?  Or send them privately, whichever
you prefer.

-VAL
