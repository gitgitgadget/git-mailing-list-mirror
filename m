From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: What's cooking in git.git (Dec 2010, #01; Sat, 4)
Date: Mon, 6 Dec 2010 13:39:27 -0200
Message-ID: <AANLkTikVfXxJU3bOEFh3kSpwA=95EhzPAfhVYJ-Oi0Zd@mail.gmail.com>
References: <7voc90wx36.fsf@alter.siamese.dyndns.org>
	<4CFBA912.2080905@drmicha.warpmail.net>
	<7v4oasvvao.fsf@alter.siamese.dyndns.org>
	<4CFCA4E6.30209@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Dec 06 16:39:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPdA8-0007GU-Hr
	for gcvg-git-2@lo.gmane.org; Mon, 06 Dec 2010 16:39:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753206Ab0LFPja (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Dec 2010 10:39:30 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:56983 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837Ab0LFPj3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Dec 2010 10:39:29 -0500
Received: by fxm20 with SMTP id 20so4298490fxm.19
        for <git@vger.kernel.org>; Mon, 06 Dec 2010 07:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=TiQmaZFBLWFnPh5dLvTpZMoi1nchaii/ieKFITj2G4U=;
        b=xg5s6xV2OpBw0lnL3R+ZiEn9477/yHjPuq4MaxXGoix3M0KnRUofZr1pneMbKRXLaW
         64zCjKYWFYj9Ckv0OJoFP1/dMom1jgylh6uLdXVNhsgR1gQ74EwRN+23iQQiBwKMkLKS
         nDI8GDLHZgS06HalzhLt/tIodbSGHYsLUmO3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=k7sJdbyDIxC2s2teMXQK00uW6qTCiWzzWj6mxNPlsGJmOSD4jUDvYofFh2Vi5rVdgI
         QO4L7ZZC3lNUdA/pEh6KYX+gaESdGM1DLp1VgNlvX6R8z4xINg3i2A45jgyi+Wqn/E7w
         w3KMlRd6U8BangXXmCEYyJCXcyFqv2AOh3DPk=
Received: by 10.223.122.132 with SMTP id l4mr5712530far.21.1291649968446; Mon,
 06 Dec 2010 07:39:28 -0800 (PST)
Received: by 10.204.58.71 with HTTP; Mon, 6 Dec 2010 07:39:27 -0800 (PST)
In-Reply-To: <4CFCA4E6.30209@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162996>

On Mon, Dec 6, 2010 at 6:55 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Exactly, and you're doing a good job of it.
Yeah, he does a good a job. :)

> It can lead to the impression (on the contributors' side) that even simple patches are
> difficult to "get in", and can lead to frustration, of course.

This resumes some of my frustrations here, and maybe the other
contributors here too. So is not just me that has this impression.
Hope the experience can be improved in future.

> But it also ensures that we don't have even more work later on, trying to work
> around a half-thought-through earlier change.
>
And this is also true.
