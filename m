From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 19/19] .gitignore: add git-remote-cvs
Date: Thu, 29 Oct 2009 11:08:33 -0700
Message-ID: <fabb9a1e0910291108q27a8db65u420991a50e1d8669@mail.gmail.com>
References: <1256839287-19016-1-git-send-email-srabbelier@gmail.com> 
	<1256839287-19016-20-git-send-email-srabbelier@gmail.com> 
	<20091029180538.GC10505@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 29 19:09:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3ZQk-0007aZ-7w
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 19:09:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753111AbZJ2SIw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 14:08:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752773AbZJ2SIw
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 14:08:52 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:32834 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751956AbZJ2SIv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 14:08:51 -0400
Received: by ey-out-2122.google.com with SMTP id 9so493011eyd.19
        for <git@vger.kernel.org>; Thu, 29 Oct 2009 11:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=1KCgCMOVCktbZvcclfZXV+S3q8l2u+jdl8mj0rnYVB8=;
        b=Q0sfqLS7wq+Maz0O2zdg3RjmgSG1B2HLQKgnhor/bfW0t8bnHt3QJjvVKRAkW7npl+
         M7pnE2U/wFg4kEMca1iOxY1tacIeRhr6SHyLObuxbDSu3Yg8aezyoPU5a522BbqENAHj
         C7x7NhTXID6ioOon6PZLmnRGhImlPZgS6ZraE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=R/wX/nCUugtDeeRBvK7X01tib0uojFCQ43NDgUt8xVBmAuW/LabJBA8iypYhvpPUSu
         qXZp4iGFuVjm0zJ7c3X6FMa8E5gMLSIh6LrHIp1Yem2b8YS4yI59BV3giTwzQ49J2fsP
         k69AJfRmorlEuZHFXxRFBh5jj6O1BDp9hT07o=
Received: by 10.216.88.8 with SMTP id z8mr145363wee.109.1256839733654; Thu, 29 
	Oct 2009 11:08:53 -0700 (PDT)
In-Reply-To: <20091029180538.GC10505@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131641>

Heya,

On Thu, Oct 29, 2009 at 11:05, Shawn O. Pearce <spearce@spearce.org> wrote:
> Uh, squash to "[PATCH 14/19] git-remote-cvs: Remote help..." ?

Durr, my bad, done locally, not sending another version yet though :P.

-- 
Cheers,

Sverre Rabbelier
