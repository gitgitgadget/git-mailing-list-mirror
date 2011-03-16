From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/8] vcs-svn: remove spurious semicolons
Date: Wed, 16 Mar 2011 15:03:42 -0500
Message-ID: <20110316200341.GA8685@elie>
References: <20110316024959.GA24932@elie>
 <20110316065256.GA5988@elie>
 <20110316070242.GE5988@elie>
 <7v4o72979u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 16 21:03:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pzwwn-0007SO-Vn
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 21:03:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753739Ab1CPUDw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 16:03:52 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:42858 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753611Ab1CPUDu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 16:03:50 -0400
Received: by gyf1 with SMTP id 1so814708gyf.19
        for <git@vger.kernel.org>; Wed, 16 Mar 2011 13:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=25x+6R3CDmDo3hA5L3HYMnx6vlrvhA96QgGd4Cp2jV4=;
        b=s27S1F0pQI4gMgImM4rNIfEBFY/FODTcQpslr7H63r5n8043NtgFipAv6sBhZipmTh
         HG1SuGFHxthDjmVGAYwxNkCuzlqH/zQAGzCZmQMuVcFcJHCv7iJVQ/ZPSCXf1irkHSU0
         bJO3fhWvhMdYrcA8oI1BSbaGsH+6WfXqoSh1E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=uMwyezvLLamcbRRpIPJbB0oZrIGXGCCuPvooxDdlC+bVXIN6swVexm74AWS4Fi91pu
         nfaBOMWx3/T4aQLV3XDcA4IQG6OOFwa0zXnIN3DBBqji6vG+H7fsXsc3UQPsgYjt2Six
         NkF5MxQWekBJ/MwAA/Tr+m/Tk+YeqdBhzDUd4=
Received: by 10.151.118.3 with SMTP id v3mr481316ybm.391.1300305829754;
        Wed, 16 Mar 2011 13:03:49 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.ameritech.net [69.209.56.53])
        by mx.google.com with ESMTPS id q13sm3745829yba.8.2011.03.16.13.03.46
        (version=SSLv3 cipher=OTHER);
        Wed, 16 Mar 2011 13:03:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v4o72979u.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169186>

Junio C Hamano wrote:

> Yuck.  Correct but ugly.

Yes, might be better for me to just hurry and apply David's patches to
get rid of the treap. :)
