From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: What's cooking in git.git (Jul 2011, #04; Wed, 27)
Date: Thu, 28 Jul 2011 10:12:23 +0200
Message-ID: <CAGdFq_hHUq2nV1emr9h=VKMokkN3cZ0D95LiW05QW_JuVq06wQ@mail.gmail.com>
References: <7v7h73mfmj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 28 10:13:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmLiQ-0007e5-0E
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 10:13:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753630Ab1G1INF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Jul 2011 04:13:05 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:32889 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754238Ab1G1IND convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jul 2011 04:13:03 -0400
Received: by pzk37 with SMTP id 37so4146570pzk.1
        for <git@vger.kernel.org>; Thu, 28 Jul 2011 01:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=/VJOxbfxu1yX8QY2FV2FCNcgBRwGRODWKQnd1dxgJiU=;
        b=d5ek2Q6VhdIkj8wPo4dzCIJJC/QErq+3RqHuAHkKgmLVGgPyDGpcmd1cUxuzGgXZvi
         UsEAlkbF6EgzwUq6BFHQr4GU27LHEcgNmA70L4eycNAr55G2GCs5P246SfhFSZ0yGoba
         +r0Pz4QQinQw0xPCNFq6jinGJUYq0WMFbxczU=
Received: by 10.68.54.164 with SMTP id k4mr1215924pbp.310.1311840783072; Thu,
 28 Jul 2011 01:13:03 -0700 (PDT)
Received: by 10.68.71.162 with HTTP; Thu, 28 Jul 2011 01:12:23 -0700 (PDT)
In-Reply-To: <7v7h73mfmj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178048>

Heya,

On Thu, Jul 28, 2011 at 02:08, Junio C Hamano <gitster@pobox.com> wrote=
:
> * sr/transport-helper-fix-rfc (2011-07-19) 2 commits
> =C2=A0- t5800: point out that deleting branches does not work
> =C2=A0- t5800: document inability to push new branch with old content
> =C2=A0(this branch uses sr/transport-helper-fix.)

The fe-fixes series that I sent out last Sunday addresses the bug
pointed out by the first test case.

--=20
Cheers,

Sverre Rabbelier
