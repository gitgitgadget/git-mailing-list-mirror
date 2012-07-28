From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Make git-svn Use accessors for paths and urls
Date: Sat, 28 Jul 2012 02:54:22 -0500
Message-ID: <20120728075422.GA8835@burratino>
References: <1343419252-9447-1-git-send-email-schwern@pobox.com>
 <20120728030959.GA3020@burratino>
 <50139755.7020105@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, robbat2@gentoo.org,
	bwalton@artsci.utoronto.ca, normalperson@yhbt.net
To: Michael G Schwern <schwern@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 28 09:54:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sv1rA-0001Pz-8J
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 09:54:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751917Ab2G1Hyb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jul 2012 03:54:31 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:39523 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751540Ab2G1Hya (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jul 2012 03:54:30 -0400
Received: by obbuo13 with SMTP id uo13so5519352obb.19
        for <git@vger.kernel.org>; Sat, 28 Jul 2012 00:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=ftEnhSAA/lx5Cv1SWkvp2Ba9N6OL32LLrwVEq+Yndto=;
        b=AxVmBmQ/Hs4juKEwnpWc1K2kagjBM2OEFEFtHuJvliZpbDcn11qnAACNSe67146uu/
         QD3vxSXM4WxfrHuH5ui8KxaZ7AIsmyGyyFG7mi3yPIWCXFTVcSiwDvhjiPet0FUilLhl
         brRZ2ybgtekQj2HKYfUEAnrlErXQ7FCbdyYi/Quk0QwM6rtN1nBJzLDpIGiFF0bZoAQe
         3vrfrHX4SEsb3xEnz+wLRCXOfQqsfu87g/vpBjBrSvHBhLRPdRNAps4cNuvVsHXDBwoe
         nhMG+jy16OaetMu91YK9LFyc1nwHaz3zJFf7WGGQU7hKOF7S+P6MNLgZnYz2Ve7QMXtl
         z8DA==
Received: by 10.50.196.195 with SMTP id io3mr3946076igc.39.1343462069843;
        Sat, 28 Jul 2012 00:54:29 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id g5sm1235769ign.4.2012.07.28.00.54.28
        (version=SSLv3 cipher=OTHER);
        Sat, 28 Jul 2012 00:54:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <50139755.7020105@pobox.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202410>

Michael G Schwern wrote:
> On 2012.7.27 8:10 PM, Jonathan Nieder wrote:

>> If you have a chance at some point to offer advice, I'd love to add
>> the information to Documentation/SubmittingPatches that was missing.
[...]
> Remind me when I'm done with the 1.7 fix please?

Sure, if I remember to. :)

Thanks,
Jonathan
