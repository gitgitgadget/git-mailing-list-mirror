From: "Steven Walter" <stevenrwalter@gmail.com>
Subject: Re: [ANNOUNCE] yap: Yet Another (Git) Porcelain
Date: Sat, 6 Sep 2008 14:33:21 -0400
Message-ID: <e06498070809061133p2e3a206fmfd47961645b15ff@mail.gmail.com>
References: <20080906150723.GA31540@dervierte>
	 <20080906173925.GA4044@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Sep 06 20:34:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kc2cB-0002ME-3R
	for gcvg-git-2@gmane.org; Sat, 06 Sep 2008 20:34:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752579AbYIFSdX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2008 14:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752566AbYIFSdX
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Sep 2008 14:33:23 -0400
Received: from wr-out-0506.google.com ([64.233.184.231]:50092 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752492AbYIFSdW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Sep 2008 14:33:22 -0400
Received: by wr-out-0506.google.com with SMTP id 69so939215wri.5
        for <git@vger.kernel.org>; Sat, 06 Sep 2008 11:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=0don0zac9ehly4nxVq64aZ8UC6RYmOwN/OKTFDD+Nec=;
        b=bY+/K3C+p+YMw08TYEEi7Vbm0KOna/ImrRliXLBrQSUXsFJzhHRwPkpFpm/ccFCZsr
         FDs36mTo80ddXRDpUMNQsTKH9yXl4Bw3Z5YsLJXKEDT6/hFImgjTwVTdKe1TIyJsjZQg
         64Dpczo87j2Tj2WL7aG+gznFUtattnQoFVoEc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=lROiUe81BhhZBIQtl+HOmmppRJgHOHUKTkviYTGd/v1/dT48jjRZmSxqUB7Nt7zDUw
         B6eLGISSvjmoZ7375Rf+dLOz+nE9UYD8Nf+bGfEhrLQQO8giMaw8yxTj2C2E6BmncZbs
         1h1HrtfoNou+5f7Dsy9gyfcP66mDjPOKegJyQ=
Received: by 10.90.90.4 with SMTP id n4mr4849548agb.43.1220726001111;
        Sat, 06 Sep 2008 11:33:21 -0700 (PDT)
Received: by 10.90.25.17 with HTTP; Sat, 6 Sep 2008 11:33:21 -0700 (PDT)
In-Reply-To: <20080906173925.GA4044@coredump.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95090>

On Sat, Sep 6, 2008 at 1:39 PM, Jeff King <peff@peff.net> wrote:
> On Sat, Sep 06, 2008 at 11:07:23AM -0400, Steven Walter wrote:
>> After starting yap several weeks ago, I feel it has reached a level of
>> maturity that makes it suitable for public consumption.  yap is three
>
> Link?

Heh, that would help.

http://repo.or.cz/w/yap.git
-- 
-Steven Walter <stevenrwalter@gmail.com>
"A human being should be able to change a diaper, plan an invasion,
butcher a hog, conn a ship, design a building, write a sonnet, balance
accounts, build a wall, set a bone, comfort the dying, take orders,
give orders, cooperate, act alone, solve equations, analyze a new
problem, pitch manure, program a computer, cook a tasty meal, fight
efficiently, die gallantly. Specialization is for insects."
 -Robert Heinlein
