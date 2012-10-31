From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] test-lib: avoid full path to store test results
Date: Wed, 31 Oct 2012 19:28:36 +0100
Message-ID: <CAMP44s28e4Lxuq5_jZhaOV2PE9X1Qf1o60G7ENqG2ym05kRGfg@mail.gmail.com>
References: <1351570377-894-1-git-send-email-felipe.contreras@gmail.com>
	<20121030044609.GA10873@elie.Belkin>
	<CAMP44s3ap19TDsSo_fmNqJp+ROWo2Ka8bc35YQmR3mMw375WsQ@mail.gmail.com>
	<20121031012730.GY15167@elie.Belkin>
	<CAMP44s1xAeW2QZsNwRVRx+DEhYVVdiKbw-y-aNuo6unuv7pYZQ@mail.gmail.com>
	<20121031021318.GB15167@elie.Belkin>
	<CAMP44s3WODA2Vru0Q1b5EWA6_1vdHnPmFfUmDg0Phh0S=76O9w@mail.gmail.com>
	<509167C8.6090600@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Oct 31 19:28:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTd22-0007Pw-Mc
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 19:28:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758270Ab2JaS2j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2012 14:28:39 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:38543 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751813Ab2JaS2h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2012 14:28:37 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so1754867oag.19
        for <git@vger.kernel.org>; Wed, 31 Oct 2012 11:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=dpqaUOcv3HdVj+1/NxhbbAqqssDhkYHVCq02GB7nnaI=;
        b=SjsdjO9OCNNumVCnUKXhJiVi2prH/5x2HGC4Jh5LhUDbl7289xMhLs+dHlPHlXM2kQ
         bvx5VpPyXzcpIJKOET96wVg97b0S8jpfx9uWXNYXn+Mb8aOxjFz4S5kWeX+Kv0yMm/li
         3Y4Nzhui1wuGm3CRD49MEIySNaU7zS828GaAcDef8d3xmPLOlUeDNHgW2FRYNnebKaCw
         QHx/kj+j8ndeNYktgx5J9cxpJYHV1/yr/kYgyJedYNxZg0I6EsIfAhBUsXAnuGdzw+Ux
         eSC0UeXgldLlxo88Gh1LOzXUKcMAjMaeevzX0ZsY1XWR09DAjIDafH0hDYlIc1YGBsCc
         YewQ==
Received: by 10.182.10.6 with SMTP id e6mr31014456obb.16.1351708116995; Wed,
 31 Oct 2012 11:28:36 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Wed, 31 Oct 2012 11:28:36 -0700 (PDT)
In-Reply-To: <509167C8.6090600@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208847>

On Wed, Oct 31, 2012 at 7:02 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 31.10.2012 03:28, schrieb Felipe Contreras:

>> Yeah, that would be nice. Too bad I don't have that information, and
>> have _zero_ motivation to go and get it for you.
>
> Just to clarify: That information is not just for Jonathan, but for
> everyone on this list and those who dig the history a year down the
> road.

Information that nobody has requested but Johannes.

> Contributors who have _zero_ motiviation to find out that
> information are not welcome here because they cause friction and take
> away time from many others for _zero_ gain.

Fine, stay with the broken code.

Cheers.

--
Felipe Contreras
