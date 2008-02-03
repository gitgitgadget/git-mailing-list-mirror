From: "Alan Smith" <alanrogersmith@gmail.com>
Subject: Re: MKCOL fails, 403 error
Date: Sun, 3 Feb 2008 10:32:39 -0500
Message-ID: <eae1aef50802030732s7536dfacufd0aaf41974c85d6@mail.gmail.com>
References: <eae1aef50802030535u1402471fh182a230f3e0667ea@mail.gmail.com>
	 <eae1aef50802030539l14287c7exa914696755e7ade4@mail.gmail.com>
	 <20080203143101.GB7946@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, pasky@suse.cz
To: "Mike Hommey" <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sun Feb 03 16:33:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLgqF-0008Bf-SP
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 16:33:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758936AbYBCPcl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 10:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758139AbYBCPcl
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 10:32:41 -0500
Received: from rv-out-0910.google.com ([209.85.198.184]:28073 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924AbYBCPck (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 10:32:40 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1244192rvb.1
        for <git@vger.kernel.org>; Sun, 03 Feb 2008 07:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=zWjY/pCCFUxh3NBwAcXMRw4QhXxGb17MH+6FdrQpyRg=;
        b=SvVSkbpV8RJgDInoe374LXTR7n4Jri6dExccXebuZCEMiUGr9e8URcGdYVvvGydbMqByp6Nt+LHdvIfb5bBC3vSXfkIQvwsHIqs4suJt11TvhUtZpL8StGjmJwxpQypHJ2hnU1QxOBhbiZZHT4/agGPXJmJPGbIAaGq7No5ou9I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=vt8zx//ivUrvDyjkzBxNT1IaMmhPfsjT6cx9ZZdjwlMw4PF53FwPNPvYS2VTrvSYBaf4ubZbOMJ/cSFzwxdw60CwKnjmxgwMJl6Fk39KkqQ5DKirpH9sLmnl5IQMNkJO62g450eQIuGB4qwJrvEWxxFUGVjx5gxN7uY1KTZtnuo=
Received: by 10.140.179.25 with SMTP id b25mr3973801rvf.186.1202052759422;
        Sun, 03 Feb 2008 07:32:39 -0800 (PST)
Received: by 10.141.114.12 with HTTP; Sun, 3 Feb 2008 07:32:39 -0800 (PST)
In-Reply-To: <20080203143101.GB7946@glandium.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72362>

Mike,

I do have access to the log at /var/logs/apache2/error_log. What
should I be looking for?

Thanks, Alan

-- 
My blog: lifelover.blogetery.com
My old blog: cocoalatte.info

// Things I've said -------------------------
"Maturity resides in the mind."
"Silence is the Universe's greatest gift."
"When the World realizes that personal beliefs are not something to
argue or fight over, it shall evolve."
