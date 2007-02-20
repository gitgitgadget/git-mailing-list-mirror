From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: Unresolved issues
Date: Tue, 20 Feb 2007 08:57:00 +0000
Message-ID: <200702200857.02779.andyparkins@gmail.com>
References: <7virdx1e58.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 20 09:57:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJQoD-0007mR-7v
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 09:57:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932700AbXBTI5K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Feb 2007 03:57:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932705AbXBTI5J
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 03:57:09 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:28199 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932700AbXBTI5I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Feb 2007 03:57:08 -0500
Received: by nf-out-0910.google.com with SMTP id o25so2679363nfa
        for <git@vger.kernel.org>; Tue, 20 Feb 2007 00:57:06 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=fHGxIrtVLyfEZvvqW6rjpRwMnHHdVTJm+FRuSkOp3mKR2TqIIIeO+JdmS7E5x+i2A/56nGX36R9ExV2TDd66uCU556J3zrEYujZyMdtW/pk2FOJNyQkYnF19eftC0fYm4LACTFAKOrDfGRPljn8ufibHoxKKMYV1cmt4oxO1SDs=
Received: by 10.49.107.8 with SMTP id j8mr6601462nfm.1171961826911;
        Tue, 20 Feb 2007 00:57:06 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id o53sm29877949nfa.2007.02.20.00.57.04;
        Tue, 20 Feb 2007 00:57:04 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <7virdx1e58.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40213>

On Tuesday 2007 February 20 07:28, Junio C Hamano wrote:

> * Use update-ref in cvsserver.
>
>   It currently does it by hand, which is racy and does not leave traces
>   in reflog.
>
> 	$gmane/39541

I've got a patch for this - I thought I'd sent it and it left my mind - I'll 
send when I get home.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIEE
andyparkins@gmail.com
