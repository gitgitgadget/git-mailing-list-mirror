From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 3/3] commit: show interesting ident information in 
	summary
Date: Thu, 14 Jan 2010 21:36:06 +0200
Message-ID: <94a0d4531001141136m3eb51d11rafdf7f0672e68dff@mail.gmail.com>
References: <20100113173408.GA16652@coredump.intra.peff.net>
	 <20100113184510.GA22849@coredump.intra.peff.net>
	 <5722BD3D-E7C9-47F7-B547-09B14D87DA39@wincent.com>
	 <201001141602.22244.trast@student.ethz.ch>
	 <94a0d4531001141104w74dbaf35jb5fded9e266bc04b@mail.gmail.com>
	 <7vy6k0cxbz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	Adam Megacz <adam@megacz.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 20:36:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVVUO-0007jz-RZ
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 20:36:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932325Ab0ANTgJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 Jan 2010 14:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329Ab0ANTgI
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 14:36:08 -0500
Received: from mail-iw0-f194.google.com ([209.85.223.194]:46216 "EHLO
	mail-iw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932327Ab0ANTgH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Jan 2010 14:36:07 -0500
Received: by iwn32 with SMTP id 32so709962iwn.33
        for <git@vger.kernel.org>; Thu, 14 Jan 2010 11:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9ewfHjcDAZfzvfTJQgIYMNpqnSxKmpCN8YT8zj8vQ3E=;
        b=NwBo+y25FPCun7qJTSxTIdeg4CKukXzI594V4bB1scD5d6TWnfA6Ab7IwUPGO3JGlu
         IMRKH+3MMuSr7yPupKkkM3CzQLCNAIBi/sOfZSfeQUrB/CwA3XwdVblTIrCU+z5gTyLU
         lwlLsVlKJk6CGDF+g32VsIje/U1clmpPevUQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RmiceIU0cuwj+3KY9r8IH/o/3LfQVyhCQ8oUdDSQ6Xq+ZMnWFlHTiDrjzBUsGhQuqQ
         wDBA8gCQBM+DIwh9FC2Zb77Ws8hSG3G8dq53eYhW280fPwynw/1uATYTvloLIL+SgbM4
         Y9hrvVAP3mesJNkVwMGW29j9gRukphdYKBYaU=
Received: by 10.231.9.33 with SMTP id j33mr235859ibj.37.1263497766798; Thu, 14 
	Jan 2010 11:36:06 -0800 (PST)
In-Reply-To: <7vy6k0cxbz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137014>

On Thu, Jan 14, 2010 at 9:15 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> I think the point of the message you are responding to is that it has
> already been proven that there are users that never reads any of the
> zillions of "your first 10 minutes with Git". =C2=A0How that _could_ =
ever
> possibly be the reason/justification why you would want to push that
> change to our documentation?

Users are lazy.

--=20
=46elipe Contreras
