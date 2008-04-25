From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Welcome to Git's GSoC 2008!
Date: Fri, 25 Apr 2008 09:46:19 -0700 (PDT)
Message-ID: <m3d4odq3w1.fsf@localhost.localdomain>
References: <20080422013201.GA4828@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Apr 25 18:47:26 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JpR4l-0000yS-NI
	for gcvg-git-2@gmane.org; Fri, 25 Apr 2008 18:47:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764059AbYDYQqY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Apr 2008 12:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763977AbYDYQqY
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Apr 2008 12:46:24 -0400
Received: from fk-out-0910.google.com ([209.85.128.184]:52041 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761195AbYDYQqW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Apr 2008 12:46:22 -0400
Received: by fk-out-0910.google.com with SMTP id 19so5017357fkr.5
        for <git@vger.kernel.org>; Fri, 25 Apr 2008 09:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=3HKc+0dt1LV3xvSTsbV6ODpjK7F0XTEDOTQiRXrqykY=;
        b=bRdNzKjiNNVMvAcAGty8VkcH2UWAcHG+xEj+J4JDJaot9/HOClvw8mf/G81wpNXejPW81J4MMi4KXoOBvePplQCRJFs/WbTAfa0sGYPc2bnlgnCZUVzpJ4sSWkcsoB1An6s9ezp53gtf9PaCwJ15fTg+2MfnHe/6jpiD4/rPK4Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=M2hvlJ4OBO05XD+WoBHNp7+1gsaGJtmRYxM8VLXbsVe9GkWeMduwfGrIwbl/j28DcklUVxgIP4D2aO3b/0dCR33wxb+mVXWK3leMIhIKBzy8PiiiUnf6tHYJTGepEuZP+1XFaQqrGyxgdCNt2jOAr/D7CfSmZrDQyqhk1trp40M=
Received: by 10.82.147.6 with SMTP id u6mr3084704bud.30.1209141980483;
        Fri, 25 Apr 2008 09:46:20 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.255.239])
        by mx.google.com with ESMTPS id d25sm3106570nfh.33.2008.04.25.09.46.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 25 Apr 2008 09:46:19 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m3PGkHGB025594;
	Fri, 25 Apr 2008 18:46:17 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m3PGk6v4025590;
	Fri, 25 Apr 2008 18:46:06 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080422013201.GA4828@spearce.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80340>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> This year Git was fortunate enough to receive funding for 6 students,
> and we are looking forward to the successful completion of the
> following interesting projects:

>   GitTorrent
>   git-statistics
>   Gitweb caching
>   Eclipse plugin push support
>   git-merge builtin
>   git-sequencer

I have found three another Git-related Google Summer of Code 2008
projects by other organizations:

    Git plugin for Anjuta IDE  (GNOME)
    KDevelop DVCS support      (KDE)
    Git# implementation        (Mono Project)

Info from Shawn message, and above info can be found on git wiki at
http://git.or.cz/gitwiki/SoC2008Projects

-- 
Jakub Narebski
Poland
ShadeHawk on #git
