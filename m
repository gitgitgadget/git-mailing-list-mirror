From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/10] rr/svn-export reroll
Date: Tue, 10 Aug 2010 20:53:03 -0500
Message-ID: <20100811015303.GB4169@burratino>
References: <1279210984-31604-1-git-send-email-artagnon@gmail.com>
 <20100716101352.GA14374@burratino>
 <20100809215719.GA4203@burratino>
 <20100810125317.GB3921@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 11 03:54:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oj0Wg-0004JN-W2
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 03:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757673Ab0HKByj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Aug 2010 21:54:39 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:40420 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753282Ab0HKByh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Aug 2010 21:54:37 -0400
Received: by qwh6 with SMTP id 6so8876769qwh.19
        for <git@vger.kernel.org>; Tue, 10 Aug 2010 18:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=wfKynse1Cr0tCqisQQoM2ihUtWMVQy1sR7nC0tAFIbU=;
        b=Txg45eBZJ368NV0LFWbmPpEADbYf8d3yqTk9CkIBN9g04z76V2qh2Ujri9IrCHZuzr
         A8LT0CWS3tGI4uqgYl0IZki14Shryr8WqqSZeIcZ7PnbRLbP1wbvakuAZxWf7Z/tvPgj
         LX+KWPbVrGSVhyCsvKZEfcSfTLIOy9wWJQgQU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=sQ7eyQw3deufAeTJNMV2uT4WVUb8+dzw3g05HBgfBSsrVd4xVgn/vBkIni9Ab96rrt
         gGlODieC2i3DWobCXvMW0uxaMj7ILEkKWYLNERX4G7b0NuvLl49F6AksKuZF3k6mu8Dj
         TgVYXmRk5+Jugl6nT0YdG0ZT91UHqFe2tOvEU=
Received: by 10.220.49.28 with SMTP id t28mr11035298vcf.93.1281491676680;
        Tue, 10 Aug 2010 18:54:36 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id s29sm1741486vcr.23.2010.08.10.18.54.35
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 10 Aug 2010 18:54:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100810125317.GB3921@kytes>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153184>

Ramkumar Ramachandra wrote:

>                                                             I'd
> expected some incremental patches instead of a full re-roll, but
> whatever works is good :)

Yeah, I think after this series the topic has stabilized enough
to build on. :)

> All these are good :)

Thanks for checking.
