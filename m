From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Some ideas for StGIT
Date: Fri, 3 Aug 2007 19:14:01 +0100
Message-ID: <200708031914.04344.andyparkins@gmail.com>
References: <1186163410.26110.55.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Pavel Roskin <proski@gnu.org>,
	Catalin Marinas <catalin.marinas@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 03 20:14:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IH1fN-0000jj-4f
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 20:14:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751610AbXHCSOU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 14:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbXHCSOU
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 14:14:20 -0400
Received: from fk-out-0910.google.com ([209.85.128.187]:8366 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419AbXHCSOT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 14:14:19 -0400
Received: by fk-out-0910.google.com with SMTP id z23so747362fkz
        for <git@vger.kernel.org>; Fri, 03 Aug 2007 11:14:18 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=G+GFWXiD8xbdUud/h5hOEzc7e0/vU8fp7csGib1qwdln7a1akr1w1ywqMFcNvnQt59vAGGiPJZ3pbrTZSRKjSQ8Q/p3SRM71+IxsAIrk+Ho3HeQxRb3NlaDuJW1pvyB5DgssG91O5+181dwn5WWeoh8V206FIvElvhFsyzx79jo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=cpz/Duw2B+jOm2TbYhZJ1//KWn4v6rI/fPbVM1KtcxXGoj2lnfCbEEyma+0NdWgrB67Id4fZZZ96rjd4+8ZhixfRCRU+sQEauPc7ewJFEZO/D/5QlmQsR734ZJ6zuDkfnlXK0ad25o1WhGSPMDZlEQI054nLFefmHsgesqR3ZWM=
Received: by 10.82.112.16 with SMTP id k16mr4203510buc.1186164857979;
        Fri, 03 Aug 2007 11:14:17 -0700 (PDT)
Received: from grissom.local ( [84.201.153.164])
        by mx.google.com with ESMTPS id d24sm17112136nfh.2007.08.03.11.14.14
        (version=SSLv3 cipher=OTHER);
        Fri, 03 Aug 2007 11:14:17 -0700 (PDT)
User-Agent: KMail/1.9.7
In-Reply-To: <1186163410.26110.55.camel@dv>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54738>

On Friday 2007, August 03, Pavel Roskin wrote:

> I don't suggest that StGIT gives up on the git-based storage, but this
> mode of operation could be implemented in two ways.

git's shiny new git rebase -i has removed, for me, those times when I needed 
stgit.  Perhaps those who've move from git to quilt would try again when 
1.5.3 is out with the magic that is "rebase -i".


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
