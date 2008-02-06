From: "Stephen Sinclair" <radarsat1@gmail.com>
Subject: Re: command prompt script for current branch
Date: Wed, 6 Feb 2008 17:13:12 -0500
Message-ID: <9b3e2dc20802061413v5dbe349axe43a4af263e39878@mail.gmail.com>
References: <9b3e2dc20802061152q63bc61acuaecf3f33d4df8b19@mail.gmail.com>
	 <m3r6fp4wrt.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 23:13:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMsWb-0000yd-22
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 23:13:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756757AbYBFWNQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 17:13:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756475AbYBFWNQ
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 17:13:16 -0500
Received: from rv-out-0910.google.com ([209.85.198.184]:52943 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752991AbYBFWNP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 17:13:15 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2041116rvb.1
        for <git@vger.kernel.org>; Wed, 06 Feb 2008 14:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=OACDGjvGN7xs3D+++QOBqJmbeIqF3U8VPIxd3A2dYvg=;
        b=uWADFLAJMSnCBDq9o//J7U7HKOeKKaxhMpWEbpSiFfgdq0jXfquWWN+VQN0/hO9rb/+85NqDjS2JV9Oq5yMKBOVKEGgmfMAs/iH+BLosXIHUqdhpr4QJkDsEgJL79/J4P2k+3mLVgGjdQ+RGQABvNU+c54Wgs4Ot4FKCI5ozO+s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QrHMskXMKeC+o261X6zcHbOdoyRTX3tNlZHF+tUZw1HgIowXwDvtJBq9JMG/iHmkQwPmtyiNHv87m8ZafmKt1yozNVK3qGHevByJklL8UDq7QMRzJ7KI2hpvd8djmuiITXTEDuqsxpWTLEOz91muaXqX0rNlLDrsBE5F14MSNCI=
Received: by 10.141.50.17 with SMTP id c17mr3088394rvk.295.1202335992835;
        Wed, 06 Feb 2008 14:13:12 -0800 (PST)
Received: by 10.140.173.7 with HTTP; Wed, 6 Feb 2008 14:13:12 -0800 (PST)
In-Reply-To: <m3r6fp4wrt.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72860>

> > Attached is a script I quickly wrote up yesterday.  Sometimes I've
> > found I started working only to realize I was on the wrong branch.
> > (Now that I'm accustomed to working with git, I make many small
> > branches, so it happens.)
>
> First, it is much better to put such script inline, in the body of
> your email.  This makes commenting about script body much easier.
> And if you have to attach it, for example because your mailer mangles
> whitespace (which is not the case here), make sure that attachement
> uses "text/plain", and if possible "inline" disposition, to better
> _view_ the code without need to save it to temporary file.
>
> I would take an exeption and comment on your code, even though you
> make it hard to do so.

Thank you.  Since there's already a solution for this in contrib,
(didn't see it, sorry), I'll just take your recommendations on coding
style for any future stuff I do.


Steve
