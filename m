From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Consensus on "Git"
Date: Wed, 11 Nov 2009 10:02:25 +0100
Message-ID: <fabb9a1e0911110102p3f8d005el1269b8cabfaad86e@mail.gmail.com>
References: <ee77f5c20911110032r65a60653sfeef34e3de07d17e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 11 10:02:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N896N-0007VB-8C
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 10:02:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751925AbZKKJCn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 04:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751870AbZKKJCn
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 04:02:43 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:29566 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751787AbZKKJCl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 04:02:41 -0500
Received: by ey-out-2122.google.com with SMTP id 9so197743eyd.19
        for <git@vger.kernel.org>; Wed, 11 Nov 2009 01:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=lpG+doHgIq0DMxg+hUHjpnGGNIeFaRvU0bDXqknFZRc=;
        b=n18Cda/HYXaeW9NvlGLctLTFT2UzXqlMPrM+x2OTXJVai6e5+jiDGng/NM68PZa2p5
         qjoXumo8T3ANnmWaxnoY1vr2lqaB+7a5logjNJFftAzXrWE65Hz0Zhw8CAn7XI6xD6y3
         5oz26uxVygVTlQOsTt8CiQKyVPV1hHRbjU7RE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=KAv4MM0oYCUiB0bFhuQ9DKa58hTYboRhn9fGSVzbq0pQYIdCo+goe4imEPhuEpcC3W
         jrpegHDX8d42BMMEihsKIqFcBcNq1faWIZ1GwzlBpNJ0uGSxKDPzfqgSOwPv/G6FZ433
         B4v12lSZN1t7KxHTQGc4M/vlicEQ3+VrJ/HGs=
Received: by 10.216.93.4 with SMTP id k4mr367135wef.155.1257930165453; Wed, 11 
	Nov 2009 01:02:45 -0800 (PST)
In-Reply-To: <ee77f5c20911110032r65a60653sfeef34e3de07d17e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132627>

Heya,

On Wed, Nov 11, 2009 at 09:32, David Symonds <dsymonds@gmail.com> wrote:
> Is there consensus on "Git" being the standard capitalisation, versus
> "GIT"? I only really see "git" and "Git" on the mailing list and in
> most external documentation and websites (e.g. git-scm.com and
> github.com), but git's source tells a different picture:

Definitely "Git" or "git", the source code ones are probably from
variable names, something like "GIT_INSTALL_DIR" and whatnot.

-- 
Cheers,

Sverre Rabbelier
