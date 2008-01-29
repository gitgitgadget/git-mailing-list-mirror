From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: [PATCH] config.c: Expand $HOME and tilde character in core.excludesfile
Date: Tue, 29 Jan 2008 18:25:08 +1100
Message-ID: <ee77f5c20801282325k3b2c888el7a2a97b78b799803@mail.gmail.com>
References: <y7a9aaem.fsf@blue.sea.net> <m3y7a98ttg.fsf@localhost.localdomain>
	 <buo7ihtcgtt.fsf@dhapc248.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>,
	"Jari Aalto" <jari.aalto@cante.net>, git@vger.kernel.org
To: "Miles Bader" <miles@gnu.org>
X-From: git-owner@vger.kernel.org Tue Jan 29 08:25:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJkqj-0004nb-RP
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 08:25:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753052AbYA2HZK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2008 02:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752949AbYA2HZK
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 02:25:10 -0500
Received: from rv-out-0910.google.com ([209.85.198.187]:18807 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752672AbYA2HZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2008 02:25:09 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1953622rvb.1
        for <git@vger.kernel.org>; Mon, 28 Jan 2008 23:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=puZKPNZ7gClpXV6LAb277cZCY3cUt/cmXA/GhVhrEOY=;
        b=va+iJPrtBlXLygtwCvyLaObS0uQOU08+hx9ZVTLHZJrqXNapRZDqN1HE8mF92jFthO/aQ4HDly02j+u7E+p2Wk76+9r49Q/wQkVy2BbK+tlzapnu4BuIffHC00kCs0cxyX7FFkr+qDBGkaOARp1PlJRdrS0eo4WJCnaYhEQqfyo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mBBG9rXN/+dhGMmj/PVfdrRKs5C+SY+vM5GfQzuTMQ7QCNoO9hAl2OCZSUwL/V4IYgpFsWBsCe84WsnZhlQzOF0HI1jV7JRtt1k6l8kL3FCZC6k+02NfVY06ibdqXPZxvNvUVWcVNycJZzaf6x816uhzt1TWBKdbRHZSbxq0aiQ=
Received: by 10.141.33.21 with SMTP id l21mr4144066rvj.251.1201591508080;
        Mon, 28 Jan 2008 23:25:08 -0800 (PST)
Received: by 10.141.115.4 with HTTP; Mon, 28 Jan 2008 23:25:08 -0800 (PST)
In-Reply-To: <buo7ihtcgtt.fsf@dhapc248.dev.necel.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71959>

On Jan 29, 2008 4:59 PM, Miles Bader <miles.bader@necel.com> wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> > First, git project does NOT use GNU ChangeLog convention for it's
> > commit messages.  We rather use descriptive commit messages.
>
> Not that what Jari wrote had much resemblance to GNU ChangeLog format...

What, like http://www.gnu.org/prep/standards/html_node/Style-of-Change-Logs.html#Style-of-Change-Logs
? It looked like GNU style to me.


Dave.
