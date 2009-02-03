From: Steven Noonan <steven@uplinklabs.net>
Subject: Re: Windows release
Date: Tue, 3 Feb 2009 08:42:11 -0800
Message-ID: <f488382f0902030842x6e7466ffm4668abde23e67bea@mail.gmail.com>
References: <450196A1AAAE4B42A00A8B27A59278E70977F81A@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: John Dlugosz <JDlugosz@tradestation.com>
X-From: git-owner@vger.kernel.org Tue Feb 03 17:43:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUONA-0002Rf-Bs
	for gcvg-git-2@gmane.org; Tue, 03 Feb 2009 17:43:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752430AbZBCQmN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Feb 2009 11:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752244AbZBCQmN
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Feb 2009 11:42:13 -0500
Received: from mail-qy0-f11.google.com ([209.85.221.11]:61483 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752042AbZBCQmM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Feb 2009 11:42:12 -0500
Received: by qyk4 with SMTP id 4so2710038qyk.13
        for <git@vger.kernel.org>; Tue, 03 Feb 2009 08:42:11 -0800 (PST)
Received: by 10.215.100.13 with SMTP id c13mr8588258qam.377.1233679331553; 
	Tue, 03 Feb 2009 08:42:11 -0800 (PST)
In-Reply-To: <450196A1AAAE4B42A00A8B27A59278E70977F81A@EXCHANGE.trad.tradestation.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108210>

On Tue, Feb 3, 2009 at 8:21 AM, John Dlugosz <JDlugosz@tradestation.com> wrote:
> I want to update my git installation to the latest stable version, and
> I'm running Windows.  In your download page
> <http://git-scm.com/download> the link next to Cygwin is
> <http://www.cygwin.com/setup.exe> which would seem to be the installer
> for Cygwin itself, not for the Cygwin version of the git executables.
>
> Am I missing something here?
>
> --John

Cygwin doesn't have a binary package system (i.e. rpm, deb, etc), so
you either have to run the Cygwin installer to get the latest one they
support or compile it yourself via Cygwin.

- Steven
