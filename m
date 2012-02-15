From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [ANNOUNCE] Git 1.7.9.1
Date: Wed, 15 Feb 2012 10:35:03 +0200
Message-ID: <CAMP44s0W=7FkAi1qOVJa+k8beCno6uh=gdj1CSKssQuc3aZ_BQ@mail.gmail.com>
References: <7vk43p6wpd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: linux-kernel-owner@vger.kernel.org Wed Feb 15 09:35:26 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1RxaKi-0001Nd-4U
	for glk-linux-kernel-3@plane.gmane.org; Wed, 15 Feb 2012 09:35:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757924Ab2BOIfI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 15 Feb 2012 03:35:08 -0500
Received: from mail-lpp01m020-f174.google.com ([209.85.217.174]:43069 "EHLO
	mail-lpp01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753145Ab2BOIfF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2012 03:35:05 -0500
Received: by lbom4 with SMTP id m4so412053lbo.19
        for <multiple recipients>; Wed, 15 Feb 2012 00:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=qouNDYILrkkthLnnl7f1VK+yDUTIp3k9unah8MpfNlY=;
        b=PDMfmNLAsefy2x3DNChZm1FyaCUhL6HGja3ndsBuOgxJ2OOdVgLR+t3mjc4mmTYCW1
         hq7L3xz7Kwvajb5WB7HD2VPYl8qmhIP4AAR7eIun+shvYxRq8Jple0EBXjya95TWk2kb
         CG0K9nKSYvXiGh/rXdRI3K5R2Qn8ayoDYCqmw=
Received: by 10.152.123.68 with SMTP id ly4mr16831626lab.13.1329294903147;
 Wed, 15 Feb 2012 00:35:03 -0800 (PST)
Received: by 10.112.41.73 with HTTP; Wed, 15 Feb 2012 00:35:03 -0800 (PST)
In-Reply-To: <7vk43p6wpd.fsf@alter.siamese.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190816>

On Tue, Feb 14, 2012 at 9:28 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> The latest maintenance release Git 1.7.9.1 is now available at the us=
ual
> places. =C2=A0This is primarily to fix various user experience kinks =
in the new
> feature added in 1.7.9 release, so that there no longer is an excuse =
for
> users to hold on to older releases.

I don't see the tag:
http://git.kernel.org/?p=3Dgit/git.git;a=3Dtag;h=3Drefs/tags/v1.7.9.1

--=20
=46elipe Contreras
