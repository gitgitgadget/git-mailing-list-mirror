From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: [PATCH 2/2] git-show: use pathattr to run "display"
Date: Thu, 1 Mar 2007 09:17:53 +0000
Message-ID: <200703010917.54026.andyparkins@gmail.com>
References: <7vodndxwia.fsf@assigned-by-dhcp.cox.net> <200703010904.48146.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 01 10:18:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMhR2-0005Pb-EE
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 10:18:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933185AbXCAJSF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 04:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933209AbXCAJSE
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 04:18:04 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:56804 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933201AbXCAJSB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 04:18:01 -0500
Received: by nf-out-0910.google.com with SMTP id o25so833253nfa
        for <git@vger.kernel.org>; Thu, 01 Mar 2007 01:17:59 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=JFRNaMw5ovLFFlH+ehntzTAFv3el1LmMgNZouvwTt8wBTw4TPmEkoOJQ4EjVF9/UtcN48V15RdBYNqsFg0ehJAc/Iplkdz10V/wiXy9BBzTH128QOFtDS4jUmtY+F6BdmNqx90HQFzuHTLgIP7j4dKsTdVjE5fbbJyWTi0ArV7Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Kt6OmEL5icYlP8krQniw4M5lLhS6enyetWgkXyFjdP741wDEuCdzJRgJlVtn8IbO/6jkfpX/WFBi+pxPSMElkj346rSuT1WN/qQsBirT0EYQIMne5ftyuFhR83QeIxks3mB4cOT0TBYaxms4LPJ95lA+cJyap8Xkuj9oZdXmSkg=
Received: by 10.49.29.3 with SMTP id g3mr5193791nfj.1172740678901;
        Thu, 01 Mar 2007 01:17:58 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id m16sm8394511nfc.2007.03.01.01.17.56;
        Thu, 01 Mar 2007 01:17:56 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <200703010904.48146.andyparkins@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41060>

On Thursday 2007 March 01 09:04, Andy Parkins wrote:
> Is this serious?  This doesn't belong inside git does it?

I see from the source that it's not.  It's just a demo.  Sorry Junio.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
