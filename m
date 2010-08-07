From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH svnrdump-standalone] Sync with upstream
Date: Sat, 7 Aug 2010 08:21:25 +0530
Message-ID: <20100807025123.GC15410@kytes>
References: <1279064176-6645-1-git-send-email-artagnon@gmail.com>
 <7vsk3myuyo.fsf@alter.siamese.dyndns.org>
 <20100715105527.GC22574@debian>
 <20100806175709.GA2683@burratino>
 <20100807023026.GA3111@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 07 04:52:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhZWm-0003OO-UX
	for gcvg-git-2@lo.gmane.org; Sat, 07 Aug 2010 04:52:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762487Ab0HGCws (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Aug 2010 22:52:48 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:37387 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762469Ab0HGCwr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Aug 2010 22:52:47 -0400
Received: by pxi14 with SMTP id 14so3120303pxi.19
        for <git@vger.kernel.org>; Fri, 06 Aug 2010 19:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=EgTlSbD0Ps+byUuxvRPpoTGoaSI6SsmE/L4z4Jey15I=;
        b=eo2rHB2KWogQdqS4ds8nO6A56Orm5EEeNYBEVZJ8J5WGuc4PxHXSbuWAdN5GXqcsF3
         mRCbYco8CZaEOb4e4Dpxj3/7g8QX4KVMh79MjYQBZ+Ud/HuiHFuYUmZMaWH5Z672NXi2
         p6lEqAQ1lIG9W8wwTqRqLP/nDjn6VRDj+F1kM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Vs3Xy0sO9iuU0Uwa7w1uknSMNoIeb0CcpnuM+PwXbZO13U40POTRPNVUJyP+HHY0d+
         KJqV1Cr7XNMpw78v2vBXJxxT65gD7mjkW+XaHWnnALkLCqqKlDpoJTczE5ThKE6Vd9KJ
         iJTLPcua/KSJIrGyuWGhF9lT+M4YUwJnB1iyI=
Received: by 10.143.39.12 with SMTP id r12mr4317897wfj.173.1281149566510;
        Fri, 06 Aug 2010 19:52:46 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id 23sm2291108wfa.22.2010.08.06.19.52.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Aug 2010 19:52:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100807023026.GA3111@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152837>

Hi Jonathan,

Jonathan Nieder writes:
> for the tree.  The todo branch documents how to revive the
> git-svn branches.

Thanks especially for taking the effort to import the history from SVN
and write a nice NOTES file :)

-- Ram
