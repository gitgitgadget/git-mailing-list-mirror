From: bill lam <cbill.lam@gmail.com>
Subject: Re: rebase hint unmerged file removed
Date: Tue, 25 Aug 2009 12:42:34 +0800
Message-ID: <20090825044234.GA391@debian.b2j>
References: <20090824140549.GA3973@debian.b2j>
 <20090824143657.GA12809@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 25 06:43:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfnsO-0003a2-UR
	for gcvg-git-2@lo.gmane.org; Tue, 25 Aug 2009 06:43:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754342AbZHYEmj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2009 00:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754100AbZHYEmj
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Aug 2009 00:42:39 -0400
Received: from mail-pz0-f194.google.com ([209.85.222.194]:52589 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754212AbZHYEmi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2009 00:42:38 -0400
Received: by pzk32 with SMTP id 32so1320354pzk.33
        for <git@vger.kernel.org>; Mon, 24 Aug 2009 21:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mail-followup-to:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=YXur8IXm31gnzxb3aEm+2iAtXHYHlH9cy4f9Mr7jHm8=;
        b=d77kxLN8cdwu9k5GCaIPP7A/lweLMVGpgAVTu5Fc9xyxGcl6cAj3T+047yRmEB5tBi
         oWHggYlP0kU1OhLVKxfN9hGoGuEHIwkbDCzag4fg3BBS75m98J/n96dBOIIGWk5+4t3M
         INGYBaiBGRvtMBA3eoNCpyO1myforDSREgBAo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=s8NnFjH7RJtcUNJ9eks88WqeYB8SO8Dj3uyi7lZf1AM4EMLn5uINYAK2goa52MCqGc
         lPErugkh7Y5MIK8OUigwYQA5wW3EuLTZbJEVBm5evZlpHsg4XszuLuMbVToYcv5ZkCg8
         8ik9WMk6YoVg6fB15TAc9sxLSYojZknlwQB+E=
Received: by 10.115.51.16 with SMTP id d16mr8407199wak.165.1251175360246;
        Mon, 24 Aug 2009 21:42:40 -0700 (PDT)
Received: from localhost (n218103237119.netvigator.com [218.103.237.119])
        by mx.google.com with ESMTPS id j28sm1070320waf.30.2009.08.24.21.42.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 24 Aug 2009 21:42:39 -0700 (PDT)
Mail-Followup-To: git <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20090824143657.GA12809@coredump.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126997>

On Mon, 24 Aug 2009, Jeff King wrote:
> The version of "git status" in next (and presumably what will be in
> v1.6.5) shows unmerged paths with more information. In this case,

Thanks, Jeff, Johannes,

I'll wait to see.

-- 
regards,
====================================================
GPG key 1024D/4434BAB3 2008-08-24
gpg --keyserver subkeys.pgp.net --recv-keys 4434BAB3
