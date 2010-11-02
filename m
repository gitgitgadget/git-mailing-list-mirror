From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCH 05/10] Change "tracking branch" to "remote-tracking branch"
Date: Tue, 2 Nov 2010 16:43:28 +0100
Message-ID: <AANLkTinwdDJKQMPx=Z_F7H9Nj=m0MYjQ8SnOjPV2J5x1@mail.gmail.com>
References: <1288711888-21528-1-git-send-email-Matthieu.Moy@imag.fr> <1288711888-21528-6-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Nov 02 16:43:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDJ1f-0003Qw-Ay
	for gcvg-git-2@lo.gmane.org; Tue, 02 Nov 2010 16:43:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753522Ab0KBPnu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Nov 2010 11:43:50 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:38065 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753334Ab0KBPnt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Nov 2010 11:43:49 -0400
Received: by pwj3 with SMTP id 3so1594502pwj.19
        for <git@vger.kernel.org>; Tue, 02 Nov 2010 08:43:49 -0700 (PDT)
Received: by 10.229.86.2 with SMTP id q2mr10437694qcl.188.1288712628638; Tue,
 02 Nov 2010 08:43:48 -0700 (PDT)
Received: by 10.229.105.76 with HTTP; Tue, 2 Nov 2010 08:43:28 -0700 (PDT)
In-Reply-To: <1288711888-21528-6-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160537>

On Tue, Nov 2, 2010 at 4:31 PM, Matthieu Moy <Matthieu.Moy@imag.fr> wro=
te:
> +[[def_remote_tracking_branch]]remote-tracking branch::
> + =A0 =A0 =A0 A regular git <<def_branch,branch>> that is used to fol=
low changes from
> + =A0 =A0 =A0 another <<def_repository,repository>>. A tracking
> + =A0 =A0 =A0 branch should not contain direct modifications or have =
local commits
> + =A0 =A0 =A0 made to it. A remote-tracking branch can usually be
> + =A0 =A0 =A0 identified as the right-hand-side <<def_ref,ref>> in a =
Pull:
> + =A0 =A0 =A0 <<def_refspec,refspec>>.
> +

You missed a tracking branch -> remote-tracking branch substitution in
the third/fourth line.

Santi
