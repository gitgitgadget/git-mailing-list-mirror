From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: git color in commit editor
Date: Thu, 6 Jan 2011 11:58:20 +0100
Message-ID: <AANLkTimAXV9u4FfL2cv5vE9oDgs-LfJu2DopRw=FEqUE@mail.gmail.com>
References: <AANLkTimMZaSW4ZUS60Vo38vyuq-PPqPhGdCVZjFzF2Gs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Pavan Savoy <pavan_savoy@sify.com>
X-From: git-owner@vger.kernel.org Thu Jan 06 11:58:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PanY3-00065g-7z
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 11:58:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753021Ab1AFK6W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jan 2011 05:58:22 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55901 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752932Ab1AFK6V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jan 2011 05:58:21 -0500
Received: by fxm20 with SMTP id 20so15898603fxm.19
        for <git@vger.kernel.org>; Thu, 06 Jan 2011 02:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=Xxc51mtvSTMVAIcVmIh4O0RWGUZpdUnb5fzS4xQTSGg=;
        b=m+xUIv8FN5N0bqieeU+CTQKA0IKAypQ4YW7xpMsrfpWyM6kY7L4t9Vn1mySphOMGJb
         ++3kSC/KB1OGtik8KHabomiiMDRkI0XnUwSNp21CNH4Hxe5FIiaGV70LdUU0nxAZSezu
         v1RssKSvgqMHKLwWRTBHPWMBPSbgAN8d+GcZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=hqxBOV+Gy2Sq4gGkdgun3T6542yjhWCySp+Ypa11N+w44XYnOK1zj7P4+Hkk1OB15U
         VoubT6baDw3AAEScJ+8CwFY7pdA+NXcSsBk4F0CK7dGVP7FGqbKgDSSPNm8SbadOAliM
         KLDsbxnwm3/29/+hGz8+68/ZOYF4uhYjEEx78=
Received: by 10.223.103.8 with SMTP id i8mr1454832fao.47.1294311500508; Thu,
 06 Jan 2011 02:58:20 -0800 (PST)
Received: by 10.223.86.204 with HTTP; Thu, 6 Jan 2011 02:58:20 -0800 (PST)
In-Reply-To: <AANLkTimMZaSW4ZUS60Vo38vyuq-PPqPhGdCVZjFzF2Gs@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164628>

On Thu, Jan 6, 2011 at 07:42, Pavan Savoy <pavan_savoy@sify.com> wrote:
> I have git version git version 1.5.6.3, on 1 system and get the colors
> right during a git commit (commit editor being vim..)

FWIW here's how to get those colors under Emacs:
https://github.com/rafl/git-commit-mode
