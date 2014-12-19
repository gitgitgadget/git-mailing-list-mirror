From: Alex Henrie <alexhenrie24@gmail.com>
Subject: Re: Fix wrong catalan translation
Date: Fri, 19 Dec 2014 09:13:08 -0700
Message-ID: <CAMMLpeTdTOxEeBAd3h5m5ostoGcQvRrCcQvxa-i34p95PmMp8g@mail.gmail.com>
References: <CACsWDtysnvwxzQCChVfZAF5fQMoT-qYZhC0cfj3Px2Eris5_ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>,
	Joan Perals Tresserra <j.pertres@gmail.com>
To: Albert Astals Cid <aacid@kde.org>
X-From: git-owner@vger.kernel.org Fri Dec 19 17:13:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y20BN-0000zg-OC
	for gcvg-git-2@plane.gmane.org; Fri, 19 Dec 2014 17:13:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752225AbaLSQNb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2014 11:13:31 -0500
Received: from mail-ie0-f180.google.com ([209.85.223.180]:50609 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751792AbaLSQN3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2014 11:13:29 -0500
Received: by mail-ie0-f180.google.com with SMTP id rp18so981380iec.39
        for <git@vger.kernel.org>; Fri, 19 Dec 2014 08:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=DeRdZt+VYqQrb849YCZj8UWDtSutwOKog0jsSdVxnyo=;
        b=SexlJWcNxKdtI6eEZkJx8m4xC5o6YCmFFRorjZIGxR0I843eMy079TRzQJttQYa0oV
         gu3wxo9YE9vnQb2JLv/A6JEOgNivsKELcNo6E04Dcw+hcJNWTWDLU31d+/DyXqfUCtrc
         FysBAIIBcUEHXyPcKgTnBNV55xZXIKTOM3LCKy7PhVFq98BsCUoERehZ+DszRPMOsdIW
         PV9eiyB6EmJRU2x9PKG3iBvgSlGsN1JTwdp9TWEFiYG9Y2SINLRJPKejq8SMixiZcrFN
         knKbNzMZIRDL+pL7yhGTrHlH/P5ggf2nbdsqxuOwOlaS80BTnrSLr9y5f3e3ZeR+aK+K
         V4iQ==
X-Received: by 10.51.16.37 with SMTP id ft5mr3816713igd.6.1419005609033; Fri,
 19 Dec 2014 08:13:29 -0800 (PST)
Received: by 10.107.128.194 with HTTP; Fri, 19 Dec 2014 08:13:08 -0800 (PST)
In-Reply-To: <CACsWDtysnvwxzQCChVfZAF5fQMoT-qYZhC0cfj3Px2Eris5_ug@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261569>

2014-12-19 3:38 GMT-07:00 Albert Astals Cid <aacid@kde.org>:
> Hi, i'm attaching a fix for the Catalan translation were it seems some
> Spanish sneaked in.

Hi Albert, thanks for your interest, and sorry for the error. I'm
currently working with Joan Perals on a batch of corrections to the
Catalan translation, including the one you mentioned:
https://github.com/alexhenrie/git-po/pull/1

Hopefully it will be done soon.

-Alex
