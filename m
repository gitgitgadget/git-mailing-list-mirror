From: Greg Brockman <gdb@MIT.EDU>
Subject: Re: [PATCHv3] Updated patch series for providing mechanism to list 
	available repositories
Date: Mon, 26 Jul 2010 16:18:38 -0700
Message-ID: <AANLkTikG0e5dtGgMe03s=PpG793B-MkrGjdGa0LuZ5zH@mail.gmail.com>
References: <1279725355-23016-1-git-send-email-gdb@mit.edu>
	<AANLkTin+EMYHrr11Dba9Mob+b_Dar_cedWmTsDF=AHFt@mail.gmail.com>
	<AANLkTilSqePFPkteFd7DBgmdhqJHfUDuW_qhkbWVVb3Y@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: j.sixt@viscovery.net, gitster@pobox.com, jrnieder@gmail.com,
	git@vger.kernel.org
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 27 01:18:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdWwa-0006Un-1E
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 01:18:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752411Ab0GZXSn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 19:18:43 -0400
Received: from DMZ-MAILSEC-SCANNER-4.MIT.EDU ([18.9.25.15]:53294 "EHLO
	dmz-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751201Ab0GZXSm (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Jul 2010 19:18:42 -0400
X-AuditID: 1209190f-b7b0aae000000a7d-80-4c4e17d4912b
Received: from mailhub-auth-3.mit.edu (MAILHUB-AUTH-3.MIT.EDU [18.9.21.43])
	by dmz-mailsec-scanner-4.mit.edu (Symantec Brightmail Gateway) with SMTP id F8.86.02685.4D71E4C4; Mon, 26 Jul 2010 19:18:44 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-3.mit.edu (8.13.8/8.9.2) with ESMTP id o6QNIfiO021323
	for <git@vger.kernel.org>; Mon, 26 Jul 2010 19:18:41 -0400
Received: from mail-iw0-f174.google.com (mail-iw0-f174.google.com [209.85.214.174])
	(authenticated bits=0)
        (User authenticated as gdb@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o6QNIcbK028978
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <git@vger.kernel.org>; Mon, 26 Jul 2010 19:18:41 -0400 (EDT)
Received: by iwn7 with SMTP id 7so3140066iwn.19
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 16:18:38 -0700 (PDT)
Received: by 10.231.152.146 with SMTP id g18mr9332827ibw.48.1280186318189; 
	Mon, 26 Jul 2010 16:18:38 -0700 (PDT)
Received: by 10.231.144.140 with HTTP; Mon, 26 Jul 2010 16:18:38 -0700 (PDT)
In-Reply-To: <AANLkTilSqePFPkteFd7DBgmdhqJHfUDuW_qhkbWVVb3Y@mail.gmail.com>
X-Brightmail-Tracker: AAAAAhVGFPIVRtIh
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151902>

> It would probably help if you re-send the entire thing again.
Ok, will do so shortly.

> It also seems to have an unaddressed comment
> (<7vlj96m4mc.fsf@alter.siamese.dyndns.org> from Junio).
Yep, my patch series actually does incorporate that comment.  I didn't
respond to that explicitly because I didn't want to spam the list, but
in the future I'll be sure to respond to comments... I can imagine it
makes things much easier for
people-who-are-not-the-one-writing-the-patch to follow.

> It's also less confusing if the version of your patch series (see
> --subject-prefix in git-format-patch) matches your series. I went
> looking for v2-v3 on the list, but found that you were just counting
> the two RFC's as v1-v2.
Ah.  Will do in the future.

> Things quickly fall from the end of the list archive around
> here. Don't be afraid to resend. It's also easier to review if some
> mails in the old series have subsequent fixup mails.
Ok, sure.  it's good to know that that is acceptable.

Thanks,

Greg
