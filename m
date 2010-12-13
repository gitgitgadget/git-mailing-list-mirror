From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: What's cooking in git.git (Dec 2010, #04; Mon, 13)
Date: Mon, 13 Dec 2010 12:47:30 +0100
Message-ID: <AANLkTikGneq+zeN5Z5XrUseX4Arevft67U7pV+h+5Tr+@mail.gmail.com>
References: <7v7hfe5awz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 13 12:47:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PS6sT-0004Tj-Fr
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 12:47:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754669Ab0LMLrc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Dec 2010 06:47:32 -0500
Received: from mail-fx0-f43.google.com ([209.85.161.43]:35790 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762Ab0LMLrb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 06:47:31 -0500
Received: by fxm18 with SMTP id 18so6132096fxm.2
        for <git@vger.kernel.org>; Mon, 13 Dec 2010 03:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=J6FSdcLKGOn8dVxJTDNmIlnBZm/r+7DNd9/lWWlSD14=;
        b=pjK0c5l5+wVMx14f48hLBe31thdFQScSfNovfEZIy5iOlyW2AWw6CgE0myDnY7kw2K
         fhbKb9UZuYzp7xZzHC8PAKUXs7vFyUEBFVFo3ZDpGGEcTlm6pkGgNhWwULtalvl4Tkzv
         6HvY321ltTNIHvUozX1qiC7z6Wb/KXJq+Wlu0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=QGTl7wmJHmrT0WMplYIxWhiaMCh3oaSf+ZaglI6lETGdNh7yi5zcuZ0Vwg4LoVeV61
         4rF4JsbpIbIVeudabg/FGABILvBwTVpdQCcp8Lb1aGQun/G6fdui27lzvY7PZ0qgftN2
         FW0XLXpee2wJs66sAwnZfIOZTXZz/KO4kp6yY=
Received: by 10.223.95.197 with SMTP id e5mr761642fan.104.1292240850065; Mon,
 13 Dec 2010 03:47:30 -0800 (PST)
Received: by 10.223.86.204 with HTTP; Mon, 13 Dec 2010 03:47:30 -0800 (PST)
In-Reply-To: <7v7hfe5awz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163553>

On Mon, Dec 13, 2010 at 09:34, Junio C Hamano <gitster@pobox.com> wrote:

> Needs a bit more minor work to get the basic code structure right.

And I'm still not sure (see earlier replies to "What's Cooking" posts)
what needs to be done to make it better.
