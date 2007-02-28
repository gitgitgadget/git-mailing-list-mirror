From: Andy Parkins <andyparkins@gmail.com>
Subject: Re: defaults for where to merge from
Date: Wed, 28 Feb 2007 15:43:29 +0000
Message-ID: <200702281543.30730.andyparkins@gmail.com>
References: <es450f$d58$1@sea.gmane.org> <200702281522.14965.andyparkins@gmail.com> <45E5A01F.7060204@lu.unisi.ch>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Paolo Bonzini <paolo.bonzini@lu.unisi.ch>,
	Paolo Bonzini <bonzini@gnu.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 28 16:43:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMQxt-0005R7-S3
	for gcvg-git@gmane.org; Wed, 28 Feb 2007 16:43:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751808AbXB1Png (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Feb 2007 10:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751942AbXB1Png
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Feb 2007 10:43:36 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:41478 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808AbXB1Pnf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Feb 2007 10:43:35 -0500
Received: by nf-out-0910.google.com with SMTP id o25so590803nfa
        for <git@vger.kernel.org>; Wed, 28 Feb 2007 07:43:34 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=togO4tpSN8a9wqdN5YFlM6KYv0gIbAVnuwDVE8/EmCzdBVatkhzTd5tqjEg/LKB+SU0iBlW0KgR/K75Eshg39c2knAIEB7VV+7L8euo+amJLJdpbABruhpnASGzhlAJ8JugP43ApV3y6niQ0NkwlwINpWQ/zIHk6jHqQ7vgmedY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=imA+KtCdM614JCT2fTmJgbvfUJsFBhk9FHEHhzJ2dGKT1rjzO/Igq8+n4oJyOSaAKmU1BCVVKMoDRpZ1145c9Y0lElHBpYWoCjyfCVPDCw1Zp02lv1KHQwNx9S1Hpv5xfS6Qm7FDLNvS35z9jZqsnil6ZN6mzBjC1bPYvHOpeEk=
Received: by 10.48.210.20 with SMTP id i20mr3828799nfg.1172677414514;
        Wed, 28 Feb 2007 07:43:34 -0800 (PST)
Received: from 360run094l ( [194.70.53.227])
        by mx.google.com with ESMTP id l38sm6122330nfc.2007.02.28.07.43.31;
        Wed, 28 Feb 2007 07:43:31 -0800 (PST)
User-Agent: KMail/1.9.5
In-Reply-To: <45E5A01F.7060204@lu.unisi.ch>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40946>

On Wednesday 2007 February 28 15:30, Paolo Bonzini wrote:

> So, is there a reason why the config not could be cleared out by branch -d?

Good point.  I can't think of one.


Andy
-- 
Dr Andy Parkins, M Eng (hons), MIET
andyparkins@gmail.com
