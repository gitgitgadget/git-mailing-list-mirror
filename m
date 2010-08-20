From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git commands
Date: Fri, 20 Aug 2010 02:51:11 -0500
Message-ID: <20100820075111.GC24678@burratino>
References: <1282288658094-5443370.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Joshua Juran <jjuran@gmail.com>
To: sandy2010 <sandeeptt@yahoo.com>
X-From: git-owner@vger.kernel.org Fri Aug 20 09:53:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmMPK-0006az-48
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 09:52:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751210Ab0HTHwx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 03:52:53 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:58300 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905Ab0HTHww (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Aug 2010 03:52:52 -0400
Received: by iwn5 with SMTP id 5so541120iwn.19
        for <git@vger.kernel.org>; Fri, 20 Aug 2010 00:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=hD+dnBXGqWiR3bhcgzCCivXY1Cg7y1KNzGWBt/qd//k=;
        b=xFRyHI/xlAQGyzh5geXFQl40RZk37jhxCcqjonkSbGiW1XCxupRxhZ0XTfY5JlDJvm
         0Y7agSq65SvJ/zP0/5qoOjmEX/VU/+lMjej/wvZdmUPY5dMmPO2PnY/dQKtu8Hsg6FTm
         ayiqBCGDpnCxv2JuZm4lDlMwrq9Rg4pcdIFew=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ppPPO90w+uFhFNUMNur7XFa1Cimq0wosSDqHkCrYkR1NaU/+WNtXdzJ82nSZR/hWJA
         SfppeSLIC+bdHNvdJPosHFq5Ww/6SxGKixS8mZOR7LKZlY8BYPCEeKed0OUkxE5nCXS5
         cATB0LtQEvbWM/zXMn7aJG6ADVq+TW+NvWGWk=
Received: by 10.231.10.132 with SMTP id p4mr1262378ibp.67.1282290771772;
        Fri, 20 Aug 2010 00:52:51 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id j2sm2352878iba.18.2010.08.20.00.52.51
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 20 Aug 2010 00:52:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1282288658094-5443370.post@n2.nabble.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153982>

sandy2010 wrote:

> I'm new to git and I wonder what is the difference between two commands:
> 
> "git clone" and "git-clone" and which one should be use?

By the way, when documentation points to the latter (and is not
pointing to some man page like git-clone(1)), please feel free to let
us know, preferrably with a patch. :)  There is a history that might
have left some of the documentation inconsistent.

Regards,
Jonathan
