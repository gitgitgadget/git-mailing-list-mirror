From: Alexander Litvinov <litvinov2004@gmail.com>
Subject: Re: git-svn does not seems to work with crlf convertion enabled.
Date: Thu, 24 Jul 2008 10:13:00 +0700
Organization: AcademSoft Ltd.
Message-ID: <200807241013.00862.litvinov2004@gmail.com>
References: <200807231544.23472.litvinov2004@gmail.com> <200807231852.10206.litvinov2004@gmail.com> <alpine.DEB.1.00.0807231356540.8986@racer>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 24 05:14:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLrHU-0005nu-6z
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 05:14:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751796AbYGXDNM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 23:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751772AbYGXDNM
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 23:13:12 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:27380 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751650AbYGXDNL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 23:13:11 -0400
Received: by ug-out-1314.google.com with SMTP id h2so559656ugf.16
        for <git@vger.kernel.org>; Wed, 23 Jul 2008 20:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=P2P7oEXKZf5St/5O86+fOApKoyeUDmoINIgPHK2znCA=;
        b=Pu3m2odXDcJGW0utBurQGeWjgSpbJgrnoQyyHwBuC14DmrxcRrnRNpg5jbZTR3RpZP
         Ixse5VI34afZbgpQdeE2iKto6GoMuS1IjB4d98VGU1owbcJ+QvxASL0QVze0ZkXxnWzB
         Ga6BRZ05EzRa1cN1YMrCFhvBeDPTEKk1rfml4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=pWWzzq5uXP4c/QmK3HVqb/Fhi6McTyGjI0g5iWSuAYcH0knaGt5YM1+YooSEPIx2W+
         lZNU8ko+j2jVHW8BwJ48JqxauatVj364fhsR4dPsJ2G/jnHldKXqeRtY4YCFF3DfYJJJ
         +UvBTxnIne6+u9moBFbIYsAST0nfOjrVa4kD8=
Received: by 10.67.98.15 with SMTP id a15mr355473ugm.15.1216869189418;
        Wed, 23 Jul 2008 20:13:09 -0700 (PDT)
Received: from lan.ac-sw.lcl ( [91.201.74.194])
        by mx.google.com with ESMTPS id o1sm3597642uge.2.2008.07.23.20.13.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 23 Jul 2008 20:13:08 -0700 (PDT)
User-Agent: KMail/1.9.5
In-Reply-To: <alpine.DEB.1.00.0807231356540.8986@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89830>

> Note that you will have to do your digging using msysGit (i.e. the
> developer's pack, not the installer for plain Git), since git-svn will be
> removed from the next official "Windows Git" release, due to lack of
> fixers.

You will not believe me. I use git under Linux, develop under windows on 
network drive :-)
