From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Git User's Survey 2008
Date: Thu, 24 Jul 2008 10:15:38 +0200
Message-ID: <200807241015.38817.jnareb@gmail.com>
References: <200807230325.04184.jnareb@gmail.com> <alpine.DEB.1.00.0807231128090.2830@eeepc-johanness> <20080723171745.GC5283@blimp.local>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 10:16:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLw0G-0007xV-UD
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 10:16:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbYGXIPs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 04:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbYGXIPr
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 04:15:47 -0400
Received: from ik-out-1112.google.com ([66.249.90.176]:27104 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191AbYGXIPq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 04:15:46 -0400
Received: by ik-out-1112.google.com with SMTP id c28so2048658ika.5
        for <git@vger.kernel.org>; Thu, 24 Jul 2008 01:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=CQwp8X+6riP/eu0V9AK2/K0XIvaDCqHMclkNhr7Bfjo=;
        b=dGJNT4w0tmzuIrC4cegsBY0n0fgS3KZTlMuxgVMAeFwZSYFwGIihbLCrJXmyzJeeHj
         tKGUzpAYKorclvrLZ1PJLQege2A0W3tBuSc1M+IDkXjfRON2h5TTiQxDzJYTEW7cZ/++
         D9wYk8gcsVigDv2G9DLNVri/iTsjhZo6RaV2U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=JrXQj0GjPxXgciB9RB6dmrZ9bAXKseEclcirbTKVE6UjdwRHplJxro7MJeHvVwpnQa
         xGtWOpHjeqV4p26XGTAuI5HhiqKADLqnbsvMgSrTwewXOJsvUpFHeatK+5GXbDREPuX4
         Kiv1M5TgACw0Xt6jMhRykhNCDv2tDvPQo0Pu8=
Received: by 10.210.127.13 with SMTP id z13mr931978ebc.143.1216887344247;
        Thu, 24 Jul 2008 01:15:44 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.208.47])
        by mx.google.com with ESMTPS id y37sm12779299iky.8.2008.07.24.01.15.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 24 Jul 2008 01:15:43 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080723171745.GC5283@blimp.local>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89847>

On Wed, 23 Jul 2008, Alex Riesen wrote:
> Johannes Schindelin, Wed, Jul 23, 2008 11:53:27 +0200:
> > >
> > >    19. How do you publish/propagate your changes?
> > >        (zero or more: multiple choice)
> > >      - push, pull request, format-patch + email, bundle, other
> > 
> > git svn
> > 
> 
> a converter using fast-import/fast-export/plumbing
 
So it would be now:

   19. How do you publish/propagate your changes?
       (zero or more: multiple choice)
     - push, git-svn, foreign SCM (not via git-svn), pull request,
       format-patch + email, bundle, other(*)
     + (*)If the way you publish your changes is not on above list,
       please explain how do you publish your changes.

-- 
Jakub Narebski
Poland
