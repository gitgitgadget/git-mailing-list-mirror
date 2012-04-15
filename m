From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Explain how svn-fe parses filenames in SVN dumps
Date: Sun, 15 Apr 2012 00:08:51 -0500
Message-ID: <20120415050851.GA2544@burratino>
References: <4F89ADCD.6000109@pileofstuff.org>
 <20120414171431.GA4161@burratino>
 <4F89B5C5.3030606@pileofstuff.org>
 <20120414181823.GB4560@burratino>
 <4F89F27B.5050706@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	David Barr <davidbarr@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Andrew Sayers <andrew-git@pileofstuff.org>
X-From: git-owner@vger.kernel.org Sun Apr 15 07:09:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJHic-0004Z4-2Q
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 07:09:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751050Ab2DOFJF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Apr 2012 01:09:05 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33322 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750746Ab2DOFJE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2012 01:09:04 -0400
Received: by iagz16 with SMTP id z16so5993338iag.19
        for <git@vger.kernel.org>; Sat, 14 Apr 2012 22:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=nEQo92pZZ/CP8VsoUdNDtFtlhpTs10QAva2rYWj3jn4=;
        b=ywt3gB6kSvSsN9pUEcMJPmuVNJfi0wbjSKikx5WwVsCrJHuJjTEAD/OxEtMKugxBXr
         xtd6e9wGzC2z8vCNNDX1u51n5g9NLy9vmTcn+XMvpTPZo+yqGbtZjLRFj5YMcDZoC9Nx
         zKNIhccxdVJSvGpBKCuyobVkARGvYLJxb06xAqPuQ/RA/7ZDJctRKWvkrkU9l9R2RG0j
         GYvvC9E7UqxmmAwsR6iEOaksgkLqkVIJthU8YDUjfSJpJkyxSTLkNoO96thL0lpa79+J
         Epo3EYbvvKqwd5C5UuES5G7To86KmxHkAOF+THVDZKz5H9KrNawYumpBlbpFDzA1ISzr
         S13w==
Received: by 10.42.138.9 with SMTP id a9mr4295062icu.14.1334466543297;
        Sat, 14 Apr 2012 22:09:03 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id nq4sm12313835igc.5.2012.04.14.22.09.01
        (version=SSLv3 cipher=OTHER);
        Sat, 14 Apr 2012 22:09:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4F89F27B.5050706@pileofstuff.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195546>

Andrew Sayers wrote:

>                            I'm afraid my patch etiquette fails me here
> though - is it better for me to roll your text into a new patch, or let
> you do that and submit my text separately?

If the example I sent looks good, please feel free to morph it into a
new patch.  Thanks again for your work, and glad I could help in some
small way.

Ciao,
Jonathan
