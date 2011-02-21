From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: how a patch can be accepted?
Date: Mon, 21 Feb 2011 17:23:39 +0100
Message-ID: <AANLkTin1hNwKfgRrukKvEMDXCSHnU=EfPFJLQ2cYci9L@mail.gmail.com>
References: <AANLkTikPtYy9_4WjvSqdiFG8pjv5KH5e16=4HoeAzoWb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: xzer <xiaozhu@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 21 17:35:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrYjZ-0007VK-0Q
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 17:35:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754684Ab1BUQfL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Feb 2011 11:35:11 -0500
Received: from mail-bw0-f42.google.com ([209.85.214.42]:60131 "EHLO
	mail-bw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752224Ab1BUQfF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Feb 2011 11:35:05 -0500
Received: by mail-bw0-f42.google.com with SMTP id 13so2726339bwz.1
        for <git@vger.kernel.org>; Mon, 21 Feb 2011 08:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=FI+PhtsbhwMXglZu2cLvNirkWrkzPrRtpXiuhtFd5A8=;
        b=XT7+W0LjcNrK9DKOEqayANsX7BxoXWW2EVujtYbq5D1w/zOUQE2RWEPXnsBKtk+uD5
         1l5k0aK5/sEFkL046h/gN4lsunsbwtkVbi5y3QdrsXWHR7omACwl+F0n9g+Q7kSuxiNW
         4XJP82wPLsP62yCO9Ff+ltRpp0CewoDcJFloA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=jceXoMTdDH2T+65BmD6awxu5RjN2zk8onkJ0Gv7/gA2KnF1Uh/D6BqQEGmj/DdW0B7
         jJI4W2vsT7aFn9qY4j92fG9GHIARifVLv6700N9cvymtIVhsuYA3VAU9fZhDpRWInnDi
         IiVwZjhlu0RJPIp05JKVTF3HtLTgbUaW/aSZ0=
Received: by 10.204.7.213 with SMTP id e21mr1510954bke.47.1298305419631; Mon,
 21 Feb 2011 08:23:39 -0800 (PST)
Received: by 10.204.71.7 with HTTP; Mon, 21 Feb 2011 08:23:39 -0800 (PST)
In-Reply-To: <AANLkTikPtYy9_4WjvSqdiFG8pjv5KH5e16=4HoeAzoWb@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167494>

On Mon, Feb 21, 2011 at 15:48, xzer <xiaozhu@gmail.com> wrote:
> I submitted a patch recently by sending a mail to this mail list, but
> I don't know how it can be accepted or rejected? Is that enough just
> send a mail to here? Because the patch is a very important fix to my
> usage and I don't want to apply it every time by myself.

Did you read Documentation/SubmittingPatches?
