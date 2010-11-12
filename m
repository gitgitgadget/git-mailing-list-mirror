From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: Newbie: Restore messed up code from local or remote repository
Date: Fri, 12 Nov 2010 15:02:45 +0100
Message-ID: <AANLkTinyhGKbLDJSsu19+capPUgCx0m_5feaOoSuXCm8@mail.gmail.com>
References: <1289550163511-5731540.post@n2.nabble.com> <20101112124621.GF30870@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: gzoller <gzoller@hotmail.com>, git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Fri Nov 12 15:03:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGuDh-0001QO-JA
	for gcvg-git-2@lo.gmane.org; Fri, 12 Nov 2010 15:03:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211Ab0KLODI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Nov 2010 09:03:08 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:62079 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932094Ab0KLODH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Nov 2010 09:03:07 -0500
Received: by qyk12 with SMTP id 12so1127263qyk.19
        for <git@vger.kernel.org>; Fri, 12 Nov 2010 06:03:05 -0800 (PST)
Received: by 10.229.182.5 with SMTP id ca5mr2026107qcb.150.1289570585593; Fri,
 12 Nov 2010 06:03:05 -0800 (PST)
Received: by 10.229.105.76 with HTTP; Fri, 12 Nov 2010 06:02:45 -0800 (PST)
In-Reply-To: <20101112124621.GF30870@efreet.light.src>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161343>

On Fri, Nov 12, 2010 at 1:46 PM, Jan Hudec <bulb@ucw.cz> wrote:
> On Fri, Nov 12, 2010 at 00:22:43 -0800, gzoller wrote:
>>
>> Hello -- Extreme Git Newbie
>>
>> I have a project that is checked into a local git repository as well as
>> pushed to a remote repository.
>>
>> Through misadventure I've managed to screw up my working code and want to
>> restore what I had from my last commit on either the local or remote
>> repositories.
>
> If you screwed up content of the index, you will need the 'reset' command.
>

If the problem is that you messed with the index (stage) or the
working directory and you want to discard local changes to them, you
could also execute "git status" and follow the instruccions there. If
that is not enough, report it here.

HTH,
Santi
