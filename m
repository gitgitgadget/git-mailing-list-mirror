From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git User's Survey 2008 partial summary
Date: Wed, 3 Sep 2008 18:00:26 +0200
Message-ID: <200809031800.27739.jnareb@gmail.com>
References: <200809031607.19722.jnareb@gmail.com> <d411cc4a0809030841n7defd31frbbab2a1b7ab824d7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Miguel Arroz <arroz@survs.com>
To: "Scott Chacon" <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 03 18:04:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kauns-00048V-J1
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 18:01:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077AbYICQAc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 12:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbYICQAc
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 12:00:32 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:28386 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752000AbYICQAb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 12:00:31 -0400
Received: by fg-out-1718.google.com with SMTP id 19so187189fgg.17
        for <git@vger.kernel.org>; Wed, 03 Sep 2008 09:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=/mnc7ANOrbsm6TH7niylUPwZK17jd+nnHNlmevhT5FY=;
        b=VNiQc8AXl9TOSPCR/YI2LsPRs0OIcHKBcDkAu1J/TPgs1TUUaORhtPzT0a470sWwcY
         i4bcvkjgLc8CuDodzs5XkKSDq7iEcx9FfwMCjKskvGwTuQEb19DHx+ovNezUC5p7c+Fj
         /a9LSK6alOZSQRC147fWLusPPyuc8WPKd6leM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=dcn2znGdatW+/2jGXIYz9wOpHKRvtfavDGwp5pIfr/kwcv5AHLVpyIQ9lGA84QKtp5
         9HlghkA76p9v7FqGu9+3Trh0xaPffyB3exk/HhW7bKI4kz2G31/NKv7F2GUIhWPnD0G4
         U9GKza+0OYnqMYchahUwsM6FxlTRz+v9xHFYw=
Received: by 10.86.27.19 with SMTP id a19mr6788611fga.37.1220457629923;
        Wed, 03 Sep 2008 09:00:29 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.253.191])
        by mx.google.com with ESMTPS id 4sm10030933fge.8.2008.09.03.09.00.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Sep 2008 09:00:28 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <d411cc4a0809030841n7defd31frbbab2a1b7ab824d7@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94808>

On Wed, 3 September 2008, Scott Chacon wrote:
> On Wed, Sep 3, 2008 at 7:07 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> >
> > This is partial summary of Git User's Survey 2008 after more that 1000
> > (yes, that is more than _thousands_ responses) just after the 3 days
> > of running the survey.  It is based on "Analysis" page for this survey:
> >  http://www.survs.com/shareResults?survey=M3PIVU72&rndm=OKJQ45LAG8
> 
> Is there a way to download the raw data?  There may be some
> interesting correlations between answers in different fields I would
> like to look for in the data, but it's too aggregated here.  I heard
> it would be available at the end, but can I get it from somewhere now
> as well?

I, as survey administrator, can export survey data to CSV or Excel
formats, but currently I cannot export URL to such data.  So you can
either ask me to send you such data[*1*] (CSV for around 700 individual
responses weights 1.7MB, and 272KB after gzipping), or sign in
to Survs.com (which might, or might not, require invite) and ask me
to add to "git" role/account/group.

On the other hand you can use different filters (again, I think only
survey administrator can do this, or whatever role is it) to limit
summarized replies, for example show summary only for users which
use Git on MS Windows (answered "What operating system..." question,
and the answer was "MS Windows (Cygwin)" or "MS Windows (msysGit)".

I can also enable individual responses in shared view (above link),
so you can see reply by reply; but I don't think this is particularly
useful, especially with 1000+ responses (21 in 'testing' channel).


[*1*] I will not send this to git mailing list...
-- 
Jakub Narebski
Poland
