From: "Stephen Sinclair" <radarsat1@gmail.com>
Subject: Re: [PATCH] Default to fetching a remote after adding it.
Date: Fri, 11 Apr 2008 15:17:50 -0400
Message-ID: <9b3e2dc20804111217n1b45f78fh27363b76283219d8@mail.gmail.com>
References: <20080411203501.7095b866@localhost>
	 <1207939163-24787-1-git-send-email-g2p.code@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: Gabriel <g2p.code@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 11 21:18:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkOli-0000HU-Bt
	for gcvg-git-2@gmane.org; Fri, 11 Apr 2008 21:18:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760349AbYDKTRx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2008 15:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758817AbYDKTRx
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Apr 2008 15:17:53 -0400
Received: from el-out-1112.google.com ([209.85.162.179]:1618 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755372AbYDKTRx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2008 15:17:53 -0400
Received: by el-out-1112.google.com with SMTP id v27so502019ele.17
        for <git@vger.kernel.org>; Fri, 11 Apr 2008 12:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=30sEwjQC56N6tw6EITw2Fw29HtVAnrlJISvQHY/oRJM=;
        b=XOdAx1OvJEN3Ibnfvn1kud/ouDbzUETZr+yYYSPJLWNA1QlL0yP0AZvCVqgxLmmIddIG6Ck72jWw6kbxALeM3wquIuMWEODJTJoFkDT+/3XOLKALtSYpaUPLEr1AZz/r/UfchHqQJfX0ino+VQmnGXI6sT9VOZeJe07pgOV7Grg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CZh1yu44hPItOx9Lgqlm+cQvPUZPpXXD2kZJs3EpA/tSXrNb9kPNWFqXSb1U1gQaRSSfnitXleY11pwwH9rqCYBYiHh3ScTSrBU301eU+obfIkRUjFIQMzecZsbwPvjYsXZchIdlqt6xTJbtCJ50qL8gxiZK3bLImW0b4naSJQU=
Received: by 10.140.125.1 with SMTP id x1mr1726028rvc.217.1207941470058;
        Fri, 11 Apr 2008 12:17:50 -0700 (PDT)
Received: by 10.141.66.3 with HTTP; Fri, 11 Apr 2008 12:17:50 -0700 (PDT)
In-Reply-To: <1207939163-24787-1-git-send-email-g2p.code@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79288>

On Fri, Apr 11, 2008 at 2:39 PM, Gabriel <g2p.code@gmail.com> wrote:
> This is what the user wants in 99% of cases.

Where did you get these magical statistics?
I, for one, have never expected this behaviour.

Steve
