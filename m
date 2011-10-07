From: Philippe Vaucher <philippe.vaucher@gmail.com>
Subject: Re: Pull --rebase looses merge information
Date: Fri, 7 Oct 2011 08:46:34 +0200
Message-ID: <CAGK7Mr5K63s78nt+UBC45_Ec1v-yfQMQK6+Wb-itu_rJHVPDgw@mail.gmail.com>
References: <DECF417E-50BB-4963-965C-BEF1B5C95DAC@mac.com> <201110062031.p96KVvsv018248@no.baka.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duane Murphy <duanemurphy@mac.com>, git@vger.kernel.org
To: in-gitvger@baka.org
X-From: git-owner@vger.kernel.org Fri Oct 07 08:47:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RC4DB-0007IG-5j
	for gcvg-git-2@lo.gmane.org; Fri, 07 Oct 2011 08:47:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758350Ab1JGGrI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Oct 2011 02:47:08 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:61035 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755464Ab1JGGrH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Oct 2011 02:47:07 -0400
Received: by qadb15 with SMTP id b15so2539011qad.19
        for <git@vger.kernel.org>; Thu, 06 Oct 2011 23:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=jjkF0htj2KPsSyHrAPNz1PfcZ93UvS4mNbcaQClQj9Y=;
        b=wmxmrqZ3mHRdoyM9ZSGGHZI2B7pteGZ3C0GDQa4bkKGnqQpyhMj34PSLFNWtCSz/cY
         B+Dq8l+vWjlyqySxjNQ2UiuMsL1k2VMeKnk7tJhXpaoACl13uwK2ZMx2IeU/5Wsbw3fL
         d4ERdA8LXpo3fEzii//ji9741EB6f9/e28Giw=
Received: by 10.229.226.141 with SMTP id iw13mr1255326qcb.98.1317970025644;
 Thu, 06 Oct 2011 23:47:05 -0700 (PDT)
Received: by 10.229.185.204 with HTTP; Thu, 6 Oct 2011 23:46:34 -0700 (PDT)
In-Reply-To: <201110062031.p96KVvsv018248@no.baka.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183059>

> I personally believe all pull should be --rebase, all merges should b=
e
> --no-ff, and all rebases should be -p. =A0At least by default. =A0But=
 that
> is just me.

+1

Philippe
