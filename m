From: Bradley Wagner <bradley.wagner@hannonhill.com>
Subject: Re: What is the scenario for a commit with 3 or more parents
Date: Thu, 29 Jul 2010 13:57:53 -0400
Message-ID: <AANLkTimxcnTkJLqX6qfdYWHrgXOzZ-Rk_48KHyip39ay@mail.gmail.com>
References: <AANLkTikMRa_LrD2fU9Piv3GW2H0r7Jf_9s5iM0wc9t6s@mail.gmail.com>
	<20100729021946.GG25268@spearce.org>
	<AANLkTik-wOB-iEGK8EnW1Rdk9wwc1E86tYoBU26WepYJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 29 19:58:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeXMm-0005bd-4A
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 19:58:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752570Ab0G2R5z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Jul 2010 13:57:55 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:42846 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751417Ab0G2R5y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jul 2010 13:57:54 -0400
Received: by pwi5 with SMTP id 5so212613pwi.19
        for <git@vger.kernel.org>; Thu, 29 Jul 2010 10:57:54 -0700 (PDT)
Received: by 10.114.197.17 with SMTP id u17mr669541waf.36.1280426274297; Thu, 
	29 Jul 2010 10:57:54 -0700 (PDT)
Received: by 10.229.236.2 with HTTP; Thu, 29 Jul 2010 10:57:53 -0700 (PDT)
In-Reply-To: <AANLkTik-wOB-iEGK8EnW1Rdk9wwc1E86tYoBU26WepYJ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152190>

On Thu, Jul 29, 2010 at 1:55 PM, Sverre Rabbelier <srabbelier@gmail.com=
> wrote:
>
> Heya,
>
> On Wed, Jul 28, 2010 at 21:19, Shawn O. Pearce <spearce@spearce.org> =
wrote:
> > Yes. =A0Its called an octopus merge. =A0It happpens sometimes when
> > merging 2 or more otherwise fairly isolated changes in a single
> > shot. =A0E.g. `git merge feature-a feature-b thing-c`.
>
> Do we have an explanation anywhere as to when one would use a octopus=
 merge?

Another question I had about this: isn't this documentation about
"multi-way merge" inaccurate:
http://book.git-scm.com/5_advanced_branching_and_merging.html.

Sounds like it's not equivalent to merging each branch individually.

>
> --
> Cheers,
>
> Sverre Rabbelier
