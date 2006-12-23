From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: What's cooking in git.git (topics)
Date: Sat, 23 Dec 2006 16:38:45 +0000
Message-ID: <200612231638.50045.andyparkins@gmail.com>
References: <7vzm9g2rv5.fsf@assigned-by-dhcp.cox.net> <7vlkkzv6rq.fsf@assigned-by-dhcp.cox.net> <200612230112.24212.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Dec 23 17:41:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gy9wS-0000Ok-9O
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 17:41:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753578AbWLWQlf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 11:41:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753582AbWLWQlf
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 11:41:35 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:52121 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753578AbWLWQle (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 11:41:34 -0500
Received: by nf-out-0910.google.com with SMTP id o25so3832916nfa
        for <git@vger.kernel.org>; Sat, 23 Dec 2006 08:41:33 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=rVjlImzZ8QscI7bnXAbStEuzAtjt+uLHM7Z1Fv1Rle9+Lvr6/yRPwPBtl0DUJvrqKaSmKA2fN9EecUz3LVc/iru6pTbAQMSHEuk69LTtV7WV8irQr5IGNnvI0HMpRqQIlSmCBtPVB0ZZ2/3A8Jjq86GaGF/fIvx9wmbpgUiACVQ=
Received: by 10.48.216.8 with SMTP id o8mr13174059nfg.1166892092701;
        Sat, 23 Dec 2006 08:41:32 -0800 (PST)
Received: from ?192.168.7.100? ( [82.0.29.64])
        by mx.google.com with ESMTP id n22sm48644425nfc.2006.12.23.08.41.31;
        Sat, 23 Dec 2006 08:41:31 -0800 (PST)
To: git@vger.kernel.org
User-Agent: KMail/1.9.5
In-Reply-To: <200612230112.24212.Josef.Weidendorfer@gmx.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35325>

On Saturday 2006, December 23 00:12, Josef Weidendorfer wrote:

> Andy: Did you check whether your disentangled commits each actually did
> compile on their own? If yes, how did you do it?

I didn't; they were easily separable and independent fortunately.  I don't 
have a good way of doing what you ask other than making the commits then 
testing each of those individually; then again there have been plenty of 
ocassions when a git guru tells me some magic that suddenly does exactly what 
I want.

In the case of testing my split commits I suppose it would need some way of 
pushing the working directory into a kind of alternate index temporarily.


Andy
-- 
Dr Andrew Parkins, M Eng (Hons), AMIEE
andyparkins@gmail.com
