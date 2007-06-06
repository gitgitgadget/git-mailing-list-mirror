From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [ANNOUNCE] qgit new "smart browsing" feature
Date: Wed, 6 Jun 2007 09:30:47 +0100
Message-ID: <200706060930.49621.andyparkins@gmail.com>
References: <e5bfff550706031339v5ffda0a6u6f520f0c7b49f442@mail.gmail.com> <200706042004.01819.andyparkins@gmail.com> <e5bfff550706051148v57715bb1q88987e3fc6410899@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Marco Costalba" <mcostalba@gmail.com>,
	"Pavel Roskin" <proski@gnu.org>, "Jan Hudec" <bulb@ucw.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 06 10:31:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hvqv4-0002ds-3J
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 10:31:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751734AbXFFIbB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 04:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752558AbXFFIbB
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 04:31:01 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:32926 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751734AbXFFIbA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 04:31:00 -0400
Received: by ug-out-1314.google.com with SMTP id j3so392065ugf
        for <git@vger.kernel.org>; Wed, 06 Jun 2007 01:30:58 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=sgEICFNhdHz/niN9+ZOHdD8TWM3yl2+AGEaDjUUzNXxkwV7t7dk1Ukc3ilfnKBPb/eC7+Fs1gu3IWdAmzQRbPN1veP4MpPzgDZlo6pUfBDk2et0Dtzomwnzfxge5zzrHCF7YowWVh24memmuIg2XjqISDDgBscYCrkdSbErJhKQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=RJh1PL8cp6IcgWEPbY2Th46h/37g6byvO5bnIROPenfOiCZLoN9pfMfRLfr/R6rnCyu06rvrz7d0GtBruw1JdxqoMip6uut3IMuGqP1M/GA9LJDlevCWh35BUzRijj3xNMtz5VDB30nMyNdD3lGVTUf+6C/mXGKoAEA3ZZBCYfA=
Received: by 10.82.178.11 with SMTP id a11mr457819buf.1181118658475;
        Wed, 06 Jun 2007 01:30:58 -0700 (PDT)
Received: from dvr.360vision.com ( [194.70.53.227])
        by mx.google.com with ESMTP id z40sm5433183ikz.2007.06.06.01.30.56;
        Wed, 06 Jun 2007 01:30:57 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <e5bfff550706051148v57715bb1q88987e3fc6410899@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49267>

On Tuesday 2007 June 05, Marco Costalba wrote:

> I've just pushed a patch series that implements your tab widget idea.

I like it a lot.  I also like having the settings. I always appreciate 
software that lets me work how I like.

> Have fun and let me know!

I've experienced a few occasions when the wheel scroll goes a bit strange.  
I've not figured exactly what I did to trigger it, but it was something like 
this: when scrolling up and down a lot, and causing the page flip to the 
message view, suddenly the scroll didn't work for normal upward scrolling.  I 
flipped pages again and it started working.

I'll try and narrow down exactly what I'm doing and be more precise.

For now, latest qgit is in /usr/local/bin, so will be getting daily use.



Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
