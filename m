From: Matthew L Foster <mfoster167@yahoo.com>
Subject: Re: git and time
Date: Wed, 27 Sep 2006 11:01:47 -0700 (PDT)
Message-ID: <20060927180147.33024.qmail@web51009.mail.yahoo.com>
References: <451A8AD9.2010107@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 27 20:02:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSdjJ-0007uW-EP
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 20:01:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030517AbWI0SBv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 14:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030518AbWI0SBu
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 14:01:50 -0400
Received: from web51009.mail.yahoo.com ([206.190.39.128]:47512 "HELO
	web51009.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1030517AbWI0SBt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 14:01:49 -0400
Received: (qmail 33026 invoked by uid 60001); 27 Sep 2006 18:01:47 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Q0PeCjBRryCHkH3xpDU7iV9pyekAmBZ3HqnNXzmuypnHKT/fUOGizhqLWDXqtLgSAPagaHos8QKDOuHKB+ySitMOtlx2wi3u4XDBIFycXZmnU2LIdMjRZ3Se6GyPJHS70R1bvdKGOil+ClwocTq6nsKocwA1003rzDfD3L++H00=  ;
Received: from [207.172.80.85] by web51009.mail.yahoo.com via HTTP; Wed, 27 Sep 2006 11:01:47 PDT
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <451A8AD9.2010107@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27917>

> Because git doesn't care about timestamps. It stores them as comments 
> (albeit auto-formatted comments) and relies on the dependency chain to 
> provide history.

Ok, the word "history" in the context of git primarily means the order of changes not the when?
Would it be a conceptual or technical issue for git to directly track the local time of
merges/changesets?

-Matt

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
