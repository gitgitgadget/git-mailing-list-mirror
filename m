From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Google Summer of Code 2007
Date: Wed, 28 Feb 2007 08:42:07 +0000
Message-ID: <200702280842.08279.andyparkins@gmail.com>
References: <20070225075917.GC1676@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 28 09:42:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMKO9-0001j5-NL
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 09:42:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752053AbXB1ImP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 03:42:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752056AbXB1ImP
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 03:42:15 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:11695 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752053AbXB1ImO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 03:42:14 -0500
Received: by nf-out-0910.google.com with SMTP id o25so484042nfa
        for <git@vger.kernel.org>; Wed, 28 Feb 2007 00:42:13 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=HWxc2kkcpdVEuShkp6UGZOxsIIT5NbTVuNpY/UZyeoSYIUoSQWnHocnmQvGuQphQ2r3Ll8O8LFVMCsgsH7VBgys6Gkp+tCqtujOioJfmMot0CYf/wX8gTKEB9ARJApHf/tDZHmKGbCG5ZuW91LZMemYWzw//BE6LZzmJuLdDab0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=S3u/zRsPMnMkH4Gxzk7RT2XwYGc8bIvaBAubHlb66w48TwfyP/aem1miTLb77mnbLAzufdqgoLtAgoaF5aDBP+7dH7thgjozTiNUspmlIwmTgsL4giCTI9l/1T0X3dBZNoCMpmeQ8DBNqsHLUo3isGssFP0aGAdILdNhXciqcaI=
Received: by 10.49.54.3 with SMTP id g3mr3166660nfk.1172652133018;
        Wed, 28 Feb 2007 00:42:13 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id p72sm5033386nfc.2007.02.28.00.42.10;
        Wed, 28 Feb 2007 00:42:10 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <20070225075917.GC1676@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40904>

On Sunday 2007 February 25 07:59, Shawn O. Pearce wrote:

> Thoughts?

What about the oft-asked for windows port?  From what I've seen, none of the 
Unix types have any incentive to do this, so a financial incentive might be 
just the thing.

Perhaps the windows port is already far enough along that this wouldn't be a 
big job.  In which case the project could be windows shell integration (or 
whatever other candy-based device a windows user would need to easily use 
git).

Project title: "Make it so that one .exe click-and-install would make the full 
power of git available in an idiot^H^H^H^H^H typical-GUI-using-developer 
friendly form"

Given that the best thing for git in the long term is more users, and that no 
windows support is the commonly given reason why other SCMs are chosen 
instead, this would be a good use of the resources.

I'm off to shower, I feel dirty even talking about Windows :-)


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
