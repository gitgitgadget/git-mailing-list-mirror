From: David Barr <davidbarr@google.com>
Subject: Re: What's cooking in git.git (Mar 2012, #02; Sun, 4)
Date: Tue, 6 Mar 2012 09:34:08 +1100
Message-ID: <CAFfmPPNWXG2iP4jg0v0EoMuGb6eNoEvFuserc7vtP9EeLFp1CA@mail.gmail.com>
References: <7vk42z32jo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 05 23:34:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4gTv-0005AS-B8
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 23:34:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757258Ab2CEWeK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 5 Mar 2012 17:34:10 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:40293 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757149Ab2CEWeJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Mar 2012 17:34:09 -0500
Received: by gghe5 with SMTP id e5so1201984ggh.19
        for <git@vger.kernel.org>; Mon, 05 Mar 2012 14:34:08 -0800 (PST)
Received-SPF: pass (google.com: domain of davidbarr@google.com designates 10.236.191.105 as permitted sender) client-ip=10.236.191.105;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of davidbarr@google.com designates 10.236.191.105 as permitted sender) smtp.mail=davidbarr@google.com; dkim=pass header.i=davidbarr@google.com
Received: from mr.google.com ([10.236.191.105])
        by 10.236.191.105 with SMTP id f69mr29970748yhn.23.1330986848707 (num_hops = 1);
        Mon, 05 Mar 2012 14:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding:x-system-of-record;
        bh=/ZS4dri5lPQw/aIiITrNkxKiqeLTVNqqvDL8bIh/FV8=;
        b=E/KqA6SCq3qHX5gpq/YCPjtYFaXy10AzfWJWVvLlhnIplc2kdQMfVtd7TNeKbwg491
         /2iyCqKKD217X2n9q/1qqqepZymsfv6Zit9l6fUhaa4Kt2Ye9NiJbtjtQHhMtykeipSL
         pLficeNv0NKqs5XtqW8WToQdsjlA5Nki9g5+zn3NIT3mpCSiHzWekhZTM4EekfI6qi6A
         cfVraXaVRy6kQwA04u/SVLTKRELFgwN7fKx3Xeka6/iGNbMkHRy1PxMaBoJJIrW6N4xU
         kKVyNWyhRcsjoXZMm7ryAaEj+z9p9W0Tau8jbqAMnvXzjh/ewdAyPtM92SZuV2fC+jx4
         FOtg==
Received: by 10.236.191.105 with SMTP id f69mr23646670yhn.23.1330986848612;
        Mon, 05 Mar 2012 14:34:08 -0800 (PST)
Received: by 10.236.191.105 with SMTP id f69mr23646663yhn.23.1330986848526;
 Mon, 05 Mar 2012 14:34:08 -0800 (PST)
Received: by 10.101.154.34 with HTTP; Mon, 5 Mar 2012 14:34:08 -0800 (PST)
In-Reply-To: <7vk42z32jo.fsf@alter.siamese.dyndns.org>
X-System-Of-Record: true
X-Gm-Message-State: ALoCoQkUcy5sTz0MeoMrzzE4cJ83+EDGMoU2T91RmiSPIv2j9bX7XyylNdRqS0gtFrwocQLjPnzwBGj7WkCTGBUOLF5xJ4Z4O6M1jhfF+HU/mUZDlA5tpZTZhK1a6IJWuzY53mpyNQhhKkfl8Q9hsRdT91dNP/ToeA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192281>

On Mon, Mar 5, 2012 at 6:55 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> You can find the changes described here in the integration branches o=
f the
> repositories listed at
>
> =A0 =A0http://git-blame.blogspot.com/p/git-public-repositories.html

Just a note that the htmldocs are readable at:
  http://git-htmldocs.googlecode.com/git/git.html

Also, they would be readable at:
  http://gitster.github.com/git-htmldocs/git.html
If the branch gh-pages existed and mirrored master.

--
David Barr
